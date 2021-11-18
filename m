Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E22C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 08:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B84F61AA9
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 08:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243108AbhKRItV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 03:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243100AbhKRItO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 03:49:14 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15D2C061764
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 00:46:14 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id g18so5274549pfk.5
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 00:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8CSVWEFFmczN6qYH/Mj8S2+J/vbKwF6IxiFaee0QCCA=;
        b=PCqQVgWHdu5fqc2y+oPPg7+ZCYaTkKGkldxxMkDN8Tq2Orqi8ADjQscCFLGXihX6wI
         u63GnH0Ceh0Hc8vR4FG5EfpzJ+iaAaZlVwP50LzGFc698zVAnbFGkKPXaLLT6HHfz6mc
         uUmL9QrlpFH2skVh3p0uffy7IDLD13aKfrcjdMCiLhOKe6OfrUlXT2nF2H92nCboK/6D
         WoeUxBqEaOEe3JaNhiCye5PXCI0XQt4TcGlpNJw6NExaTEFqLgjROcaogcr1oPlUSkiX
         CW7cJi7TYraS+I7IlVPEVOkfHKOUkPMo1ymJwAv+VYhCpaFeI5GuQ1nVnznX1y/kCbOP
         v/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8CSVWEFFmczN6qYH/Mj8S2+J/vbKwF6IxiFaee0QCCA=;
        b=1LTUem7xPGAR6SJq4ylgsCTRJkGOF1HdsO1x06a91WCkdynPKB2pNY5rDGAHZ6MKgk
         3iuekEiwFUHzeOjbfGHp1egj6L1ZIcs3l1ntcg/fhAxMCNxcvXIahDd+nnddMMhXzFuH
         8kx6HGX/DsAj2/fSYZz6MD5aOAZta/GuHK2PY6Y0pMk8UM45zp5F1UVwIXvZY5bWkZVx
         5IyC/mR0Z7hLvM3PDgnSWfECjPAFEGRgy8FaAo+n3+H9aTpW6kqFNsVInNPBT5WzdJmt
         YvLb4dQPDm9yu+Mrj+9C3wqB3ovJXo+IoRCioMMBBvd6wk5bE0ZVmde9n0+42I01OxEr
         oHug==
X-Gm-Message-State: AOAM531Xw+vTljcRXO9O3C5ajwG/SpF7XOssn16jNcjdssg3lrabmLP0
        hT6BIEm4OC1CicSqPG+KXRfZiSabypRZlrZr
X-Google-Smtp-Source: ABdhPJzH4yv6WA6rX3rSiSPEqXHO44W18Vgscq6tsG4Np32rqBmzNPE6EMXJGVuPx7WYry/F6lfkEA==
X-Received: by 2002:a63:ff1d:: with SMTP id k29mr9819154pgi.372.1637225174107;
        Thu, 18 Nov 2021 00:46:14 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id t13sm2187116pfl.214.2021.11.18.00.46.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Nov 2021 00:46:13 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     congdanhqx@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH 2/3] t3104: add related tests for `--oid-only` option
Date:   Thu, 18 Nov 2021 16:45:57 +0800
Message-Id: <20211118084557.76846-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.12.g48302d14a8.dirty
In-Reply-To: <YZKCmPJzOwLeFhIJ@danh.dev>
References: <YZKCmPJzOwLeFhIJ@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


on Mon, 15 Nov 2021 22:54:00 +0700, Đoàn Trần Công Danh wrote:

Thanks for helping to review this patch.

> Failed with:
>
>         GIT_TEST_DEFAULT_HASH=sha256 ./t3104-ls-tree-oid.sh

You totally right and the tests should pass both sha1 and sha256.

> I think we can use:
>
>         git ls-tree $tree | awk '{print $3}' >expected
> ...
> ...
>
> Ditto for this test and below tests.

Yes, correct and better.

But should also escape the dollar character to work.

> The last redirection '>/dev/null' does nothing, me think.
> Style nit:
>
>	use '>expected' instead of '> expected'

Yeah, that's my bad and will fix.
