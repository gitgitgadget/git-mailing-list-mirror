Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EAD21C17D
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336131; cv=none; b=AbYRmsTYsjZYlgWOCee0xbNck4sO6tG1gGx9PmmoJ1CkW0VtAHIRL4ouSkp5BVArcmzhM2UL6kAV7I4cWkDzRnmvCHwaWSGrX6RlzcA1xzb7qB3pIeoAwa03Xrn9H21KeRu6SmkMF4NYYjKiEBKlvAOyPQnjZapum/oku4U8TIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336131; c=relaxed/simple;
	bh=4GpBEWuZyjKam3J1MUa5kJL6hQFYQLQ6hqv3r1N/qNA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=p6GDSBocrBC5sIbm3QBpiRogsj+p6mo7BkXZwZJ7Xd9GukfweZ1LjDeZ1SPq0guhmTIptjlV45rf3LkcEijrNWsPQa+gA8VpwcYmlfazs5cqYI9SzhbXmlMjtEwpcgCdQ3/3wn0TLBSFIwiuFN7YwHD1BEEtjp1j25oXYid7FA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Bm/TmXZO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T03FqkMd; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Bm/TmXZO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T03FqkMd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D9B11400074;
	Tue, 13 Jan 2026 15:28:49 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 13 Jan 2026 15:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1768336129; x=1768422529; bh=xL
	q1OTeRJ9NnWpdSSeUiHHIKmAgG8dkYPfYEX8+sDIE=; b=Bm/TmXZOkDebyE7NDu
	66KUhE+SOHVIylZHMrCuXi5KjIrqNvFi0ow1S86Ca+t5vQviU6MHc/SRKsORa5uS
	tveQUsTYJ/pwwusOrSpWXC8P+SdznjamNEvL3uZuqrPLFajrpDnIctQXDb3CQ3wL
	4NKH2IcHYyx3ppBlPI2U7huL+mSPK7vMBRACr4KsOqsCaUkYqPqgT4TtCyk4LmMD
	uFK7oDJhl3yQyt4vPG3Ii+IsM+qcya1IyAjJPeJ7E3bU7WYzOIKt/xYI8x+ivny1
	O3LMMn/8dH80PfX/raSsz2fiu6b3429+h0MmQdjJQDzElQ2ix9moogPcEmWx8EyS
	z78g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1768336129; x=1768422529; bh=xLq1OTeRJ9NnWpdSSeUiHHIKmAgG
	8dkYPfYEX8+sDIE=; b=T03FqkMdY0pJHplzEUBiGMjwjXpaKdv+qWBw1k+tlGBx
	VPI3XJ3SM2eQN4adEOtY7DLl6Y9CPCaxD+stZmTCVopfRRs+O0oKetLIe0YkrQHb
	D/nXnQjpdSpeCd8m3OocO2GxNewFXAjL7VSyeMIX8k4miag56LnPAs0Avtzusq0Z
	pMDPOKBedSI/4EmIrgbw8Gjtd74FRqohNGSDXczBId82MGrUXKVKcVEMVvIo+h2q
	tqcUxsjBPKfR0SJORYP42VSr9E8+DGIYZ7WIgfJTHZEfKrlwwjzVX1CGCrwCGz+3
	wY8SEyWRNU5BacrmdMAeTIzimPrB6/tUEV/u9ZUJrw==
X-ME-Sender: <xms:AKtmaQolzfcmeD_y1ulBXzsQGmKlAR7OR2_Ez_ExcD5E0uvAPIbdDaI>
    <xme:AKtmaReVZn5n2saElVgi8_ZOnkKnf7ETjq_FAdDPduh3kKTOtw7kpOc7dQDfLMxOI
    EP-6-QAFDVbU8GSNnEBgK2wxMNE0r4bMFzSwGleVv7AtpSV1qmN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdduvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkffutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephefftdffiedtteeh
    keejtdetkeffgfetfedtueekheehveehtdelgeeiieejfeegnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggs
    ohhrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AKtmabXiMglzt9SeIGUeb--a7HmMBTjtnOcG-iQ-IC8pKLdFgFb9cA>
    <xmx:AKtmaRhuD79620DFBw5cAtOixSVOYfkhS8Vl3cNlWvgfZ0mzxIaAfA>
    <xmx:AKtmae_tYW7dQw9HGrvTBD1TtMJIzoig2QKSOR8Yo9W6_yhXiwk-ng>
    <xmx:AKtmaTD0YjPedi6k_pqdxW7yXgghLRYRv770fZpvo8DFJBI_MaB8pA>
    <xmx:AatmadEAyTUBjWSipmzkmRI8J61PprzeVi58WdiXEbWXBCtB6RicjXoD>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 25F661EA006B; Tue, 13 Jan 2026 15:28:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Jan 2026 21:26:45 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "Adrian Ratiu" <adrian.ratiu@collabora.com>
Message-Id: <249f08d1-4457-4a41-8dbe-9725c0c392de@app.fastmail.com>
Subject: [BUG] push: pre-push hook that waits for stdin is slow
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

  Thank you for filling out a Git bug report!
  Please answer the following questions to help us understand your issue.

  What did you do before the bug happened? (Steps to reproduce your issu=
e)

Used `git push` with a pre-push hook which included a loop over standard
input (stdin):

```
#!/usr/bin/env bash

while read -r -a array
do
    # what the loop body does is not important
    :
done
```

At first I tested with a loop body. But I got the same behavior with
`:`.

It=E2=80=99s just the usual: check if what we are about to push is to so=
me
blessed branch. If it is it says that the push failed and tells the user
to use `--no-verify` if they are sure.

  What did you expect to happen? (Expected behavior)

For the hook to finish quickly and the push to finish within a few
seconds at most.

  What happened instead? (Actual behavior)

The push to the remote (Bitbucket cloud) takes over a minute. But not
with `git push --no-verify`. Then it takes a few seconds.

  What's different between what you expected and what actually happened?

Time.

  Anything else you want to add:

I bisected using `timeout 3 git push ...` with a local remote to
857f047e (hook: allow overriding the ungroup option, 2025-12-26). I used
a script on my own $dayjob repository. But I also tested the following
script on commit f0f19d01 (fails) and the commit right before
it (does not fail).

It uses a pre-push hook which is just `cat`. Apparently it has to do
with how stdin is handled. An empty script does not have this problem.
And neither does a script that just uses `echo` (example).

```
#!/bin/sh

uuid=3Dd0befd7e-efe4-11f0-b6e1-8b95c76aee96
repo=3D"$HOME"/"$uuid"

# Destroy test stuff
cleanup () {
   rm -rf "$repo"
}

setup () {
    # I seem to need a realistic/meaty repo
    git clone . "$repo" &&
    (
        cd "$repo" &&
        git tag test-tag &&
        remote=3Db896ac6c-efe7-11f0-bebc-3bf1b96c1ded
        git clone . "$remote" &&
        git remote add local "$remote" &&
        # hook setup
        mkdir hooks &&
        cat <<-\EOF >hooks/pre-push &&
#!/bin/sh
cat
EOF
        chmod +x hooks/pre-push
    )
}

if test "$1" =3D cleanup
then
    cleanup
    echo >&2 "bisect: cleaned up test data"
    exit 128
fi &&

if ! test -e "$repo"
then
    setup
fi &&

make || exit 125

timeout 3 \
    ./bin-wrappers/git -C "$repo" -c core.hookspath=3Dhooks \
    push local test-tag

# exit code 124: timeout(1) timed out
if test "$?" =3D 124
then
    exit 1
else
    exit 0
fi
```

I tested and reproduced the issue on `master`, `next`, and `seen`:

=E2=80=A2 master: on 8745eae5 (The 17th batch, 2026-01-11)
=E2=80=A2 next: 054afa95 (Sync with 'master', 2026-01-12)
=E2=80=A2 seen: b351b516 (Merge branch 'bc/sha1-256-interop-02' into see=
n,
  2026-01-12)

  Please review the rest of the bug report below.
  You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.52.0.421.gc32ead4fc78
cpu: x86_64
built from commit: c32ead4fc78dfd0327f6b2599e4fdca8166afa18
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
libcurl: 7.81.0
OpenSSL: OpenSSL 3.0.2 15 Mar 2022
zlib: 1.2.11
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.8.0-90-generic #91~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu=
 Nov 20 15:20:45 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
commit-msg
post-applypatch
post-checkout
post-commit
post-merge
post-rewrite
pre-auto-gc
pre-push
reference-transaction

--=20
Kristoffer
