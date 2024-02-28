Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA31552E8
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128507; cv=none; b=GtuLXSOblNbc5HCGvW+m91RIuLg+TW8c5tba5iPAV0OtHL/T1V2hDeGYBYts9bIjfW0pEP0VMyVT40Woi9KBqyu/gscvyMpl5CM3MZjQW7vVpD4JWIgN6Uc9A0uDX7xpuz0DOZDO90QY313U3+ZwZGIEbO5gSfy2Eosj+oBTqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128507; c=relaxed/simple;
	bh=KKtcdNcS+DBrpcFyC/8jCMVsUbWMXzVd3KAo9cxyLKc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=PqTANRDqZFs85QcDu+2hK52XYWzo+mPfNyWL0ytz7m51JrZfT4D+wCCE81gLFlvWcw3nNuq3hLeKbJPiBtuVas2P5FKtXasoyXvWpmiO+AzHoHaU0KuqbhdwQF5jeUmJZdjol3UdBu7wWKPHf+YA1bUNe7gEwt3dnSq0MgYpRcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO/Ey/wv; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO/Ey/wv"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-787c97deabdso246184085a.3
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 05:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709128505; x=1709733305; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqqufaHBkfzJ9F/9modHTmcMQ24UhIqNFmsACu/S/Ro=;
        b=dO/Ey/wvw3yFMRWzFGnCZjKaj1xI2k7i9y6ENFEKXl3Xp18prH82RQTL2lNff+uHhd
         i3zMhsgTRzcIbg11TOo9Ibs1HVUs+BZRh5eP8ea1SOyBnxs4wmwC4lMbJCPSavjirbsg
         uflvmKS0INA166b2ybzWegiGs3Ydm3WJSSsQqd+qqXjMvABjrP8V3Bc1o94ht91gDK2N
         tNgZUEDlb6bzfvD4u5SdU7IniaC+xa5dKOjGLEu46xsIKRVSMNPmM71O7N8/6ascXzEP
         j2xnSlNyLD7+MKcjfhedG+LwtsWHSs/2AT4/iXLlMeaCJwjnVrnRopy5RFUkDaDsIRkP
         qc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128505; x=1709733305;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KqqufaHBkfzJ9F/9modHTmcMQ24UhIqNFmsACu/S/Ro=;
        b=VQT7baJ+gfjjti9whdLgbcywPJ2Mhoqtgl1V3Yi2tIQflcRUeSCSS1HFDn2/WhldsS
         r4u7Apgci+mZkwRXBvwJ4aT4P80kRK09YvJsbnVnYX4YeZvYOpuwQkshFeeJjPVytstn
         8ayn5WROHJN+9LqqTeGt9yabqGesQZfwPnYyxQUBxanMlBawswaP25aXL3diTxm9frXj
         rY88wNYWx/MCS4jlRhXse25PEh8/fFNCiHmGejvBFnBXQBdxfAtcE1CcVQAOSJQFXCvf
         jwDi738N9UTRlmdULN7trmUvpm0CBSMV7Eo1TntLU5cZP6CAG1NW/aTdzc2oPlyH5ubM
         153g==
X-Gm-Message-State: AOJu0YxfigA14Rpu0inzBWRQtxNOHGQgp/XseptEfOBPyBiiBuH2+Z10
	KZkrJMgZHov5VE8aprJ5MJ+gPOTmifizUfAcqR2tXPtdr/HgTOGJCd4QNy3+VkM=
X-Google-Smtp-Source: AGHT+IG4+X69JiojRXYqaA5tdfrbtIgd0oIjNLOCTmuCWylq97xNlpXogiUfuSfcEWvftPHIQIDxLA==
X-Received: by 2002:a05:6214:1d2d:b0:68f:2a2b:c6e0 with SMTP id f13-20020a0562141d2d00b0068f2a2bc6e0mr6278292qvd.64.1709128504602;
        Wed, 28 Feb 2024 05:55:04 -0800 (PST)
Received: from [127.0.0.1] ([2606:6d00:11:ff90:f134:2d0a:620a:ef80])
        by smtp.gmail.com with ESMTPSA id jh15-20020a0562141fcf00b0068fa78ccef7sm5247839qvb.116.2024.02.28.05.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:55:04 -0800 (PST)
From: Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH v6 0/2] Implement `git log --merge` also for
 rebase/cherry-pick/revert
Date: Wed, 28 Feb 2024 08:54:52 -0500
Message-Id: <20240228-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v6-0-8ec34c052b39@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC4732UC/53PQW7DIBAF0KtErDsuEBzbWfUeVRdjGBtUAxY4b
 qPIdy9OF426zAbpgz5v5sYyJUeZnQ83lmh12cVQwunlwLTFMBI4UzKTXCouBQc/wRRH8JTK25d
 bLGhLKV1hdvoTMBiIS7mAOdPFRLCEJgOve9NS23SN6Vn5ek40uO87+/5Rco+ZoE8YtN2xy5yXR
 OhfPeaF0t6wLi8xXe9zrse99zuSEA1vheJ1VQ4hQYB3FU7VFK3HEN5Gj26qdPRsd1b113x6mVU
 Bh2OvOzrJlreD+o/UD4isn0TqguAgaJCmI6XMI7Jt2w8zYaMIuQEAAA==
In-Reply-To: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
References: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>, 
 Michael Lohmann <mial.lohmann@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, 
 Michael Lohmann <mi.al.lohmann@gmail.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: b4 0.14-dev

Changes in v6:
- Changed the error message added in 1/2 and adjusted in 2/2 to avoid a rhetorical
question

Changes in v5:
- Marked error messages for translation and tweaked them as suggested by Phillip
- Reworded the message of 2/2 as suggested by Phillip
- Removed the change to gitk's doc in 2/2 as pointed out by Johannes
- Fixed the trailers in 2/2
- Improved the doc in 2/2 as suggested by Phillip and Jean-Noël

Changes in v4:
- Added a commit message for 2/2 detailing the use case and summarizing the discussion in the thread
- Adjusted the documentation of the option

---
Michael Lohmann (2):
      revision: ensure MERGE_HEAD is a ref in prepare_show_merge
      revision: implement `git log --merge` also for rebase/cherry-pick/revert

 Documentation/rev-list-options.txt |  7 +++++--
 revision.c                         | 27 +++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 6 deletions(-)
---
base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
change-id: 20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-05bd8e8797db

Range-diff versus v5:

1:  c9536431d1 ! 1:  363657561c revision: ensure MERGE_HEAD is a ref in prepare_show_merge
    @@ Commit message
         (2) obtain the oid without any prefixing by refs.c:repo_dwim_ref()
         (3) error out when MERGE_HEAD is a symref.
     
    +    Note that we avoid marking the new error message for translation as it
    +    will be done in the next commit when the message is generalized to other
    +    special refs.
    +
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    @@ revision.c: static void prepare_show_merge(struct rev_info *revs)
     +			&oid, NULL))
      		die("--merge without MERGE_HEAD?");
     +	if (is_null_oid(&oid))
    -+		die(_("MERGE_HEAD is a symbolic ref?"));
    ++		die(_("MERGE_HEAD exists but is a symbolic ref"));
      	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
      	add_pending_object(revs, &head->object, "HEAD");
      	add_pending_object(revs, &other->object, "MERGE_HEAD");
2:  1641c4be81 ! 2:  749abadc04 revision: implement `git log --merge` also for rebase/cherry-pick/revert
    @@ revision.c: static void add_pending_commit_list(struct rev_info *revs,
     +				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
     +				oid, NULL)) {
     +			if (is_null_oid(oid))
    -+				die(_("%s is a symbolic ref?"), other_head[i]);
    ++				die(_("%s exists but is a symbolic ref"), other_head[i]);
     +			return other_head[i];
     +		}
     +
    @@ revision.c: static void prepare_show_merge(struct rev_info *revs)
     -			&oid, NULL))
     -		die("--merge without MERGE_HEAD?");
     -	if (is_null_oid(&oid))
    --		die(_("MERGE_HEAD is a symbolic ref?"));
    +-		die(_("MERGE_HEAD exists but is a symbolic ref"));
     -	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
     +	other_name = lookup_other_head(&oid);
     +	other = lookup_commit_or_die(&oid, other_name);

