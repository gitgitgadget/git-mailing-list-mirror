Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011C11F404
	for <e@80x24.org>; Wed,  5 Sep 2018 14:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeIETRU (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 15:17:20 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:42086 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeIETRT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 15:17:19 -0400
Received: by mail-pf1-f180.google.com with SMTP id l9-v6so3597513pff.9
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 07:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4AkadhpJAD9MExHuTiJao4o6oH0crlCt5hwCfntHNcY=;
        b=gjvVqk9aw5eCS2nAiyCmII2uqSyc9m4vIPUtIxfmwT9nZuPfnq/v6UpUuum4GAWNct
         rTAL++gThKtqoc/EhoOuPNdJqZsNR5YE57ztLiYf9PWTAfAwlsA5o2nl14b2rXfEm1Hz
         1hBEEsdLqqcGX1cn/PlZurT+Gzo9ybXwypzDY+tGO4e1hmvsuCFbWOzoKntxQmvJToc3
         xMIa0DC8t5B+FsQCgmxmvViTizDQe1XmPum4VAKqshSO0gEvESlENTrFOyxDZoeljuW6
         mrapdOSgXpaCNEMyah1qpx3biv7/JhAoHoRlLql5ZLhh65w0QlxP23licc7HHf/xeUFU
         rcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4AkadhpJAD9MExHuTiJao4o6oH0crlCt5hwCfntHNcY=;
        b=EIQx+HI47rpoJoBoH9IVSPZG8v6DQgbr0q76xp+RZxbr3QnPYjlmc9grJA/S6011xB
         KCPVZmrIWBzT6k8kiGh0opGaIdRV2EyZCElT2+qvprORD4ksthDDmhiM3mt2B5GqGs+S
         lPqVL9ZbZTm2leYY9OuIzUJ/sjL4cZ1GBKwFSJQ8z+2SMsHY4IT6Tu2igW0AZxEj77vD
         XBBok0bO/sQX8WVV3Y1OoTMDPSgJ3zLXm8uLQFDJKgdHk9yEzk2ljSxmo1EOmPifYDHi
         COMnmsUNCz0/NDGM8nU9VXL6KCmFBJ1rdNM3C3wyLiCd1iH/yubKV4FbrlQNiEsnjrPy
         Gz4Q==
X-Gm-Message-State: APzg51AiL4C1DJDe4ANVPWJZWikovp12PxyBjFmEVV74x2NIuiUYW6xI
        hcMH2uHLeD78QLASZj4oB1eWwa3c
X-Google-Smtp-Source: ANB0VdbvbH60NHDk/+hV0iNH8hdzdy47KuxTE9AGt1bTuqGuqBkuNM7s4hj8RvBGR01+mqlzb5ldVw==
X-Received: by 2002:a63:5845:: with SMTP id i5-v6mr36623388pgm.272.1536158808402;
        Wed, 05 Sep 2018 07:46:48 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id z11-v6sm3137568pff.162.2018.09.05.07.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:46:47 -0700 (PDT)
Date:   Wed, 05 Sep 2018 07:46:47 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 14:46:29 GMT
Message-Id: <09d16aff20fc16768e688c109519e4e41f9a8e36.1536158789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 11/11] fsck: verify multi-pack-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When core.multiPackIndex is true, we may have a multi-pack-index
in our object directory. Add calls to 'git multi-pack-index verify'
at the end of 'git fsck' if so.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/fsck.c              | 18 ++++++++++++++++++
 t/t5319-multi-pack-index.sh | 13 ++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 63c8578cc1..06eb421720 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -848,5 +848,23 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (!git_config_get_bool("core.multipackindex", &i) && i) {
+		struct child_process midx_verify = CHILD_PROCESS_INIT;
+		const char *midx_argv[] = { "multi-pack-index", "verify", NULL, NULL, NULL };
+
+		midx_verify.argv = midx_argv;
+		midx_verify.git_cmd = 1;
+		if (run_command(&midx_verify))
+			errors_found |= ERROR_COMMIT_GRAPH;
+
+		prepare_alt_odb(the_repository);
+		for (alt =  the_repository->objects->alt_odb_list; alt; alt = alt->next) {
+			midx_argv[2] = "--object-dir";
+			midx_argv[3] = alt->path;
+			if (run_command(&midx_verify))
+				errors_found |= ERROR_COMMIT_GRAPH;
+		}
+	}
+
 	return errors_found;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index b6c34631d3..63f8718fd7 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -160,12 +160,17 @@ corrupt_midx_and_verify() {
 	DATA="${2:-\0}"
 	OBJDIR=$3
 	GREPSTR="$4"
+	COMMAND="$5"
+	if test -z "$COMMAND"
+	then
+		COMMAND="git multi-pack-index verify --object-dir=$OBJDIR"
+	fi
 	FILE=$OBJDIR/pack/multi-pack-index &&
 	chmod a+w $FILE &&
 	test_when_finished mv midx-backup $FILE &&
 	cp $FILE midx-backup &&
 	printf "$DATA" | dd of="$FILE" bs=1 seek="$POS" conv=notrunc &&
-	test_must_fail git multi-pack-index verify --object-dir=$OBJDIR 2>test_err &&
+	test_must_fail $COMMAND 2>test_err &&
 	grep -v "^+" test_err >err &&
 	test_i18ngrep "$GREPSTR" err
 }
@@ -258,6 +263,12 @@ test_expect_success 'verify incorrect offset' '
 		"incorrect object offset"
 '
 
+test_expect_success 'git-fsck incorrect offset' '
+	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\07" $objdir \
+		"incorrect object offset" \
+		"git -c core.multipackindex=true fsck"
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
-- 
gitgitgadget
