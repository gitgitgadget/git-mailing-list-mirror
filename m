Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60575207E3
	for <e@80x24.org>; Tue,  2 May 2017 02:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbdEBCEK (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 22:04:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35772 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdEBCEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 22:04:09 -0400
Received: by mail-pf0-f193.google.com with SMTP id o68so10969941pfj.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 19:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hJKDVDiQZ9qcCTAFpSXSuGDEH+Ks/by+NFG33UbFMvg=;
        b=jAWd/uqNqDzuBsjICaDkg8VQEkvJmfaoXtAF8AFzJkdFVa4DXeH7JXx5ZBoQpClz5F
         LnICnknllgWRxXenwH09SP+bGobWyKPLgANEAd+idWinsieKJ0iaWqRCU1ZyKPMoEtF9
         FInKx+5lnSWdhh5+i9zHZHIfOTNcGL9C4M+pBUSzOhTgcSyaiwZVaxlqMZkD4voner3i
         2wWuWSoeI/rgHjatxPXofilbRnJJdA3S6toJJ1zbxPDP9PjjwdreYdmuBPfvZvOivSv9
         IaHMphVdMhIpmVMeL+3QhhNk4Dk7Wt6/QOLSKmXYIBQX+VTguKlmMDHoiD4bE0HomzAL
         6i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hJKDVDiQZ9qcCTAFpSXSuGDEH+Ks/by+NFG33UbFMvg=;
        b=IR76bommOSkSwafI73NirOIuHExxhcI8w4dwbHnh939GOJIb6TPs0ayp3cjbvEMgEX
         Glek/BVz6iNiP6gQ3eRZUglb6+XFTnyMxGQWfRc7oafL6IEXZdpaFEWv7KUYbtufsGGG
         dN3L4g/ZVu/7z/gzA7GSnMYll8cyTBJgtQVjuxFRdW3SPKfAI7PMgXO5peLtukjDPZjV
         XX8AjXm78gbCOYP2fUdVls1WN/NGwgAtLSjgLMSQM8pGmwRsHlQ+7RbuhzXjNRcHzfKZ
         rrfye2sSd7789A0HlJfYs7la6ovOELwfPHQX2WJu4OlhR305XB0Xy+MSsv6lCQHTBbW3
         YelQ==
X-Gm-Message-State: AN3rC/7I2UXKmEfp+Tj+4IxRB2EcNCjbsp24O+FQceUeWC1pnvx3rQOK
        ADIbh7R/LBTj3Q==
X-Received: by 10.84.168.69 with SMTP id e63mr37838014plb.124.1493690648461;
        Mon, 01 May 2017 19:04:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id p2sm27487121pfj.93.2017.05.01.19.04.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 19:04:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jrnieder@gmail.com, bmwill@google.com, git@vger.kernel.org
Subject: Re: [PATCH 2/5] submodule_move_head: prepare env for child correctly
References: <20170501180058.8063-1-sbeller@google.com>
        <20170501180058.8063-3-sbeller@google.com>
Date:   Mon, 01 May 2017 19:04:05 -0700
In-Reply-To: <20170501180058.8063-3-sbeller@google.com> (Stefan Beller's
        message of "Mon, 1 May 2017 11:00:55 -0700")
Message-ID: <xmqqy3ugdnfu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> We forgot to prepare the submodule env, which is only a problem for
> nested submodules. See 2e5d6503bd (ls-files: fix recurse-submodules
> with nested submodules, 2017-04-13) for further explanation.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Sounds good (if only because this makes it similar to other
codepaths).

Is this something whose breakage before the patch is easily
demonstrated with a test?

>  submodule.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/submodule.c b/submodule.c
> index cd098cf12b..c7a7a33916 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1476,6 +1476,7 @@ int submodule_move_head(const char *path,
>  			cp.no_stdin = 1;
>  			cp.dir = path;
>  
> +			prepare_submodule_repo_env(&cp.env_array);
>  			argv_array_pushl(&cp.args, "update-ref", "HEAD", new, NULL);
>  
>  			if (run_command(&cp)) {
