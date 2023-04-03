Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A051C761A6
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 17:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjDCRg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 13:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDCRg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 13:36:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162D11FFC
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 10:36:26 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u10so28782947plz.7
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543385;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6L4Ahn7VIwEvR79et5h7CCA9aAO3zKyXWz0C7JOOZJc=;
        b=g952qju/FDkmcqGqXybrAPQAF7gBsFIHQ74Lk6scSEVQNh3eNLiyM/3y0jpa8c0QC4
         iZ4jlOMaf8XtVqOQmjA1I00OptnWTrKkf6o2BqexyL4CDIIOc1tkR5A2h+dFq66zIFzM
         Kmo4Y0SBdW0m+3iMq3OpA0EADpyjMOZm8xh6JXMMPIMIBpoEFFx0RQyW8QjghKFplqDl
         7Mh6gOO21hH/8zH6rMQXuGYRa5dpSx+sLVv/WNa2NXZ3vjVtCw8YPmn2RooJ+vXo/JKu
         qqRGwEmhS2m7o1dfpO/BQ3pgplx64QnYwZJi1KUwFhVHO3kLxu32lB8gcwNsQ3IZP2dY
         FZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543385;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6L4Ahn7VIwEvR79et5h7CCA9aAO3zKyXWz0C7JOOZJc=;
        b=WSl932H8gtbl5A4RqoyXWuGCsQAe2dkJW7v0YB6aZ2f6qWWN6a7M1kUEmbZP9LlvoL
         eU6Z63faGbDyC9XI0516hBB8PrnmjHR9NRly2eQFtlc+4sdd6lUKmrvBCRNz4yZe7GF1
         HCD0ZN3/kXYIaooKto+RtFsl6Q69uOucDylkhhs3AoWknj08qSoQntyNQSI81aUcldYW
         WBaY0qPScFevq6lvVsp/X7H3AqAUsswp2zB9TQjIN+JPKW9nGK6R0xFwXFwKYryt5wY/
         5hMiVTMaoUPYQ2BwJlalh9hkfvu13OyAas6ZGXk7e2UV0m9MUJWQ4nEbtQTRbETVf7Zy
         wiYg==
X-Gm-Message-State: AO0yUKV4m60zf9TJW6jvgrkVD6OriJpBDr857AExY2fxSWy3cFAqHF8G
        h2QMmKMnUPdLm3MT7bGpI1oIiMt5o28=
X-Google-Smtp-Source: AK7set/MloI+odGMh4L+i76DJqKpzymRi5MF4Z8W3mOudbJlIOzhHlgQvR6JElW1fayurSsYFq3xvQ==
X-Received: by 2002:a05:6a20:4fb0:b0:dd:ac3a:b798 with SMTP id gh48-20020a056a204fb000b000ddac3ab798mr30480562pzb.13.1680543385552;
        Mon, 03 Apr 2023 10:36:25 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id d3-20020a654243000000b00502ecc282e2sm6332814pgq.5.2023.04.03.10.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:36:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Guillem Jover <guillem@hadrons.org>
Cc:     git@vger.kernel.org
Subject: Re: Add a way to disable =?utf-8?B?wqtnaXQgY2xlYW7Cuw==?= per repo
References: <ZCiZCM+AAUnjp4Ml@thunder.hadrons.org>
Date:   Mon, 03 Apr 2023 10:36:25 -0700
Message-ID: <xmqq355g6f6u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Guillem Jover <guillem@hadrons.org> writes:

> Accidentally running «git clean -xdf» or «git clean -Xdf» might be
> catastrophic there.

So would accidentally running "rm -fr" there be catastrophic, too.
I doubt it would make much sense to file a feature request to Debian
or GNU/FSF to disable "rm -r" in certain directories.  I am not sure
why "git clean" should be any different.

Commands like "git clean" require "-f" before they become overly
destructuve for a reason.  clean.requireForce defaults to true for
the same reason.
