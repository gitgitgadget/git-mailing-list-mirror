Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF2C920281
	for <e@80x24.org>; Sat, 16 Sep 2017 06:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbdIPGWR (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 02:22:17 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35010 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdIPGWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 02:22:16 -0400
Received: by mail-it0-f68.google.com with SMTP id u2so2621043itb.2
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 23:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=NHU1GYmBvbQeP9SFbtPy6ygDXsMgr6hCzV86BjIYGHw=;
        b=fnC1nwzsUllew3ZRb0porSrCvDDdufFdswuS/1tOvg4W1T8Ygw2UFrZmumptnnrqx6
         qBZCxdeVV9Hi165Khr3s/uFFzaf4UVIgA4KdEa5dLFLJVEO3Ie52pqKbnJvmpgXGnNYB
         wJmKSwG2ljZFM2nsNW8qo+ihDsLWzhFp5X0ebVx3vs/gO5RLHxpv+6E9JbQ1+B7Ll0cB
         Bfxo5gN/TMig5LiLtjJuK6fgsbxc0XnDZHg0L5FsvADp8v2HTpNpe3a3CeOiXsTWtRnL
         qOF5jQjq0ApJa0+XpurhRZZJPJxxaroXj+k1K01wN0J1N9dIWWuhoacLnwEzo4VYxdwr
         6wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=NHU1GYmBvbQeP9SFbtPy6ygDXsMgr6hCzV86BjIYGHw=;
        b=AXpP95ov8wfkdWRI5pC98JQGia4pcQj2BQAMkjuduWto+6wEfhcp3COsxOdvVmbbYG
         tgzYSLg5cDhU7q2LVoGeu8vyEdIMyz0OmA+y7+A4h+/wD3fqKc942C/Ozmx9kI8/d2bE
         0FoeLO3K4BRlJBVZ4r9crsyyt5bsxVdPiN3E0X8bxbtFY6Qe9KxcC/rR60r5MJA7u5F8
         5pMWA4xAloOStxjllI/7XyZOlgKLxZCOqfcRs/L9OfdmlLYyGF0AzJ8vfYm45WfasMvN
         eLF0zZX9G7qnvlWcUzkvg0umCF97A2urMeo0Hx20VY8j6O3k32RBFiFIDw5lOjEp51/r
         0Zyg==
X-Gm-Message-State: AHPjjUgIiAtwPYf1w96IooncRpqmAnuEQpbAqvW+bcwHQ1d8l53QfOkn
        fJrfE7CGaRub+A==
X-Google-Smtp-Source: AOwi7QC04B1WanNc4oppMPqIzZEuhWgRSvHVw9ik7GWEpQ5QXSTY0mqbhriGaXrw/wFs2394dOrSdw==
X-Received: by 10.36.81.208 with SMTP id s199mr9196449ita.31.1505542936233;
        Fri, 15 Sep 2017 23:22:16 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.googlemail.com with ESMTPSA id d142sm1370009iod.20.2017.09.15.23.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Sep 2017 23:22:15 -0700 (PDT)
Message-ID: <1505542931.27598.4.camel@gmail.com>
Subject: Re: [PATCHv3] builtin/merge: honor commit-msg hook for merges
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com
Cc:     git@vger.kernel.org
In-Reply-To: <20170907220429.31312-1-sbeller@google.com>
References: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com>
         <20170907220429.31312-1-sbeller@google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 16 Sep 2017 11:52:11 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seems 'Documentation/githooks.txt' needs an update related to this
change. Previously it said(note the **s) that 'commit-msg' is invoked
only by 'git commit',

    commit-msg
           This hook is invoked by git commit**, and can be bypassed with the
           --no-verify option. It takes a single parameter, the name of the file
           that holds the proposed commit log message. Exiting with a non-zero
           status causes the git commit** to abort.

---
Kaartic
