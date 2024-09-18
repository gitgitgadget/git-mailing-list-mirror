Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C83F175D2E
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653570; cv=none; b=KQm7VRwNFBjPzRYKadOR2D2HxP2RrHaBd0sqPDT1AnB7UGbs6hNxGJ4cuFP+6kilZOnNzpaaPAzWgb6yqvn+d2EqwHhn5z2H+vRAoEHBxFK1kIXaX54n7pO4Poecqpas6a0aN/2NNIcvA6EWXgNtdZP9AvJHHGB2yDnXQ9XRxLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653570; c=relaxed/simple;
	bh=V+PCBFoUZDurAjL+hSgj0ctGmqmsePLOe0FMtjRYHr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsuovNldHipxhWtWAl2bth5Nail/zuknu+hXHAJUQ9pcPRdIUqN3YEAa3IvEgUft6O1QVkNs40cS2JTcKIwPVYfWLMM4+q2/tRrY1dpgZUUdV9lpNWNcHJwkuVbpu1rkfBWcVXaIHZlsxxL3o1aBeDpCBYs8n56f/i/g7T4er58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OVf4/9ZH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JyRYmIbP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OVf4/9ZH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JyRYmIbP"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 05FE41380261;
	Wed, 18 Sep 2024 05:59:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 18 Sep 2024 05:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726653568; x=1726739968; bh=yW0zfeDh8H
	BLlqeC+4b4oga/8yHazWccstJVHYQg6vA=; b=OVf4/9ZHwuVIrbslqdbzEcqhKo
	tPap3Hi09nYE5j+cuGPrEWyExYxuS25zRZyDX54/x7p4X8S4ZeiJFo1mCOmetbm0
	Pyzxpwrfum3nwLmi1pabe5TcMJjQdl3weFdaRa0BOfJc+s36eCnaKEEjXe1qhaZ9
	VDy0c5tSjg6MOSN39hNpXzvRgV9LMP0x5AHrZcMaPu4WyXFDlRp/bOD7XV/eTL2d
	AidDp9umcqE7NoXS9AezOyS5v6GH7TsWzy2XypRzfjaAaufpDVkBfoxtXY/Otbg2
	aDT46wKh5Dm7e91MuaTH7pg0VbmBNGJ4y33437IAl+66ggeaGTNnv47iALOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726653568; x=1726739968; bh=yW0zfeDh8HBLlqeC+4b4oga/8yHa
	zWccstJVHYQg6vA=; b=JyRYmIbPnPgUs3+JYuWvDss7Bu9axJEu+UfsaeCIJBaI
	sHs/M7jd0e6YRStjcWKtphmmwjhyjzPtkoIfe0PmM/1hgxHoYVgcsI86XtQ3u0zf
	dw+7BQ5GbRoCTTeTwXRgUUwf+U7hvnamybAktdyuMHimqcs7GCP0hzGmmfz65lwD
	1BQHc3bFRpFLuW6ftCYfbfcOGrM9iV30U1LkYLHcL7uACPP2GGUW6tJdvXXd1W6f
	Zw6dskvmfHg0E7K4xA1PGomr8Ew0CEf0qQ/AkvPh/7mv4oR6bKW+gbpffvo1Aynh
	FwtTm49jZ5DwNR7Hdq7BgDSB56jSXSJVktVHM+IxiA==
X-ME-Sender: <xms:f6TqZnTs6Uarv5h4Tn-VqdpxARRS_m3ln5QGHLm0MT12oiunhKhm9g>
    <xme:f6TqZowB8DbRm5vT6ZuFRxbGN2FxpMeqPjLmIdRdObnouBbJAXvz99UBKxV7Mkle2
    7ZYVkhuwIKkYT6xsw>
X-ME-Received: <xmr:f6TqZs3IBNK4bni-ZcHX9MsrAMb6VDQERu3UNAgUSxScSsoGcAlAAIOzFWArp8kVgDrAyjfByW4OLC62oVHRsqMUsAKAR6z8dJNoWIY-ruW01V9J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:f6TqZnAZUeCq5G_xcV8Vmc1xgXYJUu0PfzRm4WGVfNgstQm1jnFjLA>
    <xmx:f6TqZgg55i7oAKGZqNORxdbUxeylPbPSnonJh3KC6pkmSvtzVdjskg>
    <xmx:f6TqZroUitN_1qb6cCVAZh2LqSmurfjQX9AiXP2IgcflcI9a42gMVg>
    <xmx:f6TqZriAf_qdFwEjSDkufBlOOET8JyRU9v2QKpaWFkY0Yo2rrYBZeA>
    <xmx:f6TqZodu67I-_7iWqfx4zR2pMnx2tS2dbyQIJHy-7fFExn7CsBRXITok>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:59:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 878f0ced (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 09:59:04 +0000 (UTC)
Date: Wed, 18 Sep 2024 11:59:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	James Liu <james@jamesliu.io>
Subject: [PATCH v3 0/3] reftable: graceful concurrent writes
Message-ID: <cover.1726653185.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726578382.git.ps@pks.im>

Hi,

this is the third version of my patch series that implements support for
graceful concurrent writes with the reftable backend.

There is only a single change compared to v2, namely that we handle `0`
and `-1` for the lock timeout config. With `0` we fail immediately, with
`-1` we lock indefinitely. This matches semantics of loose and packed
ref locking.

Thanks!

Patrick

Patrick Steinhardt (3):
  refs/reftable: introduce "reftable.lockTimeout"
  reftable/stack: allow locking of outdated stacks
  refs/reftable: reload locked stack when preparing transaction

 Documentation/config/reftable.txt |  8 ++++
 refs/reftable-backend.c           | 13 +++++-
 reftable/reftable-stack.h         | 13 +++++-
 reftable/reftable-writer.h        | 11 +++++
 reftable/stack.c                  | 38 ++++++++++++------
 t/t0610-reftable-basics.sh        | 58 ++++++++++++++++++++++++++
 t/unit-tests/t-reftable-stack.c   | 67 ++++++++++++++++++++++++++++++-
 7 files changed, 189 insertions(+), 19 deletions(-)

Range-diff against v2:
1:  700a35df125 ! 1:  77cffd3b1eb refs/reftable: introduce "reftable.lockTimeout"
    @@ Documentation/config/reftable.txt: reftable.geometricFactor::
     +	Whenever the reftable backend appends a new table to the stack, it has
     +	to lock the central "tables.list" file before updating it. This config
     +	controls how long the process will wait to acquire the lock in case
    -+	another process has already acquired it. Default is 100 (i.e., retry
    -+	for 100ms).
    ++	another process has already acquired it. Value 0 means not to retry at
    ++	all; -1 means to try indefinitely. Default is 100 (i.e., retry for
    ++	100ms).
     
      ## refs/reftable-backend.c ##
     @@ refs/reftable-backend.c: static int reftable_be_config(const char *var, const char *value,
    @@ refs/reftable-backend.c: static int reftable_be_config(const char *var, const ch
      			die("reftable geometric factor cannot exceed %u", (unsigned)UINT8_MAX);
      		opts->auto_compaction_factor = factor;
     +	} else if (!strcmp(var, "reftable.locktimeout")) {
    -+		unsigned long lock_timeout = git_config_ulong(var, value, ctx->kvi);
    ++		int64_t lock_timeout = git_config_int64(var, value, ctx->kvi);
    ++		if (lock_timeout > LONG_MAX)
    ++			die("reftable lock timeout cannot exceed %"PRIdMAX, (intmax_t)LONG_MAX);
    ++		if (lock_timeout < 0 && lock_timeout != -1)
    ++			die("reftable lock timeout does not support negative values other than -1");
     +		opts->lock_timeout_ms = lock_timeout;
      	}
      
    @@ reftable/reftable-writer.h: struct reftable_write_options {
     +	 * Note that this does not apply to locking individual tables, as these
     +	 * should only ever be locked when already holding the "tables.list"
     +	 * lock.
    ++	 *
    ++	 * Passing 0 will fail immediately when the file is locked, passing a
    ++	 * negative value will cause us to block indefinitely.
     +	 */
    -+	unsigned lock_timeout_ms;
    ++	long lock_timeout_ms;
      };
      
      /* reftable_block_stats holds statistics for a single block type */
2:  f4be0966e17 = 2:  6130565498e reftable/stack: allow locking of outdated stacks
3:  111b497ef17 = 3:  25d4e513a36 refs/reftable: reload locked stack when preparing transaction
-- 
2.46.0.551.gc5ee8f2d1c.dirty

