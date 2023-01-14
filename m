Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8078DC46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 16:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjANQJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 11:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjANQJC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 11:09:02 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB982902E
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:09:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o18so4097042pji.1
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+s+AlBwtJF5MgsO7hYfAbvs+tMHr/uvRBmGfcygeRaw=;
        b=aWkXyOvFd8DWMtAtOtZjTFNvsdfALOzQYQ2UnqoEZ44jxjbj+VydMdVguCpOQLTPaN
         Z48iaK2H58kmOZuPJsSKyqu8JZv30nND8ObcjLFWGYCeqCFs5e/kKQCMvmiaHxOPtN3H
         /TVuP5CuaPSDcj9p0G8hhu9qm7AD3xo+yF4yp4iOu+Ry9pwdlYPwPmbRdKuheS5saMt/
         IQRx04IvK7VSm4ig82W3VwrKrMFs7BYuBRbuOTgnXQXyEAWPJmDeqQjKXRyvAc6V1O3a
         OXA+g+Qzg8q23HBSsMKj6aNj4Mxv7GX0RfXD7nObOhy60BfGfrRgGUFI+NR9YeXM7Nx8
         hsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+s+AlBwtJF5MgsO7hYfAbvs+tMHr/uvRBmGfcygeRaw=;
        b=nYOBsJlEekMOER4pivc+VqdJWqu7+orDaMdtxNR4zZBLYPTb6/COjUSEVPRJsq7aEg
         lebhunt1tntn5ql7vIDGje5WKhpUB+4UhkqjqKa84Bkfuj5fIjAyaVvceCxYpWSUg3DK
         PJ8bXUnKKHzyDHWkRFpaMtm5gABHOD8cj0nRArtZfz1XBZcL4FQe1ETjJruSuyNnI3At
         410VVBCvJ1JiVt0cNZNVZD8n15bqAWq+orMN+cearTl8dhfJbOn44DLA8a9zVSOB6pwJ
         SJ5Xyf1b3as2JkmrNen5QUtAJt3HkYbEfjKldClkyCijioBhCYPNG9irIu7iTJ4Rcq4a
         qzgA==
X-Gm-Message-State: AFqh2kqsSQJDZA9TTJpy1pnS/woC8RD8SELGT13E+Ezaz1j9XAUeE2jA
        cEyQUucQgGHRI/BZ5VS5QSM=
X-Google-Smtp-Source: AMrXdXtCVfryLRM5q8LolqatTzvKnt4AhFAJk4Wh0duT5NNAzeo+iAIacMSo6xRMZ7eivniZcEghLw==
X-Received: by 2002:a17:902:7610:b0:192:751d:b2e4 with SMTP id k16-20020a170902761000b00192751db2e4mr62282781pll.48.1673712540085;
        Sat, 14 Jan 2023 08:09:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id r2-20020aa79882000000b0057447bb0ddcsm15356306pfl.49.2023.01.14.08.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 08:08:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Diomidis Spinellis <dds@aueb.gr>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org
Subject: Re: BUG: git grep behave oddly with alternatives
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
        <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
        <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
        <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
        <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
        <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
        <Y7flVcALZQgz0VPl@coredump.intra.peff.net>
        <26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de>
        <Y78GXZvyrOrXhe7n@coredump.intra.peff.net>
        <4165031d-e7f1-0477-2245-6a8e312de522@web.de>
        <Y8CBrtmL45tA/N8z@coredump.intra.peff.net>
        <230113.86ilhazved.gmgdl@evledraar.gmail.com>
        <xmqq5yda5p4l.fsf@gitster.g>
        <0e25e6b0-2eb8-40ee-7999-f2863a545a15@web.de>
        <b2e597aa-044d-e136-43b9-afc84a1e3794@web.de>
        <ab50c16f-dbb0-0661-4d08-fa150d31f88b@aueb.gr>
Date:   Sat, 14 Jan 2023 08:08:59 -0800
In-Reply-To: <ab50c16f-dbb0-0661-4d08-fa150d31f88b@aueb.gr> (Diomidis
        Spinellis's message of "Sat, 14 Jan 2023 14:45:54 +0200")
Message-ID: <xmqq5yd9m738.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diomidis Spinellis <dds@aueb.gr> writes:

> Indeed, I removed the alternation handling functionality by accident.
> I was not aware of the BRE-handling difference between the GNU and the
> macOS native regex library.  I think having git-grep behave the same
> as grep(1) on each platform is consistent with the principle of least
> astonishment (POLA).  This would mean that on macOS plain git-grep
> should use enhanced basic REs as proposed in René's patch.

Thanks.  I am fine with what René's patch does, which we already
queued, then ;-)

Let's merge 54463d32 (use enhanced basic regular expressions on
macOS, 2023-01-08) down to 'next'.
