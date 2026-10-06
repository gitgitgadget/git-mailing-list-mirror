Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A349E5D2
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303430; cv=none; b=m4si6QGFgIF6QLgrNY7PXlzxER4WK0dKtzXoGVBofjRxPp1pYLdjWgrlYpYMc8VrdckV8x5BSshJJiaeSsVDCehnVfJrNbI6hdMFMGHXbuKASWQW9v6viTlJYuQFFNhgYbkmbFegTka9C5Vb4Jkw7TodotmPw+MwIcXDowktLV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303430; c=relaxed/simple;
	bh=5yI2g8ygdjNfz0Ho03fPQfrysZg/wmEG5ZU+OerxDLc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rHc/63xu5ycdWqjLSFZjj0HYchIVfpjCNqtyIXfg6mr0rkoYwpDIsgQ/iCf3x6rs5BaRiqoUHHbk4yBxewSUJVrlWNwg/Vm8UiEBu0NwqKQtf9PhaLfKzrZ/QoPh8uIRC+PabsW+4Yaqhm8AhoJLFePo++446vlQMDq1sShMYMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cQrEj+NN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bUDIaFqn; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cQrEj+NN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bUDIaFqn"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23393140003E
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:17:05 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 06 Oct 2026 12:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791303422;
	 x=1791389822; bh=TMUmj41hUw4qjhLs8CaNp7qFMpd8JeXqtD67Yh+SUs8=; b=
	cQrEj+NNxDUKY3ArAcA7d7h1AR9h6JoVDHJYDvcNh2NOrLZgzHmo3hHIzc+6N5mC
	d1m0EWE3Nn8QBtmYpvkqxYZaoKi0F4kBlK7NqNfd4EZVTGZjDd9APH267HSVZhSh
	hMJ3IxX/CYs/ULcYbA83AtelK9/9kxRmDiF/VW+XRDkOvjHZa73I3GI+hpvn+Faf
	NTrIIFX1waNT1eXQ+fnnqi3z1Mp1RTsPdVVDD0kSO8eahi+nbaZVqngFksn2Lhoa
	1KdCcfrFrubUQgLQQOPjtNO+eMSwWHgWMUbHmvSSSLdWj4UsrIRI9Q8sHuVsAMUx
	3SmL7BFhSifAXj1eeUJevw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791303422; x=
	1791389822; bh=TMUmj41hUw4qjhLs8CaNp7qFMpd8JeXqtD67Yh+SUs8=; b=b
	UDIaFqns/4yktCEiEOeZ9HoZOdc+co1iJeH8vo/bLtXEGy4GlaZnHkv5caGnxEPl
	2mklqVh3tSK+Ei5dbGhNQUPxsGK1SXEOQw4wODrFbQzNTVuQz91LHKA7JL6KNKZW
	ekGLHCx2evg7fsgSoLocNPiZj6pXLIB8Wbext/rhLv1NV0OUQO6zD1in2PGrSN/z
	5Llz8MvMBnuxfAImCFJr9Ok1UZMTd13os+mYekErNH13npeV9UYQccbderyko7wx
	s0ynjMcbvEkSdUP9XFetcXSAfbR7YoXVvrgwr1gB7i2Sne+fBVzQOW9N6aUeplCe
	8sMk81ZBSa4hB2v01JYbA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791303422; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:n7AVsnbGRut/O0cmsmYSUc0/n7Fx23A+gr+Vg+N5j6qM4jq
	O9muzLP5n9MPibp1SdCe5Z60zuUyocOc4XoQqoTykRw60EV7/tMDcKeZxM7VVNYM
	HhewKuUI9hY4xXcg2WJARHUU9JUHaexcxtJoyzsWAiRqfhNi4hUhRP2eWtgU6Pbk
	jAFjnAx3GKzrgrooUS7vqlLyC6rZADT7sRyVBmWJnLBpQcw4/7nWzT1F+z0f0/mR
	6n62CnrEwKKWZZJHg6KpOpC6WcllqRhy9sRaIpPS+lVfkqIpnE5G+8lq+ltdmD0q
	2Yn9ukIRLu04ud99p2gKhCMyrb5frt5pWKVp3+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iaJIx8f+cgDOudOja8HvrPdUTCTR5R2531rMOkSPG2A=:5yI2g8ygdjNfz0Ho03fPQfrysZg/wmEG5ZU+OerxDLc=;
X-ME-Sender: <xms:-x7FaqcQO4uFn7DIAe2XDUM1fROmX8dzBp9IFTQznmDXMY9KwaNo2bo>
    <xme:-x7FavD0nmBvtt5ztF7v1BIkYEX_TutYxL01Lfl9UZGT_WoFDYw2ma5qXD8sNypi6
    l6vh307aoc6cCPbLQPNe1YrYR7lvf5hrJ5fkXk3k-NozepIQvEzaYg>
X-ME-Proxy-Cause: dmFkZTEO3B/YGQEmQSiAzm2eppY+CyeOaoBJFr03A0C8CQq6DpVj1HvaFPNqVsq/p8MlCy
    cD5NJeVYyBNJ67Kwp3L3qDwN5lJRmqUUH9VTajqJSTYvMmvZnIOK9mPJQdQL8yiagTDJRt
    uC+uIX3s2XxpzamaHG8Xa+nhkCpn7nSFcvLqwsGxNu6eNP6g5K43ffahi6n2LSD9WcCSyi
    hg9hJCtmd+JJnzc34z/2XMsUGw0L7CpDcewp86smbJoqLp5ElD6dGclIggJI3t/7qdrz4o
    LwW5D1Q5pDUq7zqc4cGgeonLjX0IOJPGOAbERmGlPNLLR4Em5twKEN8axpCJPNNahNjYnr
    JQtYme4dEDoQS+kzLwviQqFvgVWMVp0pRSF8q89ogZC6ukTBpUejABf3lnp1cSq1SBfFSV
    wvkoxhvKbG+zAWeT8LxhCmqsR36EoPcmCHu/ZDtun1pdWgjjwzeii3d3gpMsl60C/xCKsi
    Toh1fyd94Ss8j3FyBQhWT08HkSsLtwF0zlg8A8rz/6zXifJ8UyWY8RDe7dlSHqeCIsavTn
    2p6vfvtSNo9o4/uyLzRo3ICU5p+bv+8EIg3P3KFMyqXnZc7KZGqF+0nVpZtBS9Rl9hIrK3
    oyrWGI6G51CPP5ocSKv+yUXkCv+fXNxcDQxw0dTb/2b498qtmqBKiQkLGKxQ
X-ME-Proxy: <xmx:_R7FalAGrSKoRWCbtgvTxZsOqbhyRFLXxkS_VTjygAEmoMO9TmzZRQ>
    <xmx:_R7FagpNLZ4F2Nk25vYc8EV8Ir2_Um4h-7HXfWX9VVeuHSTMWNeiAA>
    <xmx:_R7FavkitcHmT8yQNx9hnoWdyXcUAFjVlQRrvQAjDUfpHdKFGtcTDQ>
    <xmx:_R7FagziULnSgvwNdCDQBpx7QDDMYIwQFYXp4UlOQb2Ftm3IiKg7_g>
    <xmx:_h7FaobdQsRUCxfPE-v0KeD7sCh8OqItJEcTkJjAsXP1pgYecUPFEPXX>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A63B822C009E; Tue,  6 Oct 2026 12:16:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFHk59oX2pKR
Date: Tue, 06 Oct 2026 18:16:07 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Scott Chacon" <scott@gitbutler.net>, git@vger.kernel.org,
 "Scott Chacon" <schacon@gmail.com>
Message-Id: <d59dfe7e-5958-4a72-92d7-788521f3e55f@app.fastmail.com>
In-Reply-To: <asOa6dgpj0qV5QAU@pks.im>
References: <20261002081846.25144-1-scott@gitbutler.net>
 <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
 <CAP2yMaKF4CRvtfTQDVe51SqEm_DnoVOmED5kcUSg7UvLkBp4Xg@mail.gmail.com>
 <asOa6dgpj0qV5QAU@pks.im>
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits and tags
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026, at 14:41, Patrick Steinhardt wrote:
> On Mon, Oct 05, 2026 at 11:32:54AM +0200, Scott Chacon wrote:
>> On Fri, Oct 2, 2026 at 9:06=E2=80=AFPM brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>> > On 2026-10-02 at 08:18:42, Scott Chacon wrote:
> [snip]
>> > Every major forge has support
>> > for SHA-256, whether publicly or in preview,
>>
>> Nobody has access to this for GitHub, which is where almost all usage
>> is and where the kinks could theoretically have been ironed out. If
>> 3.0 comes out in March, there will have been no time for anyone to
>> give feedback or make substantial changes before everyone is forced
>> into real usage of this highly incompatible change.
>>
>>[snip even more]
>>
>> As one small but interesting example, I'm honestly fascinated that
>> there is only now a thread here about the GitHub specific usability
>> issues [2] with mixed odb repos (between several GitHub-y people,
>> nonetheless) that hasn't been previously considered (the "limbo"
>> idea). This is the kind of thing (among many others, I'm sure) that
>> would come up if people had time to use this at all before a default
>> switch.
>
> The biggest problem I have is that the ecosystem has been entirely
> unwilling to do anything about the SHA-256 move before we announced th=
at
> this is going to become mandatory. Only then were developers even able
> to convince anybody (especially those paying the wages) to get the time
> to implement support for it.
>
> So there is some kind of ossification happening in the space. But thin=
gs
> are finally moving now that the due-date is drawing closer. I would be
> extremely hesitant to change course again and drop this breaking change
> now that there finally is some movement. Because the only consequence =
of
> that would be that the ecosystem will stop working on it again. And ev=
en
> more so, I would even expect that this will make the next time we want
> to do a breaking change exponentially harder as the lesson learned is
> that nobody needs to do anything.
>
> Maybe I'm too pessimistic about this, but I don't think so. We've been
> working on this whole transition for almost a decade by now, and only
> now where we're forcing the ecosystem to adapt are large players like
> GitHub even moving.

The wider ecosystem is one thing. But git(1) itself doesn=E2=80=99t seem
ready at all.

A few days ago, having read Scott Chacon=E2=80=99s blog post and discuss=
ions
around it,[1] I wanted to test migrating the Git repo to SHA-256. So how
do I do that? I google around and the most official =E2=80=9Ctransition=E2=
=80=9D program
seems to be this.

https://git-scm.com/docs/hash-function-transition

I.e. a document where you can=E2=80=99t really tell the implementation f=
rom the
aspiration.

=E2=80=A0 1: It seems he has never linked it here on the list, like in t=
his
     thread.

But okay, the *real* program to convert a repository seems to be

    git fast-export --all

And that was okay. The Git repo seems to have a bit of cruft, and
git-fast-export(1) fails on the first error then suggests a fix so that
you can continue on to the next error. But that=E2=80=99s fine for a one=
-shot
program. For anyone interested:

    git fast-export --all --reencode=3Dyes --mark-tags \
        --signed-tags=3Dverbatim \
        --tag-of-filtered-object=3Drewrite >SHA1HERE

Some real loss of fidelity was there though:

1. You can=E2=80=99t for some reason export refs that point to blobs or =
trees
2. Your Git notes will be effectively lost since they will retain their
   SHA-1 filenames. (This is mentioned in hash-function-transition)

Then you import it with

    git fast-import

But to no one=E2=80=99s surprise (here) this does not work because of th=
e SHA-1
collision submodule.

Okay, dropping that exercise for a second. I would personally be okay
with trying out this migration on my existing repos that are =E2=80=9Clo=
cal
only=E2=80=9D. It would clearly be in my interest to find any bugs that =
are
particular to my workflows. But for that I would that migration where
you keep a mapping of SHA-1 to SHA-256. Or else I will lose Git notes
forever (which I use a lot).

But reading brian=E2=80=99s cousin response:
<asQrWAKQXV9zn1Vq@fruit.crustytoothpaste.net> ... it seems that there is
not enough in git(1) or anywhere else to do that.

So what is anyone outside the group of guts-of-Git developers supposed
to do? It seems we just have to wait until Git 3.0 and see what happens.

And then you can imagine Git 3.0. Someone happens to make a new Git
repository and they use it for three days without trying to push it
somewhere to SHA-1-Only land. But then they do. And the forge has at
least implemented a nice, informative error message. The user only cares
that =E2=80=9Ca week ago it worked=E2=80=9D and =E2=80=9Cnow it is broke=
n=E2=80=9D. (=E2=80=9Cbroken=E2=80=9D
subjectively.) He feeds it to some oracle and it turns out that they
just need a few commands to convert back to SHA-1, then one command to
turn off the default. Now they have mitigated the =E2=80=9Cbroken Git=E2=
=80=9D problem
for themselves. And what have they lost? It=E2=80=99s not even a hack.

Then zoom out and you might have the wider ecosystem, like forges.
If they don=E2=80=99t implement it in time? Well, maybe that informative=
 error
message becomes:

    remote: unsupported hash algorithm
    remote: if this is your first push of a local repo, here=E2=80=99s
    remote: how to convert your repo to SHA-1:
    remote: <commands>
    remote: and here=E2=80=99s how to turn off this default [...]

Then someone will post that as a question on StackOverflow, get flamed
because the error message =E2=80=9Csays how to fix it=E2=80=9D, get 3000=
 upvotes, and
the world moves drunkenly on.

The above scenario would be very hyperbolic and too cynical if not for
the context: one person is leading the direct implementation work[2] in
their spare time. In order to migrate Git from a to-be government-wide
banned hash algorithm. That seems like an institutional malfunction.
Somewhere.

To reiterate, there doesn=E2=80=99t seem like there is anything for us
above-average Git-interested users to do yet. So it feels like we
just have to wait until March or a little later, see if the default-
SHA-256 change lands, and see what the fallout is. And that is a bit
frustrating.

=E2=80=A0 2: This is to acknowledge that there are other people like rev=
iewers
