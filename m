From: Scott Chacon <schacon@gmail.com>
Subject: Re: EasyGit Integration
Date: Wed, 10 Jun 2009 09:48:22 -0700
Message-ID: <d411cc4a0906100948qd499996o8d092686a1643167@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
	 <4A2F0B8A.9010203@vilain.net>
	 <7vws7khlvj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 18:48:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEQyU-0002Hf-O7
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 18:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921AbZFJQsW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 12:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755681AbZFJQsV
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 12:48:21 -0400
Received: from mail-px0-f200.google.com ([209.85.216.200]:33594 "EHLO
	mail-px0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbZFJQsU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 12:48:20 -0400
Received: by pxi38 with SMTP id 38so833811pxi.33
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=03ZAWcBct3krdMTu+QHUS+mdjtg3c/cI5twwRzPmtyA=;
        b=cfR8X0HARIn5k0ShmrdvO4QPb+IgAW73wdTlmWpN45vmFl+6UQgQAAQa1YapvjSI7z
         50OQJSze6NrJOxZBoqlvMhtT+G3FUETr6dRG9EI1JfGlQeiiq0QZ63ek2eLHimQ5aEWB
         oyutj+dBk6d6IoKqattbdQ43KSrtvES8+2MPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vk3N8SOYLstEf2YVemUdV4k8HhSbzzzfa2eV+ruWs1J4WEySj7oa8hbUn8+/K6JWeH
         wl4TXdt7jGzZIWcfHJwDnZi/WaHbYhVkF7xIW+3+VFU3dcZICzTpaI9AfKODZjoD7pEG
         sEuooLpLIudkwaSDCNfkgvnEl90sUx381QWBs=
Received: by 10.142.76.4 with SMTP id y4mr562617wfa.172.1244652502423; Wed, 10 
	Jun 2009 09:48:22 -0700 (PDT)
In-Reply-To: <7vws7khlvj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121286>

Hey,

On Tue, Jun 9, 2009 at 7:18 PM, Junio C Hamano<gitster@pobox.com> wrote=
:
> I do not think introducing "git revert-file" (or "git revert -- path"=
) is
> a problem at all. =C2=A0But "git revert $commit" has been and is an i=
ntegral
> part of the established git workflow, and I do not see a point in cha=
nging
> it to mean something else, with any deprecation period.

I would vote for simply adding 'revert-file' rather than overloading
another command with two completely different actions.

> It will bloat the total number of subcommands you can give git, with =
the
> end result being

It just seems that this is sort of a paving the cow paths practice - I
see a lot of people creating aliases for 'unstage' and 'revert-file'
and 'uncommit' and things that are relatively common but difficult to
remember how to do because they have very obscure syntaxes
(syntaxen?).

Worrying about subcommand bloat seems a tad silly at this point given
that there are over 150 valid verbs now, right?  If existing commands
do categorically different things depending on input values, doesn't
it make sense to simply have different verbs exist for each separate
action?  I mean, worrying about the usability issue of having too many
commands but not thinking that making users learn 'git reset HEAD
path' is an issue seems really strange to me.

> If "eg" (I do not have _anything_ against it; the discussion applies =
to
> other Porcelains as well) were kept independent _and_ offered complet=
e set
> of features that users need without resorting to git-core, on the oth=
er
> hand, the students do not have to know about "revert", and the manual=
s
> they need to consult will not have to talk about "if you are using
> git-core, this is done differently in this way". =C2=A0The learning c=
urve will
> get a lot smoother for new people.

I think I understand the argument here, but I really, really don't
want to suggest to people to install Git and then install a separate
porcelain, and then have them spend time learning a command set that
is completely absent from other machines that have Git installed.  I
realize this is also an issue with adding new commands (in that they
would be absent from machines with older Git installed) but that issue
fades away after a few years, where the previous does not - in fact,
it becomes a far more difficult problem.

If it's not installed with 'apt-get git-core' or what have you, then I
(and I assume others) are never going to waste everyones time teaching
them a niche tool they will never find elsewhere.

> But aliases for doing essentially the same thing in slightly differen=
t
> syntax? =C2=A0I'd rather not to see them called "git foo". =C2=A0In t=
he end, I think
> it will harm the users, both new and old.

It would be one thing if I were suggesting that 'git revert' be
changed to 'git regress' or something - it's not a simple naming
issue.  It's more that things like "git reset HEAD <file>..." to
unstage simply makes no sense unless you have a pretty technical
understanding of reset, the index and HEAD - none of which a beginning
user should need to learn right off the bat.  Unstaging files _is_,
however, something that a brand new user will need to do right off the
bat.  The only paths left to them, then, are either learning the
technical details of the index and 'reset' to understand why that
command makes sense, or to simply learn the command by rote - which is
nearly always what ends up happening, since it's incredibly difficult
to learn the index well.  Hell, I've been using Git pretty extensively
for years now and I still have a hard time remembering exactly what
'reset' will do in different circumstances.

Easy things that users have to do a lot should be easy, is all.
Besides just being nice for users, it would probably save a lot of
grief for you guys with people asking and complaining about these
things on this list and the IRC channel.

> If you go back to the list archive, you will find me suggesting a new=
 set
> of commands with "gh" prefix, back in 1.3.X days, I think.
> I was not joking. =C2=A0The reasoning was exactly the same, and it re=
mains so.

Again, having to explain to people "most of the time you use gh for
all this stuff, but occasionally you use 'git'" or vice-versa is just
confusing and error prone.   Introducing some command denormalization
for the sake of getting new users on their feet with less friction
seems less painful both for the developers and experts having to help
said users and for the users themselves.

I wasn't suggesting a core rewrite, I just thought that hitting some
of this low hanging fruit - again, paving the cow paths as it were -
might be relatively painless and save everyone a lot of time.

Scott
