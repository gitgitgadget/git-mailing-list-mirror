Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBC0C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 21:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJDVNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 17:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJDVNu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 17:13:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785A9659F6
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 14:13:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so14211235ybr.0
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ThXkwHYDsdEKFNDPSfPlR8mcVoXy4sz2Z5suO/mKgI0=;
        b=U1kNevaqFBUIeuwQPUJvheN6F+x9BHGv+olu2jwASK0FgLLwBCBL2VXxf1KqVzpb2K
         wgRHm74yJZiTzeGwtrWGBZYtGcdFsfvsLpDBqhl5Om60MTET5QRyZsjVAGCXV4D9UxwJ
         noyoMs1xNwJ/MDjI6b6xZaWtSKbzfREvDQOc6OZkomb1QUK9Bghpjnw86ojo/q990BfT
         B3oPLgSfSYYDqv3ls6kQ5XuAsp8StXDVMxdUZsG0k2F+FSCTqeOaZhNAMTAcusWkTH4l
         dPPVIwSndAkNpYdMGCpVF+5/15iOVBiOGe/aE1kt43dbg9bMZbLetb02XCO8BNFB+LZJ
         OfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThXkwHYDsdEKFNDPSfPlR8mcVoXy4sz2Z5suO/mKgI0=;
        b=6iMndyk1g1acO33wXTWyc5QIYQyQKo5hqcTnd1j9GMxWnq6+7UY8QEmE1IJENOkRpM
         Sub+7clYcR5Jzke1xvSbEsERrXsxM6XD2ue/zBIdN/+hzY0HRsJ090GK5gVtnE6J8rkg
         NmwMRiy/gLNinM50t7fqYePbiF+CEm/XMA9ek2oJ6z9VA4nojYGS4LUVqb6IdxFcgIVP
         k/0Df2DNVAe1ZFp4Z8pgKt08whTD/nwuN/lXtNSmQr173fA5LC2Vun5MWh0RlSdqNuW5
         uT/PNno6KDa16rbXVM3RCvFqckQBQOKOZVMIoM6wUCJyL6y1xcQDvWT0+O+42hGKhXLW
         srrQ==
X-Gm-Message-State: ACrzQf0W0FYe0N2aUxOSbPpf3THpAK1QPQe4eK50/vwbPBPwPwlt4HBC
        0dq/T24qWeNpVq2O6ME4Fy84B0k73yggqRRrqE2Hzjk9dKsXud9qPdXsHGr7VNuEwqgdDEidU4T
        Rx0KTNINUZwahDhla0Iv4SX9P09NzhFVYQhIhZLgJXwqa4Dh1Oj0sBF1wf3CH9yRJxADGycmMjo
        xY
X-Google-Smtp-Source: AMsMyM5y0e7Z/WnxnIXx/tnw60oq9dVM0mISp3JwbyoNuKzrQdh3bkae2fSWwxSO89xuSNSMJVfBDH/k824EPkfYKO0H
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0d:de83:0:b0:337:c0bf:12ee with
 SMTP id h125-20020a0dde83000000b00337c0bf12eemr25772378ywe.289.1664918028716;
 Tue, 04 Oct 2022 14:13:48 -0700 (PDT)
Date:   Tue,  4 Oct 2022 14:13:39 -0700
In-Reply-To: <cover.1664316642.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1664316642.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <cover.1664917853.git.jonathantanmy@google.com>
Subject: [PATCH v2 0/2] Fail early when partial clone prefetch fails
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for your comments. I don't think that there is a test 
for when a lazy fetch fails, for some reason, so I added one.

Jonathan Tan (2):
  promisor-remote: remove a return value
  promisor-remote: die upon failing fetch

 object-file.c            |  4 ----
 promisor-remote.c        | 23 ++++++++++++++---------
 promisor-remote.h        | 11 +++++------
 t/t0410-partial-clone.sh | 14 ++++++++++++++
 4 files changed, 33 insertions(+), 19 deletions(-)

Range-diff against v1:
1:  fdb35bc9a6 ! 1:  207332c2df promisor-remote: remove a return value
    @@ Commit message
         No caller of promisor_remote_get_direct() is checking its return value,
         so remove it.
     
    +    Not checking the return value means that the user would not know
    +    whether the failure of reading an object is due to the promisor remote
    +    not supplying the object or because of local repository corruption, but
    +    this will be fixed in a subsequent patch.
    +
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
2:  06a649b01a ! 2:  9bbf130c2c promisor-remote: die upon failing fetch
    @@ Commit message
         When this batch prefetch fails, these commands fall back to the
         sequential fetches. But at $DAYJOB we have noticed that this results in
         a bad user experience: a command would take unexpectedly long to finish
    -    if the batch prefetch would fail for some intermittent reason, but all
    -    subsequent fetches would work. It would be a better user experience for
    -    such a command would just fail.
    +    (and possibly use up a lot of bandwidth) if the batch prefetch would
    +    fail for some intermittent reason, but all subsequent fetches would
    +    work. It would be a better user experience for such a command would
    +    just fail.
     
         Therefore, make it a fatal error if the prefetch fails and at least one
         object being fetched is known to be a promisor object. (The latter
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
      	if (to_free)
      		free(remaining_oids);
      }
    +
    + ## t/t0410-partial-clone.sh ##
    +@@ t/t0410-partial-clone.sh: test_expect_success 'fetching of missing objects' '
    + 	grep "$HASH" out
    + '
    + 
    ++test_expect_success 'fetching of a promised object that promisor remote no longer has' '
    ++	rm -f err &&
    ++	test_create_repo unreliable-server &&
    ++	git -C unreliable-server config uploadpack.allowanysha1inwant 1 &&
    ++	git -C unreliable-server config uploadpack.allowfilter 1 &&
    ++	test_commit -C unreliable-server foo &&
    ++
    ++	git clone --filter=blob:none --no-checkout "file://$(pwd)/unreliable-server" unreliable-client &&
    ++
    ++	rm -rf unreliable-server/.git/objects/* &&
    ++	test_must_fail git -C unreliable-client checkout HEAD 2>err &&
    ++	grep "could not fetch.*from promisor remote" err
    ++'
    ++
    + test_expect_success 'fetching of missing objects works with ref-in-want enabled' '
    + 	# ref-in-want requires protocol version 2
    + 	git -C server config protocol.version 2 &&
-- 
2.38.0.rc1.362.ged0d419d3c-goog

