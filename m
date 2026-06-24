Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865C3A1DB
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782331769; cv=none; b=ElsN62t5JlyyuRxcofzxGOlWzLbW2vHdf/ymK13qFkwuM16Irth1i2NOE6UQwGC1LkqUEQaMl651NRRa7NJwxStUFZz4ScXfPfVJN2kh/5jPDFGAUYFsffwZF9ZIHVZfExdIt1tfY1BAz68u+BXYAedhYbFRbqm0d8nwJnpVfPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782331769; c=relaxed/simple;
	bh=xXsB/N/UhgE2Ei75m6z8dZfcqRouxjM9MESs7V53yCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lglCFeNvVsdnjnFVI1aIKi34zxcAk+dFp/RjZy3VfWt4JAiSPSaJcw3l0twwt6IMQI97/vyzREv79DUUBcCx5JKIza3j+m5KsrBufJmhjzoWh8b853tCAwdXsdMZUjD1+D2ZH9ZgfNhv8DBphH30bPAy6uwhk+/BIjoVsm8tuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ruf+oche; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kRD71/zT; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ruf+oche";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kRD71/zT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9AE101D00119;
	Wed, 24 Jun 2026 16:09:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 24 Jun 2026 16:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782331766; x=1782418166; bh=RwlKcy0PvD
	RN9KO46X9exK5m0Y5eACs8EHbUE4K603c=; b=Ruf+oche5Q5aMdhiF1QnS9wo5Z
	FoBgs5ZHWgeu6JjUZBs02NcVzhvQsaeYb0p3w+FhetOhLzKzVZ2IbnKBBaJgiryV
	6fmKD/9zoBFJaApG9qE75a+SCj45UGUD0eSb1fVCU1f9xlL01kDttRyF9ro66Tbd
	IbMEutqc7uiW0Bpr0zVMozK/oSpMspiCeWcPReSe0uAFol8uP9y8uO/4znBEV44z
	kOjx9R6s9RroGDtvklWHkZFhdLp/jTvQeET4fnYZHKUpLOV3cjPZl7hp3zDh9qL7
	uCgVzcOM+o4zUxvJkDy4dr24vSZDfnv/9dlfRCslFWTBnD8iI/yYpJMni3Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782331766; x=1782418166; bh=RwlKcy0PvDRN9KO46X9exK5m0Y5eACs8EHb
	UE4K603c=; b=kRD71/zTSeho2fJxKJn62ntGNiOSdrUhRGjlXlJyCg2gmxTsbGD
	43g/V0Sx5VLkb/yqneywgO3hMNpiicsMjbLsEURJNYoVOph63Q60fxmVu5yAURcB
	iBxRiyfwsyFx4Br8d+yXCvrpHx48T7RCBzwZ/i37/dm8w3Zza0kU7/27hPwusrvK
	gCOD8X+z7dQHkPGlnhPPqHPl4a14n0t5H2BRMQakm7dnaQOUnkT+MmXLPBJ2hEHy
	VSjVcylxcmKzAXoEbjP+UBQM/jWpEbKzEftuP+LPiUTQ8/zDdhC3MEzr2urMMpBj
	u1D6EIgqPI2Q2r19hgz6oTP9LkBDmq8ff3w==
X-ME-Sender: <xms:djk8aum3QemseS-P7PDRreFka-Cov7uoF2t4ztj3QQqmIBWkWBBUGQ>
    <xme:djk8as1kMVgOj6OQ-JDsRF_6zrdwSmoQ4VvQ0mhYiBflHU6ZnBqGq8_uVzChN1X64
    QGOvmIZXHafzNQaBm8jrFg9izXwz7j4Xs3lLObZD3uxCtHwp6l34Q>
X-ME-Received: <xmr:djk8ahonfg5IxckdWSlPeUBkVnmDOGPNK1Wmnd9noBjBQK5oA9Wcp_l9uAAjF6Ij0B7s6pJCS6LfjxlBN87W-4i4Nyg_BdeKHXVCpTs>
X-ME-Proxy-Cause: dmFkZTFuTDkvBzv0G4PCx2LTMsmkqW3/qau9qiIPfgMuWG7O10+bYgsYrnpme+FEwdTxDT
    Q2WFEYUguUkGpCYH0zKNxhaUpDEn3RHPm+nqlAywXuLbiol53Mqj+DsgJPeWqECDvV2uNk
    a6dybVjz5NR25zpxWFXb6szFKzQklEtXSe0erq50iQvQbslqI7TUOFzHZ3cyTMlNhLtqSV
    hXlMQgD6NIcHJMgcd5DlOAaYMGDN70cu81p9Sjt3vFfI08B7Mc9PZWvZ+2Su3bGEPzAyCe
    X0C/z5BvOToev+LGQXWx3wOlRAr/rXB+2AAgDmenQVlVKEXr3qavJzhb+lyd2hJaBb7pVj
    ByPx2tQ2vka3eBFhZ+6l8zTceXfliKO3ZnW08fePuICxlPvZWz4iGVULq52SunMLF6pyQc
    WQwjNtWpx30lG/+3eY/7aO5WS5kXKU7djIH0LZN8Ux5EgIxpBJTXWYCEvgol5OekmgXrW1
    LRv0PA9zKXXB9XLbYmv89TroqzINxhJtLVaFapPZjIoU8WKaVaiitha4DocnI8tqs1mEfW
    WAgLaAwYa50+TCsn5Ru4LjpSo7yg0anSjv0U/Vh5JvyZ3dt+aX/0E6W0z8ERuWGYTashfZ
    3arSo3qnI4yrnmq4rRtWJIBQauBIlpAMIczQzwL5cluFoaIkJhnPWeA94isw
X-ME-Proxy: <xmx:djk8ahcQ8POcziXtf0NzPh8nNtTdUTmVwTwqW_09tPPQK8vcajSPJg>
    <xmx:djk8aoq5IAB8jc7JNUcE93xrqbFBPq2aU6QUfXvyjmpQqElQGzcG-g>
    <xmx:djk8aqFJb3odL84t2RrZuegtPTZKNFzWpyD1G80mGi7tZMQPlq2WTA>
    <xmx:djk8agsT4COKgopERBgTkfYcKfl_CQgVfq9QHMFx9gOHKqW63kgoxg>
    <xmx:djk8atJxVZr5DGHnmY6dlPLRoB54fbratJ-APJh2ZrrP7DSjTTNd9r2W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 16:09:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 0/6] receive-pack: use ODB transactions to stage object
 writes
In-Reply-To: <20260624041920.2601961-1-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 23 Jun 2026 23:19:14 -0500")
References: <20260624041920.2601961-1-jltobler@gmail.com>
Date: Wed, 24 Jun 2026 13:09:24 -0700
Message-ID: <xmqqechvitu3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Greetings,
>
> This patch series replaces direct usage of the `tmp_objdir` interfaces
> in git-receive-pack(1) to instead use the `odb_transaction` interfaces
> to create/manage a staging area to write objects to. The purpose of this
> change is to get git-receive-pack(1) one step closer to being ODB
> backend agnostic. For now, the object writes themselves are still
> "files" backend specific due to being handled by the git-index-pack(1)
> and git-unpack-objects(1) child processes. This will be tackled in a
> separate series though.
>
> Thanks,
> -Justin

The integration cycle this morning was somehow more painful than
other cycles.  

FYI, this topic had some interactions with ps/odb-source-packed and
ps/refs-avoid-chdir-notify-reparent and needed the following
evil-merge fix to make it build.

commit 721c15c1d5ef8f8aab8b9f50463e979e890b1ab6
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Jun 24 12:45:35 2026 -0700

    merge-fix/jt/receive-pack-use-odb-transactions
    
    conflict with ps/odb-source-packed and ps/refs-avoid-chdir-notify-reparent

diff --git a/odb/source-packed.c b/odb/source-packed.c
index c3c26fb53e..b9231a8da0 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -545,7 +545,8 @@ static int odb_source_packed_write_object_stream(struct odb_source *source UNUSE
 }
 
 static int odb_source_packed_begin_transaction(struct odb_source *source UNUSED,
-					       struct odb_transaction **out UNUSED)
+					       struct odb_transaction **out UNUSED,
+					       enum odb_transaction_flags flags UNUSED)
 {
 	return error("packed backend cannot begin transactions");
 }
diff --git a/t/unit-tests/u-reftable-table.c b/t/unit-tests/u-reftable-table.c
index a35bbc8004..dd5db06534 100644
--- a/t/unit-tests/u-reftable-table.c
+++ b/t/unit-tests/u-reftable-table.c
@@ -235,7 +235,8 @@ void test_reftable_table__seek_invalid_log_offset(void)
 	uint8_t *footer;
 
 	cl_reftable_write_to_buf(&buf, refs, ARRAY_SIZE(refs),
-				 logs, ARRAY_SIZE(logs), NULL);
+				 logs, ARRAY_SIZE(logs),
+				 REFTABLE_HASH_SHA1, NULL);
 
 	/*
 	 * Corrupt the log section offset stored in the footer so that it points
@@ -278,7 +279,8 @@ void test_reftable_table__new_with_truncated_table(void)
 	struct reftable_table *table;
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 
-	cl_reftable_write_to_buf(&buf, refs, ARRAY_SIZE(refs), NULL, 0, NULL);
+	cl_reftable_write_to_buf(&buf, refs, ARRAY_SIZE(refs), NULL, 0,
+				 REFTABLE_HASH_SHA1, NULL);
 
 	/*
 	 * Truncate the table so that it is large enough to read the header, but
