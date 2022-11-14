Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6EBC4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 23:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbiKNXSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 18:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiKNXSg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 18:18:36 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81357DD8
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 15:18:35 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id p141so9439900iod.6
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 15:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zT/3itYHi3JeXTkZFz6il0HG4xtBQmXi1gF+B88PKrI=;
        b=00jd2iuqG1cc1ksbPDFXYQe0c++0TugiNPrXOYVj+XGImbzz2826Z5QuUvwREd5S0k
         D7Uu50zeEkxn6tFFQkK4+xFRlfFqaaEV8bDujHpjqx263/hCB75FgkaOhsjy5SofDV1i
         /t/esHYACnpQLQVKwJITtfMx5w0wrAceTD8Nw7nlKG6o3ws/Wlw13kIjyARzc1F6iR7a
         ixLvmc2fnzc1MPnzfYm3ZJv3iPxkCIbFruChU7p6EpPXrjoDX2HWFkVVWOxHvktxKpff
         PlET1m75+oDlSM5qFEgV5dG/XkOpDtENWE5CtW7XsnlKJwFA0BWDtValGIhALy16ZJ0e
         TteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zT/3itYHi3JeXTkZFz6il0HG4xtBQmXi1gF+B88PKrI=;
        b=4xC0K4DSgnSUfhXD/Y47gRdL8wmQ/zltr0chY8UCc4ZET4/j4UWUKR8Dk/1KJHmqfx
         baL/8eu9W17OqYzWIOTzGYpdsd3V7sYIcOVvwIQf+0DGswDWHQ7j5Y1SSbsyTtBUrKuj
         DJpmrOpefYpTro/1wsaahc2M8zjV8G9yKr8351xR7l6UWh4dwFFTXK8H7SL3SMWOk4j0
         toy92Y/gN6gj1flNxgNnSuxYJThW6UMShvBhA4Ad5zTxUsyFIqTYyelg6Jb32fqzTLLf
         ignyAf6aOSztcn7de03YyKNmnhFfO2P9w2sQSVD3dbtCsFu8O0sQgztyd69hYViFlt8/
         dpsQ==
X-Gm-Message-State: ANoB5pkiVCzBI0FU88oZ4iKDotlKqzuheZlYbPBhdJDXWayAEUog4atu
        YocUZo5EHUyuDMfJygmT47zqpQ==
X-Google-Smtp-Source: AA0mqf5p5HeMgJ+x9EdLhGsjaJ1OWmoiTxAgfrITWkDUXp9JgHtNKFrPYiXSQUBHJyqjiSaEnkyBVA==
X-Received: by 2002:a02:ceb3:0:b0:374:fbbe:2da6 with SMTP id z19-20020a02ceb3000000b00374fbbe2da6mr6546976jaq.163.1668467914874;
        Mon, 14 Nov 2022 15:18:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z11-20020a05660217cb00b006bccaa66ee4sm4562975iox.40.2022.11.14.15.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:18:34 -0800 (PST)
Date:   Mon, 14 Nov 2022 18:18:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH] Docs: describe how a credential-generating helper works
Message-ID: <Y3LMybivz12lj9Gu@nand.local>
References: <pull.1379.git.git.1668217470500.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1379.git.git.1668217470500.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2022 at 01:44:30AM +0000, M Hickford via GitGitGadget wrote:
> From: M Hickford <mirth.hickford@gmail.com>
>
> Previously the docs only described storage helpers.
>
> A concrete example: Git Credential Manager can generate credentials
> for GitHub and GitLab via OAuth.
> https://github.com/GitCredentialManager/git-credential-manager

Thanks. I'm tagging Matthew Cheetham (cc'd) as a potential reviewer.

Thanks,
Taylor
