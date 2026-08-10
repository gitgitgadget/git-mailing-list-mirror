Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF7A305677
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368822; cv=none; b=PyH8RUnWEOl/1EhE7jCJGNmRip9j7a68B4sUL3efX/XDd/BuG4kXq+dkGV/eVS4vUfx07+ZyBN8ed8IQaaPW1aQWs7FDcghKnAKrwv5xBnEGyrtObxy8BfosI125lssFNVCaAXICLBj6FujU1hb8/NO6AsSn4uAAvBOz05AZKWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368822; c=relaxed/simple;
	bh=ezdD1DytriV8U93DYFNODm3Grs0pa9ZBrqC6OLh1UjM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u8m2OwVU84HUrACfffLCesTCMZdLK0bwb6cvK1Cj3N9fniXAvlU14emvk+Rl/XE6+4icI+pJvHlvzmFfVA6lc1oIv/jJ2eazhiFI3es8xVLCr3WseQJp6PGgKOLCPSnKrm9lWEPvu6DJVUPd8RBs+2vtf8sUgbYVfYm9AyG/d4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TAOS8zl3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P0Z0ObgE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TAOS8zl3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P0Z0ObgE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5189E14000EA
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 09:33:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 10 Aug 2026 09:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1786368819; x=1786455219; bh=dohC/Hst7o
	3tgUpFithHyl4EDAWErY2y4QmML6PMXo0=; b=TAOS8zl3U+ehsxbyR8g4xKaVbc
	dtz8xj+jQwyUp8QUQGAtWa02d14PSqW/+VttT4RBfmHqaNqaDEJFV56Bolw8oHrI
	Y6HBnsUBMApnkrNkebGl/8yY0ydm9tZLw+DKlmheJcEkBjWSZWJyxDmN7ymI0JNd
	XvTtjLcrXFYOyUnwyBkSmYxxaXeYT8YsaAQsE1iBdmMHiP2brLQUq5ZmuBDr3EWi
	kzag5geF7sCOa5klhfGBq/gdy4nziVExo+PHg+I7SlyWEuVVr6IpBhlgYZBbQXre
	8yCpAS96Ariziutl8MKfMPkSQ7R+bdMPhdfSa9KoG9ugoh1sddQFvc2Sve5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786368819; x=1786455219; bh=dohC/Hst7o3tgUpFithHyl4EDAWE
	rY2y4QmML6PMXo0=; b=P0Z0ObgEwnBCdOBCixnmA0bcswejHBIbbRquJ+nPT9Vt
	0sKmuymrMOwyj5RJmXe9J+G6NOSBSslFD7wnRBIUsahMYiM0j7xxx1hUuRE5HtBh
	WCoqJsDvWiMfgDEaUupUuEa4P+eL2FkMUfst74YXgI6aHNd1bkUBZ4REGcxYmYTS
	iO/4hzjg28A3oSFnhpQWGDOhereAGK4wmKxoqteiNeYznBKE1FUPwUXPNkIncCV3
	fceE+eGHRNeBZhVo3n2BUMBZ2F8n8/3nQ/8BWhb2bpa6e8cHDLzVJaALQ0/v+OXX
	IwU6VtELyK3STrQcRtOADMH+WRh/amM42ucCeXPN9Q==
X-ME-Sender: <xms:M9N5am6zfp8JrMuVQ5dQOHvfK6RkTriJxCQzy_5SimtX0ATFZ_qp1A>
    <xme:M9N5am1OLzJmyvjB6PJxORdSD4FXBUr_agPpIwWHzvdJdRGmUQEd97PvhEXqYKig7
    Pc3x6TK5Mdbw6KZ04aVVNE5b2kupzyCitH-DgIjbTtYmfEnfVSETY8>
X-ME-Received: <xmr:M9N5arG9OC1WMXhkT66N4sk0R4KcBGB33cXdKwcUJ07o95ts48EbfdWmR_p09kmEub5c816p7HHVhRgSGEyWXwud5jB5-Z1BneO0m7VYUQ>
X-ME-Proxy-Cause: dmFkZTFeSTvqWc7e48O4fjq3b8W8XOCxWt3fHVTdE4b9jlXdOF6N1G2fm3keG7fOBoDKu0
    bgWoYf2ui8KeYPmjKolpG0DXRZXlatOe3p8wf4Ae9QuGbOGolFy5QBaFWm9EiPYvOVvTAW
    OJkvjiNyJ5L1Pn8srWL+5Q9k7BqfzRARbf+97vjZorqCiobVtgb/DXwY9s8Lhoz1kHBgCa
    EeTzs6QNC5NZi/W3wH7XSaFiJce/reyaaGxG2lFUj0oMOGBTbN+MJF531Lk+62sowTHlVb
    6Dlxzlt8g1K4zpMIOm8PS0NxvvacgnUdVeTDveYgj3XRRD6U1HZspwnjsrMJyxEzFIH8QC
    z9sf1w+9vim4SvLPXiHt4ZadtRmB5SIlyzSRXx9IGM2brL5PRuspROhk6YvTdvkL0HylEo
    AH4Wc2KnOtqoGbbqWiXLce/Ob0W806Ka5sAd4crZDxylJOco4Y2Q2y7gELWHQ/eigLQ8bj
    pWusHcbvlTisUvb3l5VFeFTMfE8aOv9d9zK364z+4fciGlJsrdbg5E+00B73rjdCg6rpou
    JmWx/P/hYexxUkI5ZV8dDWD0ssRX66x0HYMlkgBf1C0aL84pi96CCgPnb/vvSPMifI+A80
    k/wUBRJ7tsdvG/i/FTJdU5NJ2MLZDuvmlLabn8DrdzN36ybRYibJK5z9qH5g
X-ME-Proxy: <xmx:M9N5aoRLNwHYAzfuwDgTsCkyV0Vw83AgaPXy34tgt_fbBtsonOpjjw>
    <xmx:M9N5aqC0OOkAO9sKCgRizmIs5ucXFmREHNuRVgEg8ULNHpPL16cm_Q>
    <xmx:M9N5ag2Vl0TkDaL9B0Uax47VXZbZi5vMPqSttCbaX1aUjueUodP75w>
    <xmx:M9N5agUubyGiXAkWE8P_WEf0g-oXX5Cd5Ji7Cqde6y5EhMCdVkCfjg>
    <xmx:M9N5avaDZdf8R_3g92Zcs8DCcMXYB1kIljElyVjttzGtgoywPA6Fvp0u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 10 Aug 2026 09:33:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 211c4bbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 10 Aug 2026 13:33:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] odb: eagerly load alternates
Date: Mon, 10 Aug 2026 15:33:27 +0200
Message-Id: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNUQrCMBCE4auUfXYhtiLFq4gPm2ZaoyUNu1GU0
 rsb9fGD4Z+VDBphdGpWUjyjxSVV7HcNDVdJEziGampde3S9O3C+Gy/BM2SCzm/OiiwKlrlAkxQ
 Ydxi9k66HC4FqqE7G+PqdnC9/28PfMJRvmbbtA9CSARmGAAAA
X-Change-ID: 20260804-pks-odb-eagerly-prepare-alternates-3efb0a38e0dd
To: git@vger.kernel.org
Cc: 
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
 odb.c                  | 106 ++++++++++++++++++++++++-------------------------
 odb.h                  |  22 +++++-----
 odb/source.h           |   7 ++++
 odb/streaming.c        |   1 -
 pack-bitmap.c          |   2 -
 packfile.c             |   1 -
 packfile.h             |   2 -
 12 files changed, 68 insertions(+), 85 deletions(-)


---
base-commit: f6ad67a7977439ad8351d42e6ccfd11f714db765
change-id: 20260804-pks-odb-eagerly-prepare-alternates-3efb0a38e0dd

