Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE68180A96
	for <git@vger.kernel.org>; Thu,  2 May 2024 20:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680964; cv=none; b=JafNPkC0VkNIhICImqFXESFrGYuN2zNhEygsNDDrwZ0ndiyZIWqA9D4tPD2ljTaXHDhhQ6KlGo3d3sTwt0OL3DjDsu9eFv1MhMlHQK6DN49SUOTxdxH7gVHqq4jIQAfP17nXTzd1RXubD3cjdLJbf5R6is4JWaZLbNccMk5GOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680964; c=relaxed/simple;
	bh=6GE28WgXrFCnBVJf6//Nw+oU12/96cboqJkBmFj9198=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K6fuT8+78O1L/EVl1CGERJOX1cW01gyYHNmUzeqBOeBzWoTSszpi0hwEAamgnGfkSe58zlieeJ48NOFptacd4O7lRHnYEuzd00gBQ9+wrbDf4P7mPUEad9m6yaBB2uhPoae1qbkI3SehaDYbxm8YTrgwK4GVYGWYEZnnBlbbyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=m6ZnBIXi; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m6ZnBIXi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6A7D230F0;
	Thu,  2 May 2024 16:15:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6GE28WgXrFCn
	BVJf6//Nw+oU12/96cboqJkBmFj9198=; b=m6ZnBIXiDTMjjJ6lVvI8vNfS02Tw
	B6br7O1GKHnnfVbh8ObsyajQE11aeHWFESXWSQoP4GPcRCySITOTMx4vY7w2k9V/
	kI+Rhmo66+GIi3HhFLPbjKyfuC8HgXR6cyA+BB4emST6wnpnKIBo6aXFcAJca6fU
	MkNRP5egRiC6lac=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE99C230EF;
	Thu,  2 May 2024 16:15:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F260230EE;
	Thu,  2 May 2024 16:15:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
  git@vger.kernel.org
Subject: Re: t4216-log-bloom.sh broken ?
In-Reply-To: <xmqq7cgcdm4f.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	02 May 2024 12:55:44 -0700")
References: <xmqq8r0ww0sj.fsf@gitster.g> <20240502055621.GA29945@tb-raspi4>
	<xmqqsez0fbam.fsf@gitster.g> <20240502185903.GA11895@tb-raspi4>
	<20240502192622.GA1841@szeder.dev> <xmqq7cgcdm4f.fsf@gitster.g>
Date: Thu, 02 May 2024 13:15:57 -0700
Message-ID: <xmqqsez0c6ma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CA32277C-08C0-11EF-96BB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> I am curious what other differences Torsten will find out between
> good macs and bad ones.  Perhaps we can narrow down the bad apples?

So, "no, your 'mv' is broken" seems to be the answer to the question
on the Subject line, and it is rather well-known, it seems.

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] t/lib-chunk: work around broken "mv" on some vintage of =
macOS

When the destination is read-only, "mv" on some version of macOS
asks whether to replace the destination even though in the test its
stdin is not a terminal (and thus doesn't conform to POSIX[1]).

The helper to corrupt a chunk-file is designed to work on the
files like commit-graph and multi-pack-index files that are
generally read-only, so use "mv -f" to work around this issue.

Helped-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-chunk.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/lib-chunk.sh b/t/lib-chunk.sh
index a7cd9c3c6d..9f01df190b 100644
--- a/t/lib-chunk.sh
+++ b/t/lib-chunk.sh
@@ -13,5 +13,6 @@ corrupt_chunk_file () {
 	fn=3D$1; shift
 	perl "$TEST_DIRECTORY"/lib-chunk/corrupt-chunk-file.pl \
 		"$@" <"$fn" >"$fn.tmp" &&
-	mv "$fn.tmp" "$fn"
+	# some vintages of macOS 'mv' fails to overwrite a read-only file.
+	mv -f "$fn.tmp" "$fn"
 }
--=20
2.45.0-31-gd4cc1ec35f


