Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79658220698
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526052; cv=none; b=LBHRV0XTgx+g6DLxf2JkK7Ta1rVi5veGwnFh4w6VJ05obcLBTYV96a8Fx2Ft8JLA7LlsZelFHvmlZD5icmere2uiVkwReI5NkfXPPZA+obyc+yDNCiee9UujFQoohV97ImoWJ++zR5niwfAoDDj0EVtWnvHBTeo4wH6iJZhZ9E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526052; c=relaxed/simple;
	bh=uNkQ0x3l1c1xxMBniBnpyMYPJBWA9yZJ2q8UdHLrN2I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=CgitPc6bUBsbYyO6f2TzxEoEuSMVkvuBEnOEhL9RhgwWdTvZ7/NOMIy4v/8DQh3q7Z0h1mV6iJYPxgJ3FShoMiELQO47ine1O5HJgbTiZVfXX8ZZ4P5fllBSxyz2B7rwr9skiMJT3mu1NThRa12DPWrJWRyCnoa5Gi2AOWmEKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KDLmndRj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L9oejJZr; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KDLmndRj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L9oejJZr"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9114314000FD;
	Wed, 12 Aug 2026 05:14:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 12 Aug 2026 05:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786526049;
	 x=1786612449; bh=gK9RLsYes2MTX+uD5gub5N/709/yOJdGCODeijiTNuo=; b=
	KDLmndRjJ5cQ/3pLiplJyZ0UNsE9hUOQCSliSqhQXSGZkuXE/vqwU7NDtRUmICyT
	jSVHJG0ow8bsAk2SBrdmLs+ToBJ8VM/jDDDPN9IcVuJYNX6TBPplZX68AEDN1syN
	oZteeokgUeUTMPfq+oRfwcN4efuEqkCjNs5fRGzy84VD4OhDIcffOEuGWZuYBCGl
	ode+CQKTi89DuoeoD8tqacHwoHucDjY1Y3JaLniTcs/TXB1741cwUwkx/MsYwjR5
	2BjKtXrUA0d3/e4xCp8P4+SA61+Htn91TCHNowZI6LR/F4fmVFgtgQ0uEZ1cgMK6
	/xS0y86MazpKPh620161DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786526049; x=
	1786612449; bh=gK9RLsYes2MTX+uD5gub5N/709/yOJdGCODeijiTNuo=; b=L
	9oejJZr3whdXebsdvuI74LQlMqDIHAr28ntdf8Ddq65GJIUGs3rMsSGmfj/Sl+dZ
	f8Gl5pCWXL2jPH11qEcREFc2BM68AUb56vaI0HDW+ci2TpVTO9RsBV3jEsNlpIqi
	b1FbP6avF+tZ/RsixzBivSzM246lO+QteVj9dbDvKPYFZyO1Q9EcE5KqwNVKyVFW
	JImrS6eyyJfMhipWTiloWc4yXdj5/b2XQU7ATweS3VM9gUo68QhdhqbZx6KI+saJ
	BofAT5xIbxLyzT7D8aMLHKS7K//z1goRUu7DrfvFHaq1+ThnuLBIFDggDIgOMDbX
	l909sfjvXH3y8dP+9iaPA==
X-ME-Sender: <xms:YTl8avQBewMcuIF044t7FfxEierzXVyCIwBYh1XOFpPhl-Ui4A_u9A>
    <xme:YTl8amyspDzg62-jzrTX7s2dhjLRsKx8Py_jY5LtvrWchOytsni9uVpSWC0_5oFqB
    uutAv50OcMAiI49jUb2J3j-6neMN_m5Mym3u01Uz3z35IqFF_nk>
X-ME-Received: <xmr:YTl8aido35QhzTiQTaf1po8Tdl7xvNBjzs1l-vwyiyteWBNOWq4l0hLBWPN6Um7L6yFyoG3vzvYRFkZ48WQyzJWlhiDoxQWqWHO3ReLBXA>
X-ME-Proxy-Cause: dmFkZTFKI3oCTf0qLVJDBltgF8InAfSJB3lZfltaF5p1kE3ZuLR5PsAt5u3/aq5MxYBl6k
    weazdimRAoDi6a3AGYoffx4OTctgaJyuJhZa+nqG79+r8nEw36Uh+sweikga0OjZPSaMmu
    b1RT0ln59+3GRbUAWPmQigsTwQQ/twsYfAIQKrywcETjKt5xwRH+ugeUq/Vxu+YTo5kq8T
    YMMlZUln2XRInnGvRpJFNziVJl8a2EF0knEZl2RIgZPCbwMBdGqAyjw/8F5FbTPH77SEzh
    bNQBXjns5/om5sVVhaR3u5tN1Vb5W5DecYTCdqd0/zkcXPdDEqJuwlp2UUzUg/L9Ta4+VV
    7wSvYNHIiu7ch0LBIUJ5xq7tb143uBxdc3OGK6RIOZE0a1liIHvZ7OtJhSqZq0wEIDxOcA
    D2VhMj0yfjtz8P5aP/nmPnpT8WiMjTyo7h+n3+srlS+w1u3lmL1ofP7MhyGO3f0YolA8ls
    XH3URU+NgSJi4u3oIYyPcZjYeWK4bvgSSxTgH9XGnH3uuyRKWDO+0b1nsBW1n6w/ulDYOF
    aAQuCaB2s5OPluinLhx7l6ZBnkh6wGpu39caC05w1tHRIu+w4BMKDTXQI7lXxUUBtYs3JL
    IxE8AYtQsy0G/FtzA8ixajg0w2EiDeLNJNC4elOtCufTlDFRxOoGx8+TyIpg
X-ME-Proxy: <xmx:YTl8aqKrgBjAxUUpzPLHM6HGQK1Zl_m_PwdTY-HhNFivhnsJ9cUIeQ>
    <xmx:YTl8arEdG6gzKaYLWaSjPXp70eV6Bhag-AHmxKyrJJIQMw_8Yn6YZw>
    <xmx:YTl8asqV_GrBXd6XyXhch2oHSKXP26CiszowSdBNh2J9wffKrLiv3w>
    <xmx:YTl8asT165nUC2dOJMywUFPMO9SWLpDmqOXpmhvKkD2zHncQhblnrQ>
    <xmx:YTl8agAgtQZ7mnR2t9-gA8nO2xkrJY1bm5vQ6FXkP6FAbCW8bfk3RyAl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:14:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c86b506d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 09:14:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] odb: eagerly load alternates
Date: Wed, 12 Aug 2026 11:13:56 +0200
Message-Id: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0K6dswUGkNceQ/DYqBTrCKQTiUSw
 t0t6AFcvuTNf7Mo4eBZ1DlbVODJix/6BPkhU82N+pbB28Qqx/yEJRoYHwKDrYGp5dDNMAYeKTB
 QFzn0FFmgYFcjFSWjtSoNJcX59x65Vl+WV33nJm7Lm3HzEocw719MevN+QY3/BCcNCA4dGTKIh
 vUlHR39U1Xrun4AiItGDeMAAAA=
X-Change-ID: 20260804-pks-odb-eagerly-prepare-alternates-3efb0a38e0dd
In-Reply-To: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Hi,

when initializing the object database we only eagerly initialize the
primary object database source. If the primary source has alternates,
those alternates are only initialized the first time we really access
the object database.

When introduced in ace1534d6f (Introduce SHA1_FILE_DIRECTORIES to
support multiple object databases., 2005-05-07), alternates were
originally only loaded when a given object wasn't found in the primary
object database. This was also reinforced by later optimization, for
example in 693d2bc625 (Attempt to delay prepare_alt_odb during get_sha1,
2007-05-26), where we tried to avoid loading alternates in even more
cases. But as Git has evolved, we eventually started to eagerly parse
alternates all over the codebase, including on every single object
lookup, and consequently deferring this operation does not really buy us
much anymore.

The result of this is that we have calls to `odb_prepare_alternates()`
cluttered all over the code base. This is somewhat awkward, and as
almost every Git command ends up reading objects at it doesn't even buy
us anything.

This patch series thus gets rid of the lazy-loading. Besides simplifying
the codebase a bit, it also prepares us for moving alternates into the
"files" backend as discussed in [1].

The series is built on top of 010afd3166 (The 12th batch, 2026-08-07)
with ps/odb-make-creation-pluggable at e927cfeb21 (odb: make creation of
on-disk structures pluggable, 2026-08-07) merged into it.

Changes in v2:
  - Add a missing word to a commit message.
  - Explain why we don't have to handle GIT_ALTERNATE_OBJECT_DIRECTORIES
    when re-preparing the object database.
  - Link to v1: https://patch.msgid.link/20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im

Thanks!

Patrick

[1]: <amLgMqkqxR8mKIbT@pks.im>

---
Patrick Steinhardt (4):
      odb: decouple source path comparisons from `the_repository`
      odb: eagerly initialize alternates
      odb: drop `loaded_alternates` field
      odb: drop `alternates_db` field

 builtin/fsck.c         |   3 --
 builtin/pack-objects.c |   3 --
 commit-graph.c         |   4 --
 loose.c                |   1 -
 object-name.c          |   1 -
 odb.c                  | 109 ++++++++++++++++++++++++-------------------------
 odb.h                  |  22 +++++-----
 odb/source.h           |   7 ++++
 odb/streaming.c        |   1 -
 pack-bitmap.c          |   2 -
 packfile.c             |   1 -
 packfile.h             |   2 -
 12 files changed, 70 insertions(+), 86 deletions(-)

Range-diff versus v1:

1:  25802adffa = 1:  721907c60d odb: decouple source path comparisons from `the_repository`
2:  1e73b730d8 ! 2:  3b2c23566c odb: eagerly initialize alternates
    @@ Commit message
         many calls to `odb_prepare_alternates()` cluttered around the code base
         whenever we are about to iterate through the sources.
     
    -    This lazy loading doesn't really add much value: the moment where read
    -    any object we _have_ to load the alternates anyway. So given that most
    -    of our commands would access the object database this optimization is
    -    not really buying us much in the first place. Quite on the contrary, it
    -    makes the code harder to understand and is a potential source of bugs in
    -    case any callsite forgot to prepare alternates before we iterate through
    -    the sources.
    +    This lazy loading doesn't really add much value: the moment where we
    +    read any object we _have_ to load the alternates anyway. So given that
    +    most of our commands would access the object database this optimization
    +    is not really buying us much in the first place. Quite on the contrary,
    +    it makes the code harder to understand and is a potential source of bugs
    +    in case any callsite forgot to prepare alternates before we iterate
    +    through the sources.
     
         Historically though there was a reason why we deferred lazy-loading: it
         may happen that the repository has "core.ignoreCase" configured, and we
3:  2ca1aa2a37 = 3:  df5d7df91d odb: drop `loaded_alternates` field
4:  1e97c93bdf ! 4:  50a37ef385 odb: drop `alternates_db` field
    @@ odb.c: void odb_free(struct object_database *o)
      	pthread_mutex_destroy(&o->replace_mutex);
      
     @@ odb.c: void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
    - 	 * the lifetime of the process.
    + 	 * Reprepare alt odbs, in case the alternates file was modified
    + 	 * during the course of this process. This only _adds_ odbs to
    + 	 * the linked list, so existing odbs will continue to exist for
    +-	 * the lifetime of the process.
    ++	 * the lifetime of the process. Consequently, we don't have to
    ++	 * reprocess GIT_ALTERNATE_OBJECT_DIRECTORIES here.
      	 */
      	if (flags & ODB_PREPARE_FLUSH_CACHES) {
     -		odb_prepare_alternates(o);

---
base-commit: f6ad67a7977439ad8351d42e6ccfd11f714db765
change-id: 20260804-pks-odb-eagerly-prepare-alternates-3efb0a38e0dd

