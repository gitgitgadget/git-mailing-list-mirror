Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA475EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 22:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjFPW25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 18:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFPW24 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 18:28:56 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E132D2D6B
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:28:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53450fa3a18so919836a12.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686954535; x=1689546535;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDLEbVVtMXkYbkQPEW/sfHVpS8Ia6FdECSx1hMtzzJ4=;
        b=1N2WliUzuKJm/+Gb1zRXgpnArexgL5Is4ycFmK7IdNT2iV1XoReD3D5HAnRR95xbBA
         aPMG6PB+0sUCb0FX6xtwzl/fv3CnnexlKEM8eHIwWUCuqAqOlLMcIA00BosgHa4Cqxzq
         3S74kmJKWySlLI9jSgxSHz0TpSG5/8gnp3F4i3r8mZi8Ce+51k1GZ8mdDAoe8gNOoR41
         pt13RAyCKB0Z8CEyx5uAf/3rWFAfabd/QTSzd4cSCW5tiTWB4aiHEiS/91l0L8TVnX3Z
         UKgU/JbL0WzgIRK9aSwvIiv2f+8CyZhu4EL0kWLWqUC/MNgbttdo4iVUXWJ22czyfYlj
         hDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686954535; x=1689546535;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDLEbVVtMXkYbkQPEW/sfHVpS8Ia6FdECSx1hMtzzJ4=;
        b=X3D+dSO3xqIqQmSn8f5LTCT0XYx98NzxG8Pn5NAFubiEV28SuAIinqJg6WEmY4aNPk
         0WRkRa7WPvLUyNzJ1qjE9H9jM8FN8zIEQw7IYsBKQCQjMNRgJ/emfGbS/GbmUV5bG2o3
         zHABBkFvAIf51P5H1phkH65lBboVvfXbTufWeTBBHBErW6BN1dwEVUMCk0l6u/fyuPVv
         oojOVvnz75DZGhd80tzN0W4+qBDEvVtotPDUPOMe9+355T4uOBf+mEqfHOa1XduxB5pr
         Ybt/4aV3wxVQ8a0Lh+JLZKtt4SZkOlukYuf5RofUEvJFADtn6n+fqAEmlSXkdts0+SjU
         sD6A==
X-Gm-Message-State: AC+VfDx7KUV2l8nFeCziz23L6UZBzcGMXGVb5AzWkPNwyoNnSbh0/RTc
        7We83VjRO5d+767mQ4oO2tVQ5ySxkpk=
X-Google-Smtp-Source: ACHHUZ6oKM239TUQMZSQyS5viplSxsAE0PU7cPX22Pfq1VBiAApvf73qC0XsbG12fSvi06jOJmECqIwJN+s=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:104b:0:b0:54f:fcfe:5727 with SMTP id
 11-20020a63104b000000b0054ffcfe5727mr74194pgq.2.1686954535187; Fri, 16 Jun
 2023 15:28:55 -0700 (PDT)
Date:   Fri, 16 Jun 2023 15:28:53 -0700
In-Reply-To: <20230616042407.GA54009@coredump.intra.peff.net>
Mime-Version: 1.0
References: <PH7PR07MB9467452EBAFAB2C825295C0C8C5BA@PH7PR07MB9467.namprd07.prod.outlook.com>
 <42e4373e-b700-45a6-99cc-db2f8896d5b7@app.fastmail.com> <20230616042407.GA54009@coredump.intra.peff.net>
Message-ID: <owlyzg4z59ei.fsf@fine.c.googlers.com>
Subject: Re: Possible bug regarding trailers
From:   Linus Arver <linusa@google.com>
To:     Jeff King <peff@peff.net>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        "eric.frederich@siemens.com" <eric.frederich@siemens.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Peff,

Jeff King <peff@peff.net> writes:

> So I think the only bug is that "commit --trailer" should not respect
> the divider. And the fix presumably:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index e67c4be221..9f4448f6b9 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1043,7 +1043,8 @@ static int prepare_to_commit(const char  
> *index_file, const char *prefix,
>   		struct child_process run_trailer = CHILD_PROCESS_INIT;

>   		strvec_pushl(&run_trailer.args, "interpret-trailers",
> -			     "--in-place", git_path_commit_editmsg(), NULL);
> +			     "--in-place", "--no-divider",
> +			     git_path_commit_editmsg(), NULL);
>   		strvec_pushv(&run_trailer.args, trailer_args.v);
>   		run_trailer.git_cmd = 1;
>   		if (run_command(&run_trailer))

> I cannot think of a reason we wouldn't want to do that (though obviously
> it would need a test to become a patch).

I would like to work on this patch. I should be able to push something
up in a couple weeks.
