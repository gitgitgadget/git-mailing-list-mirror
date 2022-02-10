Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767E2C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 19:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343869AbiBJTRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 14:17:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343857AbiBJTRo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 14:17:44 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40516131
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 11:17:45 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id e1-20020a17090ada0100b001b83a55e809so4909356pjv.7
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 11:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=Ub11sBcriO8u2FatZw4XNh0mLL7n4B/gSeq0oRjWw8A=;
        b=Dve/OUY0llrEk7bRqzwv9V0e71OR259V+Udt26z8/1x2vD3LwLxvcKKLBy5CtGuYVL
         4VdK6+k3nXOtFSB1YNIyVVIsOVGklQN9aqnP7vD/ATgZGrUc0jYnh1OP7rgjWUQlE55e
         YDI1POCzaE6gDtdR+CNpMkF2g53+6fp61IZaBJfsXYcrWUKoKi/7+aOsiLqmYDYq3kjG
         e5jaY/Voc+79Pay7iFX+dUzFPMXflKa5jrh+p+hYLyxAXKSblEqXuJGBMpabLVSvVYAI
         r7rKGJBwxtU9kRVgQVaZoghJeRfBSzvr8tCBIhVzjFhM48agN7/f1whlKzCAawbY6rZs
         vrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=Ub11sBcriO8u2FatZw4XNh0mLL7n4B/gSeq0oRjWw8A=;
        b=N9vS8pB3Led5c7NZA905kg93KBwJQsYOhnIxKW3ikSIQhapqhGEl2Uw+5096KzTXwn
         XzQqCYXJ1tRYbmK5fBlLg59NWbEnYXWiqAMcMbxctRou/Pvk4wKwj+3+eyEU6wSIj2Vj
         yXnvxPCYYMmmE0kWNmDe4vT0gYc+G/nqkFsjIfVXG3NLsMyHx+EckZp8M03v3IK4IU+U
         20qbZMsE47/NptyEYrGqUC/Pj75PS/7sDqn3xu432Xr49kfDkS7I5UjLkVzn8SY2pFu5
         or5ukgaBeSXXKFhbKi3qJYJp88hkcExsDzyUnOF7R96j3NN0RqU2MMqrEoUDYwF8USl3
         jD/w==
X-Gm-Message-State: AOAM530YhmlVH0XWAZxOzua2PQUHZKCvdE7U/vD9sM9/6XrMPSpfrRZ1
        RxFT3m0OOvsg3Dj9iYUvo+gZZ+zFOD7meIDgSxQX
X-Google-Smtp-Source: ABdhPJy80Foe/2sAGOfoU78+2pe5ht6X9n3ht2BosBd0dY0cVP2y0t1MfL9W+vEi+lYVA/we11v1+GtsQUDFgt06bebb
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:6886:: with SMTP id
 d128mr7232742pgc.522.1644520664599; Thu, 10 Feb 2022 11:17:44 -0800 (PST)
Date:   Thu, 10 Feb 2022 11:17:27 -0800
In-Reply-To: <20220210044152.78352-6-chooglen@google.com>
Message-Id: <20220210191727.660437-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: [PATCH 5/8] t5526: use grep to assert on fetches
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> In a previous commit, we replaced test_cmp invocations with
> verify_fetch_result(). Finish the process of removing test_cmp by using
> grep in verify_fetch_result() instead.

Thanks; this and the previous patch look like a better scheme for
testing.
