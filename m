Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3835CBCB
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729590; cv=none; b=jQnnNqZ6RCEyQh/uFw4GOZnByeB5tcShUpjZfqDOc8GmLywOixWNq7KGVg+6tn3HoSzCRruVYp11ZGaGQeyr6U9qtjLdIe6J98rZGQQNcv4cjPoFSZZh9Jr1e5CbCCgi+9TIVv8GLh6MZ4bmLxWxPC+ls9KJhAbCKsuRJVhRhJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729590; c=relaxed/simple;
	bh=I0+1+9C3iKIusqhBtbzHG60knBwE/QON3L5J8iDzW3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdXzRRfcTP0ahmXQm+kCptotJOYmEeSbv1BeWROAkXWiUHm+v2rMsMB1iMnE7w4VQ99cJI32EseBhbHROmo7UNHSw2xwdoZsPyrl8Tnv/LOCqVpl1OzX54vlBBiDlHZP/XfN3P3u4JVjKymIvtdKdpktJmkM+i2Id3vVdZc+UZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=0jxHrilv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CpJzOd5X; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="0jxHrilv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CpJzOd5X"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A87291D00077;
	Wed, 17 Jun 2026 16:53:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 17 Jun 2026 16:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781729588;
	 x=1781815988; bh=/TQ3nefkH78+zdVFrOuwXWhhm8FUKEaBKeCSDXWvgEE=; b=
	0jxHrilvk6TgFNhwkxgPWSwNVnlb/rgup/2xvBKbHmcyIDX6GtclskHG/c271Ow2
	ugQVsjx6++LXVueyN2ssihW/T0OtnfQlcS9DCTQkUY6rNEhyQnvgZN5NpE6+gYZ5
	PFU/bDhzno/R/iHM1RCUrpgDUrNrrq0Fdo1SMOMcu5l976i7ZL3ZNX7u1q/z1NdA
	MPuFdOc+hw3GSuPZ81gCCca91bYqV/4bvMVdwu90U9YhAOLCjnox7ipMmuTg/kMR
	02SzKeGSTquDvZWvuLQkvwgIX80TIzdxoqVUKY0DdSRaMRWqe4/KFDfAwgpP5nyW
	LO1KnHTfEBhOROPYs3QMLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781729588; x=
	1781815988; bh=/TQ3nefkH78+zdVFrOuwXWhhm8FUKEaBKeCSDXWvgEE=; b=C
	pJzOd5XaHglk3ETcozR6bY+E4uZWCiPjfoy7sb9wM8EIbM0odCqD6c2Nk8CRf5GB
	oCPhqlCWLBv4WPRyccEEMrJ2OELbjtDjDx45bGE0AWT114K+Vodp18MTI17jeJyu
	zle7NSHVY5xc7h/LtalWBJCBPT8e2gWBRVALmYa5G8zSQkqWF/1Zd/dGwgAkLfv7
	BNtOFgZHCzqSYF4xGqpplHCcV6fTCYwXz+RJ11KQps3jtCSd4+v6GbhJfxfOzIVM
	HOsSC/CgJX497TlBnmXCcuvJHcwKDyIJSII1n0GZUwwEuFyKIN8R8gdylTSGpmK7
	3gvzyE6AYETgo7hh0SI8A==
X-ME-Sender: <xms:NAkzajxAehbxASM9jt9I6NP6A1LtbfjCaBxbwGdJ1QLKHVb3MaYHGkg>
    <xme:NAkzais55VgRacn4MWww8APYm5VDYifRAsr9iK9ggCsClwd5eAtsvOatuPhlynbBm
    Kyk-2gbOxic9jG88S8IeliZ0ViWiVjsT9iO561VcCUUVbDnqgx6>
X-ME-Received: <xmr:NAkzaqsBGP2mPeA1Hl2zrkWdKGIChRnSoMDfLQveVqrzHb0nCw4jsqw4hOabCITz4Mm6s4z1AY59auTdC7ZxZcIzzLqMDyasuIBKTbICi5J4aIxCgwX-bNK2RQ>
X-ME-Proxy-Cause: dmFkZTEAjnDpsbzRqsIgqUIzTdGUdXEO+h9xpm0hY1dN4LwFENS4EJFVcwuriADNcp6bdK
    ReECXoThdiibEO4PfBlP4EZnXskCCGlFVljs+QWTGWdugrTxDeB0xglwngo+ifMTgYfarg
    dA8ezCyO/zUBY+ncNIiaTrvZsXuM+ybLIYaakNkHhC/Z+8BimpUvZkc83uOptf8kqduXAo
    zEHyViJ/quLL4Bz5PgqgYjvPd7TVfYmOWXM5XYT1NuQBsa70xgL3e1SfTupjlqKq4l895F
    w6XoysdE1Mac2nkUaozitwcXWPgBF6JBEm+nS22v5pUf890ittmxrHoz6cS54+jIjKWiC3
    QlImsMrsUbDXrBXHWz6GPUMm34gA/bxJsRAwEwC0Z6g+qMxEXiI3Wi4AdmDCt6msedt3xy
    H7hjZeUvqm0S/SasB5ORRMouc5bwi9ASa2/ZqQHJ5OL/97+rSxtw34wkOfP3AC0MG/zbzy
    tXgKMtt/RN/AoxAZ8MwhcmwhONtLnO4Pe/WqAEu7wxVhu9Gn3c8Kg5pCyoJOKSltxumW13
    6lbBozCdSUV0BIz5wSxdFrCK4zCMxNxmV5Kyyf72bNaJlhd9lIAPTvs8vz1zjoG6VjKt0r
    CJ6TeCnzTNoa/qxcHt8IPw4RZOpSYfIvVmWu3Hnraf0/0J9Rbcnbz9JOLHJQ
X-ME-Proxy: <xmx:NAkzanPbJhEo6fVcm7Wxb5ht46KTPtzhnEvynlknunSxzcaqj3CO-w>
    <xmx:NAkzao09GqmiR7Sj-sargQ57Wv61sl_uK1hNv0X3_gcrb7tjn_8S-w>
    <xmx:NAkzajNkBqIHncM9V5yRLMqLojOgXT8q7-nsPPEgPkvoDKyqRED8kg>
    <xmx:NAkzao2FlcFirFG2ek5pan4hUJuKq8YsVWSlS4pYUEjLPqnKUKZ6yQ>
    <xmx:NAkzaq2YAzM5CPZptq8L-jJYsF50BFmq1fa8uR-dFRks7bl61IpznMDm>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 16:53:07 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/5] SubmittingPatches: discourage common Linux trailers
Date: Wed, 17 Jun 2026 22:52:16 +0200
Message-ID: <V2_discourage_Linux.9b8@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V2_CV_SubPatches_trailers.9b6@msgid.xyz>
References: <CV_SubPatches_trailers.8f3@msgid.xyz> <V2_CV_SubPatches_trailers.9b6@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The Linux Kernel regularly uses trailers (or “tags”) `Fixes` and
`Link`. Sometimes people submit patches to this project with them.
They have their use in that project but it is not clear what purpose
they would serve here.

For `Fixes`: Linux has many trees, and applying patches with
cherry-picks is common. A `Fixes` trailer in commit C2 pointing to
commit C1 helps the cherry-picker figure out that she probably needs
C2 if she wants to apply C1. See linux/d5d6281a (checkpatch: check for
missing Fixes tags, 2024-06-11):[1]

    Why are stable patches encouraged to have a fixes tag?  Some people
    mark their stable patches as "# 5.10" etc.  This is useful but a
    Fixes tag is still a good idea.  For example, the Fixes tag helps in
    review.  It helps people to not cherry-pick buggy patches without
    also cherry-picking the fix.

In contrast the Git project has few trees (to my knowledge), and there
is much less need to cherry-pick fixes as opposed to either using
backmerges or rebasing all of the downstream tree’s commits on top of
git.git `master` from time to time.

This project does regularly mention what commits a patch/commit fixes,
but that is done inline in the commit message proper (cf. the trailer
block of the message).

For `Link`: These are used both to link back to the patch submission as
well as with footnotes. In contrast this project has `refs/notes/amlog`
for linking back to the patch submissions, and footnotes are only used
in the commit message proper.

† 1: Commit linux/d5d6281a has “linux” in front of it since this commit
     is from the Linux Kernel, not Git. Example of a Linux tree—as well
     as an example of `Link`—is [2].

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ [2]
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: Msg: it’s “cf.”, not “c.f.”

 Documentation/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 0b12badf86d..38e18982aa2 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -476,6 +476,10 @@ While you can also create your own trailer if the situation warrants it, we
 encourage you to instead use one of the common trailers in this project
 highlighted above.
 
+Other projects might regularly refer to other kinds of data, like
+`Fixes:` and `Link:` in the Linux Kernel project, but these ones in
+particular are not used in this project.
+
 Only capitalize the very first letter of the trailer, i.e. favor
 "Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
 
-- 
2.54.0.22.g9e26862b904

