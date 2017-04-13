Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57E620960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755462AbdDMTFp (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:05:45 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34696 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbdDMTFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:05:44 -0400
Received: by mail-pg0-f52.google.com with SMTP id 21so34591086pgg.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cwNPXQOU/pJ+P1qcFN8bwFTZGwv9dPSEy+NONgQ/lYo=;
        b=mgbM4lacFEVhvDlsi85tTV49jjw5Oi3V+3MrUVs1i4jGeTOCTHnS82cAFLPmJx1UNh
         jSSlmx6oD/kvMYk+yjgVmn0wKyvRH8S6PEOijKTnRo1Ymuo7Q6NQ8SbbzD9UIo5eJkPr
         bVYeWnC7Aprz3WTB/ecz5/62vP3IoatiKC9QQhc0Mv4BbXnMQV3tEHij7wfAANazHr/h
         r2yhprkADSYWQzVXPkFMJtTpKO5BxTDakZcjWPZDSv/jtAofAEFjigq45PgLN0A2GvZT
         utjGVi0KHIzSJcM3sUXoI+MlxdEOczdt9keW0AdXtmszFagkqk9yw9c0EY7Fozq92nZq
         TBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cwNPXQOU/pJ+P1qcFN8bwFTZGwv9dPSEy+NONgQ/lYo=;
        b=kqEC9Rhf7EY5vcG2fFQeL8dbQfPLHH1gU0nE9doQGPONxmrL4qsMcD3zvz4IkMjFUv
         4VXg11ani+IlJWY9BI2zloBwOxkKkXmvL24tvkSzIWAcgLkRCMgmw+ZVc05T0+0bHQGw
         38NGU5zWDVdtChUtVsUvp5BofqVOqvC1d8O3SZtLvWGdNDwnsUCEXzZcf9VWDU65wRmD
         Q+5i6oxbs/mOU6rUsHu3EiOPid6NZ0qnWqzJ9YzloAMLqwqYisCACxMyXBVpo4+EfZRi
         R5LdT1atxjsS6l5EUce/vv7OGRN7zzKLtgIw4KcZWxXe7u0TDCTv312CbWIy5Ws40eNF
         hedQ==
X-Gm-Message-State: AN3rC/7dnVnqHrBIsDpgHfr5cnxfTcx6mQRmdfNRiHlg+F5W4fyrjSnv
        VLVj56ZSMqGjUlCOYe05mw==
X-Received: by 10.84.199.170 with SMTP id r39mr5257508pld.144.1492110343613;
        Thu, 13 Apr 2017 12:05:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:1426:66e2:260b:9db9])
        by smtp.gmail.com with ESMTPSA id m29sm37602671pfj.32.2017.04.13.12.05.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 12:05:42 -0700 (PDT)
Date:   Thu, 13 Apr 2017 12:05:41 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 2/4] submodule.c: uninitialized submodules are ignored in
 recursive commands
Message-ID: <20170413190541.GD96917@google.com>
References: <20170411234923.1860-1-sbeller@google.com>
 <20170411234923.1860-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411234923.1860-3-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11, Stefan Beller wrote:
> This was an oversight when working on the working tree modifying commands
> recursing into submodules.
> 
> To test for uninitialized submodules, introduce another submodule, that is
> uninitialized in the actual tests. By adding it to the branch "add_sub1",
> which is the starting point of all other branches, we have wide coverage.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c               | 3 +++
>  t/lib-submodule-update.sh | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/submodule.c b/submodule.c
> index c52d6634c5..2fa42519a4 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1332,6 +1332,9 @@ int submodule_move_head(const char *path,
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	const struct submodule *sub;
>  
> +	if (!is_submodule_initialized(path))
> +		return 0;
> +
>  	sub = submodule_from_path(null_sha1, path);
>  
>  	if (!sub)
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index fb4f7b014e..22dd9e060c 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -73,6 +73,7 @@ create_lib_submodule_repo () {
>  
>  		git checkout -b "add_sub1" &&
>  		git submodule add ../submodule_update_sub1 sub1 &&
> +		git submodule add ../submodule_update_sub1 uninitialized_sub &&

The 'submodule add' command will make the submodule active, so you'll
need to add in a line to subsequently make the submodule inactive for
this to work, unless you do in at a later point in time.

>  		git config -f .gitmodules submodule.sub1.ignore all &&
>  		git config submodule.sub1.ignore all &&
>  		git add .gitmodules &&
> -- 
> 2.12.2.603.g7b28dc31ba
> 

-- 
Brandon Williams
