Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1199928B7F8
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301688; cv=none; b=eZQZFFuIAYrYp5Vsi/X69YmXDw/fN3I9vjaG8T82cx5nRiYdZoGEg+fD3dkZeT0vvdvdrHsno923FLBJkVcjUjPmK2cqpcwETeybbn4J07o5ewVpRULo2DKMTMy2UVAsvQoR0Rmjqm80ZB/uBM2rq0SRL9LAxw1B0W+aNig41do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301688; c=relaxed/simple;
	bh=SL0T4ubV8TKAJNVqeGE2CjUD0dZmICjOjbMKnXdHy9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMXyHKbQWbi1k8CkmGN7rY4axLVCbMgNIwkHpMfAy7ZRoQvJrPdNBD12nYpwQjPlo8IOmB8c9VPQAfsK3ZEObMrAMbeca5xcXVqmrHB1j4GSgP/tcb+HD9ZkCoOJYBZwUPRSCtx1qIthjZsM8pAE5G1s5sKSVqGyPmFClfV4SzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOPRLcKe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOPRLcKe"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234b9dfb842so19343805ad.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751301686; x=1751906486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OH9tjIe8Dywvu2+GnBHf55eFOhQ+Jt+gV6jF3FmBXM=;
        b=aOPRLcKemBgd1oNU9PoRAcwN7a/lY/nx3ArcxSuw2gePJPmKVcVbXw+69mHtVefdyb
         aXR9ONCnjpQYvh1xQLQQ9KRlwn24uo+C2xbJbrq9RADxTcS5k3XnlcMVe86xaUeVUI0t
         aPVigGL7U1TAwHnxViwHGh1AAOuRx3coqnz/nbRv72IHMX6po4Acs+t07/RnnY2lDkmi
         NeuUtcRzhNbzRiOR64lVcFkm5/7GJPEVRA3LPbgYl2JXl7eKFxZNBV1OeENhd0WvPB8u
         0KQ20rN1JJt9904sE5UTgT/U+h1nYG+do1ZuEQVhBkpO3J/YsLZiNfs6b8qFXYftx8zr
         pdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301686; x=1751906486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OH9tjIe8Dywvu2+GnBHf55eFOhQ+Jt+gV6jF3FmBXM=;
        b=RcfMcJp1BGV+O7Sooy0CGBZItpz5QHUje4c62NEHqBfGYqrCCb7MugdU2iBvAh7eST
         PaJfwI5juqLdhSa91eVGmfJLYO3NCWVlMktsIyBV6DvMBPzZLpuij98YzGAm7U7BdA/T
         zFPbl0ICyLKZqPZlxPpB8IcRu+wqsNx67nHWDW+15xtTD3uTIJOa7cac3LVR+3BXiiID
         i/bf2yl/cgJ0ikcrVKtUkJrRY1M9kWYe1c80wtkBtxpAjnpbzYdKI6hDjms/hfu/1MDy
         sH5hG5ReeAVFCt0cczjT4ZCvBgzgvUF23sXh9FDkekHYYgjA52Sr8OT9RJZo+R8sxRxI
         6uxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPr9KT1c/lyKCkw/2ESiIkb+8yACwM07N5VmslbZAJpMoSDtKMxYAYHvpRzs4+IPa3OsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8QYnIgW5YDHuuprTVOUBSMAGdhjUps6xGL4pNsbcRE820aBk
	7roX5+j7DtJ9745FxMIiTAwwFNruzdMdPZEqm3GUkLE26WVRrXx0KEdw1qUP3g8O
X-Gm-Gg: ASbGncvPayIlddSsSmm8JDdMJqgd9wH5Lmn/fOUyI+wi6cVNWwVGYxAgXkjI1TV+kM3
	Mvuam74pffH3/+mFvJG9ogTywdfy8Wjuwfk/wo0xWm23xrzcTeIOvhpbcMqSowfhLYKfY/qUgcI
	oXcvmb3ubOSW47YX3eGReehXH2x9xY6CGKdLvT2Orhe7qQqHpcMldSnKUueHg1KaSWBEtsQr2GE
	ISqri6mz2vNNNpvr73ULJ4JXj4BOx6LUog8jw8bMIMSIDEjEfqDpORF1JLBUP8oPoQPpIAcV2hm
	o3/XFjiQmUpktO4Xy+tiRGxSWJDkoECrRejdktMNn1LXBQK6Y+Q1tDzMNo9Vv2YWgHEBzx2qNAX
	zN05l
X-Google-Smtp-Source: AGHT+IFcgKfSa0a6+JkpOpl6TFYChu6jfCYnAoZXjMO+dGr5h8K8Lgc1liNVq1Pn/ILK1DvkmhFAgA==
X-Received: by 2002:a17:903:2ece:b0:236:9dd9:b75d with SMTP id d9443c01a7336-23ac4606753mr245317945ad.40.1751301686210;
        Mon, 30 Jun 2025 09:41:26 -0700 (PDT)
Received: from thinku.localdomain ([2401:4900:1c20:3d25:645c:9adb:1b15:c2cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39f34dsm84841385ad.130.2025.06.30.09.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:41:25 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	shejialuo@gmail.com
Subject: [GSOC PATCH v2 0/2] builtin/prune: remove dependency on global variables and 'the_repository'
Date: Mon, 30 Jun 2025 22:11:03 +0530
Message-ID: <cover.1751296633.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749343601.git.ayu.chandekar@gmail.com>
References: <cover.1749343601.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aim of this patch series is to remove the definition '#define USE_THE_REPOSITORY_VARIABLE' 
from "builtin/prune.c" by removing global variables and the global 'the_repository'.

This patch series contains two patches:

1 - Move the global variable 'repository_format_precious_objects' into 'struct repository' 
and update all affected code paths accordingly.

2 - Remove the dependency of 'the_repository' in "builtin/prunce.c", allowing the removal of 
the definition.

Ayush Chandekar (2):
  repository: move 'repository_format_precious_objects' to repo scope
  builtin/prune: stop depending on 'the_repository'

 builtin/gc.c     |  2 +-
 builtin/prune.c  | 27 ++++++++++++---------------
 builtin/repack.c |  2 +-
 environment.c    |  1 -
 environment.h    |  2 --
 repository.c     |  1 +
 repository.h     |  1 +
 setup.c          |  5 ++++-
 8 files changed, 20 insertions(+), 21 deletions(-)

-- 

Summary of the range-diff:
* Changed the commit message of 1/2 to use "setting" instead of "settings" since it refers to just one.
* Added "Mentored-by" tags in both 1/2 and 2/2.
* Fixed line formatting in builtin/prune.c in 2/2.

Range-diff:
1:  699f9a947d ! 1:  995389d622 repository: move 'repository_format_precious_objects' to repo scope
    @@ Metadata
      ## Commit message ##
         repository: move 'repository_format_precious_objects' to repo scope
     
    -    The 'extensions.preciousObjects' settings when set true, prevents
    +    The 'extensions.preciousObjects' setting when set true, prevents
         operations that might drop objects from the object storage.
         This setting is populated in the global variable
         'repository_format_precious_objects'.
    @@ Commit message
         This change is part of an ongoing effort to eliminate global variables,
         improve modularity and help libify the codebase.
     
    +    Mentored-by: Christian Couder <christian.couder@gmail.com>
    +    Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
         Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
     
      ## builtin/gc.c ##
2:  f22cc88e9f ! 2:  f70de9d549 builtin/prune: stop depending on 'the_repository'
    @@ Commit message
         repo and thus remove the definition '#define
         USE_THE_REPOSITORY_VARIABLE'
     
    +    Mentored-by: Christian Couder <christian.couder@gmail.com>
    +    Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
         Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
     
      ## builtin/prune.c ##
    @@ builtin/prune.c: static int prune_object(const struct object_id *oid, const char
      		return 0;
      	if (show_only || verbose) {
     -		enum object_type type = oid_object_info(the_repository, oid,
    -+		enum object_type type = oid_object_info(revs->repo, oid,
    - 							NULL);
    +-							NULL);
    ++		enum object_type type = oid_object_info(revs->repo, oid, NULL);
      		printf("%s %s\n", oid_to_hex(oid),
      		       (type > 0) ? type_name(type) : "unknown");
    + 	}
     @@ builtin/prune.c: static void remove_temporary_files(const char *path)
      int cmd_prune(int argc,
      	      const char **argv,
    @@ builtin/prune.c: int cmd_prune(int argc,
      
     -		if (!repo_get_oid(the_repository, name, &oid)) {
     -			struct object *object = parse_object_or_die(the_repository, &oid,
    +-								    name);
     +		if (!repo_get_oid(repo, name, &oid)) {
    -+			struct object *object = parse_object_or_die(repo, &oid,
    - 								    name);
    ++			struct object *object = parse_object_or_die(repo, &oid, name);
      			add_pending_object(&revs, object, "");
      		}
    + 		else
     @@ builtin/prune.c: int cmd_prune(int argc,
      		revs.exclude_promisor_objects = 1;
      	}

2.49.0

