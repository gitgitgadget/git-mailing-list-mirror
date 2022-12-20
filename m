Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA457C4167B
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 07:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiLTHe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 02:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiLTHeY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 02:34:24 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634E6212
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 23:34:23 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d82so7912819pfd.11
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 23:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CdtM2kJfxPsN5/ZQVu+x1D74QMPprL4I2EG4aZ6RnSM=;
        b=qXgvevwdB6jqBcMwHwhA0JuIDUxjCKqlp1JzB4TYwGEu8bUSCqs/2PwYWFET0xsK/3
         y7vGxkyB+xUeIpvR72CUzBO0YDgU3cxriWCairHF64GQ9PageMYnkt+SbDHxZw3kaKp5
         fNQ7XS0kHtPGJRtJCeEYWDMxZO/BXJ09bzLLelPLnWnvpEvIxW4Zqct0hZ8kCVqb/DhD
         1ouDVnYIrcX6JAx7KS0CHaB8xbTJ3Zd2XyiWwN1VdODfh4e4v2P2kzMerbwIEziuCQiq
         nX24jtz3z9lmZ9xHsFn2SxTb4ev1wQmxzw3b19o0olCOgFx/3KvnngfOnNU4z9dMJvC+
         EkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdtM2kJfxPsN5/ZQVu+x1D74QMPprL4I2EG4aZ6RnSM=;
        b=YZhRc8h0fNK8XGc7zMQJm2bC3spWKLolm4DWdstmXcqe5Tg5ZnWUjYk6R1u8Tro73Z
         2QQUYDHRApnmHOLWwgdU2hiR28DELeqAtSVVRYrKZ2rP+UU1B4RLMlq9LmXGKQ72mA6M
         /YeBOmIPWGoMAjhRLqmu59AYQoFFlfVUmf2MF05d2uOcOV24a7YcQNnR1ckgDRynfADt
         rqbOrqk3DtDit7MhuXwgliIOdhrK9Bu32Rnmi89rENeCQO7NHxT3OLjC7aJwVsOsLBlV
         hK5yYWvkOpInCu/nt1sG9dltUqMsrEkpfO980mZvRgQ2KO+Ejoq8gf2zjvAd4/rstSs7
         JbmA==
X-Gm-Message-State: ANoB5pno+lDIPW2aR3yBqeJhXJLTdNEuYrwcsyJgn3VvHhlkf5+HvkOi
        BQFYXTECzgaL+aGbHNDe1WQ=
X-Google-Smtp-Source: AA0mqf7Bfk+gEVedxxBc/KhRpywlNixoHHYWbsG9bTylWgRhTSEkW7NoElUpZdPJZyFTWpaA3FgIaA==
X-Received: by 2002:a05:6a00:7ca:b0:577:3944:aa78 with SMTP id n10-20020a056a0007ca00b005773944aa78mr41224663pfu.0.1671521662766;
        Mon, 19 Dec 2022 23:34:22 -0800 (PST)
Received: from localhost ([2001:ee0:50c6:3450:b0ce:46ff:fe04:76aa])
        by smtp.gmail.com with ESMTPSA id h10-20020aa796ca000000b00571cdbd0771sm7903491pfq.102.2022.12.19.23.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:34:22 -0800 (PST)
Date:   Tue, 20 Dec 2022 14:34:19 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>
Subject: Re: [PATCH v2 1/3] ci (check-whitespace): suggest fixes for errors
Message-ID: <Y6Fle8gzVU5si3T/@danh.dev>
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
 <pull.1444.v2.git.1671496548.gitgitgadget@gmail.com>
 <a2b5f3e87d6ef62d8005cff5568ad3afc4af3771.1671496548.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b5f3e87d6ef62d8005cff5568ad3afc4af3771.1671496548.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-20 00:35:45+0000, "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com> wrote:
> From: "Chris. Webster" <chris@webstech.net>
> 
> Make the errors more visible by adding them to the job summary and
> display the git commands that will usually fix the problem.
> 
> Signed-off-by: Chris. Webster <chris@webstech.net>
> ---

I think this change is getting too long to be embeded in a yaml file.
I think it's better to move the shell code into its own script, so we
can have better code highlight in editor and a proper shebang (/bin/bash).

>  .github/workflows/check-whitespace.yml | 37 +++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
> index ad3466ad16e..a0871489b24 100644
> --- a/.github/workflows/check-whitespace.yml
> +++ b/.github/workflows/check-whitespace.yml
> @@ -20,31 +20,50 @@ jobs:
>      - name: git log --check
>        id: check_out
>        run: |
> -        log=
> +        problems=()
>          commit=
> -        while read dash etc
> +        commitText=
> +        lastcommit=
> +        while read dash sha etc
>          do
>            case "${dash}" in
>            "---")
> -            commit="${etc}"
> +            if test -z "${commit}"
> +            then
> +              lastcommit=${sha}
> +            fi
> +            commit="${sha}"
> +            commitText="${sha} ${etc}"
>              ;;
>            "")
>              ;;
>            *)
>              if test -n "${commit}"
>              then
> -              log="${log}\n${commit}"
> +              problems+=("" "--- ${commitText}")
>                echo ""
> -              echo "--- ${commit}"
> +              echo "--- ${commitText}"
> +              commit=
>              fi
> -            commit=
> -            log="${log}\n${dash} ${etc}"
> -            echo "${dash} ${etc}"
> +            problems+=("${dash} ${sha} ${etc}")
> +            echo "${problems[-1]}"
>              ;;
>            esac
>          done <<< $(git log --check --pretty=format:"---% h% s" ${{github.event.pull_request.base.sha}}..)
>  
> -        if test -n "${log}"
> +        if test ${#problems[*]} -gt 0
>          then
> +          if test -z "${commit}"
> +          then
> +            lastcommit=${{github.event.pull_request.base.sha}}
> +          fi
> +          echo "A whitespace issue was found in one or more of the commits." >$GITHUB_STEP_SUMMARY
> +          echo "" >>$GITHUB_STEP_SUMMARY
> +          echo "Run \`git rebase --whitespace=fix ${lastcommit}\` and \`git push --force\` to correct the problem." >>$GITHUB_STEP_SUMMARY

When move this block into its own script, we can use single quote
string here, too.

> +          for i in "${problems[@]}"
> +          do
> +            echo "${i}" >>$GITHUB_STEP_SUMMARY
> +          done
> +
>            exit 2
>          fi
> -- 
> gitgitgadget
> 

-- 
Danh
