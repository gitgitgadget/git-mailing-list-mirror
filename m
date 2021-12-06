Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91569C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 00:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbhLFAjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 19:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhLFAjh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 19:39:37 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172DFC061751
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 16:36:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso9199615wms.2
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 16:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+Pbgnih6S9oimb3vusHeaW/GfwxnUF0nmL4S68I7wGE=;
        b=gTnEhODDSHN83RkJ+JE+y1Rr8aiSb6hggKWbOR9Bg29nsWT3sbyoqNbeLFVk1gs9Cw
         Q0yfUHSweJ+8PaFx2IDk3wP8SOpy1yKZhnH7ZWGsMUFe9WRMPAgnAS+ufpSmGBJ8dddQ
         3HtYdkMzwRI/ICrhqVgki56mMiM1uFnVCaiPW+/5R/C66KJ7ynWgqlsBwxaLe7ux9joU
         4eWbOMjFW5phhFoC41nNFBJLuMwWMN7jfbYxLXuLwo8/CgdL+m/mmLXqYK6L6WJsTZVa
         NhLS7ydmSulB6FfkDUg+KQ36HLWZjbLhU5/D5VNmICHWbWE5dTaeKbk/njWQ0nZACssD
         hxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+Pbgnih6S9oimb3vusHeaW/GfwxnUF0nmL4S68I7wGE=;
        b=gCOb0zLX/nj88ieQOiBkoMPeuk4Wr6UZ9jIg4TulitWxFD6OsvHxGqFktoZekeRxN1
         FSY4MhFpN0VUqFAft7dF/1bHszAJu5S9qC4oqea35GrGJoGzOaclN/jI+Itl1ZDkvTDe
         evcFRIbjcCiIfo2ehAyXXb7NW4WW+6krRnsSU+L5JL8oAY2w9gcKAuQ3AEkW72AgA4DG
         OMTKtiRgF9Evu+L/OeuDE9MiWndmmwcgVnF+PssXzuypYjyYn4FABTU5yz14qKEs9Xwt
         wKx8rWDmkV9gF+PJUmT4T/DZVjXOJifMEhJ2Y/jAnsuRvCR5VRilJPNl38cHSe6DEVP+
         SXNQ==
X-Gm-Message-State: AOAM5321Oeiroc70j87ZRwJ3yA7AyxUJGFrtrJxfccOsSDm70IqXh+ks
        w4MjDLKzKgTCLjShR0hPXcKz4zQGwuY=
X-Google-Smtp-Source: ABdhPJwn+TGaxBAJTHCJI5XyOzOSvZ+URrC6YVxOusiFgCxDM9CycWagpRD10KE+jeFuohvC2AkorA==
X-Received: by 2002:a05:600c:3227:: with SMTP id r39mr36256801wmp.120.1638750967416;
        Sun, 05 Dec 2021 16:36:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm9851381wrp.79.2021.12.05.16.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 16:36:06 -0800 (PST)
Message-Id: <pull.1091.v2.git.1638750965.gitgitgadget@gmail.com>
In-Reply-To: <pull.1091.git.1638585658.gitgitgadget@gmail.com>
References: <pull.1091.git.1638585658.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 00:36:03 +0000
Subject: [PATCH v2 0/2] ns/tmp-objdir: add support for temporary writable databases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2 changes: I lost a couple changes in the shuffle while splitting these
changes out

 * Make the will-destroy boolean a single bit field of type unsigned int so
   that it doesn't change twice in this small patch series.
 * Remove a the_repository reference in the disable ref updates code. Now
   the repository is taken from the ref_store.

New interface into the tmp-objdir API to help in-core use of the quarantine
feature.

This patch series was formerly part of the ns/batched-fsync topic [1]. It's
now split out into its own gitgitgadget PR and discussion thread since it is
the base for en/remerge-diff as well.

The most recent feedback was in [2]. I removed printing from prune_subdir
and simplified the strbuf handling in prune_tmp_file.

References: [1]
https://lore.kernel.org/git/pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/CABPp-BH6m4q_EoX77bqLcpCN1HRfJ_XayeCV2O0sRybX53rPrw@mail.gmail.com/

Neeraj Singh (2):
  tmp-objdir: new API for creating temporary writable databases
  tmp-objdir: disable ref updates when replacing the primary odb

 builtin/prune.c        | 20 ++++++++++++---
 builtin/receive-pack.c |  2 +-
 environment.c          |  9 +++++++
 object-file.c          | 50 ++++++++++++++++++++++++++++++++++++--
 object-store.h         | 26 ++++++++++++++++++++
 object.c               |  2 +-
 refs.c                 |  2 +-
 repository.c           |  2 ++
 repository.h           |  1 +
 tmp-objdir.c           | 55 +++++++++++++++++++++++++++++++++++++++---
 tmp-objdir.h           | 29 +++++++++++++++++++---
 11 files changed, 183 insertions(+), 15 deletions(-)


base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1091%2Fneerajsi-msft%2Fns%2Ftmp-objdir-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1091/neerajsi-msft/ns/tmp-objdir-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1091

Range-diff vs v1:

 1:  4ae4303595e ! 1:  36c00613d9a tmp-objdir: new API for creating temporary writable databases
     @@ object-store.h: struct object_directory {
      +	/*
      +	 * This object store is ephemeral, so there is no need to fsync.
      +	 */
     -+	int will_destroy;
     ++	unsigned int will_destroy : 1;
      +
       	/*
       	 * Path to the alternative object store. If this is a relative path,
 2:  d8ae001500c ! 2:  f667cbcc47d tmp-objdir: disable ref updates when replacing the primary odb
     @@ object-store.h: struct object_directory {
       	/*
       	 * This object store is ephemeral, so there is no need to fsync.
       	 */
     --	int will_destroy;
     -+	unsigned int will_destroy : 1;
     - 
     - 	/*
     - 	 * Path to the alternative object store. If this is a relative path,
      
       ## refs.c ##
      @@ refs.c: int ref_transaction_prepare(struct ref_transaction *transaction,
     @@ refs.c: int ref_transaction_prepare(struct ref_transaction *transaction,
       	}
       
      -	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
     -+	if (the_repository->objects->odb->disable_ref_updates) {
     ++	if (refs->repo->objects->odb->disable_ref_updates) {
       		strbuf_addstr(err,
       			      _("ref updates forbidden inside quarantine environment"));
       		return -1;

-- 
gitgitgadget
