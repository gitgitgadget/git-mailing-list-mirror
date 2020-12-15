Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6168C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 14:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743BB22518
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 14:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgLOOYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgLOOYG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 09:24:06 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6518C06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 06:23:26 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id h18so19474377otq.12
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 06:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ep+pwtSsCFPDKfGklf2FQU1N0RhCfjUaI3fZQXUuTFc=;
        b=N7KIxn0W8oKdu3M64VsKzvb80ulAbqvtVxwWBEezWdyrrDVmecpcHBCeTCGxH0aiPn
         EvhA730aKCdUWahFt7ErLcRMeZyGZUa0jkXcIDFmKglwyM3qdzPQ5oEoIJAxmMrzlhuf
         owJHKHHS8klHD3sFD09S6skNSERyNpRoc5a0Oth/z885KI5VqGNHjZ1DeAe0dCqscZ+5
         MPReVAr03FG7eeYWJChpJxQ3SBq53c8A0vbzh2Pylu9MD31f8bpzWuNRQ7tfm8pJzeWk
         umrQoNd/VQSznJC5nbRq7fvIPXm8gfU7zjRHJ8Cqd056kpwf84sH5bGtPFncKpv4D08m
         X2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ep+pwtSsCFPDKfGklf2FQU1N0RhCfjUaI3fZQXUuTFc=;
        b=OxRPeidebvXs/BOqRNdU9DGnMoHgENIdOnDe7wJqIC1W3iUMkUC5mPkjICaf80Td/J
         pis2n5YZ6iqOi/+xQ+KfLoSC+GEoo1D7gPbCKYN+pZK+stSc/Xppkl9X2iOMYIj+fLK7
         stRf5XrEZD3vtOA1sfAysyHxH/SBtlZTtUZErh0LDPM/WRgcq3kGckUhadekw0h5jc2P
         n8fbz41q0MWtIudNpNOm7J/3D2qZlMrvL+kXYPoUYtf+vOdSAA+LrIeVY0J6LRSuH9tH
         oFwOmy0klk3pxPGNm7irGr+Tg/oukq+Z82rv4bwge1gXVqI9T6BjwmSPVyMvWso9QKm7
         T54w==
X-Gm-Message-State: AOAM533Ar+Hn4zi1gYeW99nh7VtdOE1NAzaTZvUJ4II9NH4PAHHCWq+8
        oi1Bx3xekqx7Z8dzxysjIt4=
X-Google-Smtp-Source: ABdhPJxNQXpnioXNqZAm3q9KRvXAqoWdiKSORqcmFQszdgftl8YvCfG4FFhwW0lqQGqkDepX3NFseg==
X-Received: by 2002:a05:6830:3156:: with SMTP id c22mr22949351ots.16.1608042205788;
        Tue, 15 Dec 2020 06:23:25 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id p4sm5106977oib.24.2020.12.15.06.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 06:23:25 -0800 (PST)
Subject: Re: [PATCH v2 09/11] merge-ort: add implementation of rename/delete
 conflicts
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
 <f017534243c967caa0137e6899f4e1c69ff02c2e.1607962900.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <05f52d13-d9ec-226d-370a-140937b12e7a@gmail.com>
Date:   Tue, 15 Dec 2020 09:23:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <f017534243c967caa0137e6899f4e1c69ff02c2e.1607962900.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14/2020 11:21 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Implement rename/delete conflicts, i.e. one side renames a file and the
> other deletes the file.  This code replaces the following from
> merge-recurisve.c:
> 
>   * the code relevant to RENAME_DELETE in process_renames()
>   * the RENAME_DELETE case of process_entry()
>   * handle_rename_delete()
> 
> Also, there is some shared code from merge-recursive.c for multiple
> different rename cases which we will no longer need for this case (or
> other rename cases):
> 
>   * handle_change_delete()
>   * setup_rename_conflict_info()
> 
> The consolidation of five separate codepaths into one is made possible
> by a change in design: process_renames() tweaks the conflict_info
> entries within opt->priv->paths such that process_entry() can then
> handle all the non-rename conflict types (directory/file, modify/delete,
> etc.) orthogonally.  This means we're much less likely to miss special
> implementation of some kind of combination of conflict types (see
> commits brought in by 66c62eaec6 ("Merge branch 'en/merge-tests'",
> 2020-11-18), especially commit ef52778708 ("merge tests: expect improved
> directory/file conflict handling in ort", 2020-10-26) for more details).
> That, together with letting worktree/index updating be handled
> orthogonally in the merge_switch_to_result() function, dramatically
> simplifies the code for various special rename cases.
> 
> To be fair, there is a _slight_ tweak to process_entry() here, because
> rename/delete cases will also trigger the modify/delete codepath.
> However, we only want a modify/delete message to be printed for a
> rename/delete conflict if there is a content change in the renamed file
> in addition to the rename.  So process_renames() and process_entry()
> aren't quite fully orthogonal, but they are pretty close.

Thanks for adding this warning about the change to process_entry().

> @@ -657,6 +657,7 @@ static int process_renames(struct merge_options *opt,
>  		unsigned int old_sidemask;
>  		int target_index, other_source_index;
>  		int source_deleted, collision, type_changed;
> +		const char *rename_branch = NULL, *delete_branch = NULL;

Ah, here they are!

> +		if (source_deleted) {
> +			if (target_index == 1) {
> +				rename_branch = opt->branch1;
> +				delete_branch = opt->branch2;
> +			} else {
> +				rename_branch = opt->branch2;
> +				delete_branch = opt->branch1;
> +			}
>  		}
>  
>  		assert(source_deleted || oldinfo->filemask & old_sidemask);
> @@ -838,13 +847,26 @@ static int process_renames(struct merge_options *opt,
>  				   "to %s in %s, but deleted in %s."),
>  				 oldpath, newpath, rename_branch, delete_branch);

This context line is the previous use of rename_branch and delete_branch.
Perhaps the declarations, initialization, and first-use here are worth
their own patch?

>  		} else {
> +			/*
> +			 * a few different cases...start by copying the
> +			 * existing stage(s) from oldinfo over the newinfo
> +			 * and update the pathname(s).
> +			 */
> +			memcpy(&newinfo->stages[0], &oldinfo->stages[0],
> +			       sizeof(newinfo->stages[0]));
> +			newinfo->filemask |= (1 << MERGE_BASE);
> +			newinfo->pathnames[0] = oldpath;
>  			if (type_changed) {
>  				/* rename vs. typechange */
>  				die("Not yet implemented");
>  			} else if (source_deleted) {
>  				/* rename/delete */
> +				newinfo->path_conflict = 1;
> +				path_msg(opt, newpath, 0,
> +					 _("CONFLICT (rename/delete): %s renamed"
> +					   " to %s in %s, but deleted in %s."),
> +					 oldpath, newpath,
> +					 rename_branch, delete_branch);

Since the primary purpose of rename_branch and delete_branch appears to
be for these error messages, then likely the previous error message about
a rename/delete should just be promoted into this patch instead of the
previous.

In fact, the error messages are the exact same, but with slightly different
lines due to wrapping:

			path_msg(opt, newpath, 0,
				 _("CONFLICT (rename/delete): %s renamed "
				   "to %s in %s, but deleted in %s."),
				 oldpath, newpath, rename_branch, delete_branch);

and

				path_msg(opt, newpath, 0,
					 _("CONFLICT (rename/delete): %s renamed"
					   " to %s in %s, but deleted in %s."),
					 oldpath, newpath,
					 rename_branch, delete_branch);

I wonder if there is a way to group these together? Perhaps the nested
if/else if/else blocks could store a "conflict state" value that says
which CONFLICT message to print after the complicated branching is done.

Alternatively, this message appears to be written in the following case:

	source_deleted && !type_changed

your if/else if/else block could be rearranged as follows:

	if (collision && !source_deleted)
		/* collision: rename/add or rename/rename(2to1) */
	else if (!type_change && source_deleted)
		/* rename/delete or rename/add/delete or rename/rename(2to1)/delete */
	else if (!collision)
		/* a few different cases */

Of course, the thing I am missing is that copy of oldinfo->stages[0] into
newinfo->stages[0] along with changes to the filemask and pathnames! That
is likely why you need the two different markers, because the cases truly
are different in that subtle way.

>  				/* normal rename */
>  				die("Not yet implemented");
> @@ -1380,12 +1402,21 @@ static void process_entry(struct merge_options *opt,
>  		modify_branch = (side == 1) ? opt->branch1 : opt->branch2;
>  		delete_branch = (side == 1) ? opt->branch2 : opt->branch1;
>  
> -		path_msg(opt, path, 0,
> -			 _("CONFLICT (modify/delete): %s deleted in %s "
> -			   "and modified in %s.  Version %s of %s left "
> -			   "in tree."),
> -			 path, delete_branch, modify_branch,
> -			 modify_branch, path);
> +		if (ci->path_conflict &&
> +		    oideq(&ci->stages[0].oid, &ci->stages[side].oid)) {
> +			/*
> +			 * This came from a rename/delete; no action to take,
> +			 * but avoid printing "modify/delete" conflict notice
> +			 * since the contents were not modified.
> +			 */
> +		} else {
> +			path_msg(opt, path, 0,
> +				 _("CONFLICT (modify/delete): %s deleted in %s "
> +				   "and modified in %s.  Version %s of %s left "
> +				   "in tree."),
> +				 path, delete_branch, modify_branch,
> +				 modify_branch, path);
> +		}

Thanks,
-Stolee
