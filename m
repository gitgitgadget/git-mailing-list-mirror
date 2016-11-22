Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01BC41FEEF
	for <e@80x24.org>; Tue, 22 Nov 2016 00:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbcKVAox (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 19:44:53 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35743 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752916AbcKVAow (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 19:44:52 -0500
Received: by mail-pg0-f66.google.com with SMTP id p66so258942pga.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 16:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sA5BAEwLZPQJ2WIxZJOxBvfvbJ3RLE/vjfdC7H0BJ7o=;
        b=bVWMtDoHq3ze7LguLJVkZNy0Q/FvsCLxWzjCXVkeS//iT9oaOLKNgIRERVafP3ngzE
         1pnbQRvopsqB4OUC+BRC9aNKHXJ/0mAHDqmLxMa/j54rnePwY8XLAXE/iBo+voA6Txt3
         qOaWgAoZig/OwNXd8ZmdAEZoqqBQ8S1JiYdhBJ0Jzwa/ipkueKwkLNTQsiglS4hr0/x+
         eCoU3WBOzyuwbSDVMKl3DWivuVxZkwIHScHrvZmJNcIlAgfBIOBs4jhqqucEtun017d7
         tk43RPXefn8vndOJhs/hqJjFSYpCd92aCxaVvqbI6MPgJkhmNeMnd4mrklbfEmHJZOMF
         CgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sA5BAEwLZPQJ2WIxZJOxBvfvbJ3RLE/vjfdC7H0BJ7o=;
        b=jv92ScJmSehruWyC5wX91F7GSwz40WKZs94eodqq40GEiTteYSE0d/VypfXNTdL6zG
         +VkU0k25V+QPpZyczmYQevZ95yEOaWd+YY0hHH179KHsdG48ROmxwSYXclwECZWcsE+W
         l0qq9GbuicF4s71D2UO2u7neiYsH8Bq0/RfHeclGP3lo3deBTon8XQFtc8F3+zvJ5jeS
         dI29DybnjIGyzTBkLbt69N702x/z11S9K0x8QbeC0erijw2FqY7ljy8UkAO7AW6/NyLq
         0ZCjFIdbW1chsVCPsK1aKau2UJqr4rBOaIzehxiBZH+mnVl9EDCjjIEvWNX1a3k2ikE7
         V17Q==
X-Gm-Message-State: AKaTC01mEUnxj+RtC1fOt7I7boK6ZsMOLZdPs3FAyRXx7FfGubeErZtddsbxsqNeTNEXoQ==
X-Received: by 10.99.43.8 with SMTP id r8mr37621364pgr.83.1479775491848;
        Mon, 21 Nov 2016 16:44:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:30b1:bd67:39c9:c78d])
        by smtp.gmail.com with ESMTPSA id n24sm40105105pfb.0.2016.11.21.16.44.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 16:44:50 -0800 (PST)
Date:   Mon, 21 Nov 2016 16:44:21 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/7] setup_git_env: avoid blind fall-back to ".git"
Message-ID: <20161122004421.GA12263@google.com>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> This passes the test suite (after the adjustments in the
> previous patches), but there's a risk of regression for any
> cases where the fallback usually works fine but the code
> isn't exercised by the test suite.  So by itself, this
> commit is a potential step backward, but lets us take two
> steps forward once we've identified and fixed any such
> instances.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  environment.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/environment.c b/environment.c
> index cd5aa57..b1743e6 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -164,8 +164,11 @@ static void setup_git_env(void)
>  	const char *replace_ref_base;
>  
>  	git_dir = getenv(GIT_DIR_ENVIRONMENT);
> -	if (!git_dir)
> +	if (!git_dir) {
> +		if (!startup_info->have_repository)
> +			die("BUG: setup_git_env called without repository");
>  		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
> +	}

This trips reproducibly for

  git ls-remote https://kernel.googlesource.com/pub/scm/git/git

when run outside of a git repository.

Backtrace:

  #0  setup_git_env () at environment.c:172
  #1  get_git_dir () at environment.c:214
  #2  get_helper at transport-helper.c:127
  #3  get_refs_list (for_push=0) at transport-helper.c:1038
  #4  transport_get_remote_refs at transport.c:1076
  #5  cmd_ls_remote at builtin/ls-remote.c:97

transport-helper.c:127 is

	argv_array_pushf(&helper->env_array, "%s=%s", GIT_DIR_ENVIRONMENT,
			 get_git_dir());

That code is pretty clearly wrong.  Should it be made conditional
on have_git_dir(), like this?

Thanks,
Jonathan

 transport-helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 91aed35..e4fd982 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -124,8 +124,9 @@ static struct child_process *get_helper(struct transport *transport)
 	helper->git_cmd = 0;
 	helper->silent_exec_failure = 1;
 
-	argv_array_pushf(&helper->env_array, "%s=%s", GIT_DIR_ENVIRONMENT,
-			 get_git_dir());
+	if (have_git_dir())
+		argv_array_pushf(&helper->env_array, "%s=%s",
+				 GIT_DIR_ENVIRONMENT, get_git_dir());
 
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
-- 
