From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] rev-list: preallocate object hash table in --all --objects
Date: Fri, 29 Mar 2013 22:29:52 +0700
Message-ID: <CACsJy8AXUUz3=-pWeK-y0va-=d_-aCeNgH8rAtMZdq0PE+X97g@mail.gmail.com>
References: <1364563210-28813-1-git-send-email-pclouds@gmail.com> <20130329151208.GA22744@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 16:30:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULbGV-0007ac-EP
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 16:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab3C2PaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 11:30:23 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:37908 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628Ab3C2PaX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 11:30:23 -0400
Received: by mail-ob0-f176.google.com with SMTP id er7so480002obc.21
        for <git@vger.kernel.org>; Fri, 29 Mar 2013 08:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=TR8ZOyUC5Fqw/2Rya9Rxhu64as2PFMb8aswtcMnEJJo=;
        b=B6YL7qaPTwnHkd6WSDYCzTHTORf22baoNnNBdeLMB+CLDGLbg3StK5c7+6gNmrMFex
         g5kCyXVG2c/bNf75QnlKa0bs7L8iWRjuTefIFsqjuSrYE5w55ItI/dgtwPEIqxDd0EpX
         xgpD2ModvXWabmxs2qmxfQyhi3OTU5cPkYb5hAqutEI0SSNwwRmURc/xJ0M/3PU5UpND
         lkETuyniiarVuBI6PM0BzJf+/787nhNOrUo1rLfMfsOifclo53sJTsQeJzFFCQsCY6o2
         O8jGrptNEeAdCUMDIg53ZK9hqFFXp1hrEHrwqGzVxsXSK3kKI+ayvQ6SQPQy5jrGYIM5
         Opdw==
X-Received: by 10.60.99.68 with SMTP id eo4mr960525oeb.126.1364571022604; Fri,
 29 Mar 2013 08:30:22 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Fri, 29 Mar 2013 08:29:52 -0700 (PDT)
In-Reply-To: <20130329151208.GA22744@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219502>

On Fri, Mar 29, 2013 at 10:12 PM, Jeff King <peff@peff.net> wrote:
> This feels weirdly specific, and like we should just be tuning our hash
> table growth better. You show a 3.2% speedup here. I was able to get a
> 2.8% speedup just by doing this:

It also uses a lot more memory. 5.8m entries for ".. * 2" and 8.8m for
"... * 3". Probably no big deal for modern machines..

> It might be worth trying to figure out what the optimium growth rate is
> first, which would help this use case and others. With less fragile
> code.

Agreed. Although I think it's getting out of my domain. I'm not even
sure how many factors are involved.
-- 
Duy
