Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188C7C43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB4E206CA
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qP4kEMGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgICVGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgICVGc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 17:06:32 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2472C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 14:06:31 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id k26so2530744pgf.8
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 14:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Cw9WkqLxkoN+v4gahJaF07iiwb+Q2wdGSYgDcJN4hg0=;
        b=qP4kEMGBPVhvpWw1voOy/K3t+T3n7izlJue72ue6iGbqTiD+QprspdAqEwXncW7Q4i
         q03VMGY0Hq+edEJjMJw7/gzqr1MIrftC1l3kGTwL9hQPDTNp9CYxUFak4rWNL6xo3J13
         +kgSjRNVsvkYa6fAoKm1ziqE2cYg4ae9pXI8ObVs5HeH2vivoicCnMohCp5PtHIuQMyL
         goN3+q+umo8wOmmXunHsiPRyaIal/DNxV1I7F9LBpLnAR2ZBvrmy/l3xfrMkw5urPaFB
         nvo5kRoDXD852djnrAbUVf5YOTqIMOpoJDwZ5KnvMrSDhK4WVQcJRvs3CVK1zEHCtdYC
         NctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cw9WkqLxkoN+v4gahJaF07iiwb+Q2wdGSYgDcJN4hg0=;
        b=DbkIkUAUtfTkY7FAw9QM7o3+tsueg1iGBV+G/Vrjva7nN54blxGSSBWa7bC1Ld2F74
         h8+kGlstouHyJajygCpnu8skRDpUNmWLkZJFUrHea6F4XaFwPu2UbppxQRWax1SeE3J/
         yMopYXwN3Ziqaj5eqdqiisqRE01vmRSN2k1NABtYgLUoDFeFJJVZav1EdotipMOCl/SC
         QD1HRWEk8Efwl5rimSKLn+idAbBvJ1bdbzlfaVS2JVxukA3r01bJ07XMgb4lNHZ7JA4f
         Hdt1NLLVVczDVsfw+agYwyaM9wgp6Xa3FyW3mMvDYtu/g5TsCVzvUaXQqYMts8NtDOlQ
         EfsA==
X-Gm-Message-State: AOAM530h2O8A6c10m+4MoyQF4XMlByCdP0Db1oi76UlVtXwOZnwsICZ0
        Jtx457Q2/jVNefG9WzSqcyl0t73albzDwQFvPTS3
X-Google-Smtp-Source: ABdhPJzh3OWhTsianz5ondN6VCEQoe89//yiBmw7KLfZDJ9tcINO/hpZceMiCOfEJBsrrPqb08u1GxdbAwn8NVxStqEY
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:a102:: with SMTP id
 s2mr4802506pjp.55.1599167191091; Thu, 03 Sep 2020 14:06:31 -0700 (PDT)
Date:   Thu,  3 Sep 2020 14:06:28 -0700
In-Reply-To: <xmqqy2lq8tka.fsf@gitster.c.googlers.com>
Message-Id: <20200903210628.2753574-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqy2lq8tka.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: Re: [PATCH v3] fetch: no FETCH_HEAD display if --no-write-fetch-head
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > OK - updated the code, added a test for the "--dry-run
> > --no-write-fetch-head" case, and updated commit message and code
> > comment.
> 
> Unfortunately our actions crossed X-< and the previous one that was
> good enough is already in 'master', together with the lazy fetch
> topic.
> 
> Let's turn this into an incremental fix only for "Ouch, we still say
> FETCH_HEAD when both --dry-run and --no-write-fetch-head are given"
> bug.
> 
> Thanks.
> 
> -- >8 --
> Subject: [PATCH] fetch: fix --dry-run --no-write-fetch-head interaction
> From: Jonathan Tan <jonathantanmy@google.com>
> 
> Recently we introduced "--[no-]-write-fetch-head" option to tell
> "git fetch" not to write FETCH_HEAD file.  The command reported that
> FETCH_HEAD file is written, even with the "--no-write-fetch-head"
> option.
> 
> db3c293e (fetch: no FETCH_HEAD display if --no-write-fetch-head,
> 2020-09-02) tried to squelch this, but the fix was not sufficient.
> Because we never write the FETCH_HEAD file when "--dry-run" is
> given, the addition of "--[no-]write-fetch-head" option was made by
> directly fliping the internal variable 'write_fetch_head' (which
> defaults to 'on') to 'off' upon seeing "--dry-run", which allowed
> the condition to decide if we write FETCH_HEAD to be a simple
> reference to the variable.  But now, we need to tell if the user
> explicitly asked "--no-write-fetch-head" with "--dry-run" to
> decide when to show the report about FETCH_HEAD correctly.
> 
> Introduce an extra 'user_specified_write_fetch_head' variable, which
> is 'on' by default and is turned 'off' with '--no-write-fetch-head'.
> The 'write_fetch_head' variable that decides if we actually write
> FETCH_HEAD remains there, retaining its meaning, but use this new
> variable and 'dry_run' to decide if we report about FETCH_HEAD.
> 
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---

Thanks - this looks good.
