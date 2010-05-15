From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] ls-remote: print URL when no repo is specified
Date: Sat, 15 May 2010 17:56:20 +0800
Message-ID: <AANLkTimTKiGxpVelj9rVV_BV-f8NiKlQHpov38ojlfFq@mail.gmail.com>
References: <1273416140-5044-1-git-send-email-rctay89@gmail.com>
	 <1273598423-3156-1-git-send-email-rctay89@gmail.com>
	 <7veihh8y8b.fsf@alter.siamese.dyndns.org>
	 <AANLkTinxm8hwX53LE9_7rDPoKs9UnGAyFFfVcoh-WGxE@mail.gmail.com>
	 <20100514161743.GA1957@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 15 11:56:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODE6e-00048m-4d
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 11:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068Ab0EOJ4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 May 2010 05:56:22 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:47014 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab0EOJ4V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 May 2010 05:56:21 -0400
Received: by pzk42 with SMTP id 42so1766409pzk.4
        for <git@vger.kernel.org>; Sat, 15 May 2010 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YUla3gXB/luOUCI2ekxGK/0PJnRRxG/R0a+vaTJaEzM=;
        b=XpLz9RTK4sDe1eVqWutVdyCEwyEZECbs7LGG3es+cAPKNI1H2pif95zA9vXhHqzgz6
         eGX/Y2C1bHdjv4SHwq4BAYzQQ71CyKFqGfQ9qKMbWX9NpvdUMnjDCQ3iZJJ9OcR6uEKU
         AeaQv7DAdsGAD2Cit2J8foTVWYzeMWVgOKecE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hAjSGeBI80y4/JjeMl8htLLVHfLu/ksHTefVvPwv5gYuZ9HHPK9IQ8AKw+g6p41JZg
         FcFNxrJcU+gN0oLiFxrcemn1tc+/vOfPwLrnPBU606yjRvD0j1NbQAkvT3053f+6wU7U
         GPfQ/+rj7KeRBN9vr+9YC6oTXsQDJYFelQnac=
Received: by 10.142.10.3 with SMTP id 3mr1447079wfj.120.1273917380615; Sat, 15 
	May 2010 02:56:20 -0700 (PDT)
Received: by 10.142.240.11 with HTTP; Sat, 15 May 2010 02:56:20 -0700 (PDT)
In-Reply-To: <20100514161743.GA1957@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147136>

On Sat, May 15, 2010 at 12:17 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Tay Ray Chuan wrote:
>> On Wed, May 12, 2010 at 1:50 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>
>>> I cannot convince myself that this is a good change, as I've always
>>> thought "ls-remote" output as something people want to let their sc=
ripts
>>> read and parse. =A09c00de5 may have given an enhancement to these s=
cripts in
>>> the sense that they can now respond to an empty input from the end =
user,
>>> but this patch forces them to change the way they parse the output =
from
>>> the command.
>
> Would 9c00de5 be so useful for scripts? =A0I suspect the typical scri=
pt
> does
>
> =A0git ls-remote "$remote"
>
> so to use the new default it would need adjusting.

Right, existing scripts that use git-ls-remote are unlikely to be
affected by 9c00de5, or this patch, for that matter.

>> in this patch, the remote url is printed to stderr, instead of stdou=
t,
>> so existing scripts should be safe.
>>
>>> I also think this patch is solving a wrong problem.
>>>
>>> When an end user does not know which remote ls-remote would be talk=
ing to
>>> by default, what else does he *not* know? =A0Probably which remote =
"pull"
>>> would be fetching from
> [...]
>
> I think I see what you are saying, and for scripts, that really would
> be the most useful thing. =A0Then the script could use something like
>
> =A0if test -z "$remote"
> =A0then
> =A0 =A0 =A0 =A0remote=3D$(git branch --get-remote --current)
> =A0fi
> =A0git ls-remote "$remote"

Just curious - when did git-branch learn "--get-remote"? Or "--current"=
?

--=20
Cheers,
Ray Chuan
