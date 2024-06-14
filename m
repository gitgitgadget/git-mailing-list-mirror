Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7F1A01CF
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390462; cv=none; b=IWSJFge4IbhdLT5urnDOogyct4WaMhBqjz4twXnCDfWLq3oRmCwFHcd5WOu3WwCNDThsodrGkhIrTvBd08SX4VhTCdL9CdUWDIISmoMgFPngt9HXmzPDyhdC26IJteFhA7+CbBX4amuFm1935+k97uD8FiMKhVRhKMHcR8gA+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390462; c=relaxed/simple;
	bh=X8EXE+E7YSFp4FUC0NO6ZlFSYhuPeyl9fbXMz2Ncgzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eCWyxbgbNDlT4FkKhEzhcI2tZjdqHrA+52Vx/kaw9Wi/kZfLz4ow6ZyY9+YpoUFRYOLb0YSivTMZqYtV5vyPowDqdZ830v6gzTAe5ynipMXGbxVk1P0bomzX0ji04w0KzToDMAgHWy6xQHz8+iGZ8AFZlr0QRutkU8HM8Wa+1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=n3rC8n6h; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n3rC8n6h"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AA83F244C4;
	Fri, 14 Jun 2024 14:40:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=X8EXE+E7YSFp
	4FUC0NO6ZlFSYhuPeyl9fbXMz2Ncgzc=; b=n3rC8n6hj1L2tqbVDf6juJoEzTtG
	j1qpXEVO8iKpA4BPMrTIuzYhaV9mbkQ4rpUSVLtBVOvuStIgUfQpYkIEVUJc4h9q
	CEI6Mx4Aq7+K6P0i+OF1bs1ComyFwCshDyRKrNcSuHr+x/P2kiZ+4YDmFnoaC6H+
	Lmr0VR2kXo4GELM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A231D244C2;
	Fri, 14 Jun 2024 14:40:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 033C3244C1;
	Fri, 14 Jun 2024 14:40:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Tom Scogland <scogland1@llnl.gov>,  Tom Scogland via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: [PATCH] archive: document that --add-virtual-file takes full path
In-Reply-To: <xmqqh6dvflea.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	14 Jun 2024 11:07:41 -0700")
References: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
	<pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>
	<bc3711a7-37d5-46bc-979e-83bd0b2cf900@web.de>
	<95B94723-BCBF-48B4-A02C-A5C61FB060DA@llnl.gov>
	<01b21870-b37e-47fe-9bd7-225499ae5eaf@web.de>
	<xmqqh6dvflea.fsf@gitster.g>
Date: Fri, 14 Jun 2024 11:40:57 -0700
Message-ID: <xmqq5xubfjuu.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A476E85E-2A7D-11EF-A7B6-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> I'm not sure I have an opinion on that topic, yet.  Fixing the
>> documentation is certainly easier.  Adding the prefix to the path of
>> virtual files as well is a breaking change.  I feel that the easier
>> route should at least be mentioned in the commit message and why it
>> was not taken.
>
> It has been a few weeks since this discussion stalled.  Let me make
> an executive decision on the direction here---let's keep the behaviour
> and align the documentation so that we won't break existing users.
>
> Thanks.

So here is to re-ignite the discussion.

----- >8 -----
Subject: [PATCH] archive: document that --add-virtual-file takes full pat=
h

Tom Scogland noticed that `--add-virtual-file` option uses the path
specified as its value as-is, without prepending any value given to
the `--prefix` option like `--add-file` does.

The behaviour has always been that way since the option was
introduced, but the documentation has always been wrong and said
that it would use the value of `--prefix` just like `--add-file`
does.

We could modify the behaviour to make it literally work like the
documentation said, but it would break existing scripts the users
use.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-archive.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.tx=
t
index 98526f2beb..a0e3fe7996 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -53,7 +53,7 @@ OPTIONS
 --prefix=3D<prefix>/::
 	Prepend <prefix>/ to paths in the archive.  Can be repeated; its
 	rightmost value is used for all tracked files.  See below which
-	value gets used by `--add-file` and `--add-virtual-file`.
+	value gets used by `--add-file`.
=20
 -o <file>::
 --output=3D<file>::
@@ -67,9 +67,7 @@ OPTIONS
=20
 --add-virtual-file=3D<path>:<content>::
 	Add the specified contents to the archive.  Can be repeated to add
-	multiple files.  The path of the file in the archive is built
-	by concatenating the value of the last `--prefix` option (if any)
-	before this `--add-virtual-file` and `<path>`.
+	multiple files.
 +
 The `<path>` argument can start and end with a literal double-quote
 character; the contained file name is interpreted as a C-style string,
@@ -81,6 +79,10 @@ if the path begins or ends with a double-quote charact=
er.
 The file mode is limited to a regular file, and the option may be
 subject to platform-dependent command-line limits. For non-trivial
 cases, write an untracked file and use `--add-file` instead.
++
+Note that unlike `--add-file` the path created in the archive is not
+affected by the `--prefix` option, as a full `<path>` can be given as
+the value of the option.
=20
 --worktree-attributes::
 	Look for attributes in .gitattributes files in the working tree
--=20
2.45.2-683-g09b5b61c39

