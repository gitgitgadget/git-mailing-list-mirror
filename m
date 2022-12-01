Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABDEC4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 19:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiLAT1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 14:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiLAT1h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 14:27:37 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7DF108C
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 11:27:36 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id j18-20020a170902da9200b00189b3b16addso3111418plx.23
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 11:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdc2tj7LYlrOP/L9j/6EgZ0cLvcJbd68pH5XFE8SvRs=;
        b=reqn6tXhvuO35hV+GOBYWA3CiQsA1tNK46zGlPEFruLiiW4UXjkz4JeK3P7Vcv/pAW
         77DfT01PD/qZ5Ed6PHU9Nm+QoWrn8fglWVRFYinCPqEY/WUQui4mWg2yGWgAo8YAug+6
         JOqZz7P2db4zV07xv9F77+SJSTlZp2lLeH5Vw5zHZBVMWxF0HIpPSCt4lZF7gfrEUof5
         RMFgmVfxypFYpf45qmDx/gvfCFinnAL55FKwZVN9OKwgmP7kRsTxYQdCR/Ojvd3lrneM
         tvzhAjGeyotzcBSn3+J1ZWhbcB5p8vCB1sdyueMpgPggjjxJ2uBNcBcsiZMoR+cnURak
         +Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdc2tj7LYlrOP/L9j/6EgZ0cLvcJbd68pH5XFE8SvRs=;
        b=xrDXPMcSg1NlJ9yMSpZmnHcpp1QqgzBjQzups5GL+xdRtjYxqOGjiT3N03noMVGKY6
         oGpxmst5+Mo0Vaxo+T2RMwFhHkh5bleHtZ8Dsmx6CVPgvBRP8cvi3D0Bt1QHoWB6W59c
         t8rl78cQh2iulr3iNTR09MJ9s4KqqdO8Z3WO+P5hCvctj99bcAQhFGNzLf68ELD2uYbh
         oe2TFhUqy8GB+lUWBAeldll2PTAFOS91GQM2nRjINvDULj7iaBm2TpSwtLhh4JOk97Vd
         4ePiztdtZm+nHs1sPStPz46ECsz6G9rDuiJatq3nxiBGTuAt6U7cEYrUT0fefOEUiddC
         lncQ==
X-Gm-Message-State: ANoB5pkbRfeR6CHr0NT71LNp/FaPPoH1tc1WwRsBc08b5bcaoGmjtUzM
        Ota5MIV9Bv4Is45UFmUa7bX8g4jWjxViSWOSmcY0PnqulqiQqpuJ0Hmxzy5zzDyJDV+tew24QvJ
        xznhlUiM48V+gwzpjJqp7XAK1BeBWNhiSP+nJPc3a1ydaK/4EKMoOuRejjWJfLYyrbI4NVU7WGH
        eP
X-Google-Smtp-Source: AA0mqf5jE9dGYbC3Jt/p/bxIyUvUpLg/tZMohZshtk2q2zcd8Gq2YtfwtkXXKDvHKDlshLGZUHUX0gKFTipFFA28C5IP
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1388:b0:574:d12e:f3d6 with
 SMTP id t8-20020a056a00138800b00574d12ef3d6mr30686400pfg.78.1669922855681;
 Thu, 01 Dec 2022 11:27:35 -0800 (PST)
Date:   Thu,  1 Dec 2022 11:27:29 -0800
In-Reply-To: <cover.1669839849.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <cover.1669922792.git.jonathantanmy@google.com>
Subject: [PATCH v2 0/4] Don't lazy-fetch commits when parsing them
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for your reviews. Here is a reroll with the requested change
(just one small one).

Jonathan Tan (4):
  object-file: reread object with exact same args
  object-file: refactor corrupt object diagnosis
  object-file: refactor replace object lookup
  commit: don't lazy-fetch commits

 commit.c       | 18 ++++++++++++++--
 object-file.c  | 57 ++++++++++++++++++++++++++++++++++----------------
 object-store.h | 10 +++++++++
 3 files changed, 65 insertions(+), 20 deletions(-)

Range-diff against v1:
1:  604160e79c = 1:  604160e79c object-file: reread object with exact same args
2:  a8c5fcd9f8 ! 2:  1be60f1bf2 object-file: refactor corrupt object diagnosis
    @@ object-file.c: void *read_object_file_extended(struct repository *r,
      
      	/* die if we replaced an object with one that does not exist */
     -	if (repl != oid)
    -+	if (real_oid != oid)
    ++	if (!oideq(real_oid, oid))
      		die(_("replacement %s not found for %s"),
     -		    oid_to_hex(repl), oid_to_hex(oid));
     +		    oid_to_hex(real_oid), oid_to_hex(oid));
3:  940396307f = 3:  28935ba1b0 object-file: refactor replace object lookup
4:  6af8dcebd1 = 4:  a38229c42a commit: don't lazy-fetch commits
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

