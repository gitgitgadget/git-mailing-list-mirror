Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3020CC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 09:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343511AbiEZJuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 05:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiEZJuT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 05:50:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B3DCE09
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:50:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ck4so1922238ejb.8
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jb3i+NPYGOm/Y8GeZQAOlUgadkPwdvCnShy9ei2Bw1I=;
        b=jxjm5eA7eWKQxqP2mcsmQtP+oPpG73eS/JMAk4HllTZIC9XoSTlzL/DGKQBuSydmcW
         GvvBBNpWt6To0b3nHFjOutSV6Lkuhn+WnQ9MVuc0qJ/8zp+GInR00R+JI/Jd0/4yQcBb
         ukL5xf8q9+U7rVUUwrPaUX/ZK8iRORassnluuJ36CXVUEqZYlzIua0nV1wgJM969prys
         IP/hL7e3YHahbuhBuqsv/ag1NkitVPd29tIm12PiGU5w6/bQCucdjeeDQ5eJ3b7sp0St
         NBKhtIKcNaGHj7FdgIaRSVNxgr4Jmw7MJmf2OYITks8bkbaX2OnlJmhaz8CrzBluSaY1
         p1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jb3i+NPYGOm/Y8GeZQAOlUgadkPwdvCnShy9ei2Bw1I=;
        b=yDjilqk3gtdBRFNzhlSgw5gEsKNOIuU7GMImPlhB9brMdjTirsi1r/IxkzxDtkQIoq
         Z3zae0lske7Cu56Bekw2LGm3MacgZEI3DgH6Pi8vhkgnhX2iVoijNU2vugpdJE5zdSok
         OvgdDBRtMM4QKrgUKRaNXyQnaMCvUP5n/xz36D6WgMy+OGxRoa5zjFMr1wDyzbuwODtH
         +pHt9UvDF2w20BjL9v/FHg1fzECMug9hFpLHksjZDKDzI5CbNRNzQAk2ODEzpNYuRMV0
         xGPVJp20fb+T3Rd5Bq6Y3QfX10m5Yw/U6WNLInf9kEvtlyOhoDJm/0Ue+40YXaTyoToj
         Ndqw==
X-Gm-Message-State: AOAM530RlYMLa2DajFXFqWdrY64yqD2lGbP1A4TaRxmtBKdOuUaURFCw
        zx3b6qNcIuJb34Xgh4PyxjU=
X-Google-Smtp-Source: ABdhPJzjPLUg7sPeHFM+Nvjr9vGVngLNCq/Oqri4xzSZESqTcqEKofnU2VsrLXuxd05hXpUxhXnihw==
X-Received: by 2002:a17:907:2d1e:b0:6fe:c5a3:4874 with SMTP id gs30-20020a1709072d1e00b006fec5a34874mr21276926ejc.61.1653558616261;
        Thu, 26 May 2022 02:50:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kk6-20020a170907766600b006f3ef214ddfsm363813ejc.69.2022.05.26.02.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 02:50:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuA8E-000B7t-VN;
        Thu, 26 May 2022 11:50:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 2/3] rebase: help users when dying with `preserve-merges`
Date:   Thu, 26 May 2022 11:43:54 +0200
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <d0fb54105940f19809eeb5d5e156bf3889d16b0c.1653556865.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <d0fb54105940f19809eeb5d5e156bf3889d16b0c.1653556865.git.gitgitgadget@gmail.com>
Message-ID: <220526.867d687hd5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Philip Oakley via GitGitGadget wrote:

> From: Philip Oakley <philipoakley@iee.email>
>
> Git will die if a "rebase --preserve-merges" is in progress.
> Users cannot --quit, --abort or --continue the rebase.
>
> Make the `rebase --abort` option available to allow users to remove
> traces of any preserve-merges rebase, even if they had upgraded
> during a rebase.
>
> One trigger was an unexpectedly difficult to resolve conflict, as
> reported on the `git-users` group.
> (https://groups.google.com/g/git-for-windows/c/3jMWbBlXXHM)
>
> Tell the user the options to resolve the problem manually.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>  builtin/rebase.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 6ce7e98a6f1..aada25a8870 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1182,8 +1182,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	} else if (is_directory(merge_dir())) {
>  		strbuf_reset(&buf);
>  		strbuf_addf(&buf, "%s/rewritten", merge_dir());
> -		if (is_directory(buf.buf)) {
> -			die("`rebase -p` is no longer supported");
> +		if (is_directory(buf.buf) && !(action == ACTION_ABORT)) {
> +			die("`rebase --preserve-merges` (-p) is no longer supported.\n"
> +			"Use `git rebase --abort` to terminate current rebase.\n"
> +			"Or downgrade to v2.33, or earlier, to complete the rebase.\n");
>  		} else {
>  			strbuf_reset(&buf);
>  			strbuf_addf(&buf, "%s/interactive", merge_dir());

Existing issue: No _(), shouldn't we add it?

I wonder if we should use die_message() + advise() in these cases,
i.e. stick to why we died in die_message() and have the advise() make
suggestions, as e4921d877ab (tracking branches: add advice to ambiguous
refspec error, 2022-04-01) does.

But then again adding new advice is currently a bit of an excercise in
boilerplate, and this seems fine for a transitory option.

I think you don't need to add a trailing \n though...

