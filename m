Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B149CC433F5
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 06:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CC960F5D
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 06:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhJIGkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 02:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244309AbhJIGkP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 02:40:15 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ECAC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 23:38:18 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u69so4218234oie.3
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 23:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ofVHzLQbCSY0fQnA4Q3OIJKgRp9m49rkJzKkRX921IY=;
        b=BkTgNE/phWq98kWDuhfR50/TAXp4AOozNOkSJ1EsE2FeCIEZAx//XCeO4ZO7J1WmnR
         Sj9aI79CC0I16Qc6R236KJz9wpj6Pn8JrUNv/mifCF9ReQ7bd/R1grlyG4zlP/g0W9nO
         bV+VYK73HosmBJk5yACRRKdW6Sti4AaMj74fqDrcPEpqL6VNExKrv4HWZExlao6WjEwK
         bWYfL3hdpubBYh139Q756OVQDuwyELFOhcaymdq5OnXHM2tjb3ekOiV8XMebE58G7rZT
         e/MC4NnvgDNjYBJNWrhBGHPAG0yZMQMoJIfWEyOiSaweHrsfwvyUbZTpY1nkpFJuXwLH
         /bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ofVHzLQbCSY0fQnA4Q3OIJKgRp9m49rkJzKkRX921IY=;
        b=bHscx1Ly3xirskooWIewC2/5hXJ/P7qsHFs/qEPVo/6YfR5fUgFmXRjXj0gWgtGR+G
         w0bE/jj3Pfus1ZIPVw12/1derRCBgc1ueZmf6ZBfpHSyxO6Wx+ZorzFqcSysG+DRO0sH
         aKWu4UlRVsyMtf9hX6YDWNzdO6CTbI9UB7WQ2HAl+4WsaIzQMcZOaP1eRwwmVAEGFVsM
         xHhMuEW1FJtX5C7dBBRQPO/dLKSe5jyPf/IyF2o8DIBpzwa5FXs5jcipZGefD5aDR9YL
         uV1xTzphubZDaw5lVn5cepSQryeRDhGsNyobC98vVxhHLVLgDQcUqaWwp6yqOy72P4qF
         1UOw==
X-Gm-Message-State: AOAM531qnNoTOUDWK8ouP5P8L2Lynpqj06tspshnJQBDsixtE86nAn2b
        pGe3pWgpXCOftwRcX65P7GIokLIkR3lKtQ==
X-Google-Smtp-Source: ABdhPJytylHSBBA+I6K2BxJ+eOGllxeUKpf22C2QONx9I+tVd9xKmAXz4eOsQrrZQXM5CGUUyJ0+qQ==
X-Received: by 2002:aca:dec4:: with SMTP id v187mr10288604oig.5.1633761498070;
        Fri, 08 Oct 2021 23:38:18 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id j65sm393584oif.5.2021.10.08.23.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 23:38:17 -0700 (PDT)
Date:   Fri, 8 Oct 2021 23:38:15 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Thiago Perrotta <tbperrotta@gmail.com>
Cc:     gitster@pobox.com, bagasdotme@gmail.com, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v6 2/3] send-email: programmatically generate bash
 completions
Message-ID: <YWE41xTLhBFWqUFl@carlos-mbp.lan>
References: <CABOtWuqXS_kJk2md=kgg-ReaWtKermpUW_Dk_bc0pMXQL+xMeA@mail.gmail.com>
 <20211007033652.80793-3-tbperrotta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007033652.80793-3-tbperrotta@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 06, 2021 at 11:36:51PM -0400, Thiago Perrotta wrote:
> diff --git a/git-send-email.perl b/git-send-email.perl
> index d1731c1755..465e9867b9 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -40,7 +40,7 @@ package main;
>  
>  sub usage {
>  	print <<EOT;
> -git send-email [options] <file | directory | rev-list options >
> +git send-email [options] <file | directory | rev-list options>

this change isn't really needed now that you are not using the usage()
to get the options, and should probably go into an independent patch,
or even better, as part of patch 3 so it is consistent.

> @@ -113,8 +113,23 @@ sub usage {
>  	exit(1);
>  }
>  
> +sub uniq {
> +    my %seen;
> +    grep !$seen{$_}++, @_;
> +}

indentation in this file is a little odd, but will be better if you use the
most common one (tab), instead of your own version here (4 or 2 spaces) and
in the rest of the code.

>  sub completion_helper {
> -    print Git::command('format-patch', '--git-completion-helper'), "\n";
> +    my ($options) = @_;
> +    my @send_email_opts = map {
> +      "--$_"
> +    } map {
> +      s/(?:[:=][si]|!)$//;
> +      split /\|/, $_;
> +    } keys %$options;
> +    my @format_patch_opts = Git::command('format-patch', '--git-completion-helper');
> +    my @options = uniq @send_email_opts, @format_patch_opts;

reusing "options" here makes this code more confusing than it needs to be
maybe something like :

diff --git a/git-send-email.perl b/git-send-email.perl
index a1338dd774..d47543bc0d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -119,13 +119,13 @@ sub uniq {
 }

 sub completion_helper {
-    my ($options) = @_;
+    my ($original_opts) = @_;
     my @send_email_opts = map {
       "--$_"
     } map {
       s/(?:[:=][si]|!)$//;
-      split /\|/, $_;
-    } keys %$options;
+      split /\|/;
+    } keys %$original_opts;
     my @format_patch_opts = Git::command('format-patch', '--git-completion-helper');
     my @options = uniq @send_email_opts, @format_patch_opts;
     @options = grep !/--git-completion-helper|--h/, @options;

might help on top

Carlo
