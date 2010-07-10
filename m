From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH 2/2] rebase -i: Preserve whitespace at beginning of commit 
	header in $GIT_EDITOR
Date: Sat, 10 Jul 2010 20:22:41 +0800
Message-ID: <AANLkTim2cOWWYbco3XYb_dfOCkUp4rfXIvE-8jZWK4a8@mail.gmail.com>
References: <1278652843-30872-1-git-send-email-ayiehere@gmail.com>
	<1278652843-30872-2-git-send-email-ayiehere@gmail.com>
	<7vpqywl1sb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 10 14:22:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXZ57-0000dg-LC
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 14:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab0GJMWo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jul 2010 08:22:44 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43845 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab0GJMWn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jul 2010 08:22:43 -0400
Received: by wwb24 with SMTP id 24so5763308wwb.1
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DOxUQYakUgRLtmLYad92VFnwceAJZkh8wtRPPqDYo5U=;
        b=SCs2Xnt9yHcOk2CyFe2Ennoq/a7EB4CccbnfNKLWMZ9v54xwZMCFFWTb6+W4cSV8r6
         dPOjKWr2ktXWU8X62wNGpTrEdiD1VC1ckAGBtFm/8rBCFETQxcHfAM/g3TA4kX1l3c3N
         pg0k8RpFGTeGO9+BM7iLnBNp6UF0zWjZgb/1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sXNHyFTMSTsmQx0JCwOz1c2t60xWRO3P/qZZ6M+E3ymwSDBj1AWZvr2GrFIWlfMMfZ
         JUDfc23ukkUu8wOppzlkjnsZzWP9O5I70FzRRLIWQaMC9sCawLwLD3C40i9mAPlevT7A
         uicAH3kVYI+gpe5xHw329AROi+hcswo4So+iE=
Received: by 10.216.180.202 with SMTP id j52mr5610187wem.112.1278764561830; 
	Sat, 10 Jul 2010 05:22:41 -0700 (PDT)
Received: by 10.216.163.142 with HTTP; Sat, 10 Jul 2010 05:22:41 -0700 (PDT)
In-Reply-To: <7vpqywl1sb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150722>

On Sat, Jul 10, 2010 at 6:30 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nazri Ramliy <ayiehere@gmail.com> writes:
>
>> +                     sed -i "s/^\([a-z]\+\) [0-9a-f]\+ /\1 $REPLACE=
_COMMIT_ID /" \
>
> This is not portable. Escaping an ERE element with a backslash does n=
ot
> make it suitable for use in BRE that sed uses.
>
> Do we use in-place replacement anywhere else with sed?  I don't think=
 it
> is portable, either.
>

And later ...

On Sat, Jul 10, 2010 at 6:37 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cat "$TODO.tmp" | sed "s/^=
/pick /" > "$TODO"
>
> Do not cat a single file into a pipeline.
>
> =A0 =A0 =A0 =A0sed "s/^/pick /" <"$TODO.tmp" >"$TODO"
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cat "$TODO.tmp" |
>
> Likewise.
>
[snip]
> Don't pipe output of grep into sed.
>
> =A0 =A0 =A0 =A0sed -ne "/^$shortsha1 /s/^/pick /p" <"$TODO.tmp" >>"$T=
ODO"

I'll send out a v2 of this series that addresses the above issues in
better ways (i think).

nazri
