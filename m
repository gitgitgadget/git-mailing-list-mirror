Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592A2AF12
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758539; cv=none; b=KdzOwhWIeBBjahVKjIY/75lmEN/MfeOa1r63ZtdcFF9mkacuC+NcCvqUyC4EwxD+NdBBUR6eWJ8JC/bwn6j9qCmjPjFVhRwasRnEDkIxPQRzPvJqNE8WmrUcmkpsVjqZWWeb5/DAWXy0VYf+SABay+jxSI+pXoNwz1ZFqLHPX9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758539; c=relaxed/simple;
	bh=OkYVNcx4IS+ZCh7dE3Rrdyr21hKzHr7cTyZ0l3TYk+0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=thAPfoEzHJt3UqBc1k5gP723KoGh82B2RcdbZ7w4ikBgwv9eGwdnvaUrLej5TuP6RDCUNpf2IYEaNUIrFaFm7Od6WsjiSiR9yVZpCdTVs/GT1urD2MDZIaivyIq6gqXJIdMvggqkCQQHi5GGWXqCuZHTDLD1Yntvi8Gxqc+04wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Mn+fuoSF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ay0THXGi; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Mn+fuoSF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ay0THXGi"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AE02E13801D4;
	Mon,  4 Nov 2024 17:15:35 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 04 Nov 2024 17:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730758535;
	 x=1730844935; bh=6tkV0nCZQSaalicryd0x9fu5Az/h+spvHQhbTzthOhU=; b=
	Mn+fuoSFfDOE+PtcFx9Oq9j8xel9bdDhLeNoHe5q/aU69rBpSQ9+kvaKdNbJ8o1Q
	7GG66wc8WqoOHrLEJLKNay0REqPi05nYwLRUwgREATawGqOY3csqWdUGYFcEph4e
	8lk7JM5Wo6n7+FohHL6xUryclG0Lhgm7NC4geooxcKgQg8dgdLGT17tZHbydvIZ/
	dEpZlsHTRzvrs7i2AKKfXo1OK2MxJduECNyOqA2nwYr+09DSFsg3y9xYMmQzaRZi
	u8HyHRedJF7nKGe3PZl3o2eA5W3o/lURWmkykVjDzAhBJnR6IpjaLvA13DaYvbsO
	ucnYjo9kgvj/fUuNWMPc5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730758535; x=1730844935; bh=6
	tkV0nCZQSaalicryd0x9fu5Az/h+spvHQhbTzthOhU=; b=ay0THXGiJ5RcO4l0V
	Uj2jaTqzEOTLheWSElfBVfKEUK/O92u8hkMZCgrv+6U/vPrIEB+MWvAFPdEx/qwC
	yt0t4yBUxeOB7rXfGFBurUfW6BqRiTU2AiFIpVuLOVqpTl99yE8Z9LqTHHdlQaTX
	ExwSG5pYT0iPTLojfqtdnsOuRKyQfsTssLik3ZJrSYwd6gukeQ9FlwWvVnhMpAdD
	O7KKZL8a4pYOamPpKi7aj1NUpR8XhXQwWq0fQ/LsMRdhKLsNoHTkPJZJTN5xR/eH
	c2rPgnB9I699bHYWVY14F3Um+u31Yf5SfKIBGoIJItOJ0suah6dzs5QWudjRcnPm
	954Mg==
X-ME-Sender: <xms:h0cpZ3LoLWVJ4TrnPy1MQgtTkMU2I4tnhIsUDGi_r3VubK_69hXjrF0>
    <xme:h0cpZ7KAcMDCmv994JmVQdHUsTXheN6Bo3BHBlZXHqNA6y-f2JTnJI-TiYtJVC83R
    iqtKJanKwZXRV3bcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheekgeeitedujefg
    veehvdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghlvghs
    thihohesshgtihgvnhhtihgrrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:h0cpZ_sP__rkhhwq1wFsaY9i4CPPd9D3oTSVcmHxSgbTp3V9NAQikg>
    <xmx:h0cpZwa8PLFNBGD8VG_UCkJgI3Q5akOrARCnUrj9QKve2Sl3vYoypA>
    <xmx:h0cpZ-Y2lc2R1957eHfDvrCJctsYAo30ZPk-H_J39DNa6YDkLFuhhw>
    <xmx:h0cpZ0CgySgXMLpaWoRav9SXETgM3qFWyPZfOMrtnH1VRaFlFN8xBg>
    <xmx:h0cpZxwC0ZNAYIQMCIosN8nfRo4wE8o1Vs0nkdRT3ovNDJmma_B2N9oe>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 71E64780068; Mon,  4 Nov 2024 17:15:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 Nov 2024 23:15:14 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Christoph Anton Mitterer" <calestyo@scientia.org>, git@vger.kernel.org
Message-Id: <305dc9f7-4bdb-40c5-92f4-7438a9ecd482@app.fastmail.com>
In-Reply-To: <ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org>
References: <ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org>
Subject: Re: git format-patch escaping issues in the patch format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024, at 20:24, Christoph Anton Mitterer wrote:
> Hey there.
>
> For some special use case, I wanted to write a parser for the patch
> format created by git format-patch, especially where I can separate
> headers, commit message and the actual unified diffs.
>
> There seems unfortunately only little (written) definition of that
> format, git-format-patch(1) merely says it's in UNIX mailbox format
> (which itself is, AFAIK, not really formally defined).

It seems to me (totally na=C3=AFve) that you would do something like

1. Blank line terminates headers
2. Then there might be some optional commit-headers which can override
   things (`From`)
3. Commit message
4. `---`
5. Look for a regex `^diff` line
   =E2=80=A2 Now the indentation will tell you when it ends
6. `^Range-diff` and `^Interdiff` can also make an appearance in this
   section

> Anyway, it seems to turn out, that no escaping is done for the commit
> message in the patch format and that this can cause actual breakage
> with valid commit messages.
>
> Consider the following example:
> 1. I create a fresh repo, add a test file and use a commit message,
>    which contains a From line (even with the "magic" timestamp) and
>    some made up commit id (0000...)
>
>    ~/test$ git init foo; cd foo
>    Initialized empty Git repository in /home/calestyo/test/foo/.git/
>    ~/test/foo$ echo a >f; git add f
>    ~/test/foo$ git commit -m "msg1
>
>    From 0000000000000000000000000000000061603705 Mon Sep 17 00:00:00 2=
001
>    --
>    ---"
>    [master (root-commit) c08debc] msg1
>     1 file changed, 1 insertion(+)
>     create mode 100644 f

At first I thought that it is a magic string for a reason.  But there
could be an organic use-case here.  Like someone who is merely
code-quoting the magic string.  And also using code fences.

    Parse the magic mbox string

    Turns out that Git has something weird: a magic string to delimit em=
ails
    or something.  Look here:

    ```
    From 0000000000000000000000000000000061603705 Mon Sep 17 00:00:00 20=
01
    ```

    It will look exactly like this except all those numbers in the middl=
e.

    Detecting this is all we need to parse that 80-message file that Ped=
ro
    sent us of our school project backup.

This will not apply because =E2=80=9CPatch is empty=E2=80=9D.

But if I change the commit message to use indentation for the
code block:

    Turns out that Git has something weird: a magic string to delimit em=
ails
    or something.  Look here:

        From 0000000000000000000000000000000061603705 Mon Sep 17 00:00:0=
0 2001

It does apply.

As for the `---`: it seems natural for people to use this as a section
break.  And I do end up needing that from time to time (maybe once a
year).  For people who stick to ASCII (`-` times 5):

    Detecting this is all we need to parse that 80-message file that Ped=
ro
    sent us of our school project backup.

    -----

    We should look into Pedro=E2=80=99s backup system.  Why does he use =
email?

Or `***`.

> 3. Adding a 2nd commit, this time using the unified diff from the above
>    patch as commit message body(!).
>
>    ~/test/foo$ echo b >>f; git add f
>    ~/test/foo$ git commit -m "msg2
>
>    diff --git a/f b/f
>    new file mode 100644
>    index 0000000..7898192
>    --- /dev/null
>    +++ b/f
>    @@ -0,0 +1 @@
>    +a
>    --
>    2.45.2"
>    [master 6bbe38c] msg2
>     1 file changed, 1 insertion(+)
>    ~/test/foo$ git format-patch --root
>    0001-msg1.patch
>    0002-msg2.patch
>
>
> 4. To no surprise, git itself of course knows the difference between
>    commit message and actual patch, as show e.g. by the following,
>    where the commit message is indented (by git):

This has happened out in the wild before.[1]  And the advice was the same
as what you=E2=80=99re doing here.

=F0=9F=94=97 1: https://lore.kernel.org/git/16297305.cDA1TJNmNo@earendil=
/#t

>
>    $ git log --patch | cat
>    commit 6bbe38c33680239ac9767e0e5095f9f32ad41ade
>    Author: Christoph Anton Mitterer <mail@christoph.anton.mitterer.nam=
e>
>    Date:   Mon Nov 4 20:00:20 2024 +0100
>
>        msg2
>
>        diff --git a/f b/f
>        new file mode 100644
>        index 0000000..7898192
>        --- /dev/null
>        +++ b/f
>        @@ -0,0 +1 @@
>        +a
>        --
>        2.45.2
>
>    diff --git a/f b/f
>    index 7898192..422c2b7 100644
>    --- a/f
>    +++ b/f
>    @@ -1 +1,2 @@
>     a
>    +b
>
>    commit c08debcc502c78786ec71d50686ff0445a13b654
>    Author: Christoph Anton Mitterer <mail@christoph.anton.mitterer.nam=
e>
>    Date:   Mon Nov 4 19:58:45 2024 +0100
>
>        msg1
>
>        From 0000000000000000000000000000000061603705 Mon Sep 17 00:00:=
00 2001
>        --
>        ---
>
>    diff --git a/f b/f
>    new file mode 100644
>    index 0000000..7898192
>    --- /dev/null
>    +++ b/f
>    @@ -0,0 +1 @@
>    +a
>
>
> 5. Next I try whether git am can use the patches created above in a
>    fresh repo:
>
>    ~/test/foo$ cd ..; git init bar; cd bar
>    Initialized empty Git repository in /home/calestyo/test/bar/.git/
>    ~/test/bar$ git am ../foo/0001-msg1.patch
>    Patch is empty.
>    hint: When you have resolved this problem, run "git am --continue".
>    hint: If you prefer to skip this patch, run "git am --skip" instead.
>    hint: To record the empty patch as an empty commit, run "git am
> --allow-empty".
>    hint: To restore the original branch and stop patching, run "git am
> --abort".
>    hint: Disable this message with "git config advice.mergeConflict
> false"
>
>    That already fails for the first patch, the reason probably being my
>       From 0000...
>    line in the commit message.
>
>
> 6. So trying again with simply that From 000.. line removed
>
>    ~/test/bar$ sed -i '/^From 00000/d' ../foo/0001-msg1.patch
>    ~/test/bar$ git am ../foo/0001-msg1.patch
>    fatal: previous rebase directory .git/rebase-apply still exists but
> mbox given.
>
>    and again on a freshly created repo:
>
>    ~/test/bar$ cd ..; rm -rf bar; git init bar; cd bar
>    Initialized empty Git repository in /home/calestyo/test/bar/.git/
>    ~/test/bar$ git am ../foo/0001-msg1.patch
>    Applying: msg1
>    applying to an empty history
>
>    Ah, now it works, so it was indeed the (unusual but still valid
> commit message).
>
>
> 7. Now that 0001-msg1.patch is applied, let's try the 2nd patch:
>
>    ~/test/bar$ git am ../foo/0002-msg2.patch
>    Applying: msg2
>    error: f: already exists in index
>    Patch failed at 0001 msg2
>    hint: Use 'git am --show-current-patch=3Ddiff' to see the failed pa=
tch
>    hint: When you have resolved this problem, run "git am --continue".
>    hint: If you prefer to skip this patch, run "git am --skip" instead.
>    hint: To restore the original branch and stop patching, run "git am=
 --abort".
>    hint: Disable this message with "git config advice.mergeConflict fa=
lse"
>    ~/test/bar$
>
>    And again, ... the reason most likely git not being able to get that
>    the "first diff" is not actually a diff but part of the commit mess=
age.

It did the right thing for me with this (last part) of the commit messag=
e:

    We should look into Pedro=E2=80=99s backup system.  Why does he use =
email?

        diff --git a/a.txt b/a.txt
        index ce01362503..a32119c8aa 100644
        --- a/a.txt
        +++ b/a.txt
        @@ -1 +1,2 @@
         hello
        +goodbye

***

The `---` part could show up in a commit message naturally.  I guess the
status quote remedy (?) is to get burned once with a failed application
and not use that as a section break any more.

It seems like it would be nice if format-patch complained if it found
regex `^---$` in the commit body.  It is not at all a magic
(obfuscated/unlikely) string.  If it crashes on that you can fix it
straight away.  Then you don=E2=80=99t have to wait for two email roundt=
rips and
an git-am(1) application.

The magic string is unlikely but could happen.  The solution is to use
an indented block.  Same for the diff.  (Hopefully few have to
code-quote diffs)

But escaping things in this format?  That has knock-on effects like
escaping-escaping.  Certainly with one-character escapes.  I mean if you
are trying to be resistant to all kinds of strings and characters, and
code blocks (with fences, not indented) can contain basically anything,
you could end up with likely collisions.  Then the format gets harder to
read.

Maybe with yet more magic strings since (unlike single chars) they are
unlikely to occur in the input:

    Detecting this is all we need to parse that 80-message file that Ped=
ro
    sent us of our school project backup.

    (blasphemous bath tub)---

    We should look into Pedro=E2=80=99s backup system.  Why does he use =
email?

And if you really meant to write that literally:

    Detecting this is all we need to parse that 80-message file that Ped=
ro
    sent us of our school project backup.

    (blasphemous bath tub)(blasphemous bath tub)---

    We should look into Pedro=E2=80=99s backup system.  Why does he use =
email?

But then the problem is that people have to look at that.  Just because
they wanted to use `---` for section break.  Then they=E2=80=99re probab=
ly just
gonna stop using it for section breaks.  Back to square one (could have
just forbidden it).

> btw and shamelessly off-topic question:
> Any chance that git format-patch / am will ever support keeping track
> of the branch/merge history of generated / applied patches?
> That would be really neat.

What does this mean more concretely?  :)

> PS: Not subscribed, so please keep me CCed in case you want me to read
>     any possible replies :-)

That=E2=80=99s the list policy.
