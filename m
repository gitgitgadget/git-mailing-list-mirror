Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A542F9C37
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845425; cv=none; b=WrWiIOHo4j1T8ycfRrtntBDwgOTHu6VEch0YM3A2IrqjurWlsEe9Ku/Bc1vtRegtdcQT2g6Du5Hd4vT0CX1c3KNIRAZN+olCkRg2n59l85ORsD9db0KDJOznJSUQsQgqM16ND4DurryHVL1zswBqfxGz4VuizWmNWzJD0p7w/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845425; c=relaxed/simple;
	bh=WUQFxFalcWQ+urfET5wg1XtGMRZCnhlWjYIgj/8zo+0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dNrCLLOdel0TsbTLdi2HlnACeBt8fcndXneIcemx1iuDyrqyuzaqRzwQKjeJchvpslLdcrkgFXBS9XXEWtF9CZYStjD0raFEcTgjSPmpnoa+1+OLjcjL5DSgGaOzM17fhBU5kw+Z0bF33ysqOmHHenAsO69jo5LzctGHy/iRQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGojucSm; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGojucSm"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8249ca723bcso1371985a34.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 15:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791845423; x=1792450223; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TenJduVcBRgyGD8ciXTbv9Ba+RCeJlSG/ghXYFCUE3o=;
        b=kGojucSmcQoZwvYVUGaloT9U92c8eNZqURThZ+R8OsGs/oK7N6zzXgwMXBkuQAYeqV
         q1HD/H4QXfTSZtneCmq0j4NCSzh8f7MozD3KsP8vCeAXmQKQTPZnHdI9Dmsw9XygGm2r
         Jtea2aMtcQqqpZc6SSPtH99tLAxwTRzKO837LUbK25oezhmTAF+Xg2G9HeItDQ1ME4ey
         JylzxBDnJ8pATMiZIYnRxBqKMjd7P1YvJUZ59Aul43euK5U1ow099CwK7+kgVXBqsz92
         jud3ZKdR+NLWKLg5rttKjyAC+O+oh4KE7Smc3R4fIZjJ/X8OoJBf2iImLrHBD8kE3Da4
         1O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791845423; x=1792450223;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TenJduVcBRgyGD8ciXTbv9Ba+RCeJlSG/ghXYFCUE3o=;
        b=KrGs2FjLBKwaXNkkHrpFkJ2io58hadeTUnzsTtcTO8z91X+tp1cRoCpM6pMuAurf+0
         QO4VL8PYNNkHiijRmdh7RkFVR9rQlkOxCPbi+tGA3JZoHJbDLpqfs6ezJQcnwiLwAVwS
         COzVg+61Y8dnM4aoaBMkuHQjQVG4/J2U1DQc/1vw2FUB2wKOpepRQ7NHGb94mpDMTY8J
         aS1l5DLQWr9A/lDGNv1TPpAM0FasfvA9uvGce4XE4Dn8JRydbEL2rMaQfqRLHhOF+BF5
         dpOUsYaisoEnAlwIjbRQti+N6+9FCotoG+ieFwezusvnWw/7FYs5ZDDnRwKH5wKCRKOW
         gYsA==
X-Gm-Message-State: AFq9FYLrEm246XJs+Zkr6iWRXSHHqnYTssmSsXXugVyrWsL8EN8dBBXa
	panpQx588VoA+UihPEILjOBwJ5Jmv7rdeF15eCExAh2rBzU/2X+Rgoxxdbn28pGU
X-Gm-Gg: AYBFou1mJfYYKBHxqfR1kdv/EqA/uGvAWacPQ7teN1aG1jExGZ+KuiAKLJatIFSEbH7
	3h79wQlYH2FgiisuAL3ccOcS4m8qkbYZaBCGvWJAu1Ry0T59CEQl1t5IrgUfGGgXfOcttkgdSr7
	uB1F2lfw+Q9gyrSDo51HTeAQOIW+rPnxshq0AyFDWvm7tHICHrwmN9kW22luV3A3SdcB376DZ31
	oy7OgnlFtqqwwdGNisZywS90f7cfWoebEXAM91//hsMS2eASiJHbl1SEnnd1tUgAhkIPtLjRb1T
	vDAnWhWcNMZ41I7rXN6wLbmqJ3I24xLF85hicEhltBwXxhZhE9V+zp+TbUToJXw6jparHBgfbZ3
	CRd3Bx/J4yfT3mPvifPui48LHWw6GJVGJASgNf6P4Tp6QTnI91xjTXtr3MyyDVKjl0te1Ju5R7b
	dmRByF9r51P2cwudxNtSdvfOnZTq4CN9uNN4u8250HKDQEFo8ueMp407KjL1uVC2/EVrPJ72gUy
	m6X
X-Received: by 2002:a05:6830:4104:b0:822:27d6:c28a with SMTP id 46e09a7af769-83090c27934mr11182084a34.4.1791845422900;
        Mon, 12 Oct 2026 15:50:22 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.100.146])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-830385b9cb0sm11265635a34.4.2026.10.12.15.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:50:22 -0700 (PDT)
Message-Id: <pull.2252.v2.git.1791845420568.gitgitgadget@gmail.com>
In-Reply-To: <pull.2252.git.1791653078449.gitgitgadget@gmail.com>
References: <pull.2252.git.1791653078449.gitgitgadget@gmail.com>
From: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 22:50:20 +0000
Subject: [PATCH v2] fast-import: fix lookup for new commits and tags
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
Cc: Aniket Gupta <aniketgupta3001@gmail.com>,
    Marc Becker <becm@gmx.de>,
    Marc Becker <becm@gmx.de>

From: Marc Becker <becm@gmx.de>

Queries for commits created during the same 'git fast-import' session
result in a crash:
    < reset refs/heads/newbranch
    < from <new-commit-oid>
    > fatal: not a valid commit: <new-commit-oid>

Getting file content for commit has no issue (working implementation):
    < ls <new-commit-oid> file-in-new-commit.txt
    > {file content}

During import, new objects may not (yet) be reachable via the ODB layer.
Try to resolve requested tag/commit via object cache first
to avoid crash.
Add test to 't/t9300.sh' with references to a pending tag and commit.

Signed-off-by: Marc Becker <becm@gmx.de>
---
    fast-import: fix lookup for new commits
    
    Changes since v1:
    
     * address notes regarding commit message
     * stick to line length in new code
     * add test with (fixed) pending references (files for SHA1 and SHA256,
       no coproc in sh, avoid named pipes)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2252%2Fbecm%2Ffix-fast-import-commit-from-existing-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2252/becm/fix-fast-import-commit-from-existing-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2252

Range-diff vs v1:

 1:  4e50f63354 ! 1:  d834e2fc47 fast-import: fix lookup for new commits
     @@ Metadata
      Author: Marc Becker <becm@gmx.de>
      
       ## Commit message ##
     -    fast-import: fix lookup for new commits
     +    fast-import: fix lookup for new commits and tags
      
     -    Queries for commits created during the same 'git fast-import'  session
     +    Queries for commits created during the same 'git fast-import' session
          result in a crash:
              < reset refs/heads/newbranch
              < from <new-commit-oid>
     @@ Commit message
      
          During import, new objects may not (yet) be reachable via the ODB layer.
          Try to resolve requested tag/commit via object cache first
     -    to avoid crash and (eventually) improve lookup speed.
     +    to avoid crash.
     +    Add test to 't/t9300.sh' with references to a pending tag and commit.
      
          Signed-off-by: Marc Becker <becm@gmx.de>
      
     @@ builtin/fast-import.c: static void fast_import_state_init(struct fast_import_sta
       	state->option = option;
       }
       
     -+static struct object_entry *dereference(struct object_entry *oe, struct object_id *oid);
     ++static struct object_entry *dereference(struct object_entry *oe,
     ++					struct object_id *oid);
      +
       static void parse_argv(struct fast_import_state *state);
       static void parse_get_mark(struct fast_import_state *state, const char *p);
     @@ builtin/fast-import.c: static void parse_from_existing(struct branch *b)
       		parse_from_commit(b, buf, size);
       		free(buf);
       	}
     +
     + ## t/t9300-fast-import.sh ##
     +@@ t/t9300-fast-import.sh: test_expect_success 'Y: rewrite submodules' '
     + 	)
     + '
     + 
     ++cat >Y-reference-pending-sha256 <<\Y_INPUT_END
     ++commit refs/heads/main
     ++committer A U Thor <author@example.com> 1712563200 +0000
     ++data 14
     ++commit message
     ++M 644 inline test file
     ++data 14
     ++dummy content
     ++
     ++tag newtag
     ++from 17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
     ++tagger A U Thor <author@example.com> 1712563300 +0000
     ++data 11
     ++tag message
     ++# no emty line after tag data!
     ++reset refs/heads/other
     ++from 85edc5eac315bc680677b2fc71622bd77476f057eb8dc8ed6a497803a24f1f46
     ++
     ++commit refs/heads/further
     ++committer A U Thor <author@example.com> 1712563400 +0000
     ++data 21
     ++what about 2nd commit
     ++from 17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
     ++M 644 inline other test file
     ++data 19
     ++more dummy content
     ++
     ++done
     ++Y_INPUT_END
     ++
     ++cat >Y-reference-pending-sha1 <<\Y_INPUT_END
     ++commit refs/heads/main
     ++committer A U Thor <author@example.com> 1712563200 +0000
     ++data 14
     ++commit message
     ++M 644 inline test file
     ++data 14
     ++dummy content
     ++
     ++tag newtag
     ++from 85b46dd918355ff17b4109ec738723d42f235a04
     ++tagger A U Thor <author@example.com> 1712563300 +0000
     ++data 11
     ++tag message
     ++# no emty line after tag data!
     ++reset refs/heads/other
     ++from ec6c4db71feb5f66615214dad2324ce030e777a7
     ++
     ++commit refs/heads/further
     ++committer A U Thor <author@example.com> 1712563400 +0000
     ++data 21
     ++what about 2nd commit
     ++from 85b46dd918355ff17b4109ec738723d42f235a04
     ++M 644 inline other test file
     ++data 19
     ++more dummy content
     ++
     ++done
     ++Y_INPUT_END
     ++
     ++test_expect_success 'Y: reference pending tag or commit' '
     ++	git init reference-pending &&
     ++	(
     ++		cd reference-pending &&
     ++		git fast-import < "../Y-reference-pending-$(git rev-parse --show-object-format)"
     ++	)
     ++'
     ++
     + test_done


 builtin/fast-import.c  | 19 +++++++++---
 t/t9300-fast-import.sh | 68 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index fbd919982c..574a03c484 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -292,6 +292,9 @@ static void fast_import_state_init(struct fast_import_state *state,
 	state->option = option;
 }
 
+static struct object_entry *dereference(struct object_entry *oe,
+					struct object_id *oid);
+
 static void parse_argv(struct fast_import_state *state);
 static void parse_get_mark(struct fast_import_state *state, const char *p);
 static void parse_cat_blob(struct fast_import_state *state, const char *p);
@@ -2658,12 +2661,20 @@ static void parse_from_existing(struct branch *b)
 		oidclr(&b->branch_tree.versions[1].oid, the_repository->hash_algo);
 	} else {
 		unsigned long size;
-		size_t size_st = 0;
 		char *buf;
+		struct object_entry *e = find_object(&b->oid);
 
-		buf = odb_read_object_peeled(the_repository->objects, &b->oid,
-					     OBJ_COMMIT, &size_st, &b->oid);
-		size = cast_size_t_to_ulong(size_st);
+		while (e && e->type == OBJ_TAG)
+			e = dereference(e, &b->oid);
+
+		if (e && e->type == OBJ_COMMIT && e->pack_id != MAX_PACK_ID) {
+			buf = gfi_unpack_entry(e, &size);
+		} else {
+			size_t size_st = 0;
+			buf = odb_read_object_peeled(the_repository->objects, &b->oid,
+						     OBJ_COMMIT, &size_st, &b->oid);
+			size = cast_size_t_to_ulong(size_st);
+		}
 		parse_from_commit(b, buf, size);
 		free(buf);
 	}
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index d9de2ef0d8..1f52be2c2c 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3938,4 +3938,72 @@ test_expect_success 'Y: rewrite submodules' '
 	)
 '
 
+cat >Y-reference-pending-sha256 <<\Y_INPUT_END
+commit refs/heads/main
+committer A U Thor <author@example.com> 1712563200 +0000
+data 14
+commit message
+M 644 inline test file
+data 14
+dummy content
+
+tag newtag
+from 17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
+tagger A U Thor <author@example.com> 1712563300 +0000
+data 11
+tag message
+# no emty line after tag data!
+reset refs/heads/other
+from 85edc5eac315bc680677b2fc71622bd77476f057eb8dc8ed6a497803a24f1f46
+
+commit refs/heads/further
+committer A U Thor <author@example.com> 1712563400 +0000
+data 21
+what about 2nd commit
+from 17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
+M 644 inline other test file
+data 19
+more dummy content
+
+done
+Y_INPUT_END
+
+cat >Y-reference-pending-sha1 <<\Y_INPUT_END
+commit refs/heads/main
+committer A U Thor <author@example.com> 1712563200 +0000
+data 14
+commit message
+M 644 inline test file
+data 14
+dummy content
+
+tag newtag
+from 85b46dd918355ff17b4109ec738723d42f235a04
+tagger A U Thor <author@example.com> 1712563300 +0000
+data 11
+tag message
+# no emty line after tag data!
+reset refs/heads/other
+from ec6c4db71feb5f66615214dad2324ce030e777a7
+
+commit refs/heads/further
+committer A U Thor <author@example.com> 1712563400 +0000
+data 21
+what about 2nd commit
+from 85b46dd918355ff17b4109ec738723d42f235a04
+M 644 inline other test file
+data 19
+more dummy content
+
+done
+Y_INPUT_END
+
+test_expect_success 'Y: reference pending tag or commit' '
+	git init reference-pending &&
+	(
+		cd reference-pending &&
+		git fast-import < "../Y-reference-pending-$(git rev-parse --show-object-format)"
+	)
+'
+
 test_done

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
