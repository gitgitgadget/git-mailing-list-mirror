Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24864C3A5A7
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 00:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLGAlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 19:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLGAlA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 19:41:00 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC6E62
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 16:40:59 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id h185-20020a636cc2000000b0046fc6e0065dso13205500pgc.5
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 16:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hDxsZyqe82Z8LgnK1b7fCA0OWXS4JU/sZ/IBgriTgIo=;
        b=QreY5M8dJ82NHpGbIHpjvxakpRtI6SfAyEPncCiGCTO8SE24eDe2YikVUL6DANEVet
         3/mFPXx9QCTNZme7t683JkLo7wY4KyI1UJuaLUPa6/IRiU++Uj7TFrfNb2qBEpVf5/ft
         TFKZS1LJv9gmTvXB1Um+P9IcwaCKRGgG9rlyl6157NHn+vaIlCZnjVQp6ZASq7sb9SQQ
         vVOcaGIUM3a8T7Gjy4dTI/lM/rDlDBq7yq/gGDfdbgZPMtbhLixN2xm/LYHHzIGwO0GO
         ef2hHH2refHPCxGKlCxivUaz92/IGyLcPqAfXtm7UlIyMWWOYgX+605gHEFaLkBepqvQ
         E/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDxsZyqe82Z8LgnK1b7fCA0OWXS4JU/sZ/IBgriTgIo=;
        b=rHuuJpKIy6Pl+EIlLJkD7aHUT13U1Dp27KNPcLTbKYL1gJ71cPymdi1ktdMaDND/W9
         ZJwFDbAAF83+qMQ40AfOP/24QLkYNE0qDMjlZSywz6zJDfNx172cSGaWOVPkQO3moLPw
         ZbXOGTQPdaeedGMDEIhIidI9HI6yb1E23hDw0+a57CjbxIo+yv95s1/EsEJrvwrQDGV6
         BoRFf/E4rX7Feev1hyc2Sr/63xcEFXfQzz+eE69ufxdcFKJ1lK7QP2h2z1CzZyuLmkwl
         1sT6WaA59RFhrzHie7M9eRQxjo4VQzFJ4KNd6Q/oTfUxXXyzJwTt3JDOzLxa4pVxfyms
         3y7A==
X-Gm-Message-State: ANoB5plHxn2D2b+iEiZHVn156+D0gle71PZx/SZrBW0eH0U6sMiF2LS0
        7ja/JqfGew6cfmgIa5H2x5SGAf3ve+mY4uTqjyTiKE8f/jsw8TBZZCNynpGMASY3zVslR0alAFA
        myMrxCFvsGGyY9cVESKC1geYBG2ZtasLWLHn4OZ0dWS2baWJh6GCp1F0Peb3m9xdP8kFnKCR56t
        9u
X-Google-Smtp-Source: AA0mqf7cRsDz9IpA8nGHmvgTZA8FDNQGmepS1AjtL4eR5Ukk/wbhV5WT9ab6Lu8sbgxWQ4hcnl0jzL8dkoihpNsoZouy
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:d086:b0:219:227d:d91f with
 SMTP id k6-20020a17090ad08600b00219227dd91fmr5114882pju.0.1670373658384; Tue,
 06 Dec 2022 16:40:58 -0800 (PST)
Date:   Tue,  6 Dec 2022 16:40:50 -0800
In-Reply-To: <cover.1669839849.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <cover.1670373420.git.jonathantanmy@google.com>
Subject: [PATCH v2 0/3] Don't lazy-fetch commits when parsing them
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for taking a look. In the end, I thought it best to bite the
bullet and move all the corruption diagnostics to where they are detected
instead of re-checking (and thus relying on errno to be preserved) after we
have found out that we couldn't read the object. This does mean a reworking
of all the earlier patches, but overall I think that this puts the code in a
better state.

I have also verified that this passes CI [1].

[1] https://github.com/jonathantanmy/git/actions/runs/3634359088

Jonathan Tan (3):
  object-file: don't exit early if skipping loose
  object-file: emit corruption errors when detected
  commit: don't lazy-fetch commits

 commit.c       | 15 +++++++--
 object-file.c  | 84 ++++++++++++++++++++++++++------------------------
 object-store.h |  3 ++
 3 files changed, 59 insertions(+), 43 deletions(-)

Range-diff against v1:
1:  3a00bc45fd < -:  ---------- object-file: reread object with exact same args
2:  9999e127a0 < -:  ---------- object-file: refactor corrupt object diagnosis
3:  28c7ee2f8c < -:  ---------- object-file: refactor replace object lookup
-:  ---------- > 1:  9ad34a1dce object-file: don't exit early if skipping loose
-:  ---------- > 2:  9ddfff3585 object-file: emit corruption errors when detected
4:  0607fa67d1 ! 3:  c5fe42deb0 commit: don't lazy-fetch commits
    @@ commit.c: int repo_parse_commit_internal(struct repository *r,
      	enum object_type type;
      	void *buffer;
      	unsigned long size;
    -+	const struct object_id *real_oid;
     +	struct object_info oi = {
     +		.typep = &type,
     +		.sizep = &size,
     +		.contentp = &buffer,
    -+		.real_oidp = &real_oid,
     +	};
    ++	/*
    ++	 * Git does not support partial clones that exclude commits, so set
    ++	 * OBJECT_INFO_SKIP_FETCH_OBJECT to fail fast when an object is missing.
    ++	 */
    ++	int flags = OBJECT_INFO_LOOKUP_REPLACE | OBJECT_INFO_SKIP_FETCH_OBJECT |
    ++		OBJECT_INFO_DIE_IF_CORRUPT;
      	int ret;
      
      	if (!item)
    @@ commit.c: int repo_parse_commit_internal(struct repository *r,
     -	buffer = repo_read_object_file(r, &item->object.oid, &type, &size);
     -	if (!buffer)
     +
    -+	/*
    -+	 * Git does not support partial clones that exclude commits, so set
    -+	 * OBJECT_INFO_SKIP_FETCH_OBJECT to fail fast when an object is missing.
    -+	 */
    -+	if (oid_object_info_extended(r, &item->object.oid, &oi,
    -+	    OBJECT_INFO_LOOKUP_REPLACE | OBJECT_INFO_SKIP_FETCH_OBJECT) < 0) {
    -+		die_if_corrupt(r, &item->object.oid, real_oid);
    ++	if (oid_object_info_extended(r, &item->object.oid, &oi, flags) < 0)
      		return quiet_on_missing ? -1 :
      			error("Could not read %s",
      			     oid_to_hex(&item->object.oid));
    -+	}
    - 	if (type != OBJ_COMMIT) {
    - 		free(buffer);
    - 		return error("Object %s not a commit",
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

