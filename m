Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D2C10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 19:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0432072C
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 19:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmkN8I9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCRT13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:27:29 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:52775 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgCRT13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 15:27:29 -0400
Received: by mail-pj1-f52.google.com with SMTP id ng8so1771046pjb.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 12:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0o3CqnO29dcLX2+PONS6dPFzrPynwonqrYPYZIDYsdo=;
        b=VmkN8I9c1ig16H1VRol4zhX+bS/axSNitNbtpewv2AmZiT6WJ2mgup5Fdnn4lXpq5+
         SvtZOMTYRlgP160PCniQVY4hTdGFHmCn+er5eiyOBJGzUadNaOxrcMXYNR/TMXqAXeVj
         MK4l62WfttFntsPjDMya/spmWzC7DPXsEQqAhT+SyvhIbALtOqSgkliChl7/92LaICSp
         JGMTpLt2A/cRpssT7AhSACSJFLG3bSvLEO+j7Suv8KACsyox8fYM6PP/aT8xipa4SFob
         6ENv+oCIrf596h78nlzSN495AMfXlUFYIUSfSTOnef7L3xjuNCwXze8uKoJm7QunRHWC
         Qwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0o3CqnO29dcLX2+PONS6dPFzrPynwonqrYPYZIDYsdo=;
        b=Tic5mNU0m1ZSC0HXvAFIncLnaTBhofbfO4SysCLt3V565HvjhJpSUtwVuS7YsinGsN
         /hzx3UW1SQXD5bOIuEYnQICwBW0uiAXr180fnmGxRiGNd4j/p/lzG1D45WvIDBQwetWP
         XNvByo/pCaD08W1/TeI2Rsou9lqSZQnsKw2qcE6Ir/GNxhnmWQWaNjui/Hu4zTx5nurr
         r4NjrTEGqUf08mBarbXGXj1CScis09c6pGvRVBoYnIaQFK8Iz7af2FegEczWBcFGbevu
         9IpnKKMCnlArNXdUBFoyQK/GKQB4qdA2g6s59NAS38etPbRQ7YtHP/4mr5br8tafx1mf
         qRpQ==
X-Gm-Message-State: ANhLgQ1b+crCFZnl+FNrwDLpLbozLdDCxHSQ5YX4x+Uqq9gEMY5aK46z
        WoHF8LqTUeBkvcDhQ4SrzdE=
X-Google-Smtp-Source: ADFU+vsA/Zrkfg7AdGXLPFtTfrXceAWWvriZUo08FiBd6ZP/Y5dCudES4WoBi+ec3ZK8p+1PyI7D/w==
X-Received: by 2002:a17:90a:202f:: with SMTP id n44mr6143805pjc.150.1584559647824;
        Wed, 18 Mar 2020 12:27:27 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id y15sm7476467pfc.206.2020.03.18.12.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 12:27:26 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     harshitjain1371999@gmail.com
Cc:     git@vger.kernel.org, Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re:[GSoC] Microproject for git
Date:   Thu, 19 Mar 2020 00:57:19 +0530
Message-Id: <20200318192719.1127-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CACuU+s9BsWVCMXpp6KgJ-NaDuadcegZ2kVSMmuAYO9YquTK8LA@mail.gmail.com>
References: <CACuU+s9BsWVCMXpp6KgJ-NaDuadcegZ2kVSMmuAYO9YquTK8LA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Harshit,

> I found a few test scripts where the 'test -f' can potentially be replaced by 'test_path_is_file'
> function.

That's nice!

> I changed one test script and it works fine. So, should I
> just commit this change now (the change looks very trivial to me) and
> if not, how to proceed from here?

Make sure to execute a 'make' in the working directory so that your changes
_actually_ have some effect. Running a changed test without 'make' is
basically running the old test all over again.

You could also maybe do some code modernizations. What I did as my microproject
might be of some help:

https://lore.kernel.org/git/20200118083326.9643-1-shouryashukla.oo@gmail.com/

Also, make sure the commit message is descriptive and does not contain any
extra whitespaces. I think you must know by now that we submit patches here
via the mailing list and not pull requests.

Regards,
Shourya Shukla
