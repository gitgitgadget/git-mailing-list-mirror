Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1DF1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 21:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755202AbcJEVEY (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 17:04:24 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:15716 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755170AbcJEVEX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 17:04:23 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3sq7ZD3JcTz5tlD;
        Wed,  5 Oct 2016 23:04:17 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4065B5301;
        Wed,  5 Oct 2016 23:04:17 +0200 (CEST)
Subject: Re: Feature Request: user defined suffix for temp files created by
 git-mergetool
To:     Josef Ridky <jridky@redhat.com>
References: <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com>
 <1499287628.1324571.1475653631366.JavaMail.zimbra@redhat.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <e3306f5a-1fb3-bd66-48ac-72b75fc7681c@kdbg.org>
Date:   Wed, 5 Oct 2016 23:04:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1499287628.1324571.1475653631366.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.10.2016 um 09:47 schrieb Josef Ridky:
> Add support for user defined suffix part of name of temporary files
> created by git mergetool

Do I understand correctly that your users have problems to identify 
which of the "_BASE_", "_LOCAL_", "_REMOTE_" and "_BACKUP_" files they 
must edit? I agree that there is some room for improvement.

The goal is that you want the user to see the label, e.g., "_EDIT_THIS_" 
instead of "_LOCAL_". Now you have to teach your users that they have to 
pass --local=_EDIT_THIS_. Why don't you just teach your users to edit 
the file labeled "_LOCAL_"?

Therefore, I think that your patch as written does not help to reduce 
the confusion. It may be a building block for further improvement, but 
if you stop here, it is pointless.

>  SYNOPSIS
>  --------
>  [verse]
> -'git mergetool' [--tool=<tool>] [-y | --[no-]prompt] [<file>...]
> +'git mergetool' [--tool=<tool>] [-y | --[no-]prompt] [--local=<name>] [--remote=<name>] [--backup=<name>] [--base=<name>] [<file>...]
>
>  DESCRIPTION
>  -----------
> @@ -79,6 +79,30 @@ success of the resolution after the custom tool has exited.
>  	Prompt before each invocation of the merge resolution program
>  	to give the user a chance to skip the path.
>
> +--local=<name>::
> +	Use string from <name> as part of suffix of name of temporary
> +	file (local) for merging. If not used or is equal with any
> +	other (remote|backup|base), default value is used.
> +	Default suffix is LOCAL.
> +
> +--remote=<name>::
> +	Use string from <name> as part of suffix of name of temporary
> +	file (remote) for merging. If not used or is equal with any
> +	other (local|backup|base), default value is used.
> +	Default suffix is REMOTE.
> +
> +--backup=<name>::
> +	Use string from <name> as part of suffix of name of temporary
> +	file (backup) for merging. If not used or is equal with any
> +	other (local|remote|base), default value is used.
> +	Default suffix is BACKUP.
> +
> +--base=<name>::
> +	Use string from <name> as part of suffix of name of temporary
> +	file (base) for merging. If not used or is equal with any
> +	other (local|remote|backup), default value is used.
> +	Default suffix is BASE.

