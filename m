Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DDEC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 00:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EFA60EDF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 00:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhKBAS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 20:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBAS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 20:18:26 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03297C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 17:15:52 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id m5-20020a170902bb8500b0013a2b785187so6755649pls.11
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 17:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=jwe6MhHHlBt+h37EGKTzjAB1UfubzM511B1E5QH0gZ0=;
        b=HwafFx+b2kLlpC2Q8SOZyUN/v4xcum+lMPdnEZJ3hHAwaVaK4Cc70Sl6NzQdn6kT3M
         8zA6ZTm3Gzfc2xtY7SjMblMoUCvEIRmSsUgHQmr2OgTg17iRzeY8yg99eosdwajtTzbm
         /WTbNCGsyhK26aOaQwF1MqbyGnpZJxahKWVfItBzdxajucswpBgeyAsqhcqV1P1mW4d4
         XhvUr2ONaPcfAziIIZcEexf0EJroFIgyA9iurVwsZHnlEHgW+Py9NGnBifhOaEwvitQT
         u6fS5BBrYAJ2K2xuHDcI5BIyNTM2sv4w/1j1diah0yaJcOEHkgSZkjZnRMMVjqJRUUyU
         Kqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=jwe6MhHHlBt+h37EGKTzjAB1UfubzM511B1E5QH0gZ0=;
        b=Y3Ij0B38KTQ/rLCzr+ru31VbtLWKKotPnVcXyjg70yC5WK4Nk8AdAsKGBkBLA/bkEk
         A2XwccrZavTELUtDK3Nvd1hCGbHc1bUN+D3rt1Y2FMRCH+QS8oIkK7p5p+t/+KuOq4jo
         ZIVjGOefmVYZpN4tn3za+QNM2/wSQmwOKHskognWZy9pvcnlpQhUzEjAMDRoM81nN5n3
         XgvA3Q8mlCbQ5Vj6v0IbMY67l8lF1DqieO5+1/l3cBlxlrifGILB7/PJziw2NkZKbKGR
         iqXJyixp9LxZuYbs5zrlDEkXJs9jPbLEyuHkZnHmRzpgRKmcprwzAtoxmlsRMKva36ev
         ryQQ==
X-Gm-Message-State: AOAM531RSdZpzb93juE4zOkdedXHjMM9dRLh/PSanO8wmSPeis5pvUax
        aynWUmR3Wrk3HmKV6+SpvoPCXNBB1fjex6DK3nUDfHMNAjbYZuL0Ga2edScL3fV+ASYGmkAhD29
        QZwA0Q/inmLZtnMts6g+X1G8HwBnoYfFotLeZbnE3tn1zXtAtVCL5Eb8hHWqn5Oc=
X-Google-Smtp-Source: ABdhPJyXl4v6Iqyfz/3BkKUU9NgfsfNqyInsp/Cdevcmu45bHdB+NHWKNKmxAjUZU/Z+YKezRkEvzBk20IuesQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:31c5:0:b0:447:cd37:61f8 with SMTP id
 x188-20020a6231c5000000b00447cd3761f8mr32711961pfx.29.1635812152073; Mon, 01
 Nov 2021 17:15:52 -0700 (PDT)
Date:   Mon, 01 Nov 2021 17:15:48 -0700
In-Reply-To: <24bffdab139435173712101aaf72f7277298c99d.1632497954.git.gitgitgadget@gmail.com>
Message-Id: <kl6lzgqnv2dn.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Subject: Re: [PATCH v4 04/13] dir: fix pattern matching on dirs
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>, <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This patch changes the behavior of .gitignore such that directories are
now matched by prefix instead of matching exactly.

The failure that we observed is something like the following:

In "a/.gitignore", we have the pattern "git/". We should expect that
"a/git/foo" to be ignored because "git/" should be matched exactly.
However, "a/git-foo/bar" is also ignored because "git-foo" matches the
prefix.

I'll prepare a test case for this as soon as I figure out how to write
it..
