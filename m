Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232F020966
	for <e@80x24.org>; Wed,  5 Apr 2017 21:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934156AbdDEV0Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 17:26:25 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35974 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933970AbdDEV0X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 17:26:23 -0400
Received: by mail-pg0-f68.google.com with SMTP id 81so3783441pgh.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 14:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+4nzb0EKxB0K6+PsrIRs+ujZFOr+5Uu8ezirDosSbpI=;
        b=Ib7Tpr510ABYTe7oUTSrANfRuYMIfKid+8QDRIJSLYzkbsgTeXH7kqZ9e+ilEJxcOv
         ff7xumF8x8lWawv4ifITI31k5j6300HViOubayD2iT1qQXX37YcKlhHGws/TPjSUNMlm
         RqJVTP0av3HewSMrYfVk4u0hiDQuZZAeLurL2k4HawyW5LysHQ5/K9cYoJHE+ERdrneR
         fhUKUelYxi4G75NyXJ+MsiUGU29/eVWVcR5+DI/xs18DRdO+hcn+fwzRexxnF+nqXUQJ
         kS4Eaza9DIcFMMHcxOFNjfsGSyicgJmFkkI+cx68cEgvhh5LbnAybZuF+voNIAYu26LW
         6SHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+4nzb0EKxB0K6+PsrIRs+ujZFOr+5Uu8ezirDosSbpI=;
        b=QlHA3LudXWNaQ67zPTg2R3+rmecCcao01FW4lYv67iI3fERN2ctk15oS6DiezVK/+R
         PZuXnmtiHiZOvTtQw+UAPplNaSCt7tXAbbFgYyinanGyp7evkSiyARwruRDYw/yt2HLJ
         Z8f7xQkcjeCD5rXGt7IN9ODtZj+08Zw56sB1Juvmmg2hk4obqUN9JuOD51aRvLSsVxOU
         ja5l4RncL/NQJVb9+OYUfBx5ZS1kGrHDnWTDmTqN/ftRD8Cv4tnP6X8ZmORrpIBFCBVU
         7M46o6sHpK9C5CszdAHoPqS6Ngca4LrX5+1mMSJwYtU9RukzM4D9dRwCJjkrJcRUf+0z
         /Avg==
X-Gm-Message-State: AFeK/H1FRcBQz6Z1oNxQH0hg2lSLoI8eHlN+3xyR2FiwbkZNqhRp7s3UUoz1zRG87bndVA==
X-Received: by 10.98.24.9 with SMTP id 9mr11015374pfy.73.1491427582992;
        Wed, 05 Apr 2017 14:26:22 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55a8:b4cb:debd:758b])
        by smtp.gmail.com with ESMTPSA id x10sm39149366pff.72.2017.04.05.14.26.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 14:26:22 -0700 (PDT)
Date:   Wed, 5 Apr 2017 14:26:20 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 1/2] string-list: use ALLOC_GROW macro when reallocing
 string_list
Message-ID: <20170405212620.GG8741@aiede.mtv.corp.google.com>
References: <20170405195600.54801-1-git@jeffhostetler.com>
 <20170405195600.54801-2-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170405195600.54801-2-git@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git@jeffhostetler.com wrote:

> During status on a very large repo and there are many changes,
> a significant percentage of the total run time was spent
> reallocing the wt_status.changes array.

Nit: commit messages tend to use the present tense instead of the past
when describing Git's current behavior.  That makes it easier for
readers to tell whether you are describing the present or the distant
past.

> This change decreased the time in wt_status_collect_changes_worktree()
> from 125 seconds to 45 seconds on my very large repository.

Nice.

This is also just the right thing to do.  The linear growth would
produce potentially (potentially because you can be lucky and allocate
in the first place somewhere with a lot of room) quadratic behavior as
realloc copies the allocation to increasingly larger regions.

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  string-list.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/string-list.c b/string-list.c
> index 45016ad..cd4c4e0 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -41,10 +41,8 @@ static int add_entry(int insert_at, struct string_list *list, const char *string
>  	if (exact_match)
>  		return -1 - index;
>  
> -	if (list->nr + 1 >= list->alloc) {
> -		list->alloc += 32;
> -		REALLOC_ARRAY(list->items, list->alloc);
> -	}
> +	if (list->nr + 1 >= list->alloc)
> +		ALLOC_GROW(list->items, list->nr+1, list->alloc);

This checks for >= but ALLOC_GROW only grows when the new size is >.
The new code is less eager about growing than the old was, forcing me
to look at the other code to find the correct invariant.

Fortunately (1) string_list_append_nodup already uses ALLOC_GROW the
way this patch does and (2) REALLOC_ARRAY determines the meaning of
list->alloc.  The >= was just overeager and this is safe.

After removing the unnecessary 'if' as described by Stefan,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
