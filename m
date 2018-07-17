Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3221F597
	for <e@80x24.org>; Tue, 17 Jul 2018 00:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbeGQA4t (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 20:56:49 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:33574 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbeGQA4t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 20:56:49 -0400
Received: by mail-it0-f73.google.com with SMTP id s40-v6so1089945ite.0
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 17:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=sopqRsVtVFubVLbiCVP4bv5RwZBVZgoEDAzKfEgX0wg=;
        b=wAHkQi0Rb/o0kRGp0oydsKWVv2y7ktNpcNI4qt3UgXlO1gC9M9jtm9ajZOUlnTX/5R
         zPMA3WQ30iR0j4z//qsmRLSZEFCvKNvtnRoN9nWr5na7BASTz7iRiDC6x345XXi/nMCC
         5MqEm6qNFv3UKFPeE9+xmPkSYwdZUd78IJiE2k/slVnMzLCTwQ3G6/tdD90/YGeANWGq
         JLVM90xvu8phzmsCmCVuuvrI1KmB5s7Jr2Kf1hLjTCqdaiaq4ZZ/X04VNXLWgRwHiuBh
         UvsBDg9rBvuQ++28YqWtqvH/3qPKyazcFFdPU8S8/8xSk4x4m13Q/cgyRtvOlscDtHrn
         pucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=sopqRsVtVFubVLbiCVP4bv5RwZBVZgoEDAzKfEgX0wg=;
        b=mF8jBkoRyc05Ya9HbDtkxhC/iMfj5689k5qF7oycOjBRhaEmjfR7cAJg1IICTmLjV3
         mzBx769gqI9+ZJVfX5ew2rGgvn+50+EhCMib/cnE7UhMYyfQi0OHOcL/MhJxGPFkk27K
         RhO3utvLVBnHBKgzwkvd41kXt5EBAEQ+sTwv5dsARz/AvVzS1fH6kOeRrmRqcPKCbDmP
         ivYWHIQNofOxBen4DRfg9hQVkmvWM5dloJMKVUWrtJHtkoEuDjoM4P0milxFhY58sT3b
         9pOlWMdylM2+OyelG2W22eYPa4DeZas1g7kb12sLMD2kLALXUrSS/5XKVWxwJLG5zoxi
         pB2w==
X-Gm-Message-State: AOUpUlGQ0nkSGNCzFJl+/ct+CTcy4zThLVggdzThXxr26RaTKa3NZNsx
        j1PZ4IgX3dQeAbPWSnUzk+bEQyoCPQgvZpTCcB6DSc0C9TXxZNhESWzgsOVRLB/idCZ0Zgbx2v/
        uL4h9/KFQxNZvSL9RqUTVZQYuvwexwa8thohDIHvTcHkZR+3oJJOFLzUSzhay
X-Google-Smtp-Source: AAOMgpf36ouQsy+hRkYk+/JT+LM95PgYZk+RTqMdjuNc6Jg8JqWkAOTN1IeIKMenrsk2+Qd+FI9iD7y3TH1e
MIME-Version: 1.0
X-Received: by 2002:a24:7b0e:: with SMTP id q14-v6mr7909133itc.44.1531787218431;
 Mon, 16 Jul 2018 17:26:58 -0700 (PDT)
Date:   Mon, 16 Jul 2018 17:26:48 -0700
Message-Id: <20180717002654.120375-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2 0/6] git-submodule.sh: convert part of cmd_update to C
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
addressed review comments, renaming the struct, improving the commit message.

v1:
https://public-inbox.org/git/20180712194754.71979-1-sbeller@google.com/
I thought about writing it all in one go, but the series got too large,
so let's chew one bite at a time.

Thanks,
Stefan

Stefan Beller (6):
  git-submodule.sh: align error reporting for update mode to use path
  git-submodule.sh: rename unused variables
  builtin/submodule--helper: factor out submodule updating
  builtin/submodule--helper: store update_clone information in a struct
  builtin/submodule--helper: factor out method to update a single
    submodule
  submodule--helper: introduce new update-module-mode helper

 builtin/submodule--helper.c | 152 ++++++++++++++++++++++++++++--------
 git-submodule.sh            |  22 +-----
 2 files changed, 122 insertions(+), 52 deletions(-)

-- 
2.18.0.203.gfac676dfb9-goog

1:  d4e1ec45740 ! 1:  bbc8697a8ca git-submodule.sh: align error reporting for update mode to use path
    @@ -6,7 +6,6 @@
         on its path, so let's do that for invalid update modes, too.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/git-submodule.sh b/git-submodule.sh
     --- a/git-submodule.sh
2:  9c5ec3fccea ! 2:  7e26af17578 git-submodule.sh: rename unused variables
    @@ -14,8 +14,12 @@
         using its own function starting in 48308681b07 (git submodule update:
         have a dedicated helper for cloning, 2016-02-29), its removal was missed.
     
    +    A later patch in this series also touches the communication between
    +    the submodule helper and git-submodule.sh, but let's have this as
    +    a preparatory patch, as it eases the next patch, which stores the
    +    raw data instead of the line printed for this communication.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
     --- a/builtin/submodule--helper.c
3:  a3fb4e5539f ! 3:  3e8d22b0c70 builtin/submodule--helper: factor out submodule updating
    @@ -7,7 +7,6 @@
         most of it is still in git-submodule.sh.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
     --- a/builtin/submodule--helper.c
4:  e680684139d ! 4:  5e0a39015df builtin/submodule--helper: store update_clone information in a struct
    @@ -11,7 +11,6 @@
         struct.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
     --- a/builtin/submodule--helper.c
    @@ -20,7 +19,7 @@
      	return 0;
      }
      
    -+struct submodule_update_clone_information {
    ++struct update_clone_data {
     +	const struct submodule *sub;
     +	struct object_id oid;
     +	unsigned just_cloned;
    @@ -36,8 +35,8 @@
     -	/* Machine-readable status lines to be consumed by git-submodule.sh */
     -	struct string_list projectlines;
     +	/* to be consumed by git-submodule.sh */
    -+	struct submodule_update_clone_information *submodule_lines;
    -+	int submodule_lines_nr; int submodule_lines_alloc;
    ++	struct update_clone_data *update_clone;
    ++	int update_clone_nr; int update_clone_alloc;
      
      	/* If we want to stop as fast as possible and return an error */
      	unsigned quickstop : 1;
    @@ -58,12 +57,12 @@
     -	strbuf_addf(&sb, "dummy %s %d\t%s\n",
     -		    oid_to_hex(&ce->oid), needs_cloning, ce->name);
     -	string_list_append(&suc->projectlines, sb.buf);
    -+	ALLOC_GROW(suc->submodule_lines, suc->submodule_lines_nr + 1,
    -+					 suc->submodule_lines_alloc);
    -+	oidcpy(&suc->submodule_lines[suc->submodule_lines_nr].oid, &ce->oid);
    -+	suc->submodule_lines[suc->submodule_lines_nr].just_cloned = needs_cloning;
    -+	suc->submodule_lines[suc->submodule_lines_nr].sub = sub;
    -+	suc->submodule_lines_nr++;
    ++	ALLOC_GROW(suc->update_clone, suc->update_clone_nr + 1,
    ++		   suc->update_clone_alloc);
    ++	oidcpy(&suc->update_clone[suc->update_clone_nr].oid, &ce->oid);
    ++	suc->update_clone[suc->update_clone_nr].just_cloned = needs_cloning;
    ++	suc->update_clone[suc->update_clone_nr].sub = sub;
    ++	suc->update_clone_nr++;
      
      	if (!needs_cloning)
      		goto cleanup;
    @@ -83,11 +82,11 @@
      
     -	for_each_string_list_item(item, &suc->projectlines)
     -		fprintf(stdout, "%s", item->string);
    -+	for (i = 0; i < suc->submodule_lines_nr; i++) {
    ++	for (i = 0; i < suc->update_clone_nr; i++) {
     +		strbuf_addf(&sb, "dummy %s %d\t%s\n",
    -+			oid_to_hex(&suc->submodule_lines[i].oid),
    -+			suc->submodule_lines[i].just_cloned,
    -+			suc->submodule_lines[i].sub->path);
    ++			oid_to_hex(&suc->update_clone[i].oid),
    ++			suc->update_clone[i].just_cloned,
    ++			suc->update_clone[i].sub->path);
     +		fprintf(stdout, "%s", sb.buf);
     +		strbuf_reset(&sb);
     +	}
5:  95409e47b0d ! 5:  ecee68506eb builtin/submodule--helper: factor out method to update a single submodule
    @@ -5,7 +5,6 @@
         In a later patch we'll find this method handy.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
     --- a/builtin/submodule--helper.c
    @@ -14,12 +13,12 @@
      	return 0;
      }
      
    -+static void update_submodule(struct submodule_update_clone_information *suci)
    ++static void update_submodule(struct update_clone_data *ucd)
     +{
     +	fprintf(stdout, "dummy %s %d\t%s\n",
    -+		oid_to_hex(&suci->oid),
    -+		suci->just_cloned,
    -+		suci->sub->path);
    ++		oid_to_hex(&ucd->oid),
    ++		ucd->just_cloned,
    ++		ucd->sub->path);
     +}
     +
      static int update_submodules(struct submodule_update_clone *suc)
    @@ -33,16 +32,16 @@
      	if (suc->quickstop)
      		return 1;
      
    --	for (i = 0; i < suc->submodule_lines_nr; i++) {
    +-	for (i = 0; i < suc->update_clone_nr; i++) {
     -		strbuf_addf(&sb, "dummy %s %d\t%s\n",
    --			oid_to_hex(&suc->submodule_lines[i].oid),
    --			suc->submodule_lines[i].just_cloned,
    --			suc->submodule_lines[i].sub->path);
    +-			oid_to_hex(&suc->update_clone[i].oid),
    +-			suc->update_clone[i].just_cloned,
    +-			suc->update_clone[i].sub->path);
     -		fprintf(stdout, "%s", sb.buf);
     -		strbuf_reset(&sb);
     -	}
    -+	for (i = 0; i < suc->submodule_lines_nr; i++)
    -+		update_submodule(&suc->submodule_lines[i]);
    ++	for (i = 0; i < suc->update_clone_nr; i++)
    ++		update_submodule(&suc->update_clone[i]);
      
     -	strbuf_release(&sb);
      	return 0;
6:  05bb02e6ea8 ! 6:  b80e60a9d11 submodule--helper: introduce new update-module-mode helper
    @@ -10,7 +10,6 @@
         for arbitrary repositories.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
     --- a/builtin/submodule--helper.c
    @@ -79,7 +78,7 @@
     +	return 0;
     +}
     +
    - struct submodule_update_clone_information {
    + struct update_clone_data {
      	const struct submodule *sub;
      	struct object_id oid;
     @@
