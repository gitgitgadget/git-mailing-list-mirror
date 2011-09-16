From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/2] grep --no-index: don't use git standard exclusions
Date: Fri, 16 Sep 2011 20:23:54 +0200
Message-ID: <CAKPyHN2ewwLf6am3VQr_z4c3_Q5=saeLcZtuY-fEtUGr-41rKQ@mail.gmail.com>
References: <2f376e61802a1a38c67698d5ec263d1807b1fcee.1316110876.git.bert.wesarg@googlemail.com>
	<7b3551dd84a2bfec78c8db1d14dd2d0e6dda35f6.1316110876.git.bert.wesarg@googlemail.com>
	<7vmxe5pp4n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 20:31:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4dBz-0003di-As
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 20:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700Ab1IPSbK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Sep 2011 14:31:10 -0400
Received: from mail-ew0-f43.google.com ([209.85.215.43]:63784 "EHLO
	mail-ew0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542Ab1IPSbJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2011 14:31:09 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Sep 2011 14:31:09 EDT
Received: by ewy20 with SMTP id 20so2960870ewy.2
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=C7VCc4u1y2AZr+XkOMSRdVXbQchkrUQq2aZw4/PBY+w=;
        b=Ibc9KFvZWboBsxrtkeHLjMUk1l2R7uUHhmQ/raGJzahDL4prc+0SRY+1iLSYkHqu6b
         yZRnDZNjRnwMz5HNKKC1OAAm63p14hnr7lDyqGBfo9pkk/Vf+dII8JW7o8xPMs2MF7SO
         xdNPbfC9tA4AqhA2tAZ5cSqVAE+K87FqpBXAo=
Received: by 10.52.22.2 with SMTP id z2mr2011708vde.253.1316197434432; Fri, 16
 Sep 2011 11:23:54 -0700 (PDT)
Received: by 10.52.107.2 with HTTP; Fri, 16 Sep 2011 11:23:54 -0700 (PDT)
In-Reply-To: <7vmxe5pp4n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181542>

On Thu, Sep 15, 2011 at 21:44, Junio C Hamano <gitster@pobox.com> wrote=
:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> On Wed, Jul 20, 2011 at 22:57, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>> =C2=A0- Since 3081623 (grep --no-index: allow use of "git grep" out=
side a git
>>> =C2=A0 repository, 2010-01-15) and 59332d1 (Resurrect "git grep --n=
o-index",
>>> =C2=A0 2010-02-06), "grep --no-index" incorrectly paid attention to=
 the
>>> =C2=A0 exclude patterns. We shouldn't have, and we'd fix that bug.
>>
>> Fix this bug.
>
> On a busy list like this, it is brutal to withhold the better clues y=
ou
> certainly had when you wrote this message that would help people to l=
ocate
> the original message you are quoting, and instead forcing everybody t=
o go
> back 5000 messages in the archive to find it. E.g.
>
> =C2=A0 =C2=A0http://article.gmane.org/gmane.comp.version-control.git/=
177548
> =C2=A0 =C2=A0http://mid.gmane.org/7vzkk86577.fsf@alter.siamese.dyndns=
=2Eorg
>
> Or perhaps have
>
> =C2=A0 =C2=A0References: <7vzkk86577.fsf@alter.siamese.dyndns.org>
>
> in the header.

Sorry for this patch with insufficient references and context. I
realized it too late, and the time was short.

>
> As to the patch, I think this addresses only one fourth of the issue
> identified in that discussion (it is a good starting point, though).
>

I thought to split the bug fixing from the new features. I already
implemented --exclude-standard, including --exclude=3D<patter>,
--exclude-from=3D<file> and --exclude-per-directory=3D<file>. But it's =
not
ready because of missing tests and documentation. So I just spilled
this bug fix patch out and will now work on the next part.

> With this change, it would now make sense to teach --[no-]exclude-sta=
ndard
> to "git grep", and "--exclude-standard" is immediately useful when us=
ed
> with "--no-index". When we add "git grep --untracked-too" (which lets=
 us
> search in the working tree), people can add "--no-exclude-standard" t=
o the
> command line to say "I want to find the needle even from an ignored f=
ile".

Would '--untracked-too' only be a synonym for '--no-index
--exclude-standard', i.e. the current behavior?

Bert

>
> Thanks.
>
