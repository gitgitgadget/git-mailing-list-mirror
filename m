From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH RESEND] send-email: add 'specify-author' option
Date: Sat, 7 Apr 2012 14:46:29 +0300
Message-ID: <CAMP44s0D1RXteHvCrsmaKVcfaK4SRArXf_nF7by2jJkgatkG-A@mail.gmail.com>
References: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
	<7vobr4236g.fsf@alter.siamese.dyndns.org>
	<CAMP44s1b=HfhPNkmiEjPnQpupd0FPBNgVyp5Sw=zFVTdqmJXEg@mail.gmail.com>
	<7vbon41ugg.fsf@alter.siamese.dyndns.org>
	<CAMP44s1m2exUVRTzcBJrY8hnWxF+uEt58AQOP5vKiA3tfeRXRQ@mail.gmail.com>
	<7vobr4ze5z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Pierre Habouzit <madcoder@debian.org>,
	Pascal Obry <pascal@obry.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Brown <git@davidb.org>, Matthew Wilcox <matthew@wil.cx>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 13:46:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGU6S-0000zh-E9
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 13:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab2DGLqc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Apr 2012 07:46:32 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38376 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab2DGLqb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Apr 2012 07:46:31 -0400
Received: by eekc41 with SMTP id c41so838376eek.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=yxKoFNoDywLCzIkPL1C9YlIeldCgr3LlrP0/o8Q5UTw=;
        b=yQHXmlWSEWP6SEhoFQRyXgiyTAwdT3jeZ+VtnYjbmrtkOD/dCvyKHJtjczs0cuoP8m
         BNsBBwMNuUg7rIQKl4J0NodBOUJyxWXVt+RG7JawQMjTWqcnAm33nQsxXt8pH4yDgOgA
         d2ANcHF2yRyB7+NEiL3tMZhkHdl9xr5H0OYV6TeYyCmLk5s515GeDXFcC17k/GwXWAAB
         9wXZjYKq84edVdU/+6B1ckFywR2iZ1IDdvTFMga2fXrq0Uw8VKcy0BNRyjmy1fu7Sn2U
         Nts9/ZZI7fBThT8LhmRc8spTEvgIpFT2ghK1uAxDw8koWYNobSCV3hCGSbpr+FF7i4x9
         ZibQ==
Received: by 10.213.20.201 with SMTP id g9mr68769ebb.105.1333799189983; Sat,
 07 Apr 2012 04:46:29 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sat, 7 Apr 2012 04:46:29 -0700 (PDT)
In-Reply-To: <7vobr4ze5z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194947>

On Sat, Apr 7, 2012 at 1:30 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> The "Subject:" is very often used in the wild, when responding to a=
n
>>> existing discussion thread with a patch, without changing the topic=
 of the
>>> thread (I would say it is used more than "From: " override).
>>
>> Hmm, but that is different, isn't it?
>>
>> AFAIK people use this format:
>>
>> ---
>> $headers
>>
>> Message
>>
>> Patch (format-patch output: headers, commit message, diff)
>> ---
>>
>> In this case 'git am' would ignore the patch headers. The only way
>> 'git am' would override $headers, is if the first part of the body h=
as
>> new headers:
>>
>> ---
>> $headers
>>
>> $patch_headers
>>
>> $patch_commit_message
>>
>> $patch_diff
>> ---
>>
>> IOW; if there's no message at the beginning of the body.
>
> Your notation is a bit unclear to me, but I take that $headers mean t=
he
> e-mail headers, and $patch_headers mean what we often call "in-body"
> headers; in other words, your patch is "duplicate my authorship in
> $patch_headers because my MSA/MTA mangles my name in $headers." =C2=A0=
Am I
> following you well so far?

Yes, but 'git send-email' already does that; when the author and
sender are not the same.

> What I meant to say was that perhaps the approach can help the same c=
lass
> of issues where other fields in $headers can be corrupted and the use=
r
> wants duplicate in "in-body", assuming that it is less likely to be e=
aten,
> and non-ASCII subject was one example that immediately came to my min=
d.
>
> So in that sense, it is not much a different issue.

No, but it requires new code, whereas my patch only exercises existing =
code.

>> I can't foresee that, but I guess we can do it anyway. So which woul=
d
>> be the fields to repeat? From, Date, and Subject?
>
> I would say From and Subject are equally worth considering.

So only From and Subject? Not Date?

Cheers.

--=20
=46elipe Contreras
