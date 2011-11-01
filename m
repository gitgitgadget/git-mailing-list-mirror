From: Roland Kaufmann <rlndkfmn+git@gmail.com>
Subject: Re: [PATCH] Display change history as a diff between two dirs
Date: Tue, 1 Nov 2011 10:01:33 +0100
Message-ID: <CANEMaQRoXRygmrYsu0xF6mWq50r9Qhh-YuXXNAhyQewd+fDtsQ@mail.gmail.com>
References: <4EAC6765.4030003@gmail.com> <7vty6rrow8.fsf@alter.siamese.dyndns.org>
 <4EAE688C.8010502@gmail.com> <7v39e8o61s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 10:02:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLAEN-0003Hi-5S
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 10:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab1KAJB6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Nov 2011 05:01:58 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34817 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab1KAJB5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2011 05:01:57 -0400
Received: by wwi36 with SMTP id 36so2765326wwi.1
        for <git@vger.kernel.org>; Tue, 01 Nov 2011 02:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Jw3WoCFD48UJ1D7LkTAx+aQG0T0lFOtdqKBahiwspnI=;
        b=YdYMY755SfUqir2DcBWrylItMfPL1v3jHxaylwTorsUNdOsf58KEbeL3xIktaD9FZe
         SovpaNjLp+Jw4UywdNzsVABn3PI1o+5MM5q5uSC+OY4vBBk1tQa9kqywrU236bTHJZCr
         vpAXcvq0djg4Zb7DloTzAHoOQ+8cpDmKOL1cM=
Received: by 10.216.168.203 with SMTP id k53mr1451321wel.15.1320138115946;
 Tue, 01 Nov 2011 02:01:55 -0700 (PDT)
Received: by 10.217.7.66 with HTTP; Tue, 1 Nov 2011 02:01:33 -0700 (PDT)
In-Reply-To: <7v39e8o61s.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: IUwWVo83ia52Vr35kRqzhg1PcNk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184561>

On Tue, Nov 1, 2011 at 04:49, Junio C Hamano <gitster@pobox.com> wrote:
> Roland Kaufmann <rlndkfmn+git@gmail.com> writes:
>> Would it be better to have yet another configuration available for
>> this option instead of reusing the existing infrastructure for `git
>> difftool`?

> It probably is OK for "git diff --dirdiff" to use GIT_EXTERNAL_TREEDI=
=46F if
> and only if GIT_EXTERNAL_DIFF is not defined, and use GIT_EXTERNAL_DI=
=46F
> otherwise. People who have GIT_EXTERNAL_DIFF set to a tool capable of
> handing directory pair can just add "--dirdiff" to the command line, =
and

Did you perhaps mean the other way around: GIT_EXTERNAL_TREEDIFF
if set, and GIT_EXTERNAL_DIFF otherwise?

I will revise the patch to incorporate that, and at the same time fix
the isempty
function (it can be done simpler).

>>> It also is not clear what could be used in "$@". Obviously you woul=
d
>>> =A0not want things like "-U20" and "--stat" fed to the first "list =
of
>>> paths" phase, but there may be some options you may want to give to
>>> the inner "external diff" thing.

>> Ideally, it should work the same way as `git difftool`.

> I am not so sure about that; difftool is another way to drive a tool =
one
> filepair at a time. You want to drive a tool that takes them as two _=
sets_
> of files, one in each directory.

I was thinking about the behaviour when you send options that are not
applicable to files at all, such as "--stat". In that case, it just sto=
ps after
`git diff`. Options that only applies to one file and not to a set
have I admittedly
not thought about (yet).

--=20
   Roland.
