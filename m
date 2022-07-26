Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68F8C00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 19:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbiGZTnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 15:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiGZTnC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 15:43:02 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A144A1CFF5
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 12:43:01 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id ot17-20020a17090b3b5100b001f2c064b8b0so1048873pjb.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 12:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=unYdPuXlR6PGC6o+/npRmXOgC9u6Eq2km3ngwfkIh+g=;
        b=kHcKo6edCa83ceOjum033MAPVe1S03JeIwpFQiEmeedN3u+qD14afLBFLRQew/ys+a
         r4+RpCQpiAklXOCmtQ+FasgA2Y5HHT0nBqLHz8avEtI1kqHpw7U9zWJaTQD8M+goxl+p
         WcjjLD2V7UiG/7nF6yoOgFeZQY6UMvP/nlmeRoYI+HrN7BWSdeKQXaX9dh2RgrhV6L3B
         R+nssDknt918brxOmayAmh2PcWv4yBxaG1q0SbIeNdKapEsXKKdlKZPCoi8F0JenPdp0
         0OlJno1n0uMGRcLKcVdciGmr/rV0m0BbfVCmq99t4estP2b/Ay8zsDEd7sejUMsokpQq
         xNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=unYdPuXlR6PGC6o+/npRmXOgC9u6Eq2km3ngwfkIh+g=;
        b=OSrBJserEmBUS2nE/AMJZ+hx7Td482iKWMqM5eoyl7M3uBVADRDgczs5cn67qGe1BZ
         ULx1wDQcrXz7n/wM5zvLH9xinTQ9n+PXiuLVcMnK6iZL2p3S+xbzAKB1l/ztNdiM/nGH
         gNByyuZyTv75eW9tCiGtIoorfVzfDh7Kls2mNv0Ku1zPS1Ko75D2z1b6A4c5bteZUT3h
         ZOiVr6TZz9XlYkaLCW+hfiBnSOiSu/FGLp3SIoa6rLT8gNiHmO7XZg2AGZioYN18GnmT
         4FE6pAg+Oi0+A+cJzwi02Y2ICS8HMMvpmNBxo3LVPPbqjif3SIAh8PIFxrs2mTH/HQ/r
         slDw==
X-Gm-Message-State: AJIora/Mzp8dmUPLh6ImcaDuyGPB1EpUW7LZPS4JvrKvgUZv9RqOaUj/
        rHk46rDD2Lep8CvpPUCkEdkbc2Ey9I7U6g==
X-Google-Smtp-Source: AGRyM1tpW9BvFxzzRukGnewR8mur2ZUu8FT9sxrobxcCpSaAj92q7TRlzaJqii6A2et9VbicuwJp6LZ4YfrUkg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:179e:b0:518:9e1d:1cbd with SMTP
 id s30-20020a056a00179e00b005189e1d1cbdmr18754204pfg.12.1658864581186; Tue,
 26 Jul 2022 12:43:01 -0700 (PDT)
Date:   Tue, 26 Jul 2022 12:42:44 -0700
In-Reply-To: <47c0803c-bd98-0460-1e9f-c37dc3deeb8d@github.com>
Message-Id: <kl6lilnjslsb.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
 <YuAj+eBajf6jkJPc@nand.local> <kl6llesfsrgd.fsf@chooglen-macbookpro.roam.corp.google.com>
 <YuAn171BhecC1w+O@nand.local> <47c0803c-bd98-0460-1e9f-c37dc3deeb8d@github.com>
Subject: Re: [PATCH] config.c: NULL check when reading protected config
From:   Glen Choo <chooglen@google.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 7/26/2022 1:43 PM, Taylor Blau wrote:
>> On Tue, Jul 26, 2022 at 10:40:18AM -0700, Glen Choo wrote:
>>>> I wonder: should it become a BUG() to call git_configset_add_file() with
>>>> a NULL filename? That would have elevated the test failure outside of
>>>> just the ASAn builds, I'd think.
>>>>
>>>> There's certainty a risk of being too defensive, but elevating this
>>>> error beyond just the ASan builds indicates that this would be an
>>>> appropriate layer of defense IMHO.
>>>
>>> Hm, if we're going in this direction, what if we made it a BUG() to call
>>> fopen_or_warn() with a NULL filename? Then we wouldn't have to
>>> reimplement this BUG() check in all of its callers.
>> 
>> That may be too low-level of a place to put this check, but I don't have
>> a strong opinion about it either way (including whether we should have
>> such a BUG() *anywhere* in this series, including
>> git_configset_add_file()).
>
> Since git_configset_add_file() returns an 'int', could we return -1
> if the supplied 'filename' was null? (The correct place to check would
> be down in git_config_from_file_with_options().)
>
> It would save all these checks here.

Hm, IIUC you are suggesting that git_configset_add_file() returns -1
instead of BUG()-ing?

BUG() sounds better IMO, since there really is nothing useful that
git_configset_add_file() (and later functions) can do with a NULL file
name. Plus, git_configset_add_file() has already reserved -1 to mean
"a file was specified but could not be read".

>
> (Also: do we care that we are ignoring the return values in
> read_protected_config()?

I don't think we care (unless this is a style issue). "git config" 
succeeds even if it encounters non-repo files that can't be read. In a
similar vein, I don't think it matters for protected config if we can't
read one of the files (e.g. xdg_config) or even all of the files; all
that matters is that we've read everything that we can.

>
> Thanks,
> -Stolee
