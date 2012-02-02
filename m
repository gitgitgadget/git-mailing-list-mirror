From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 2 Feb 2012 13:00:27 +0200
Message-ID: <CAMP44s3BcSGPCKPr_2EpGQRAv_kDM2_OQiyKDT7qY=QR0cHYpQ@mail.gmail.com>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
	<20120202084859.GC3823@burratino>
	<CAMP44s0w1eXWWaMT3WAfLxFHPQvc9dp33cyJ=T2im6g7rsrKhw@mail.gmail.com>
	<8739at8qw6.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 02 12:00:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsuP4-0008WQ-3k
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 12:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab2BBLA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 06:00:29 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46781 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754847Ab2BBLA3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 06:00:29 -0500
Received: by lagu2 with SMTP id u2so1203157lag.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 03:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vXCeDVkC4dJhFJqYEgh1HOoC+jHf7U7QLRpsQOqa1UY=;
        b=DRtPk/BrvrxR/j/38qwe1pIcw0QeN4Whzi+iFLPKxPm1wbivDnh7lY0j/JTL9HrHoT
         GkMqR5FDdjevVYIjtokSwCpStKGiwqRRP2w30Bowaf5N0jkfdV9Rfb9RCK3AinpmHHIS
         AS1leSCJMG1Hp9BmgSKMNOIpcSzI7BfkKSb7E=
Received: by 10.112.25.106 with SMTP id b10mr592971lbg.102.1328180427514; Thu,
 02 Feb 2012 03:00:27 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Thu, 2 Feb 2012 03:00:27 -0800 (PST)
In-Reply-To: <8739at8qw6.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189622>

On Thu, Feb 2, 2012 at 12:35 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Feb 2, 2012 at 10:48 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>>
>> Exactly, and "completion: avoid default value assignment on : true
>> command" tells *nothing* to most people. Why is this patch needed? D=
o
>> I care about it?
>>
>> OTOH "completion: be nicer with zsh" explains the purpose of the pat=
ch
>> and people that don't care about zsh can happily ignore it if they
>> want, and the ones that care about zsh might want to back port it, o=
r
>> whatever.
>
> Perhaps you could compromise on
>
> =C2=A0completion: work around zsh word splitting bug in : ${foo:=3D$(=
bar)}

Yes, that sounds better, perhaps:

completion: work around zsh option propagation bug

>> | tl;dr: $__git_porcelain_commands =3D $__git_all_commands
>>
>> Wrapping it up, to make clear what happens.
>
> I think this is not good style for a commit message. =C2=A0Apart from=
 the
> very trendy use of tl;dr, it doesn't even properly summarize the caus=
e
> *or* the user-visible symptom. =C2=A0It just states how the confusion
> propagates somewhere in the middle of the code.

I don't think the cause or the user-visible symptom need any summary.

I was trying to summarize this:
---
This is because in zsh the following code:

 for i in $__git_all_commands

would evaluate $__git_all_commands as a single word (with spaces),
${=3D__git_all_commands} should be used to do word splitting expansion
(unless SH_WORD_SPLIT is used).

sh emulation should take care of that, but the command expantion is
messing up with that.
---

--=20
=46elipe Contreras
