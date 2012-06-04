From: Phil Hord <phil.hord@gmail.com>
Subject: Re: git rebase -f --autosquash
Date: Mon, 4 Jun 2012 15:44:09 -0400
Message-ID: <CABURp0p+NbYbiEO3n1iwP4jH63CjqvE6zhk6pHFjGU7+N0=vXA@mail.gmail.com>
References: <D7BE2BACB49749DB9FC37D4ACCCD008B@gmail.com> <1336820755.3002.11.camel@centaur.lab.cmartin.tk>
 <7vipfyiuv6.fsf@alter.siamese.dyndns.org> <33DF11B90FEF4CB6B4103BE0AAF9B256@gmail.com>
 <7vobpap1gb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andy Kitchen <kitchen.andy@gmail.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 21:44:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbdCe-00066y-Jg
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 21:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346Ab2FDTob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 15:44:31 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50898 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757267Ab2FDToa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 15:44:30 -0400
Received: by yenm10 with SMTP id m10so3372859yen.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 12:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WTXmcP7Kjv1ry/SVhA3KoFIBnhSKRpW/qVvmq/Lh3JQ=;
        b=UghfqBRfAQuvMfudqEIVr6cbTDe8ZSVu2QpPEV+ob/6hxyJByQRoY9wa6Aj/pqwX78
         jnzrsyEAz01iXhBOh2zGn5vKOK+XPn/Nwvm/PvHgQprgpMTnJpoBca2BNs4FjRIkv3dd
         6CpYO1YPlT92dDYp5q3z1oz5m/J4D1Jbxr2URMOuzgD9AmReao1ra0TF+3Ketw3FTCeC
         SUI61lhPPJ9zrYomREYp2Z2mnelKHuM8Fl2ZMkdOJAGPUirWJQqNRgRpZNtr+vFFerQb
         yMAQ5jnrUQAvVXAuWZcVKgf4IIfwf1leVvqQcGe60bS1Pnl95dmE/ULRhvN1o+SDDhpL
         xqeA==
Received: by 10.236.193.99 with SMTP id j63mr8144796yhn.45.1338839070116; Mon,
 04 Jun 2012 12:44:30 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Mon, 4 Jun 2012 12:44:09 -0700 (PDT)
In-Reply-To: <7vobpap1gb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199173>

On Sun, May 27, 2012 at 2:44 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Andy Kitchen <kitchen.andy@gmail.com> writes:
>
>> 1a)
>>
>> $ git rebase -f --autosquash <base>
>> is made to be effectively equivalent to:
>> $ EDITOR=3D: git rebase -i --autosquash <base>
>
> I am not sure how you do the above without breaking the existing user=
s and
> other people's use cases, given that giving --force option to rebase =
has
> totally different meaning from the above (i.e. "do not refuse to reba=
se
> even though the current branch is up to date with respect to <base>")=
=2E
> Such an option overloading, especially for an option "force", feels a=
dding
> confusion without much merit---it is unclear what kind of "forcing" i=
s it
> calling for.
>
>> 1b)
>>
>> $ git rebase --autosquash <base>
>> (i.e. -f is implicit) is made to be effectively equivalent to:
>> $ EDITOR=3D: git rebase -i --autosquash <base>
>
> I do not think this would work.
>
> The --autosquash option is merely a way to help reordering by moving =
the
> "fixup!" commits in the history around without manual action You may =
have
> commits created with "fix" but _other_ commits in the history that yo=
u
> want to manually reorder in the insn sheet.
>
>> 3) A new command is created, for example one of:
>>
>> $ git fix
>> $ git squash
>> $ git autosquash
>
> All of these names are so broad and generic---I am not sure if any of=
 them
> will "click" with your single narrow use case, which as far as I can =
see
> is "I want rebase with --autosquash but I am not going to do any othe=
r
> editing." =A0None of the above three words hints the new command is a=
bout
> rebasing.
>
> Even though I find the "I want rebase with --autosquash but I am not =
going
> to do any other editing." is a workflow element that often appears in=
 the
> real life, I do not think it deserves its own command that is separat=
e
> from "rebase". =A0It is merely a slightly different way to drive "reb=
ase",
> after all.
>
> And that "I want rebase with --autosquash but I am not going to do an=
y
> other editing" is where my suggestion to use "--no-edit" comes from.

Your suggestion is not that he use "rebase --autosquash --no-edit" but
that he use "rebase --autosquash --interactive --no-edit".  The last
two options appear to be opposites from the outsider's perspective and
would seem to be superfluous.  I understand from the code perspective
that "rebase" and "rebase --interactive" are in separate
implementations; but from this user's perspective, they are the same
with one distinction; the former performs an automatic sequence of
commit actions, while the latter shows the sequence first and allows
me to edit it.  So the command "git rebase --interactive --no-edit"
reads to me like "git rebase --ask-me-how --noask-me-how", which is
nonsensical, at best.

The only reason Andy would have to add --no-edit to his command is
because the --autosquash option is, inexplicably, only valid in
--interactive mode.  This seems pointless from this user's
perspective.  Why does the --autosquash option also need the
"--ask-me-how" option?  If I don't need the --ask-me-how action, I
should simply leave it off.  I should not need to also add
"--no-ask-me-how".

That would look nonsensical.

Maybe it seems explicable to you because "squash" is a todo-list
command which is only valid in --interactive.  But this, too, is a
detail best left buried in the implementation and not exposed to the
CLI, imho.

>> 1b)
>>
>> $ git rebase --autosquash <base>
>> (i.e. -f is implicit) is made to be effectively equivalent to:
>> $ EDITOR=3D: git rebase -i --autosquash <base>

This would be my preference, except that it is the "--interactive
--no-edit" which is made implicit when --autosquash is used without
"--interactive".  The fact that these two options are implicit should
be hidden from the user and not required of him.  That both are
required seems to me to be an embarrassing, historical implementation
detail.

Phil
