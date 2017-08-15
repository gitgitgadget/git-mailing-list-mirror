Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CA44208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 23:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbdHOXKn (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 19:10:43 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32937 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdHOXKm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 19:10:42 -0400
Received: by mail-pg0-f67.google.com with SMTP id u185so3521388pgb.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YqAIasw8EiUeNRkcNkpqKb1BMuWgBo5lBU2s+5p38Y0=;
        b=cH2XLWV5GW3KYJ61DMh4aTi2YsNpCf2stv+7RUD2XSCeR7LdliOaiVj29UnZBnj7NR
         qH33WAGzMNzBLmhqxCyA8Wmf4PbhFWQDFqDcGYa4qN0iNTyQAFB/UkTYo5OwOOT/caD7
         7Bh8B3JaPoj5gERHFaNVOwM8doAKUuSTSb1FZ0Hjd1xOemJZ2wBZ5UcLIZItxb5BhP4R
         JLuqpSqJr0+dc5WEYzILbomurnFRUjhPJ+KOWml5LA7gg3rIM2kAblytuxRvG4JEhCxg
         9FxZoWdcFxQri3s+2ytDYhVklT4fcnckLy9Qs2fGiddKpbvqBXq4hlnlboLauHEcvOsq
         9Elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YqAIasw8EiUeNRkcNkpqKb1BMuWgBo5lBU2s+5p38Y0=;
        b=bzX28k2cQwofnlVMZPcuth3jFJz9uV8T3pouBHK4zuQQ3hkLxMvGnX6Hf7mupcQMJx
         rCQIpiSWBO4Er0qIdL4QArK0isCzMPtDVcVc7u7I8yxNT2ZxHMsmgNowGrT8Dcl97hhc
         pRsiUaT+xaigPXwzRCqTJhfLzm+dH4OX7w4CESN7F9cbo0CvZ1XF00EjzgMkotq2RaY2
         F8Up5Zh3JDf/O68al2GLuKH1pmSOlSjlRL/96OjFUr4CEB3SFtKNDbIDkg4BjRJ7Ok5C
         TCxxqSyw8yZ8JVJPPL/3V8Wkh2v0hxfHz/ozj3/fTluPoTXDqRMu/w+PVY20iFvMvPbw
         nUeg==
X-Gm-Message-State: AHYfb5gRiBWeDuGsET+ukH+Zvsao3xj2wrw1p4D+Q5yqCjw2w5JZPhor
        LGJmFrh+4dF77A==
X-Received: by 10.99.140.15 with SMTP id m15mr47554pgd.239.1502838641440;
        Tue, 15 Aug 2017 16:10:41 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5181:69ef:a50:cd47])
        by smtp.gmail.com with ESMTPSA id p67sm17248363pga.79.2017.08.15.16.10.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 16:10:40 -0700 (PDT)
Date:   Tue, 15 Aug 2017 16:10:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] push: do not add submodule odb as an alternate when
 recursing on demand
Message-ID: <20170815231038.GE13924@aiede.mtv.corp.google.com>
References: <CAGZ79kZouNBxOKr7X8j6wqebp3Wh3cDqhYR-t_PxaF7AwQ0Wzg@mail.gmail.com>
 <20170815224332.22730-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170815224332.22730-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> "git push --recurse-submodules=on-demand" adds each submodule as an
> alternate with add_submodule_odb before checking whether the
> submodule has anything to push and pushing it if so.
>
> However, it never accesses any objects from the submodule.  In the
> parent process it uses the submodule's ref database to see if there
> is anything to push.  The actual push (which does rely on objects)
> occurs in a child process.
>
> The same was true when this call was originally added in
> v1.7.11-rc0~111^2 (push: teach --recurse-submodules the on-demand
> option, 2012-03-29).  Most likely it was added by analogy with
> fetch --recurse-submodules=on-demand, which did use the submodule's
> object database.
>
> Use is_submodule_populated_gently instead, which is simpler and
> cheaper.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for picking up this loose end.

> diff --git a/submodule.c b/submodule.c
> index 111a3007fc..e20216bc0f 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -966,7 +966,9 @@ static int push_submodule(const char *path,
>  			  const struct string_list *push_options,
>  			  int dry_run)
>  {
> -	if (add_submodule_odb(path))
> +	int code;
> +
> +	if (!is_submodule_populated_gently(path, &code))
>  		return 1;
>  
>  	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
