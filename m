From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: remove test when closing file descriptor
Date: Wed, 17 Nov 2010 00:02:47 +0100
Message-ID: <201011170002.47678.jnareb@gmail.com>
References: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr> <m3pqu4lx6n.fsf@localhost.localdomain> <1292539020.2511.6.camel@kheops>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Fri Dec 17 00:03:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMqv-0007Tq-JI
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 00:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab0LPXDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 18:03:09 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:38390 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0LPXDF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 18:03:05 -0500
Received: by fxm18 with SMTP id 18so92435fxm.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 15:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2oll/bsbsS5vyaouzcnpJke55HqmS3gdD04+paegdAA=;
        b=GQVrgB+422KniuVbHNhQX9d1crxb3Y/7kuKCZGJ8tn0z1kemVxfGJ/Rq/7ZKSnxJ+n
         nQvjblzM4qiL1xAm/gL7bzCR1zDUrxViEgFI/d8AoMAv1P+6HoHS6FgvSQPCpsrYlibI
         gx5dUl0NovgNZ12M1dZapNgggPieA03VPKqjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=d5XUWZ6FCVqj/UW8tppIaTx4tC/DJ+HDS9ZJIzIcASnmsuAqX+7X6GkMmzqtOcghb+
         OEBhG7hrnKAnl+h8GKnaNDv1MIcrevEV8Jfcs6I2n8FRpMkyh5uEiuEqo7l2V1Jlf0s0
         Ib0c/V4YyIM8FmalwrSWaDMSuZihq3NKIpBhQ=
Received: by 10.223.79.65 with SMTP id o1mr345129fak.145.1292540584367;
        Thu, 16 Dec 2010 15:03:04 -0800 (PST)
Received: from [192.168.1.13] (abvg92.neoplus.adsl.tpnet.pl [83.8.204.92])
        by mx.google.com with ESMTPS id n3sm222233fax.31.2010.12.16.15.03.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 15:03:03 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1292539020.2511.6.camel@kheops>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163837>

On Thu, 16 Dec 2010, Sylvain Rabot wrote:
> On Thu, 2010-12-16 at 14:30 -0800, Jakub Narebski wrote:
> > Sylvain Rabot <sylvain@abstraction.fr> writes:
> > 
> > > it happens that closing file descriptor fails whereas
> > > the blob is perfectly readable.
> > > 
> > > Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
> > > ---
[...]
> > > -	close $fd
> > > -		or die_error(404, "Reading blob failed");
> > > +	close $fd;

[...]
> > In this place we close read end of pipe after at most reading a few
> > bytes (what -T test does), so what might happen is that writer got
> > SIGPIPE and "failed".  But we are not interested in this, so we can
> > safely ignore return from 'close'.
> > 
> > I think that some from above explanation should make it to commit
> > message.
> 
> Thanks for explaining it, I did not have any idea why it was failing.
> Can I use your explanation as commit message ?

Of course.

Though I am not sure if it is really the reason, it looks reasonable.

-- 
Jakub Narebski
Poland
