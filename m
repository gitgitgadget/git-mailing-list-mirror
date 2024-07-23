Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C176F308
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721694961; cv=none; b=l6asi5BJe0Jdc+KH8bs/t8hrXHpQAb4+IFAG/vgja6/120a5JWzSGnjt5e8r2mHBvsuRBMPCl6CR0JMi/yhuu+kJmUwMHI04h2okJDFQOJ2H2lg7UYKuu30DrM9BH9mAyvi1AhuOVum8w2DBALhQwcl5DKEyggo58fatfTbptyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721694961; c=relaxed/simple;
	bh=J/IaWIe94/yknMeOrt3utCXZDtZ2rCo/Cd8JO8VgocA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bw065ypg9DxOTImcqCr1527o/RL5Ja+mGyY8Un8lB3YBrFpX64ESbZD+FC4E5BPv7FCqQwN14DoOTxbshHYCBv9ZXyQbvuMbn5/V48Jm7jFS9Dir9ts6OAjo7vo7Ht5qt2QhPnlHbOlxSGr8LMzoQNR+VwqLCbwQtkMIHNOf+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BnTB3g9I; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BnTB3g9I"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 68B0E249E6;
	Mon, 22 Jul 2024 20:35:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=J/IaWIe94/yknMeOrt3utCXZDtZ2rCo/Cd8JO8
	VgocA=; b=BnTB3g9IzDMxi0ioaTkfGiiqc5DYv1UBIar/wV6WiBL/QhzO/QDlDx
	WGnKYJb6wZqYpzn+vnuf8Cx0Pv6pMRzvif879KjVL5PZLBsZqRtFWF0dH7bAOhFe
	vS8nn6eGh3N49kQDNrwGgNiWWiytmcu0ObEwHQi3/7Fqinmikldms=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F733249E5;
	Mon, 22 Jul 2024 20:35:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7F06249E4;
	Mon, 22 Jul 2024 20:35:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tomas Nordin <tomasn@posteo.net>
Cc: git@vger.kernel.org,  charvi077@gmail.com
Subject: Re: [PATCH 1/1] doc: remove dangling closing parenthesis
In-Reply-To: <xmqqy15t824l.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	22 Jul 2024 15:59:06 -0700")
References: <20240722225302.124356-1-tomasn@posteo.net>
	<xmqqy15t824l.fsf@gitster.g>
Date: Mon, 22 Jul 2024 17:35:56 -0700
Message-ID: <xmqqo76p54ib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 87333FDC-488B-11EF-AD69-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Wonderful.  Thanks.
>
> Will queue.

Spoke too early.  We need a matching change to in-code help,
otherwise t0450 would break.

Here is what I have, which hopefully needs no more fix-ups.

Thanks.

----- >8 --------- >8 -----
Subject: [PATCH] doc: remove dangling closing parenthesis

The second line of the synopsis, starting with [--dry-run] has a
dangling closing paren in the second optional group. Probably added by
mistake, so remove it.

Signed-off-by: Tomas Nordin <tomasn@posteo.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-commit.txt | 2 +-
 builtin/commit.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 89ecfc63a8..c822113c11 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
-	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
+	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
diff --git a/builtin/commit.c b/builtin/commit.c
index 6e1484446b..7f9dd45d05 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -41,7 +41,7 @@
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
-	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]\n"
+	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]\n"
 	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
 	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
 	   "           [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
-- 
2.46.0-rc1-52-gda884b23f2

