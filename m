Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D33C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbiCXQEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbiCXQEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:04:05 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EEB14000
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:02:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 125so5869601iov.10
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xLbJFR37MgG/F9TdI0Na7VSc7VFAXu9bGpQRqu6Zbk4=;
        b=dcwaeCwclb7sjNUzObahcicnrLWy/JHIPRoMuoCh4PdgBGjIJ07XdR1Uh5lH7FfKzT
         mRL7MP1/MjI6TSm7IfdGQ1mPW05M+jmJg9P/zStjVKciVISdcFcZj3NRSJpOdE8NOLoc
         8uNuiAbjCaxINFsKJxRakINMJuqI+Z4rY/Rtj1vfrQyOmx5vbl7F0lN5fgulbn01Ton4
         DLmxgXUcCHmTL2a8sCD+26drW3jeG2FTxpyTvOwzaH7MpQGf8gZo0G0FmVCHbzoYP0Us
         aDIYp+eGoJ4SjVQtxFY7HaUAGLF1/S1JvOAlEPQnCGj0iiCw7J0ziRrY/EaIYZaz4zLb
         Movw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xLbJFR37MgG/F9TdI0Na7VSc7VFAXu9bGpQRqu6Zbk4=;
        b=jMTp6MiTlAblI26VNuhb9iQ12xVbvjHxINPLDEK8D63WnoGDSlNfV1UGtD7OeDViRD
         4spToYbfGfVZ0U12hS7R4dVYZAs1yUWrfP7zGrd/Cbq+e5vFqFMnIKpmcME4BiBUqdVy
         0skiy//u8xCFyj/qWb0uzy1iB9zIg46UjY4/AE+n9ZusD1Ms5Z4QbhmU2bCplfDMET4I
         A9fWJjI1zfbdGhQNveMFuvv5LsX7udhj/6/pei5VTUKrxWHp9s+c85O55FC+8RxwiHF2
         D/sHIJXEK6E3+uZ1i2H5/1jr0Aii2dJ6oFonuWjRJpi5N0yviWLii66jPHnpIW1XckWC
         +HJw==
X-Gm-Message-State: AOAM532GELWfm9Znpsb1A4QE0P26LOsAi9r6zU5x/JUZ+kicTgIvaX32
        jyHhWXMfUsFQOH2F82/qoWxDVMSglxW2BddF
X-Google-Smtp-Source: ABdhPJzgSNooSHbvvEGDhudwqevmst2PGw6nmWcFqw1WH4TUENJdDG743E/337DdDXvbWbVvqEytJA==
X-Received: by 2002:a05:6638:1351:b0:31a:299b:6d87 with SMTP id u17-20020a056638135100b0031a299b6d87mr3449677jad.22.1648137751820;
        Thu, 24 Mar 2022 09:02:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o15-20020a6bcf0f000000b00649c4056879sm1582677ioa.50.2022.03.24.09.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:02:31 -0700 (PDT)
Date:   Thu, 24 Mar 2022 12:02:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, chakrabortyabhradeep79@gmail.com
Subject: Re: [PATCH] test-lib-functions: fix test_subcommand_inexact
Message-ID: <YjyWFqjkaGpC8NxQ@nand.local>
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
 <540936ba-7287-77fa-9cee-e257ed3c119d@github.com>
 <xmqqmthgu3e6.fsf@gitster.g>
 <e5331972-512a-c498-6a1b-927f21ef9de2@github.com>
 <YjuVAgjaiqrcT7P1@nand.local>
 <xmqqfsn8p8nr.fsf@gitster.g>
 <72c54461-8af7-29fc-04da-f435adee9bbe@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72c54461-8af7-29fc-04da-f435adee9bbe@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 11:42:44AM -0400, Derrick Stolee wrote:
> As I'm looking at Taylor's test case example, the one thing I notice
> is that there is only one pack-file before the repack. It would be
> good to have a non-kept packfile get repacked in the process, not
> just the loose objects added by the test_commit. I'll take a look at
> what can be done here.

I think you are too good at nerd-sniping me ;-). Here's a more robust
test, that I think reads a little cleaner than the previous round. Let
me know what you think:

--- 8< ---

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 5922fb5bdd..1ed9a98a36 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -369,10 +369,36 @@ test_expect_success '--write-midx with preferred bitmap tips' '
 	)
 '

+packdir=$objdir/pack
+
 test_expect_success '--write-midx -b packs non-kept objects' '
-	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
-		git repack --write-midx -a -b &&
-	test_subcommand_inexact git pack-objects --honor-pack-keep <trace.txt
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit kept &&
+		git repack -ad &&
+
+		>$packdir/$(basename $packdir/pack-*.pack .pack).keep &&
+
+		test_commit unkept &&
+		git repack -d &&
+
+		test_commit new &&
+
+		find $packdir -type f -name "pack-*.idx" | sort >before &&
+		git repack --write-midx -a -b -d &&
+		find $packdir -type f -name "pack-*.idx" | sort >after &&
+
+		git rev-list --objects --no-object-names kept.. >expect.raw &&
+		sort expect.raw >expect &&
+
+		git show-index <$(comm -13 before after) >actual.raw &&
+		cut -d" " -f2 actual.raw >actual &&
+
+		test_cmp expect actual
+	)
 '

 test_expect_success TTY '--quiet disables progress' '

--- >8 ---

Thanks,
Taylor
