Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6E5C2BBCD
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 14:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDC2224BE
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 14:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgLOOKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgLOOKB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 09:10:01 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363D5C06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 06:09:21 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id 15so23420929oix.8
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 06:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pD/rPlu5dmA8oc+xi4zpHwncnHk71PrttPw2lfgcvXY=;
        b=Gu+JnhcWRIDi3xMir/+nYl/pnbqnxxZ6yHq9EwB8/sHeUCxPPuJaneV4KihP0iRXCa
         k/qsirMQipJKlO3Cd1Bx6BpBoomMnVAbUqZ99l7gLnWSwkKD39xpdXRI/3JvJ62Z0gdk
         FBYXGiR0edNM2kmn4KlzQ6FAnexhBa+H59KwBfx/jDKtnKwt09GdqC5Rd19/AM73tY1d
         Wu3jrRnFjbaGP06cwDnhlMc7a6rElDF1bxs5QRMbAcrRmnH+wRjUyxH9ARiZwGqpQdd2
         2gJfUiDknxXURoaV4PIJfB6HBARGxQT8MRd16wSsUVL1/JI4aeriugZMlId1NAi049Ah
         oIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pD/rPlu5dmA8oc+xi4zpHwncnHk71PrttPw2lfgcvXY=;
        b=GBM7Zv3j6HvYJconhDTxa1O5N66Bj5b0CAHF2Go5oMSbjEPE73/wS9lLUldywRyZ33
         LhN5vjPeL0fbwXgoCBPZlmY8ydBhMaqqBpcXqddbIrmMhx/7i/kwy82fyWIbSEGYf2iX
         fJWn5vqTGCTzW3mjOGjCBGMeyWm8AnKPVgRTG7dnVm1LGkISEIdsgg7If0by4jjrqFKQ
         HNJxw+0U3PwYhnWwC2dRp9bcHyO2nJI9g9EMsw66Hhicwc6Wr1zfRBMOw5daBbxKxYsm
         Dk7ON0jeab5VtwIhsG7KFEg8QOqz025LTw1oQ+AbKltGrHwFKyl16qxHjhP47iJEuO2f
         1kGQ==
X-Gm-Message-State: AOAM531FIFky/LBmBkcGAfHyEmw9OdeLjtuzywjyernOSrwwIU3PcvJ8
        AqE7532zgEXv5NDBc4C+jB/j4qv2xPF7aQ==
X-Google-Smtp-Source: ABdhPJxOX0Ar3yhQSRN0uM/tYHgum7Bo/sbCbMeijpUX1e5+EOtjyRGG7xtX930iMowEhDQiOeD/Uw==
X-Received: by 2002:aca:4d8b:: with SMTP id a133mr22239200oib.79.1608041360532;
        Tue, 15 Dec 2020 06:09:20 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id o63sm4755715ooa.10.2020.12.15.06.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 06:09:19 -0800 (PST)
Subject: Re: [PATCH v2 08/11] merge-ort: add implementation of rename
 collisions
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
 <edd610321a053b431def5b06bb2983c7f4a84547.1607962900.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <48fc65a5-12ba-be67-2908-27a446b1f813@gmail.com>
Date:   Tue, 15 Dec 2020 09:09:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <edd610321a053b431def5b06bb2983c7f4a84547.1607962900.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14/2020 11:21 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Implement rename/rename(2to1) and rename/add handling, i.e. a file is
> renamed into a location where another file is added (with that other
> file either being a plain add or itself coming from a rename).  Note
> that rename collisions can also have a special case stacked on top: the
> file being renamed on one side of history is deleted on the other
> (yielding either a rename/add/delete conflict or perhaps a
> rename/rename(2to1)/delete[/delete]) conflict.
> 
> One thing to note here is that when there is a double rename, the code
> in question only handles one of them at a time; a later iteration
> through the loop will handle the other.  After they've both been
> handled, process_entry()'s normal add/add code can handle the collision.
> 
> This code replaces the following from merge-recurisve.c:
> 
>   * all the 2to1 code in process_renames()
>   * the RENAME_TWO_FILES_TO_ONE case of process_entry()
>   * handle_rename_rename_2to1()
>   * handle_rename_add()
> 
> Also, there is some shared code from merge-recursive.c for multiple
> different rename cases which we will no longer need for this case (or
> other rename cases):
> 
>   * handle_file_collision()
>   * setup_rename_conflict_info()
> 
> The consolidation of six separate codepaths into one is made possible
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

I'm really happy that you broke out the cases earlier, and describe
them so well in the message. It makes this hunk of code really easy
to understand:

> +			const char *pathnames[3];
> +			struct version_info merged;
> +
> +			struct conflict_info *base, *side1, *side2;
> +			unsigned clean;
> +
> +			pathnames[0] = oldpath;
> +			pathnames[other_source_index] = oldpath;
> +			pathnames[target_index] = newpath;
> +
> +			base = strmap_get(&opt->priv->paths, pathnames[0]);
> +			side1 = strmap_get(&opt->priv->paths, pathnames[1]);
> +			side2 = strmap_get(&opt->priv->paths, pathnames[2]);
> +
> +			VERIFY_CI(base);
> +			VERIFY_CI(side1);
> +			VERIFY_CI(side2);
> +
> +			clean = handle_content_merge(opt, pair->one->path,
> +						     &base->stages[0],
> +						     &side1->stages[1],
> +						     &side2->stages[2],
> +						     pathnames,
> +						     1 + 2*opt->priv->call_depth,

nit: " * "

> +						     &merged);
> +
> +			memcpy(&newinfo->stages[target_index], &merged,
> +			       sizeof(merged));
> +			if (!clean) {
> +				path_msg(opt, newpath, 0,
> +					 _("CONFLICT (rename involved in "
> +					   "collision): rename of %s -> %s has "
> +					   "content conflicts AND collides "
> +					   "with another path; this may result "
> +					   "in nested conflict markers."),
> +					 oldpath, newpath);

I was briefly taken aback by "AND collides with another path" wondering if
that wording helps users understand the type of conflict here. But I can't
think of anything better, so *shrug*.

> +			}
>  		} else if (collision && source_deleted) {
> -			/* rename/add/delete or rename/rename(2to1)/delete */
> -			die("Not yet implemented");
> +			/*
> +			 * rename/add/delete or rename/rename(2to1)/delete:
> +			 * since oldpath was deleted on the side that didn't
> +			 * do the rename, there's not much of a content merge
> +			 * we can do for the rename.  oldinfo->merged.is_null
> +			 * was already set, so we just leave things as-is so
> +			 * they look like an add/add conflict.
> +			 */
> +
> +			newinfo->path_conflict = 1;
> +			path_msg(opt, newpath, 0,
> +				 _("CONFLICT (rename/delete): %s renamed "
> +				   "to %s in %s, but deleted in %s."),
> +				 oldpath, newpath, rename_branch, delete_branch);

I think this branch is added in the wrong patch. My compiler is complaining
that 'rename_branch' and 'delete_branch' are not declared (yet).

Thanks,
-Stolee
