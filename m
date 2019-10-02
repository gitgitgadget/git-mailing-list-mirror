Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B8F51F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 18:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfJBSpu (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 14:45:50 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:33703 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBSpu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 14:45:50 -0400
Received: by mail-pl1-f172.google.com with SMTP id d22so172460pls.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cmMMn/3klfk+RgGsn1dd5JJF4Uiv4e2SBfxLlIxjO6o=;
        b=Qupw/GQukBp5FTkrJP1K5ek1aIKt8mDiAhOnNePL/gFREPpz1/WrJbKAgtpej93vob
         3s8HvlGx7kpPLVh7botTpFLH5DTd/EAqpEuGSNxdaXSQrG6t5jmLT23xlLG4RDhnZ89l
         z/R+aVw4LaCedTnBUKNFByzs2cET6v7ryc2jUlipdDEnSVEAnGrNkKRdQbhuFKF+4CSV
         C8YEilGDF0p8MPW1ttV27TReGq/CJUm52ke8xCUGgHqj3eoy/e74cgE8vG4RJu+VTA8n
         F+XUj+G0SpUB2uwUU2//8ipxUUFzBxXhOPp9nXt/m73fFmi5fZ/j3Fg/E3b8JDeX/6RL
         6aMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cmMMn/3klfk+RgGsn1dd5JJF4Uiv4e2SBfxLlIxjO6o=;
        b=k+SoTxGFAYy2jBQVWQaWP+pNCtLEfffL8W2VOrd89Y46rQrb/ClCmZLRknWI2rG4u6
         N42BcaPK34dNqp212vGt/bE8fXnIOiy3PWBob42/IolxB6Pp9eiL/8Q7by/okH65zgsB
         HRigcVHqagtiLlnyKm23fzEWkLohd1RL8xRbH7CMOWuIWQ8IDxl3gKmNmrXKaIPDFXOh
         0ngO4vgFm6creDmsgNPhYkpdS2/dZm37OLjgfnj06knnA5DZPtDvgPTHnIFbnDbjJOOe
         xiJcf8liNgZkrOvEBPZB//X9BNmQVb2C3jk1L+0sslILE4UW5+QTI3liMBmCXAQOTF5v
         pvsA==
X-Gm-Message-State: APjAAAVbMgJ0dUIymzk9/bf/SvBkD+zdtIaasGxX6my+DvAKvyfhA0m6
        iTKylq7PD/tjJxuv1WpET3PprFIp
X-Google-Smtp-Source: APXvYqy7eDI75UQ2SacteHYLBGO2WJUGmI96PBw2OPGzSegZxY9elRoJGyv1BE1QklLERYc5KPYnlA==
X-Received: by 2002:a17:902:d70b:: with SMTP id w11mr5380251ply.146.1570041948790;
        Wed, 02 Oct 2019 11:45:48 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id k66sm14213pjb.11.2019.10.02.11.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 11:45:47 -0700 (PDT)
Date:   Wed, 2 Oct 2019 11:45:46 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [BUG] incorrect line numbers reported in git am
Message-ID: <20191002184546.GA22174@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I found a bug where the line numbers in git am are being reported
incorrectly in the case where a patch fails to apply cleanly.

The test case for this is pretty simple:

	$ wget https://public-inbox.org/git/20191001185524.18772-1-newren@gmail.com/raw
	$ git am raw

And the output for this is:

	Applying: dir: special case check for the possibility that pathspec is NULL
	error: corrupt patch at line 87
	Patch failed at 0001 dir: special case check for the possibility that pathspec is NULL
	hint: Use 'git am --show-current-patch' to see the failed patch
	When you have resolved this problem, run "git am --continue".
	If you prefer to skip this patch, run "git am --skip" instead.
	To restore the original branch and stop patching, run "git am --abort".

In this case, the path is indeed corrupt. The final hunk header gives 25
lines after instead of 24 lines. As a result, it is erroring out
correctly.

However, the line offsets are off. Line 87, as it reports, is the
following:

	to avoid a segfault.

which is in the middle of the log message. I expect the line to be
reported as something in the range of 198-203, where the end of the hunk
actually is.

Indeed, if you take an 87 line offset from the cutoff "---", we can see
that it gives us line 201, which appears at the end of the corrupt hunk.

So it appears that the bug is a result of the the apply process not
taking into account the number of lines from the mail parsing step.

Thanks,

Denton
