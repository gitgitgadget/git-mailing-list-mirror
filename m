Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976F0C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 07:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDBC2071E
	for <git@archiver.kernel.org>; Sat,  2 May 2020 07:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sis0fADY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEBH5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 03:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726741AbgEBH5D (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 May 2020 03:57:03 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C9EC061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 00:57:02 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d16so9065226edv.8
        for <git@vger.kernel.org>; Sat, 02 May 2020 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VrxvnBoi6cO+4XHtxwKtw5MqSCBTY66g7oCe5PjnkrU=;
        b=Sis0fADYqIFRs4/oZgXKGrYz0U2gGr77oXKjjW7rHPfDFHT3GYgZbb/u8mMksGY5LH
         52efY9GRHTYIqiw7spyri+QlONQqLRHaqe41n5OwpqvXvGXQ4mXivWq7mJbzuQ+icSGP
         6zeCOzjrXSOkSVX1Ba38Q5EGux2CPwsSQQzwXeLTib27bGsCKMHz2AxmZu4z8L9k5X2+
         8DboZcE+mCeC9WQ83T1qHtQne8smZsm9PTzEtEn8+xPsTVIADY6FmkFMRRufqargiFwR
         Jn6qLVRnCXUlKGa/4Ox76CiLcyJY+MFOtmpEYfj0gGHq0APEO57gstWUQWtNs93QgX3h
         7TUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VrxvnBoi6cO+4XHtxwKtw5MqSCBTY66g7oCe5PjnkrU=;
        b=hzLLLuqUdGwWNiw1ObqgEY+iD8APe1ojrJw3LxiX8scWZUYVZGRfIIRdPEcfnGaU6A
         Z3ME+ZlF5ObELtxIS5KplPEr4h9AnpyAZakDinaQticpaLVVxE5iL1hEeisQ+kfW7Q0l
         TKIqVMD2/IlBYR9l6lIqX+G3AagF+1M+fda3n9igitz1SZ4wycuvs8lsgl6y3uE0E+lc
         3hp1Xx33FxV3GLNTATNBroJHbalh2tHdqfpoTm0Qm4m/UwK9JEjvLGu8ZmDw/l2NGYsr
         lK5BZhyn/UFnl582ego42apMTVhrjpwXu9Adtc52P096E/4wGQG+fsE2oo0SmTR+67Xm
         vXcQ==
X-Gm-Message-State: AGi0PuayYRGyap+uw9KZ20gWARj4dfsb+yEX3b2g82nwApsuZAQU7twW
        1hlP8L7LlFfixODzSmvllUmAzfyzCDV+4lLPQtk=
X-Google-Smtp-Source: APiQypKW1VTbQFP8DHOrg/XLInqWk0QQ7WXGKlCfXzTHl48WumnkeB8881uLbugWgJlI4RfDE+5TSTwtY98ChSiLvd8=
X-Received: by 2002:a50:bb25:: with SMTP id y34mr6400353ede.237.1588406221616;
 Sat, 02 May 2020 00:57:01 -0700 (PDT)
MIME-Version: 1.0
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Sat, 2 May 2020 09:56:50 +0200
Message-ID: <CAL3xRKfcKh=XxGso4DTRfJMAVMtwqyQkO0VUhqVuZUr_aQ5f+A@mail.gmail.com>
Subject: Re: [PATCH 05/15] run-job: implement pack-files job
To:     gitgitgadget@gmail.com
Cc:     dstolee@microsoft.com, git@vger.kernel.org, jrnieder@google.com,
        peff@peff.net, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

Sorry for another late reply on this RFC.
This time is a question on the multi-pack-index repack process.

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> diff --git a/builtin/run-job.c b/builtin/run-job.c
> index cecf9058c51..d3543f7ccb9 100644
> --- a/builtin/run-job.c
> +++ b/builtin/run-job.c

...

> +static int multi_pack_index_repack(void)
> +{
> + int result;
> + struct argv_array cmd = ARGV_ARRAY_INIT;
> + argv_array_pushl(&cmd, "multi-pack-index", "repack",
> + "--no-progress", "--batch-size=0", NULL);
> + result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
> +
> + if (result && multi_pack_index_verify()) {
> + warning(_("multi-pack-index verify failed after repack"));
> + result = rewrite_multi_pack_index();
> + }

Its a bit inconsistent where write() and expire() did not include
verify() within them
but repack does. What make repack() different?

> +
> + return result;
> +}
> +
> +static int run_pack_files_job(void)
> +{
> + if (multi_pack_index_write()) {
> + error(_("failed to write multi-pack-index"));
> + return 1;
> + }
> +
> + if (multi_pack_index_verify()) {
> + warning(_("multi-pack-index verify failed after initial write"));
> + return rewrite_multi_pack_index();
> + }
> +
> + if (multi_pack_index_expire()) {
> + error(_("multi-pack-index expire failed"));
> + return 1;
> + }

Why expire *before* repack and not after?

I thought `core.multiPackIndex=true` would prevent old pack files from
being used thus expiring immediately after repack is safe? (on that
note, are users
required to set this config prior to running the job?)

If expiring immediately after repack()+verify() is not safe, then should
we have a minimum allowed interval set? (although I would preferred to
make expire() safe)

> +
> + if (multi_pack_index_verify()) {
> + warning(_("multi-pack-index verify failed after expire"));
> + return rewrite_multi_pack_index();
> + }
> +
> + if (multi_pack_index_repack()) {
> + error(_("multi-pack-index repack failed"));
> + return 1;
> + }

Again, I just think the decision to include verify() inside repack()
made this part a bit inconsistent.

> +
> + return 0;
> +}
> +

Cheers,
Son Luong
