Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C71533F9
	for <git@vger.kernel.org>; Sat,  2 Nov 2024 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730510850; cv=none; b=uCbjHW+3NKU+hfpplz9abrbKBw9oPhruovK1jZr9BIFnl96OAnVU1xCji61W8BUoxJsusDMaCJRTd9NnaK/OOCPOV0dqZPIMSBNhx2KSeWOUaWXO8CK8V4pOMXcdG/KkRnuTt3ziQiXhcLIok9Kw6Qcwbq96FYCkw/KnKw9lMe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730510850; c=relaxed/simple;
	bh=UI96dfOFLucG9MbCMyFKc2Y6yxF/UkRJxmweW9Ay+KE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hlMKTAzPuaG90/xxtRyzjTM4BddpMhebNU32rPf/hklJaDj74a3c+QnSG6kC5S60WKsA0ZoBbBxn+G9rR/Vd0JtyXIEZFgaHmblUlkTq0MSQ8mXrAImvOB69pt9ni/+W/CLdtRmR1Vvg09rX0nTZ3tWhJ6GzO4s86scPaGor4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VBP9Fwzj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e2cbbAhl; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VBP9Fwzj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e2cbbAhl"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E78BE13800F5;
	Fri,  1 Nov 2024 21:27:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 01 Nov 2024 21:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730510845;
	 x=1730597245; bh=7egoxFlwmjr7X4F0464ztw7ZsxrIwSZsp85DxlqBXho=; b=
	VBP9FwzjjmZCG4dFezAjB0AwVu9uVAJq3xB9EMEYf0OP/jjVtRLlSuO4xGnuDGOO
	+rZjwqmpKkDOXw7yNNbAWpuW1xpbHVnxECCz210U86WPAoNXtwDyW4Z4rbuNZ5Hx
	9aGktwg41eV7t5bhuVwgcfirA9s3chec8M00t0piKRVJadUQT40kS+ObffJEhtaW
	8Nvz+Q8ZVAxfZ21gYxIqk2mtOz/mPENt7vHYRLeQBrs63MAFcL3+kvH5Pb2QSwFx
	o4323N1wQjEI9M9yZqNN03RQG4O3GsldDKhf00l3wihppeFJ8jm4M4BD5ZGUUqRF
	BubYSDAQIWSd9p+NM34vrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730510845; x=
	1730597245; bh=7egoxFlwmjr7X4F0464ztw7ZsxrIwSZsp85DxlqBXho=; b=e
	2cbbAhl8taiVoIJuWVFCbBeZ4l0Yfn+jhrAOQZWGhmkzytbodI7vsJsHchrOe8TA
	EwL849KU7LYIrG+KrKZvW+SIF57f1khcmPYZ9sbkLKeAe2/rqUwOpNJtJb+sIi8E
	ISSd3plgHSyWqVG5YkcG7d0vnSoOmmp4OILyVYw8h8pQd6Q6DddJ16XEAwaxs/v6
	l2ET8VjmTbozU6sBs6jkAHbvlnxIOfyEGh1AxtrodI5QKJptjKDkF1/PsCM/83uq
	h4QOUc9CrlIcDbhicbHufgP50ZSlZ0T1cIA+RIsWKXho3t2wqAYvhWk0lMs8Ju1o
	+VUce16lhoiWTo5mUZU/A==
X-ME-Sender: <xms:_X8lZzJ27FiJlzxOp0H3K02DtYvpmmKpeENfmqnpQpwY5HUYF50O0A>
    <xme:_X8lZ3Jb7ehN5oCcmPWKRMbf0RIzySble65n7vLuv8vK3Nm9WmXV1a85e3FrZewwX
    ciizKK23sF9R8Ot-g>
X-ME-Received: <xmr:_X8lZ7uzsI2epWiHl4L43FAfnURk4plkdAqdTgFOCi--Fx_7ZqYk3YlsxI4-02XllK69evSAGaYgmC38ParzTOIgxm9q-O5m5Ix8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepve
    fhleeiffekgefghedvjeektedtvdffhfeugeevhfelleevudfgleffteelhfevnecuffho
    mhgrihhnpegtrghnrghlshhoohhpvghrrghtvghonhgsuhhnughlvghfihhlvghsrdhith
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthht
    oheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_X8lZ8b0_TRKKGhxbvCCGxqwAZAFlNXdNcs3BiOvj_BjMbFTUueY4g>
    <xmx:_X8lZ6bg1lCQjx42-lUFrlUlwmdiXhde5EaN1QdNaCSKsy6OSwPg_Q>
    <xmx:_X8lZwBnQQdq7LRWoYc66WIWPZdCrKiAgr3XkdNUkRaDIEabLc5sCw>
    <xmx:_X8lZ4ZsAEBfqgXqY7eO65KBAr71QOAx0CQJOGUl0r-6li7U0kGhvw>
    <xmx:_X8lZ_PLC2exBzYLTOOeQNrEi3m-M0VoU3PkDAphyyc_wv9v0sJrEOXB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 21:27:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  avarab@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v2 1/3] Documentation/git-bundle.txt: mention full
 backup example
In-Reply-To: <e9be866f33daab2d4038f8b3f1140fe41e5f49c5.1730234365.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 29 Oct 2024
	21:41:44 +0100")
References: <cover.1729451376.git.code@khaugsbakk.name>
	<cover.1730234365.git.code@khaugsbakk.name>
	<e9be866f33daab2d4038f8b3f1140fe41e5f49c5.1730234365.git.code@khaugsbakk.name>
Date: Fri, 01 Nov 2024 18:27:24 -0700
Message-ID: <xmqqh68q1l37.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Tell the user how to make a full backup of the repository right at the
> start of the doc.
>
> This is a requested use-case.[1]  But the doc is a bit unassuming
> about it:
>
>   “ If you want to match `git clone --mirror`, which would include your
>     refs such as `refs/remotes/*`, use `--all`.

What's the open fancy quote followed by a SP doing there, apparently
without the matching closing one?  Can we replace it with a SP?

> The user cannot be expected to formulate “I want a full backup” as “I
> want to match `git clone --mirror`” for a bundle file or something.
> Let’s drop this mention of `--all` later in the doc and frontload it.

> diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
> index 3ab42a19cae..0fa181c749d 100644
> --- a/Documentation/git-bundle.txt
> +++ b/Documentation/git-bundle.txt
> @@ -23,8 +23,8 @@ the "offline" transfer of Git objects without an active "server"
>  sitting on the other side of the network connection.
>  
>  They can be used to create both incremental and full backups of a
> -repository, and to relay the state of the references in one repository
> -to another.
> +repository (`git bundle create <file> --all`), and to relay the state of
> +the references in one repository to another.

In the new construction, it is unclear if the new command line
example is about making a "full backup" and not "incremental", or it
applies to both.  I am not sure if this, especially with the removal
of "--all" from the later section, is an improvement.  Let me try if
I can come up with a better version by elaborating the later section
without touching this part.

This is not a new issue, but naïvely, one would expect "full backup"
to allow one to recover lost .git/config entries.  We should tighten
the phrasing for "backups of a repository" to avoid such misleading
false promises.  As it is the primary motivation of this series to
clarify how you would use the command for "full backup", I think
this point is worth tackling as part of this series.

This also is not a new issue, but the dashed-option "--all" after
"<file>" is an oddball from "git help cli"'s point of view.  It
perfectly fits within the SYNOPSIS for this command in that "--all"
is merely a form of valid arguments you can give to "git rev-list",
so I do not see anything that needs to be done on this point, though.

So, here is my attempt.

 Documentation/git-bundle.txt | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git c/Documentation/git-bundle.txt w/Documentation/git-bundle.txt
index 3ab42a19ca..633c99c8b2 100644
--- c/Documentation/git-bundle.txt
+++ w/Documentation/git-bundle.txt
@@ -22,9 +22,10 @@ Create, unpack, and manipulate "bundle" files. Bundles are used for
 the "offline" transfer of Git objects without an active "server"
 sitting on the other side of the network connection.
 
-They can be used to create both incremental and full backups of a
-repository, and to relay the state of the references in one repository
-to another.
+They can be used to create both incremental and full backups of
+objects and refs in a repository.  They can be used to transfer the
+state of the references to another repository, together with objects
+these references point at.
 
 Git commands that fetch or otherwise "read" via protocols such as
 `ssh://` and `https://` can also operate on bundle files. It is
@@ -176,7 +177,7 @@ OBJECT PREREQUISITES
 When creating bundles it is possible to create a self-contained bundle
 that can be unbundled in a repository with no common history, as well
 as providing negative revisions to exclude objects needed in the
-earlier parts of the history.
+earlier parts of the history.  This is like taking a "full backup".
 
 Feeding a revision such as `new` to `git bundle create` will create a
 bundle file that contains all the objects reachable from the revision
@@ -192,9 +193,11 @@ will require the revision `old` (and any objects reachable from it)
 to exist for the bundle to be "unbundle"-able:
 
 ----------------
-$ git bundle create full.bundle old..new
+$ git bundle create incremental.bundle old..new
 ----------------
 
+Such a bundle file is like an "incremental backup".
+
 A self-contained bundle without any prerequisites can be extracted
 into anywhere, even into an empty repository, or be cloned from
 (i.e., `new`, but not `old..new`).
@@ -203,11 +206,27 @@ It is okay to err on the side of caution, causing the bundle file
 to contain objects already in the destination, as these are ignored
 when unpacking at the destination.
 
-If you want to match `git clone --mirror`, which would include your
-refs such as `refs/remotes/*`, use `--all`.
-If you want to provide the same set of refs that a clone directly
-from the source repository would get, use `--branches --tags` for
-the `<git-rev-list-args>`.
+If you want to prepare a bundle from which you can "git clone" as if
+you were cloning from the repository, you can use `--branches
+--tags` for the `<git-rev-list-args>`, as "git clone" transfers only
+these two kinds of refs.
+
+If you use `--all` for the `<git-rev-list-args>`, the resulting
+bundle will be able to recreate all the refs, including those
+outside branches and tags, when extracted with "git clone --mirror".
+
+When creating an incremental bundle on top of an existing bundle,
+`git bundle list-heads <existing-bundle>` can be used to extract
+the then-current tips of the history recorded in it.  Then you can
+list them as the prerequisite objects when creating an incremental
+bundle, e.g.
+
+    $ git bundle create incremental.bundle --all --not \
+	$(git bundle list-heads old.bundle | awk '{print $1}')
+
+which tells the command to include all refs (as if cloning with the
+`--mirror` option), but without duplicating the objects already
+available in the `old.bundle` bundle.
 
 The 'git bundle verify' command can be used to check whether your
 recipient repository has the required prerequisite commits for a
