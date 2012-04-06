From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH RESEND] send-email: add 'specify-author' option
Date: Sat, 7 Apr 2012 00:48:26 +0300
Message-ID: <CAMP44s1m2exUVRTzcBJrY8hnWxF+uEt58AQOP5vKiA3tfeRXRQ@mail.gmail.com>
References: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
	<7vobr4236g.fsf@alter.siamese.dyndns.org>
	<CAMP44s1b=HfhPNkmiEjPnQpupd0FPBNgVyp5Sw=zFVTdqmJXEg@mail.gmail.com>
	<7vbon41ugg.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Fri Apr 06 23:48:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGH1G-0005r8-8w
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 23:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758157Ab2DFVs2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 17:48:28 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:48560 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab2DFVs2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 17:48:28 -0400
Received: by wibhj6 with SMTP id hj6so836770wib.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 14:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tIWV+l3JR425PfSPYv/O5hFDIFTl5X/yZd3Izv2VZyU=;
        b=vD/k9jNFl6gDQImkOE+QYVfTWDoMslsRMC2EnTZHiC32MnDmtRUOxYV+XhF93ULdkn
         wcwpYDSv6GUa9+J6aUq50sKMU7mq8cdqkRd7o46NlWvpOofGPVQljKIcXL6MJlIP2sMn
         mO1MDsgyUPO2ehLVCbPxOy7D+kGXDlWJERX5FshiijwBo308OQiaN0gJ3Ga2N4QU+W0n
         18ILLGBlHYLXYbPGeOiOc6hzF7RQBegjfZBqXf9zFD++n9BuTeBmy5jegGaErV1VdSPP
         HRKek+KxDMf6AN6D6pk7+MhKzkdF4fJehcDYX312hCIQ2FwcB1fRZ38cJOsUdOHsKzn5
         fT1Q==
Received: by 10.216.53.200 with SMTP id g50mr506303wec.2.1333748906750; Fri,
 06 Apr 2012 14:48:26 -0700 (PDT)
Received: by 10.216.70.4 with HTTP; Fri, 6 Apr 2012 14:48:26 -0700 (PDT)
In-Reply-To: <7vbon41ugg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194914>

On Fri, Apr 6, 2012 at 11:22 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Fri, Apr 6, 2012 at 8:14 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Some mail servers (Microsoft Exchange) mangle the 'From' header, s=
o
>>>> while applying the patches, the author has to be fixed manually.
>>> ...
>>> I wouldn't say that the existing option names to send-email are gre=
at, but
>>> I have to say that the one added by this is simply horrible ;-)
>>>
>>> The first paragraph of the proposed commit log message states the p=
roblem
>>> it tries to address very clearly, which is good, but is "From: " th=
e only
>>> thing that needs this? =C2=A0I am wondering if this should be named=
 and behave
>>> more like "--duplicate-header" or "--in-body-header".
>>
>> I have never seen any other 'in-body-header' other than From, and I
>> don't see how that would be useful. Anybody else?
>
> The "Subject:" is very often used in the wild, when responding to an
> existing discussion thread with a patch, without changing the topic o=
f the
> thread (I would say it is used more than "From: " override).

Hmm, but that is different, isn't it?

AFAIK people use this format:

---
$headers

Message

Patch (format-patch output: headers, commit message, diff)
---

In this case 'git am' would ignore the patch headers. The only way
'git am' would override $headers, is if the first part of the body has
new headers:

---
$headers

$patch_headers

$patch_commit_message

$patch_diff
---

IOW; if there's no message at the beginning of the body.

> When using send-email to start a thread anew, this use case is much l=
ess
> of a problem, but I wouldn't be surprised if a broken MSA/MTA mangled=
 the
> subject (especially imagine a non-ASCII ones) incorrectly which would=
 be
> helped with exactly the same in-body-header mechanism.

I can't foresee that, but I guess we can do it anyway. So which would
be the fields to repeat? From, Date, and Subject?

> You probably meant "I do not want to hear from Junio" by your last
> half-sentence, but I replied anyway ;-).

I meant I wanted to know which fields would be useful to put in the bod=
y.

Cheers.

--=20
=46elipe Contreras
