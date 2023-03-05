Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FABC678DB
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 12:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCEMWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 07:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCEMWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 07:22:09 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727D5FF10
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 04:22:06 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id k14so9242353lfj.7
        for <git@vger.kernel.org>; Sun, 05 Mar 2023 04:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5a0kTlYGWUWFHV12Ul5krMdZs8sp6eu9SPx0VQ0dWyE=;
        b=lefe8kJPD/vEmptWl6M9c4cwpwU0vj4awaoNMceqjl4Cr3P4HY8Fu+GJp8r8i3040G
         k4ZYHipFowj88UTbrYOVayiLAWDhckLsvbWGxZqMC6e7+rUnGOaNolqYbwmLS7aYH+6y
         wXXmXlZNYh9fzGWLyn54d4ydo6rfk+Z1AlFrsIrxH7TlC3jzmts2vJ9+UydfHMfr2jHy
         StQglyCQgivnwfxp8qBD+re9NNFRHeZLNc8dFFnJK1t2nr4Ug1kRhTzyqLC8cPqpWhUD
         meLmlY6qr0OF00NrePkgM7cQbGWtJE6MX0DmRNDcPyPFt4G9NgCw+Qte9w5LwNyiThmF
         1zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5a0kTlYGWUWFHV12Ul5krMdZs8sp6eu9SPx0VQ0dWyE=;
        b=iwiTqf+9moUpo/ouuVPoNJ7TF5F9zsowlqYpaJ7vs9LCm+++FOPPytG/Ub0PkMYRnz
         8EJhkjwQ9YxzL2C4/3o5NrWeSG4hyajTogRqLmSYBLyx0nJ1YqxjM7pch3GFyY63VhCO
         L2qF0AJvcgI1JeD/kEi+k5vAYUnzdDr1zge9Fzw5uNjvzLbaAdmJB2jLArah8p5g48hS
         61u3PAacwQeVr8H06HxEe8+MZLmdaZa6OmrOczdocV94NJy1MB8PdBY9syAkeczo+oZN
         4tTZrn4nXjWJKQqAKCPTXXfhrRqOcmv2AjFEFZRltUtiRr26tFuSjOeMYg2Iw/ncQH1k
         0MCQ==
X-Gm-Message-State: AO0yUKUhmEP/QWnxU+n6LpZanvXTZWUfg18yyZp9/7ieNzndzbvxd+1g
        C4+0VqZiPwpjwzqfcwuP0MQ=
X-Google-Smtp-Source: AK7set9giFe40+wHHDsEc0nkaj9cfRKEUWXXPUa4Jo4J4pwU8Zzw3wTlNPejrS2RoRiyyc/WdY0FYQ==
X-Received: by 2002:ac2:5211:0:b0:4db:19fb:6a7 with SMTP id a17-20020ac25211000000b004db19fb06a7mr2060022lfl.60.1678018924526;
        Sun, 05 Mar 2023 04:22:04 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y9-20020a197509000000b004db0a7ce483sm1176137lfe.162.2023.03.05.04.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:22:03 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, chooglen@google.com,
        calvinwan@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 0/3] rebase: document, clean up, and introduce a
 config option for --rebase-merges
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
        <20230305050709.68736-1-alexhenrie24@gmail.com>
Date:   Sun, 05 Mar 2023 15:22:02 +0300
In-Reply-To: <20230305050709.68736-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Sat, 4 Mar 2023 22:07:06 -0700")
Message-ID: <87ilff2xsl.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

[...]

> - Rephrase the warning about --rebase-merges="" to recommend
>   --rebase-merges without an argument instead, and clarify that that
>   will do the same thing

Not a strong objection to the series as they are, but, provided options
with optional arguments are considered to be a bad practice in general
(unless something had recently changed), I'd like to vote for adding:

  --rebase-merges=on (≡ --reabase-merges="")

and for suggesting to use that one instead of --rebase-merges="" rather
than naked --rebase-merges.

It'd be best to actually fix --rebase-merges to always have an argument,
the more so as we have '-r' shortcut, but as this is unlikely to fly due
to backward compatibility considerations, this way we would at least
avoid promoting bad practices further.

If accepted, please consider to introduce

  --rebase-merges=off (≡ --no-rebase-merges)

as well for completeness.

BTW, that's how we settled upon in the implementation of --diff-merges,
so these two will then be mutually consistent.

Thanks,
-- Sergey Organov
