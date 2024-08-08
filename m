Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700DE10F9
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116056; cv=none; b=PWY3wb3kFCCa2pY+UY4IUZWbe8DDw6Ppu1Cbnuuv2aW3yHcfmD+BIO9GfVodp3cJi4yM7P5NNj9l3LAxq+y/iUL1JuUx0f6HxbE0qQkgt+FxKOnoEZDsszRYpvgqe0BHLH0XSD9bsKT3rqmUcYc92CTxP0rAu9A2VWY2SpBuKIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116056; c=relaxed/simple;
	bh=YduXBB/yohrhrTfGHLoP9j1b5LF/59GFqREd9sem11c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb/Z70kJmfPFx80EaSq1oEsAIqUlGO2BbXN8MZ5z74bwWvRZha/7Ea1CgmR/nRhjCimbWq+cTHDimZJzgUfjkdBDa6HXESL2T6v1l6mk/QvXHQGjXPOtopomYfS+a0t5jyTIf2vD9fAIWIB8eyZ9UA0ahODxhzcUU6ERw80X1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqnDtpaV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqnDtpaV"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d19d768c2so636318b3a.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723116054; x=1723720854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dybC2ucSFiYdHOJPK7/XCl3ifqd9hD99ObWULiWBiAk=;
        b=RqnDtpaVCM/ZpackqibhXxqzWKXWO7hkp6LR186GNstptqZOGeQCGP7D8VA0phm8gg
         0CUH4b3ylnn+T9gral7Re+fgFat6u74WASB/X1UfQgjxwjeFkqqTDRtg9Uqiq9DF62Gm
         1CqtVTdRwLzjE5Mkd/mHuNJ/3sqFHYfODA20O9eAtoBL+x+avern/o4LB4GpTwiPhdYW
         MRkGBdV2XqJD8f9bLs+xx+xEW+F87YNUBc+4saWS+lKA90+JQfDo55VocR2wBY98sNAc
         2CsxzQUpP0JftBxGj92uw3pg8J/gqUDlVyZvt/Zmw1jiIjvy0Kvrlc2m9m0rKPXWAqDs
         ZQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723116054; x=1723720854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dybC2ucSFiYdHOJPK7/XCl3ifqd9hD99ObWULiWBiAk=;
        b=IaTspH5wr/vPfX7R8hTWqx1kWT7RfSOKdtfXg4aWPi548fZ8favW8iuSbz45Oc0Ybq
         xaMNz4faKCzhTvm+eGZ7/kaQQ6AIbfUCTT4x9epgrbt04acvI+cMzQ/sJW+qToxxkG5j
         6ThKK0OOfCkFX0Fq4Zj31tKHWBT9K63SlDivoSHIdmsHf0OehtLvZAcNRrknti8HIcaL
         u3QZFAzE2m1APg0zx7M+Y9LRH7iX2V+0yReHNWMj7cDmrgOAVLJoN//6OIm/UFS2b0u7
         RmMNhEaubcPe7DNeYIomaT/8L/gseA5ja1XjxfDvH1/uW073EUqaZgf6x8zjhZlcpzrt
         wtrQ==
X-Gm-Message-State: AOJu0Yw2tDKVSn6kQqegdwTEjC6GlIWjx4krkiayj2LmvrgE5nJr6YuY
	GwBVaqVWzEqIVaJkd0npPWrLORUYEMDU9WYjWSG2xveVNT/vXQmZatACIwy46ko=
X-Google-Smtp-Source: AGHT+IH1iSBfuZm+ZKaqcVDKDUC151LuvqcCbhU4Dm7CDrDwNfimSLHmFR+cTFpXLRKQeMqI+g52iQ==
X-Received: by 2002:a05:6a00:22c2:b0:70b:1d77:730a with SMTP id d2e1a72fcca58-710cae75777mr2056681b3a.28.1723116054042;
        Thu, 08 Aug 2024 04:20:54 -0700 (PDT)
Received: from localhost ([103.74.125.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb25e117sm973705b3a.94.2024.08.08.04.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 04:20:53 -0700 (PDT)
Date: Thu, 8 Aug 2024 19:21:22 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v16 0/9] ref consistency check infra setup
Message-ID: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrEBKjzbyxtMdCCx@ArchLinux>

Hi All, this version handles some minor changes:

1. Remove redundant newlines.
2. Fix typo in commit message.

At last, I wanna thank every reviewer. As we can see, this series starts
from 5.27, it's a very long journey. I have learned a lot.

Thanks
Jialuo

shejialuo (9):
  fsck: rename "skiplist" to "skip_oids"
  fsck: rename objects-related fsck error functions
  fsck: make "fsck_error" callback generic
  fsck: add a unified interface for reporting fsck messages
  fsck: add refs report function
  refs: set up ref consistency check infrastructure
  builtin/refs: add verify subcommand
  files-backend: add unified interface for refs scanning
  fsck: add ref name check for files backend

 Documentation/fsck-msgids.txt |   6 ++
 Documentation/git-refs.txt    |  13 ++++
 builtin/fsck.c                |  17 +++--
 builtin/mktag.c               |   3 +-
 builtin/refs.c                |  34 +++++++++
 fsck.c                        | 125 +++++++++++++++++++++++++++-------
 fsck.h                        |  76 ++++++++++++++++-----
 object-file.c                 |   9 ++-
 refs.c                        |   5 ++
 refs.h                        |   8 +++
 refs/debug.c                  |  11 +++
 refs/files-backend.c          | 115 ++++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 +++
 refs/refs-internal.h          |   6 ++
 refs/reftable-backend.c       |   8 +++
 t/t0602-reffiles-fsck.sh      |  92 +++++++++++++++++++++++++
 16 files changed, 477 insertions(+), 59 deletions(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

Range-diff against v15:
 1:  9aeaa3211c =  1:  9aeaa3211c fsck: rename "skiplist" to "skip_oids"
 2:  7511340a21 =  2:  7511340a21 fsck: rename objects-related fsck error functions
 3:  ee971d17f4 =  3:  ee971d17f4 fsck: make "fsck_error" callback generic
 4:  59ccdab54d !  4:  f80fa00538 fsck: add a unified interface for reporting fsck messages
    @@ Commit message
         "fsck_vreport". Instead of using "...", provide "va_list" to allow more
         flexibility.
     
    -    Instead of changing "report" prototype to be algin with the
    +    Instead of changing "report" prototype to be align with the
         "fsck_vreport" function, we leave the "report" prototype unchanged due
         to the reason that there are nearly 62 references about "report"
         function. Simply change "report" function to use "fsck_vreport" to
 5:  b5607ac61c !  5:  8c0376cfd5 fsck: add refs report function
    @@ fsck.c: int fsck_objects_error_function(struct fsck_options *o,
     +			     const char *message)
     +{
     +	struct fsck_ref_report *report = fsck_report;
    -+
     +	struct strbuf sb = STRBUF_INIT;
     +	int ret = 0;
     +
    @@ fsck.c: int fsck_objects_error_function(struct fsck_options *o,
     +
     +	strbuf_release(&sb);
     +	return ret;
    -+
     +}
     +
      static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 6:  5819406b40 =  6:  552fe62ff4 refs: set up ref consistency check infrastructure
 7:  6a9c194a05 =  7:  3b357fa89e builtin/refs: add verify subcommand
 8:  76406b1303 !  8:  8d2c7b3aa5 files-backend: add unified interface for refs scanning
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +	if (o->verbose)
     +		fprintf_ln(stderr, _("Checking references consistency"));
     +	return files_fsck_refs_dir(ref_store, o,  "refs", fsck_refs_fn);
    -+
     +}
     +
      static int files_fsck(struct ref_store *ref_store,
 9:  ed02380516 =  9:  b39533ae56 fsck: add ref name check for files backend
-- 
2.46.0

