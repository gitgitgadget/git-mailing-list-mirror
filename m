Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1B820281
	for <e@80x24.org>; Fri, 15 Sep 2017 17:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdIORww (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 13:52:52 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:44387 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdIORwv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 13:52:51 -0400
Received: by mail-pf0-f169.google.com with SMTP id e1so1816646pfk.1
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hmTPd9Dm/jyFJqiF9izRKd4JRmKY66KgmP5fexf0aFg=;
        b=UplPFT7NfvwliuN2UBhIUG+9JVuMKknhzHnHfxqHR+PlD+hZKpu9dmosYzH3XZlnuH
         +muhTiMmsglCLG8Lc+mBY3jCDDAahNRLIUdSd9+JCdmxg/pmLcGuneMpbLMwLNBSWPl7
         IsP7dIY4MGJSN93YHTQKj6iRIg8KqDsz4hwxsxbHyzH26XAuI0mm9+YQjDaOH3bLxI4K
         RDhVwu7gahICzVzGX0DOkohvv01cxwwBbY9u+VgBRwTNzHRaPLN9HBJoIskoecIKx3SJ
         smVZ3yqQuJ8W7FgYNzp23r0Tb9bhgkHDbWWT6b1ZhTimgh06f65Ro4c/yz1SaArsDd4L
         zKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hmTPd9Dm/jyFJqiF9izRKd4JRmKY66KgmP5fexf0aFg=;
        b=CWiojFSbJl/Hz+os8X4pScCECkDeMRtXl+EmrVb2OmM1VcS1MVDERW13fT1YCNZPCk
         Hhgq9IFQWmHC0Sub8BSE5JByJ0C+NRX/YMA8NEWZUFSaSeOU8iuIISx3jIOb4p/DJfNV
         FNk+7QczSvAHVYZgxjaepEIikrYCn+6Mlc9Zvb7YdVFDzFdSL/jBbZFfQ1IgRX8KmQyN
         Zu7ZAY5Be9Jlpah6p8WmmiFReRLI27e8i3XeEvpj7MuYL2AKieGSzGdqjS8iXpMPlGCP
         c6/kLeWDJWUB7IvZz4PEd+aWwqhRdWHnPeCYQDag2TBjouWJtfZZCXJrig3kjhYHcguU
         9TGw==
X-Gm-Message-State: AHPjjUgXjyRKGC8MCc1cVfilu1ZNnUSR/hcc7p6zunp8T3prklBtcNry
        lrbHL2bWfIk5TZ5W8nQ=
X-Google-Smtp-Source: ADKCNb6NwHzZAfSWuwTL3uWbRkXx+nOBA4I8GSEVOISoySmwlngyd0RD8E6nzvxeAENwM5XnwvBk+A==
X-Received: by 10.98.14.20 with SMTP id w20mr24969915pfi.251.1505497970442;
        Fri, 15 Sep 2017 10:52:50 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:40d3:83c7:2f82:80ea])
        by smtp.gmail.com with ESMTPSA id u66sm3781346pfd.33.2017.09.15.10.52.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Sep 2017 10:52:49 -0700 (PDT)
Date:   Fri, 15 Sep 2017 10:52:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jason Merrill <jason@redhat.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>, aldyh@redhat.com
Subject: Re: [PATCH] Fix merge parent checking with svn.pushmergeinfo.
Message-ID: <20170915175248.GT27425@aiede.mtv.corp.google.com>
References: <20170915170818.27390-1-jason@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170915170818.27390-1-jason@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jason Merrill wrote:

> Subject: Fix merge parent checking with svn.pushmergeinfo.
>
> Without this fix, svn dcommit of a merge with svn.pushmergeinfo set would
> get error messages like "merge parent <X> for <Y> is on branch
> svn+ssh://gcc.gnu.org/svn/gcc/trunk, which is not under the git-svn root
> svn+ssh://jason@gcc.gnu.org/svn/gcc!"
>
> * git-svn.perl: Remove username from rooturl before comparing to branchurl.
>
> Signed-off-by: Jason Merrill <jason@redhat.com>

Interesting.  Thanks for writing it.

Could there be a test for this to make sure this doesn't regress in
the future?  See t/t9151-svn-mergeinfo.sh for some examples.

Nit: git doesn't use GNU-style changelogs, preferring to let the code
speak for itself.  Maybe it would work better as the subject line?
E.g. something like

	git-svn: remove username from root before comparing to branch URL

	Without this fix, ...

	Signed-off-by: ...

> ---
>  git-svn.perl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index fa42364785..1663612b1c 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -931,6 +931,7 @@ sub cmd_dcommit {
>  		# information from different SVN repos, and paths
>  		# which are not underneath this repository root.
>  		my $rooturl = $gs->repos_root;
> +	        Git::SVN::remove_username ($rooturl);

style nit: Git doesn't include a space between function names and
their argument list.

I wonder if it would make sense to rename the $rooturl variable
since now it is not the unmodified root. E.g. how about

		my $expect_url = $gs->repos_root;
		Git::SVN::remove_username($expect_url);
		...

>  		foreach my $d (@$linear_refs) {
>  			my %parentshash;
>  			read_commit_parents(\%parentshash, $d);

The rest looks good.

Thanks and hope that helps,
Jonathan
