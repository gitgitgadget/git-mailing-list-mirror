Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A21C433FE
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 15:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355869AbiASPmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 10:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355871AbiASPmn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 10:42:43 -0500
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5BBC061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 07:42:43 -0800 (PST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        (Authenticated sender: jn.avila@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 87B7519F59C;
        Wed, 19 Jan 2022 16:42:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1642606960;
        bh=oV+urygafUu7KGZf5+lHndgtqcFzPdfH3mTesU2JUwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smxjlWYb4Yx367SqGHqSJNkjySunDFv66Jc8BNEbbfi6kOZmzCBWdXTxeU+M+RTR5
         JTVgbXBNwbcUFSLLy5rGOZlGSKDVj6t9qjVklFrK0TJmFcbFV2lHZuI2KCMsQ92a0F
         yfMT/V8EAz8PdKG0adDY2L74wFbaVUKyHbzCggL4W7OCAEheSftrhI3jy/cBnfPxi1
         cjv5tJgyQb8G8Hv3H9gr4x+EYpjEa/ioBBksQgNXEh6bwWbLqiaemS4PbUCZXvWDIo
         VGLdhnOmN35fXEcfuH71d4A6s9SBcn5l/lgYbrS1us/a47b93YVX2wz+2dusJkLs4M
         VMvE0kLi/M9yA==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 2/2] advice: refactor "action is not possible because you have unmerged files"
Date:   Wed, 19 Jan 2022 16:42:35 +0100
Message-ID: <3083234.G16DuhSZxH@cayenne>
In-Reply-To: <20220119094445.15542-3-bagasdotme@gmail.com>
References: <20220119094445.15542-1-bagasdotme@gmail.com> <20220119094445.15542-3-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, 19 January 2022 10:44:45 CET Bagas Sanjaya wrote:
> Factor action names (cherry-picking, committing, merging, pulling, and
> reverting) out of the message string.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  advice.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/advice.c b/advice.c
> index 1dfc91d176..4c72856478 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -175,15 +175,15 @@ void list_config_advices(struct string_list *list, 
const char *prefix)
>  int error_resolve_conflict(const char *me)
>  {
>  	if (!strcmp(me, "cherry-pick"))
> -		error(_("Cherry-picking is not possible because you 
have unmerged files."));
> +		error(_("%s is not possible because you have unmerged 
files."), "Cherry-picking");
>  	else if (!strcmp(me, "commit"))
> -		error(_("Committing is not possible because you have 
unmerged files."));
> +		error(_("%s is not possible because you have unmerged 
files."), "Commiting");
>  	else if (!strcmp(me, "merge"))
> -		error(_("Merging is not possible because you have 
unmerged files."));
> +		error(_("%s is not possible because you have unmerged 
files."), "Merging");
>  	else if (!strcmp(me, "pull"))
> -		error(_("Pulling is not possible because you have 
unmerged files."));
> +		error(_("%s is not possible because you have unmerged 
files."), "Pulling");
>  	else if (!strcmp(me, "revert"))
> -		error(_("Reverting is not possible because you have 
unmerged files."));
> +		error(_("%s is not possible because you have unmerged 
files."), "Reverting");
>  	else
>  		error(_("It is not possible to %s because you have 
unmerged files."),
>  			me);
> 

These strings don't qualify for factorization, because the words that you are 
extracting are English words that need to be translated. We can only extract 
words that are know to be constant, such as options, configuration, environment 
variables.

Playing grammar lego with sentences makes it impossible for translators to find 
a good translation.

JN



