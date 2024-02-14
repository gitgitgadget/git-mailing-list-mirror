Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DDA5C605
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936534; cv=none; b=ETQgPMiup6/iLzSA9tlu2XrmXOBjYT2CmK22lV3T12s4YBrSWe8rOM1knRbbtf8IABG9JC3aBDXJNITZZjiqlQugoKNPxcDpO2woiShWFxTEN+EsK2dZMi13LXSk+POTQTVGJV6VKCoEbjlgOr/jx73b9zaFTqPslt1PD3m58GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936534; c=relaxed/simple;
	bh=5RQ9/TCsFg7m9jzacO4edVKTCXDpeUkqjYsAMECPWNE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XeZ8rEMS96iVtusZfL9Nt+jNNYj+bIoH/ZasOnCzDVH3pynkzb7L/V/qlG9HprK1kEl1DQFpQSGp1teSx5i1x2kXC8fhu5pqCwFHK97u59TZjN4rsZMLkKeOPl4rmipdtflN/tOZZUkdx1RhuvQpX37UbNVoUwQVz6XPT80ziBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZhU/iaRO; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZhU/iaRO"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B03123043;
	Wed, 14 Feb 2024 13:44:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=5
	RQ9/TCsFg7m9jzacO4edVKTCXDpeUkqjYsAMECPWNE=; b=ZhU/iaROSUOX1OG+y
	qxjrTnCZUqH7I4FPM32E143PvMxpKCAKGeSwTmLQBk26vYhl4LEKQsPt5F18852I
	dPBLhe47JRDzyvDstIxUHUDudouHUP5/DFXJJhOhZkZF3US7gVcE0pQkq8YNaf+B
	sNqoyIJeNN5kZBwXNQLtdDb8Hc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 538ED23042;
	Wed, 14 Feb 2024 13:44:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 497E423040;
	Wed, 14 Feb 2024 13:44:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] doc: add shortcut to "am --whitespace=<action>"
Date: Wed, 14 Feb 2024 10:44:01 -0800
Message-ID: <xmqqplwyvqby.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0652EC9A-CB69-11EE-AEDD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

We refer readers of "git am --help" to "git apply --help" for many
options that are passed through, and most of them are simple
booleans, but --whitespace takes from a set of actions whose names
may slip users' minds.  Give a list of them in "git am --help" to
reduce one level of redirection only to find out what they are.

In the helper function to parse the available options, there was a
helpful comment reminding the developer to update list of <action>s
in the completion script. Mention the two documentation pages there
as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-am.txt | 3 +++
 apply.c                  | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 82dadbecc8..67b12f315f 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -128,6 +128,9 @@ include::rerere-options.txt[]
 	These flags are passed to the 'git apply' (see linkgit:git-apply[1])
 	program that applies
 	the patch.
++
+Valid <action> for the `--whitespace` option are:
+`nowarn`, `warn`, `fix`, `error`, and `error-all`.
 
 --patch-format::
 	By default the command will try to detect the patch format
diff --git a/apply.c b/apply.c
index 3d69fec836..4e57831aeb 100644
--- a/apply.c
+++ b/apply.c
@@ -78,7 +78,8 @@ static int parse_whitespace_option(struct apply_state *state, const char *option
 		return 0;
 	}
 	/*
-	 * Please update $__git_whitespacelist in git-completion.bash
+	 * Please update $__git_whitespacelist in git-completion.bash,
+	 * Documentation/git-apply.txt, and Documentation/git-am.txt
 	 * when you add new options.
 	 */
 	return error(_("unrecognized whitespace option '%s'"), option);
-- 
2.44.0-rc1

