Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D622AC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 12:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiLOMsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 07:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLOMsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 07:48:16 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA682CD
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 04:48:14 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so2568305pjm.2
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 04:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxJxrD7OMmlz85RmXown415Y+eYv250AFpJSAOmbGEs=;
        b=lDwVFhmU7fXERrBihb6GS/S/hQyGu42hrKosQebsgNPHJv3BZDIE9YukLjshfb8TS8
         F1bzwlq/psky0yPmZLvwFJxq/BIhv7VrXeIemBTNaHK6vJFV+AT9NXl29ipjUj61u18/
         n84H/BprrFccBgSSqh6E9yl5ZoEmO4bAd5y6/1NNhJ8glmVzozuBCLlh/jrtM2Nf+gdO
         pw26w3r4m9c510qyH62rvlEB/Em4fiJCvCVoUMi6kJx9tdFeMyArupSHztCpPypmv5Ms
         k3py7Q1ITBKlXYUqN02xWBBZvkgz23VXvwdTbkz3sAvW4LFOnFtnhLZYm4uT1CFHmzFJ
         PrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxJxrD7OMmlz85RmXown415Y+eYv250AFpJSAOmbGEs=;
        b=AaIUa+asVKCcQrlFBjPlCL4cVTDr34EWUrCVgb7pagkYvDnM/A61a6PuQzF0kJzDyM
         lphxL/bxssXnYIjCMHPcocJeoFUnkpxfhgbCiZ9VxqQbplx4rUpiY1anKzLE8lo0SASh
         9l7WtqmPMtmOCr9u8DEDGVSIsimts2jX9pyHjw/7sD4eJ7vtKpYQKg0x344aQfRfIamv
         +q6oIBU+/xxPwI23b/Ry0N3YKWkkw80O4BZEgFnSv7SKgmA59FSf3SSvW+AnCDxBDC4q
         pyBIWbStIHt2HEztKbzbZ6Qgg7ydjbrZbp6xdA7+MwV0SePEqoH44j3uo/D2od9H2fsH
         S1hQ==
X-Gm-Message-State: AFqh2krWQpS8CUCjJW3iTCiYxh1zI/9Wrh4Qvfgnq2oWzA39+luQ67YO
        EoUmdxQi9i+qCeQKk/sPCvlJM8d/wquSLpxU
X-Google-Smtp-Source: AMrXdXt5avnWDUzvv0ZcH1ZitmhNgBb4US/ehHkJ73hGTVDaW9LcFX5i/07cNSUUhMiD02W3MJDD3w==
X-Received: by 2002:a05:6a20:9b85:b0:af:8e92:8540 with SMTP id mr5-20020a056a209b8500b000af8e928540mr3093316pzb.1.1671108494277;
        Thu, 15 Dec 2022 04:48:14 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.63])
        by smtp.gmail.com with ESMTPSA id p15-20020a654bcf000000b00478fd9bb6c7sm1486948pgr.75.2022.12.15.04.48.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2022 04:48:13 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/5] notes.c: introduce "--no-blank-line" option
Date:   Thu, 15 Dec 2022 20:48:07 +0800
Message-Id: <20221215124807.12730-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.rc1.5.gad6de9d3003.dirty
In-Reply-To: <xmqqh6yh3nk4.fsf@gitster.g>
References: <xmqqh6yh3nk4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> but the point is "blank-line" or "newline" does not say which
> newline in the resulting notes object you are mucking with.  It is
> not like in this example:
>
>  $ git notes add -m "title of the note"
>  $ git notes append --no-blank-line -m "body of the note
>
>  that span multiple
>
>  lines" HEAD
>
> you are removving the blank lines embedded in the body of the
> message, but from the option name, it is hard to guess that.

Fine, I see. Maybe "insert-starting-newline" or "insert-initial-newline". If we
could not find a suitable naming for this, it's ok for me to hang up [5/5] (a
little struggle for me to find a better name for this now in fact (⊙ˍ⊙).),
because except it, the [4/5] still an active bugfix in my opinion.

Thanks.
