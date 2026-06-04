Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA461F78E6
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780608494; cv=none; b=rdhNYVDBOXUvTA0xWa4tXWuLFnrzEJN1OG5AF1AKBp7MIoZhWW4rjMbV8ORO/T5BU9z0aJ/UgWk4HeacMJCjtXBw++6OvHuUST7zUp3bIbi8tXNGl5rGYU7ArIGQXhZ6TiwH8sI0KnbSAdjkl0f2miHuSomCu8d7CBBHKnf02dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780608494; c=relaxed/simple;
	bh=3Ygbgn38i5nvQS+fbNVfmAlFK3qYczkM+FspnXP7YJE=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=fl6Y7yoZtl3t0xkteROnKBvvLCXbHm5zh3mf6438KbEkBrMuZQFQvaKfCy7mFlYcc2/YgMbDkvI5xuFJXyO70xCKccrGHZE4yLmiZtVhlR/LWjun+WPdDVCQFlB/a5D1n46n4ewNpK75/WLTMNVhsr96v1wh3NepagaP74/BhLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=onxLu8Kk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iYnOHtOi; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="onxLu8Kk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iYnOHtOi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4E17C7A0019
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 17:28:12 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 04 Jun 2026 17:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1780608492; x=1780694892; bh=BR5VwOOnjT
	HkY3+e87Z6hwfTtHI8w5WKy3d98vwhpB8=; b=onxLu8Kk21SL28KcnqRM+gRDBx
	GqNnI6l0BJcu7SFAJhjVDeGz1peFek1YGTOhi9T2INBp6m3/PZMwpHdVcdPo1Wwl
	8rEVIJtcwA8mW5qe3eYQTT6I2P4aTDKbgfkpPwrTjQwMIzudKgfdkxIcdvEWlhpK
	CrDesRS1vy73Zdx9Kn8VTo+8QgWXBGBZvgu95cLS54qCk7ACkrcK7dhcdCnvSuzR
	JjezykxNKViui3GT6hlssIo4OmiuZ1o+cUIeSevEKUYbcH9jERwmy5fgV4ymu7kW
	+n2gxcVTYHrc2GXGRmZGuZSa0zbntv5uXVX3NYk0WtQQN35q27YciivCkT3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780608492; x=1780694892; bh=BR5VwOOnjTHkY3+e87Z6hwfTtHI8w5WKy3d
	98vwhpB8=; b=iYnOHtOiFxovMjUkj3C2wwZE6ylYq2E3xReTv1zxuQuPQpmzGNM
	pfDeqoQyVjgalDjR1NnCnMg6ETr9kBq85zaLpaxYwSUx6Alq5UUDlKOitW7bXgyR
	If407JP61ZKematBeic6VYGg9TKt2Ld7xm+Z4gGYblFUjLhmYlvX5CHN7yUOuVoq
	dfVGw1NtvpMBf2rKXhoiNDnpjViWsmdqQy223+2YFNDgwzdFDwJFTDnJwkHgKEkk
	ynDoqLnJsxH00L7mEZxk+lfXLGVb1kDAi8gIRCvDBDTSykEEYRFjoSMiGYpw0Qv9
	0YOfPeVZU3WE6yaG5Bq6PEmKS2/s6jk5CJw==
X-ME-Sender: <xms:6-0haq3eVnZuIbYU7WAQRFy4SfzPyd8lbTl3nu2uFJx2qsKLstwuqXw>
    <xme:6-0han4RF5hKYTfivLqkIunYPTK1czbqu7nc8LfUtovIyxJDcgHFYFpCLMgERxLty
    TnNrtaXS63yx3YXV5jAgosyLatLVPWd2ztLYcsiwitzoJM4riuc>
X-ME-Proxy-Cause: dmFkZTFO/ofB7xRr8V7JlKp/jf77UwULA2yV+axoqIjno9ZqrY8rbDzGH52Os7ShRP4pW7
    GNFokdA+zSNMUQQ/takgl2rbPVzfXXGYEZ1ZBDJk8tuqC0L5Gtzbr2s1PBfTDAUjqHe4Mz
    WDTjvbIHGbjvdXY0AizySsI8ghxHz9EJZOx8DQxcbAwnYT2Yhm1JbWJSp6YLoim/l0l1Ne
    7cTCvum9LgYpPt2yKLJ9lwUKjX9p4bdp7ZLCH6Q5bqRG6fwFzteij6ecIQxYNBFHbYns4l
    pUUyaBG6ajDEVJymU5V4RfCz2M0ulF6r+Ijwl1OrauWyiltrqbbBwT2KWh/DYbAFb5DBHD
    DjzhIuwNxkr4LmAotydcTzhG/6a2Rl43c9ziVSh77aTL9Vj0+CmgBPw2yodh/EWHt2vBK9
    e1bfA5+cTta1O88qjGrPE++cQvX96KzoRu+MiXxcqFZ4KXLV4DEDRS4XxP1XW83NoeSEW1
    D0W5TWh0vkQCEVzktKo5oJhlwvyEcfudiSxBkyQo9esXjw5xPFaoRPQBk37VfQiNZ4BzGh
    1+tul+q5IetKLfxU+eqr7j6es8Up+pfdcQ40EI9HRVAS3KYmYt/KxiKwQy11BU6gBaI4jy
    dYNQn3TscaAdrYkZ94rH0AN0vAXEETPMlCVpGKI4hMhugV14ltLrmKYXqfGw
X-ME-Proxy: <xmx:7O0hamlBKNi6y4sc5nAvDkBO8nT_MCPQGuB3iYvUnrkuF5bWN6cRTg>
    <xmx:7O0hatywKfeHH5kBitoHIWZQXrwMNOS8hlniGGUbQmP7rwmzIrabnA>
    <xmx:7O0hahjrmiW4rIW14skVHexox5qRX2M0aZkxTuYI78gMGdIt_PdJ2Q>
    <xmx:7O0haiWW-H3Y8Qx65WGVipa63wTS4pmPJqiihrRueDCxcu6SZ-7W_w>
    <xmx:7O0has7v3DTPBBwHEHTbN8dA-YiYLslZBB-ET2lhKCz66dr-PFNEM-TZ>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E5278302008E; Thu,  4 Jun 2026 17:28:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 23:27:51 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Message-Id: <ae4a32e7-bacb-4c88-b2a0-5aeaff60b904@app.fastmail.com>
Subject: trailers: --only-trailers normalizes URLs to trailers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following is a bug that follows straightforwardly from the documented
or discussed behavior. In that sense it is not a bug. But it is a bug in
the sense that it makes things inconvenient and violates a design goal.

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issu=
e)

Ran what is the equivalent of

    git interpret-trailers --only-trailers

With

    git log --format=3D"%(trailers:only)"

> What did you expect to happen? (Expected behavior)

For URLs like https://www.digsm.xyz/ to be left intact.

(Well, did I expect that? It follows from the discussed behavior...)

> What happened instead? (Actual behavior)

URLs on a line by themselves in eligible trailer blocks get
normalized/canonicalized to a =E2=80=9Ctrailer=E2=80=9D with key e.g. `h=
ttps`:

    https: //www.digsm.xyz/

> What's different between what you expected and what actually happened?

In an ideal world to have some special-casing of URLs so that they are
not detected as trailers. Does anyone realistically want trailers like
this?:

    file: //...
    http: //...
    https: //...

Maybe a C-style comment?

    https: // I changed my mind about providing a URL here.
        This comment is a placeholder.
    Comment: // But next up we have a URL
    https: https://protocoltwiceover.net

And this is where my imagination ends.

Just special-casing `https` would go a long way.

> Anything else you want to add:

Yes, after this [System Info] part.

> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.54.0
cpu: x86_64
built from commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
gettext: enabled
libcurl: 7.81.0
OpenSSL: OpenSSL 3.0.2 15 Mar 2022
zlib: 1.2.11
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.8.0-117-generic #117~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC T=
hu May  7 22:17:46 UTC  x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash

[Enabled Hooks]
commit-msg
post-applypatch
post-commit
sendemail-validate

***

That things like `--format=3D'%(trailers:only)'` normalize trailers is
known and has been discussed before.[1] There=E2=80=99s been discussion =
around
the key capitalization and prefix normalization. But this is not about
that. This is just about normalizing the separator part.

=F0=9F=94=97 1: https://lore.kernel.org/git/87blk0rjob.fsf@0x63.nu/

One design goal for trailers (either by implementers or reviewers or bot=
h)
has been to avoid false positives.[2] That meant trying to avoid
detecting trailers that were not intended. For example:

    Everything was better in the past. Let me not even start on this
    rant: it is not good for my blood pressure.

This will not be picked up as a trailer block unless `rant` is configured
as a trailer key.

=E2=80=A0 2: See e.g. Jonathan Tan=E2=80=99s series about among other th=
ings adding the
     25% rule

     https://lore.kernel.org/git/xmqq7f96sa9i.fsf@gitster.mtv.corp.googl=
e.com/

But that=E2=80=99s pretty innocuous. Just a misplaced rant. The topic of=
 this
bug report is not a big deal either, but it is:

1. Structured data that gets mangled in this normalize mode
2. That can naturally go at the end of the message on its own line

And these two points are very relevant for people who never use
trailers. Or, wait. I guess it isn=E2=80=99t if they don=E2=80=99t use t=
railers and thus
will never normalize them. But it is relevant if they work on a project
where someone else does that.

IN INTENDED TRAILER BLOCKS [3]

And then there are things that can go wrong if you intend to write trail=
er blocks:

1. =E2=80=9CNon-trailer lines=E2=80=9D that are URLs get normalized as t=
railers (NTL for
   short)
2. User error line wrapping turns one trailer into an empty trailer plus
   a `https` trailer (LW for short)
3. Normalizing trailers along the way (as in patches in flight or
   something) introduces this strange lossiness (NL for short)

I did (2) (LW for short) four years ago it seems:

    See:
    https://digsm.yxz/blog/important-context/?bigtechtracker=3D86b0c5a1e=
2b73b08fd54c727f4458649ed9fe3ad1b6e8ac9460c070113509a1e

=E2=80=A0 3: Are all-caps titles good or bad? Let me know.

IN THE LINUX KERNEL

There are some hits for the `http` and `https` trailers when trailers
are normalized. The baseline:

   $ git log --extended-regexp --grep=3D'https?: //' --oneline | wc -l
   12

With normalization:

    $ git log --format=3D'%(trailers:only)' |
          grep --extended-regexp '^https?: //' | wc -l
    245

Note that I have no idea how the Linux Kernel is run. But I don=E2=80=99t
imagine that there are uses for `https: //...` trailers.

And trailer usage is complicated. There are for example on-purpose
indented `Link` =E2=80=9Ctrailers=E2=80=9D, presumably for the purpose o=
f *excluding*
them as `Link` trailers. See:

    commit d80a9cb1a64ab9c817b6262c7e4e433b6a3581a0

    <body>

    [ljs@kernel.org: avoid bisection hazard]
      Link: https://lkml.kernel.org/r/d0cc6161-77a4-42ba-a411-96c23c78df=
1b@lucifer.local
    Link: https://lkml.kernel.org/r/c2be872d64ef9573b80727d9ab5446cf002f=
17b5.1774029655.git.ljs@kernel.org
    Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
    [MORE BELOW]

Is that indented link for that `[]` comment? I dunno.

But what=E2=80=99s the main topic here are intended non-trailer lines wh=
ich are
URLs that get treated as trailers (NTL). Like this invented example:

Reported-by: ...
https://digsm.xyz/?avastvirus=3D5891b5b522d5df086d0ff0b110fbd9d21bb4fc71=
63af34d08286a2e846f6be03
Signed-off-by: ...

Or this real example where the URLs are clearly part of a =E2=80=9Ccomme=
nt=E2=80=9D
non-trailer run.

    8236fc613d44e59f6736d6c3e9efffaf26ab7f00
    Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
    [bhelgaas: squash fixes:
    https://lore.kernel.org/r/20260108013956.14351-2-bagasdotme@gmail.com
    https://lore.kernel.org/r/20260108013956.14351-3-bagasdotme@gmail.co=
m]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
    Link: https://patch.msgid.link/20251210132907.58799-4-xueshuai@linux=
.alibaba.com

(These are shown as they are written in the commit message. Normalizing
the messages would create `https` trailers.)

Here are examples of line-wrapping mistake commits (LW) for `Link`,
`Closes`, or `Fixes` (sometimes these point to bug URLs and not
commits):

    5bd97f5c5f241a5610c4412d1b93995a26241f81
    Link: https://patch.msgid.link/20260216-work-xattr-socket-v1-4-c2efa=
4f74cb7@kernel.org
    Link:
    https://lore.kernel.org/3cnmtqmakpbb2uwhenrj7kdqu3uefykiykjllgfbtpki=
whaa4s@sghkevv7jned [1]
    Acked-by: Darrick J. Wong <djwong@kernel.org>
    Reviewed-by: Jan Kara <jack@suse.cz>
    Signed-off-by: Christian Brauner <brauner@kernel.org>

and:

=E2=80=A2 24abe1f238e7d7ac56be6374c52a3c13dab84f69
=E2=80=A2 27e21516914dc130a79aa895a5a26e18f0213a5a
=E2=80=A2 be3536a4bdda53ff5a91b7e542b167d12bddb317

Finally there is this commit which has a trailer in the commit message
itself with the key `https` (NL).

    commit 496c0c4c53bbe1bad97e82cd12103df61a6e459d
    ...
    ...

	net: wan: fsl_ucc_hdlc: free tx_skbuff in uhdlc_memclean

        <body>

	https: //sashiko.dev/#/patchset/20260429114208.941011-1-holger.brunck%4=
0hitachienergy.com
	Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
	Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
	Link: https://patch.msgid.link/20260507155332.3452319-1-holger.brunck@h=
itachienergy.com
	Signed-off-by: Jakub Kicinski <kuba@kernel.org>

How could this have happened? Follow the patch-id link.

https://patch.msgid.link/20260507155332.3452319-1-holger.brunck@hitachie=
nergy.com

    https://sashiko.dev/#/patchset/20260429114208.941011-1-holger.brunck=
%40hitachienergy.com
    Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
    Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>

So it was just a non-trailer URL line as this person submitted it. But
presumably the person who applied it put the message through a round of
normalization.

Cheers, good night

--=20
Kristoffer
