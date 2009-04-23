From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] tests: remove xargs in favor of --stdin where possible
Date: Fri, 24 Apr 2009 09:22:10 +1000
Message-ID: <fcaeb9bf0904231622x721483f2v9f009784509676b@mail.gmail.com>
References: <1240468281-23815-1-git-send-email-pclouds@gmail.com> 
	<7vfxfzwytx.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0904230307h2d4ee691y412e9cf31e4e90c3@mail.gmail.com> 
	<7v8wlrwtt3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 01:24:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx8HH-0000gd-VM
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 01:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbZDWXW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 19:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757196AbZDWXW1
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 19:22:27 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:36035 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbZDWXW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 19:22:26 -0400
Received: by yw-out-2324.google.com with SMTP id 5so497115ywb.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=W2d9oRXyeiw269L2yO5JGyONoCGQYjRWchihgv52MXg=;
        b=iap8V/UF4d1yzHPPhM0FdCUMqXknNV6qUuW6snx22rH27IXI50gZn86LGSq7Yzi59I
         a0yd21lu7GIbpFbI4PzrVUZmYGtfnjcLwtbvAP07oeqiGolQjTIQNHQRFeKCkeQbnHT0
         k4kwEoWXwdvNvoqqN1+TtwGjA7W2f6OZ+csMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=v/o97GbtC4gfgP488vvI0naluLGyDKneBLx/0W0807pqnFWqSgTN+IyGfH4pNKKYQh
         j/FvsGSwsd70yBdzzBE6qt2hZ1eELlEqHmxKPsr0wBrdhS9jGSfbQVj7uAkESzEP95yH
         05Rz9JWczmjWj6sWvptHkpgop8djEpLABhBxc=
Received: by 10.100.151.14 with SMTP id y14mr2082510and.117.1240528945195; 
	Thu, 23 Apr 2009 16:22:25 -0700 (PDT)
In-Reply-To: <7v8wlrwtt3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117397>

On Thu, Apr 23, 2009 at 8:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>>> The tests may not break with your change because none of them may use
>>> problematic characters (especially "\n" and '"'), but update-index --stdin
>>> without -z is not suitable for reading from output from "find" without -0
>>> option (on the other hand, "update-index -z --stdin" is good for reading
>>> output from "find -0"; but for portability we avoid GNUism "find -0").
>>
>> It can't be as safe as find -0| update-index -z, but it would be
>> equivalent to find|xargs, isn't it? Both separate arguments by \n.
>
> Have you worked with pathnames with high-bit set and without
> core.quotepath set to false?

OK I see. There are some fancy unquoting going on inside. I'd take the
patch back.
-- 
Duy
