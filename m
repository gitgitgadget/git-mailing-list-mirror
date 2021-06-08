Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E4CC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED0961108
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhFHGCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHGCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:02:09 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A949BC061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 23:00:17 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id o5-20020a4a2c050000b0290245d6c7b555so4723430ooo.11
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 23:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZGb0HObsGilHHAEJ1aqAfchHsxRH8isI8i/KMPQCIyY=;
        b=AM1MiWUkIdfUNPp8YiVLTb7JNhK8u0kiRSShNeIQO7R1o79SdlyJqP/yV90ynZeCgv
         fqDn9BZsW1wF4au4txkwEU93O5KpYuKD9rZGa6cAWg6KLHAUrSBBsw1udDnYgHrhC+oK
         bIVv1/54Xj0w6Fkx61gEMhSlS3AFaH3MKWx9mRolsxwdphjRZOJgujetUVOx/voYt4+L
         8N6R+VddoGsIhGa4UxiHbr7tTMtox0lolt+ndjP/L4Tr+sS7pCVHcNfTJz4sHphzYm+6
         xyhxTIn3xHj4jTJHbF5/O96lJSGfzs1r8PB2ZcPOMi8F0iSTbiKrmlCjEb5SwaPuSXV+
         Gtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZGb0HObsGilHHAEJ1aqAfchHsxRH8isI8i/KMPQCIyY=;
        b=efvNIB/H0jHiaiC83iYLoBaYnaGHxHX5PwWEfP6AUZFF1pQKz9fqKw/lSRiLJMBqE+
         oEtbQ6HtIQkFHzoqLl8gbRsHs0yO43idSRTvhG8R3ZJGAQwo9JbsIgRha6tnqFb7UDp3
         90DBErAceENvRl6Ra435XzM0v2UWuGpSzA2e3HFD9uExuEYEZB0/Ikvx/GhvRVmn9Myv
         KkkrfQ/gyxK8spcDBgI0UeGUfz87NlmUCbwn3wwVZ8gS/7TLEl2/VAqfqteMhHH1CMpG
         uECxv4PuR+8yMS0Yhfhas2dqrLlN9GxFAmNF9IH+SJIP9jt1jcq54Jiddi7o0cy+zrQc
         gZtg==
X-Gm-Message-State: AOAM532DB2Jvz3EmqtUJEmfALjjR+AOtaKD+SVaPQ4esTbbMA5F6JxZt
        Bmsrj5ogFkH6Uy/thFB3crN0W6Z/snclfg==
X-Google-Smtp-Source: ABdhPJyTSLqzBHEf6OoadrfRtPsHGLzINO1j9IdLn40hrUGLdl68C8KUj9uKLjDiRbi9QyCOvzIiSw==
X-Received: by 2002:a4a:c287:: with SMTP id b7mr16300940ooq.8.1623132016891;
        Mon, 07 Jun 2021 23:00:16 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id j7sm1452856oij.25.2021.06.07.23.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 23:00:16 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/4] completion: bash: a bunch of fixes
Date:   Tue,  8 Jun 2021 01:00:06 -0500
Message-Id: <20210608060010.1676208-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210606184726.1018460-1-felipe.contreras@gmail.com>
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These should be pretty obvious and straightforward.

Since v2 only a commit message was updated to say "options of commands"
insead of "commands".

Felipe Contreras (4):
  completion: bash: fix prefix detection in branch.*
  completion: bash: fix for suboptions with value
  completion: bash: fix for multiple dash commands
  completion: bash: add correct suffix in variables

 contrib/completion/git-completion.bash | 14 +++++++-------
 t/t9902-completion.sh                  | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

Range-diff:
1:  52de92cb06 ! 1:  4b73b26338 completion: bash: fix prefix detection in branch.*
    @@ Commit message
           git clone --config=branch.<tab>
     
         Reviewed-by: SZEDER Gábor <szeder.dev@gmail.com>
    +    Tested-by: David Aguilar <davvid@gmail.com>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## contrib/completion/git-completion.bash ##
2:  af2f17364d ! 2:  cb2fc1a7f2 completion: bash: fix for suboptions with value
    @@ Commit message
     
           git merge -X diff-algorithm=<tab>
     
    +    Tested-by: David Aguilar <davvid@gmail.com>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## contrib/completion/git-completion.bash ##
3:  a3bcb70594 ! 3:  ece06463a2 completion: bash: fix for multiple dash commands
    @@ Metadata
      ## Commit message ##
         completion: bash: fix for multiple dash commands
     
    -    Otherwise commands like 'for-each-ref' are not completed.
    +    Otherwise options of commands like 'for-each-ref' are not completed.
     
    +    Tested-by: David Aguilar <davvid@gmail.com>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## contrib/completion/git-completion.bash ##
4:  6b3ef41c92 ! 4:  f9db132cbd completion: bash: add correct suffix in variables
    @@ Commit message
         but that can be done later.
     
         Cc: SZEDER Gábor <szeder.dev@gmail.com>
    +    Tested-by: David Aguilar <davvid@gmail.com>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## contrib/completion/git-completion.bash ##
-- 
2.32.0.2.g41be0a4e50

