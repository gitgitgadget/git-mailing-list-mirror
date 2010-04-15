From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] am -3: recover the diagnostic messages for corrupt patches
Date: Wed, 14 Apr 2010 20:28:49 -0700
Message-ID: <4BC687F1.4010608@gmail.com>
References: <7vpr21pyed.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 05:29:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2FlD-0005ga-2A
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 05:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534Ab0DOD2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 23:28:53 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38115 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab0DOD2x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 23:28:53 -0400
Received: by vws5 with SMTP id 5so28531vws.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 20:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=bm/Tx/l1tNuvkiOcFNVyHEhzYWxj+B+4eu0/a8XIxZ4=;
        b=J+7cr+dHRkAEaCJR+so7O285AwudJLO/0XpABfisfv1n/2h3dblyVlzRKoX3GdkSs1
         LMk38JfdUrLGOb9hma4Kn2EbCM8Hh3WrzlghrRx6erabRM9zYr1goHAqjjZR7pPyf0vq
         4gSSRiJFDl8WXE4w/+b243g05Ppiis7D5IhCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=hW9mzSD8zAB6m/u9tX4ZoQiduJfOxCxwo99e96xcsCr5ZENgDBbnI6mvTvV5SyqNAC
         CHEpQEc2oqqJfEUQ30I3IVt0VLSF34YONvZtlb/fuu+mrNOA4KHNCdD/NHX/exiT9dyD
         IlBEPFlaBx3nxL0A5e8hf9SsYt+9XIEVQV4IQ=
Received: by 10.220.125.69 with SMTP id x5mr4836862vcr.108.1271302132268;
        Wed, 14 Apr 2010 20:28:52 -0700 (PDT)
Received: from [192.168.1.5] (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 25sm21566878vws.9.2010.04.14.20.28.50
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 20:28:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <7vpr21pyed.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144942>

On 04/14/2010 01:33 PM, Junio C Hamano wrote:
[...]
> We could fix this issue by reverting 3dd170, or keeping the error message
> to somewhere and showing it, but because this is an error codepath, the
> easiest is to disable the optimization.  The second patch application is
> attempted even when the input is corrupt, and it will notice, diagnose,
> and stop with an error message.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks fine to me. Two invocations on an error path where user
intervention is most likely required shouldn't be too bad like you say.

This reminds me, a while ago I looked into pushing 3way into git-apply
(that was a GSoC project suggestion). We could introduce an internal
"I'm attempting a 3way if this fails" option for git-apply and then it
could be smart and output the errors if the patch is malformed.
Otherwise it would be silent like it should be on 3way apply for the
first time failures. Obviously this will have to happen for 3way to be
pushed into git-apply at all.

Sounds a little too smart to me though (this is the stupid content
tracker after all) so let's just do what you have ;-)
