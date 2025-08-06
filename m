Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E412E36E7
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 23:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522129; cv=none; b=EcVKra24S9MAx5u/RNW5vzFLQalmLFTqfAXA/gfCI5Hep8XBQXMkjPXWOtJFgNKsspQlQDbIg1ikhrWWmwQSKD+/ARQl9rI2sVS/Veu+zP7BryP0cFGEcOmsi8Sf5y+LemC/5/ihiVI1vt7nEiRQziumTBw/JicMKmQ7yL8TbE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522129; c=relaxed/simple;
	bh=YOAyjlRSIteNqbXgIZK+RpGdtFrZaiUBDBqnxfydYgg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f/EQS0m+t1g8CxEY8M4Tmn6CA7mhnIgb9l0+O450ofE7M38JSWuwSoFY8+Zb0JwCCHDwW6YMHNJX0jsHCGqBkgk2OWinnwWpVFZnyjGFbq9IG/QSp60Ie3mhgRcIgtUjiRGszZOwnP/db5q63jqOhLRQIUAgpWwQEGFwvRGyZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Avzjc2Rn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Avzjc2Rn"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so2579605e9.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 16:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754522125; x=1755126925; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj9+rq6CO3fpkaxhw/ActXi1lXP8VEf/XYDz81XPYw8=;
        b=Avzjc2RnMeuMPtIZFMH8mC3XeXN8uTyhyuIW5ZkyAThg2XJicjGrSH3QIM2lbsjoQl
         kMkP9xzhWz/RgcwiRlB5FEeOJ01Bx79Oh5c+mUuwaROocaVaXCgL1+iFqUlZLV9JuxEh
         loAYkNu1WVV2y1u6HsBeHquVSdCRyuXiURBuq41ancXblfBJoAXUWKwhEn2HNa9W/jeJ
         +SXBesMO4pinm7aFOhlHeTLn93eRD0q7ojYARcORYJowbp56VIfwJ3Ofi2M9D43I+4cS
         shn/UbT962HUuNSHdCUm0/Ceykx6+X3ZcTakbYr7VCH1KbKbXCXbZD8WE7oI2IeCpL2U
         Z68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754522125; x=1755126925;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj9+rq6CO3fpkaxhw/ActXi1lXP8VEf/XYDz81XPYw8=;
        b=Ks+MtV9Bjs0B4+Km1f1EsMyG0FSXzh06KDLUCORxX/2kClXTOOB663ur9VUoMuP87Q
         mS/ESb45xphIsLeneUCkoMOZ7Pkzb0KWCXKWXdmV01ew+byWwbDzlJgIEgu6hLWQyijM
         UkD76DdAfXoYOYYyeRgo/nNQ62T7tqmc72Zrdrpz6E1XzcvcbtstTzp6/C40UTc7sDuN
         GBvmuF3hJ/9F20Q+typC1NeFPB0m2WXpL6IHe4ecpJDFk73jpwYIdSGB5eGOpcIcoR9x
         4ZG9kLr70Ktt/QTgPuS0E6ne2mcHFc8gothMETGTXyHd5icf6e2xJ658lpE+hLF33JJW
         uBow==
X-Gm-Message-State: AOJu0Ywu2NBLRAZXZVTb/EukPraiCFgUG3GbXy5N9kAculO3V7uzqgQv
	tXWBboZwLRaCICjxOzJFOZ7PfgG5VRpwGkh1H0sRlismpWFL/3Vl1h0lSY6FVA==
X-Gm-Gg: ASbGncvc+MwdmRRdA84pgDA7ezSRRVao4m5X18PtAEAKEtOitje3ogRdMua04PQpTEN
	ussz8QMswOG64QDnS7gXA4zUJc5mzf+l1afw6oedjpYh/PKc0e73MJnR8XjP5MOTQm5Rdkkr3Wn
	vDXH+h25dOIYosC9eGkw921VcWk8Yk8IShnI4Cz4PmXyltcUDJ/f9XrJkzhEFqKOyQj516buV06
	nnLOuDc5zUsptanXSCO6Y0XsX91f/qliAeS9j20wbpSFLOvKIBks2UVMReghGnoAvVymFjoPr88
	AP03DFL81aURuf4B7x+DrqB7hu90HjkhoaDRI3FjsVOTD6vDC8CdzmOFe+k0TQj0aynBpmZ1KPy
	xcmmPp2QXvPqfF6W5a7Spd3vOmhpAiINVuQ==
X-Google-Smtp-Source: AGHT+IEsCVNu9h9MA5PO9eQrE4/hNeKUJn6750NBTwvATsd2JSwbFQc7ob05lK6Akyc/afX/IHyVJw==
X-Received: by 2002:a05:600c:198b:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-459ee8864c1mr6471085e9.31.1754522124806;
        Wed, 06 Aug 2025 16:15:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458f713eb44sm181090595e9.14.2025.08.06.16.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 16:15:24 -0700 (PDT)
Message-Id: <pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
References: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 Aug 2025 23:15:15 +0000
Subject: [PATCH v3 0/7] Fix various rename corner cases
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

Changes since v2:

 * Modify comment to note testfile as well as testcase name; thanks to Junio
   for spotting
 * Clarify comment about skipping rename-to-self cases in process_renames()
   in the second-to-last patch; I meant to do this as part of v2 but forgot.
 * Add a new commit which clarifies the comment in merge_options_internal
   about the interning of strings in the "path" member.

Changes since v1; many thanks to Patrick for reviewing v1 in detail:

 * Several commit message cleanups
 * Make the test in patch 3 have a single expectation while documenting that
   a reasonable alternative exists, instead of trying to document that both
   are valid and having the test accept both outcomes
 * Moved a hunk accidentally squashed into patch 4 back to patch 3, and
   adjusted a nearby incorrect comment related to the squashed change
 * Fix style issues (grep -> test_grep, // -> /* */)

Original cover letter:

At GitHub, we've got a real-world repository that has been triggering
failures of the form:

git: merge-ort.c:3007: process_renames: Assertion `newinfo && !newinfo->merged.clean' failed.


Digging in, this particular corner case requires multiple things to trigger:
(1) a rename/delete of one file, and (2) a directory rename modifying an
unrelated rename such that this unrelated rename's target becomes the source
of the rename/delete from (1).

Unfortunately, looking around, it's not the only bug in the area. Plus, some
of our testcases in tangential situations were not checked closely enough or
were weird or buggy in various ways. Adding to the challenge was the fact
that the relevant renames optimization was sometimes triggering making
renames look like delete-and-add, and overlooking this meant I sometimes
wasn't triggering what I thought I was triggering.

The combination of challenges sometimes made me think my fixes were breaking
things when sometimes I was just unaware of other bugs. I went in circles a
few times and took a rather non-linear path to finding and fixing these
issues. While I think I've turned it into a nice linear progression of
patches, I might be a bit too deep in the mud and it might not be as linear
or clear as I think. Let me know and I'll try to clarify anything needed.

Elijah Newren (7):
  merge-ort: update comments to modern testfile location
  merge-ort: drop unnecessary temporary in check_for_directory_rename()
  t6423: document two bugs with rename-to-self testcases
  t6423: fix missed staging of file in testcases 12i,12j,12k
  merge-ort: clarify the interning of strings in opt->priv->path
  merge-ort: fix incorrect file handling
  merge-ort: fix directory rename on top of source of other
    rename/delete

 merge-ort.c                         |  55 ++-
 t/t6423-merge-rename-directories.sh | 519 +++++++++++++++++++++++++++-
 2 files changed, 544 insertions(+), 30 deletions(-)


base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1943%2Fnewren%2Ffix-rename-corner-cases-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1943/newren/fix-rename-corner-cases-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1943

Range-diff vs v2:

 1:  dccc2044305 = 1:  dccc2044305 merge-ort: update comments to modern testfile location
 2:  58df0710efc = 2:  58df0710efc merge-ort: drop unnecessary temporary in check_for_directory_rename()
 3:  1ea7bfd3bff = 3:  1ea7bfd3bff t6423: document two bugs with rename-to-self testcases
 4:  29b5e00c556 = 4:  29b5e00c556 t6423: fix missed staging of file in testcases 12i,12j,12k
 -:  ----------- > 5:  c4caba16c72 merge-ort: clarify the interning of strings in opt->priv->path
 5:  a8a7535fa5e ! 6:  c00b6821e76 merge-ort: fix incorrect file handling
     @@ merge-ort.c: static int process_renames(struct merge_options *opt,
       		}
       
      +		/*
     -+		 * Directory renames can result in rename-to-self, which we
     -+		 * want to skip so we don't mark oldpath for deletion.
     ++		 * Directory renames can result in rename-to-self; the code
     ++		 * below assumes we have A->B with different A & B, and tries
     ++		 * to move all entries to path B.  If A & B are the same path,
     ++		 * the logic can get confused, so skip further processing when
     ++		 * A & B are already the same path.
      +		 *
     -+		 * Note that we can avoid strcmp here because of prior
     -+		 * diligence in apply_directory_rename_modifications() to
     -+		 * ensure we reused existing paths from opt->priv->paths.
     ++		 * As a reminder, we can avoid strcmp here because all paths
     ++		 * are interned in opt->priv->paths; see the comment above
     ++		 * "paths" in struct merge_options_internal.
      +		 */
      +		if (oldpath == newpath)
      +			continue;
 6:  7238c8caf2b ! 7:  c2eef5ef5dc merge-ort: fix directory rename on top of source of other rename/delete
     @@ merge-ort.c: static char *apply_dir_rename(struct strmap_entry *rename_info,
       	INITIALIZE_CI(ci, mi);
      -	return mi->clean || (side_mask & (ci->filemask | ci->dirmask));
      +	return mi->clean || (side_mask & (ci->filemask | ci->dirmask))
     -+	  /* See testcases 12{n,p,q} for more details on this next condition */
     ++	  /* See testcases 12[npq] of t6423 for this next condition */
      +			 || ((ci->filemask & 0x01) &&
      +			     strcmp(p->one->path, path));
       }

-- 
gitgitgadget
