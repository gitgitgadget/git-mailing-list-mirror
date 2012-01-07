From: demerphq <demerphq@gmail.com>
Subject: Re: Aborting "git commit --interactive" discards updates to index
Date: Sat, 7 Jan 2012 15:16:54 +0100
Message-ID: <CANgJU+WGEBMMQzsGyQSnMBK3Q8Z2XZdbDx4nr-tB-s0uYEU9CQ@mail.gmail.com>
References: <CANgJU+X+qLe3Aqy_ZpoSDKMuf=8=OxVvpkt0tGmSi=KVgti3HQ@mail.gmail.com>
	<7vvcoogkw8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 07 15:17:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjX4x-0006wR-8y
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 15:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896Ab2AGOQz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jan 2012 09:16:55 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44824 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab2AGOQy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2012 09:16:54 -0500
Received: by yhnn56 with SMTP id n56so997419yhn.19
        for <git@vger.kernel.org>; Sat, 07 Jan 2012 06:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=k3beHqi8oVVPTorTMtdSs2+/gL419qmDHVbBpHB96ug=;
        b=G/4keseHK1ogxDXA3myv4HyPrhQ63xTCHePIU6HKzZ9Q3KDSFmZFrzuCyJPY4/pfxL
         lAuXaPZzOvSWaitsOi5bGqXPdGttWmNqGJl8yGkNQ9m25hSrHBgfHIhrtXIpvOLSsDiq
         ioFarUXLkHqqi6l1oyoM+3kSjtu2TQhwvUHwk=
Received: by 10.236.139.234 with SMTP id c70mr12791969yhj.33.1325945814131;
 Sat, 07 Jan 2012 06:16:54 -0800 (PST)
Received: by 10.236.63.2 with HTTP; Sat, 7 Jan 2012 06:16:54 -0800 (PST)
In-Reply-To: <7vvcoogkw8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188077>

On 7 January 2012 06:08, Junio C Hamano <gitster@pobox.com> wrote:
> demerphq <demerphq@gmail.com> writes:
>
>> On 27 June 2011 17:59, Junio C Hamano <gitster@pobox.com> wrote:
>>> The latest feature release Git 1.7.6 is available at the usual
>>> places:
>>>
>>> =A0http://www.kernel.org/pub/software/scm/git/
>> [snip]
>>> =A0* Aborting "git commit --interactive" discards updates to the in=
dex
>>> =A0 made during the interactive session.
>>
>> Hi, I am wondering why this change was made?
>
> I wasn't directly involved in this particular part of the design of w=
hat
> should happen to the index when a commit is aborted, so I would be a =
bad
> person to give you the first answer, but let's try.
>
> If a "commit" session is aborted, it is logical to revert whatever ha=
s
> been done inside that session as a single logical unit, so I do not
> particularly find the current behaviour so confusing. It might even m=
ake
> more sense if we update "commit -i" and "commit -a" to also revert th=
e
> index modification when the command is aborted for consistency.
>
> You are welcome to rehash the age old discussion, though. Personally =
I do
> not care very deeply either way. I would never use "commit --interact=
ive"
> myself, and I would not encourage others to use it, either, even if w=
e do
> not worry about the behaviour when a commit is aborted.

If I were to provide a patch to make this behavior configurable would
you have any objections? I personally much prefer the old behaviour. I
want it to leave the stuff in my index.

>
> One thread of interest (there are others, as this change was rerolled=
 at
> least a few times) may be
>
> =A0 =A0http://thread.gmane.org/gmane.comp.version-control.git/173033/=
focus=3D173035

Thanks.

> Having said all that,...
>
>> .... I am writing this after spending about 45 minutes showing a
>> colleague how to use git commit --interactive, when we realized that
>> we had forgotten to add a file....
>
> ... if your partial commit is so complex that you need to spend 45 mi=
nutes
> to sift what to be commited and what to be left out, you are much bet=
ter

I was showing a colleague how to use the features it provides on a
large patch where the committer wanted to keep various bits and not
keep others.

> off to run "git add -i" to prepare the index, "git stash save -k" to =
check
> out what is to be committed (and stash away what are to be left out) =
so
> that you can make sure what you are committing is what you thought ar=
e
> committing (by asking "git diff" and "make test" for example), and af=
ter

Isnt this what the diff option in commit interactive is for?
Personally I tend to review patches in detail before I push them, not
necessarily before I commit them.

> convincing yourself that you made a good state in the index, make a c=
ommit
> with "git commit" (without any other arguments) and conclude it with =
"git
> stash pop" to recover the changes that you decided to leave out.

I personally have never had an issue with git commit --interactive so
this procedure seems really convoluted to me, and a lot harder to
teach to a colleague than "use git commit --interactive". Is there a
real problem it solves?

> "commit --interactive" robs me from that crucial "verification" step,=
 and
> that is why I wouldn't be a user or an advocate of this "misfeature".

I understand. But that is a workflow directed to statically testable
library code. Our workflow doesn't really depend on a "make test"
phase. Also, if I calling git commit --interactive (or git add -i),
then I am as confident my code works as I can be, and the reason I am
doing an interactive step is for instance to edit out debug lines, or
separate out whitespace changes from code changes, or to break my
change set into several logical groups.

> By the way, why did you draw =C6var into this discussion? I do not th=
ink he
> was involved in any way with the design or implementation of this com=
mand.

He is a git hacker, and is a friend and colleague. We both work for a
largish dotcom which uses git as our primary version control and we
have collaborated on a tool I wrote to use git to manage our rollout
processes. So when something git comes up it is natural to me to CC
him.

cheers,
Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
