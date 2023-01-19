Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ADDC46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 10:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjASKtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 05:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjASKtM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 05:49:12 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB4D4A1CF
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 02:48:35 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hw16so4514307ejc.10
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 02:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+bZskYdLXgn8KrTS7FouapbRMAMS61Om2ti4P6eLc8=;
        b=JZyRFXcfdWW6o0sgXUrHGSN/9zocMCIXzVsD+5LvYkpt6J6M+FZrdG5SPeeKIV/RSO
         c4CS674S4ky3vb8xQGhKP+vlkUKCezqMsP204C/zzsE/5ySOMzLABsfcsqCxNa2ZPkal
         /dgsbY2fqvoBCVUsn8mVdJHnRjmwFSXZwDAKJDMidrZ2UXDJlgBIZ4rYd8UJtM0M+Jm6
         LuMshsQfIt9Ehr23DEs7WXmvu1454hEA5nruBPnrc1Jqlhz2eE0XqEQS9To/UJFvMvxI
         7xxifP+lMgMZ+MQxHl9ysyqKKcIb3IBm0niBLPUcXIaoTDePbOQWuWb3JoCOJ2sDJDcP
         x9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+bZskYdLXgn8KrTS7FouapbRMAMS61Om2ti4P6eLc8=;
        b=w7CHH9//8lu8xr7zwr1WPCq/N8iQ6UJASn6OQI2twSzbehS9oDmRxb3fN5nG3mC4CG
         1HpZjMZNA7Js1ppA4Coas+jiLBThONkuhIjgyMvsY7roBrPnT5Q68OMWNWtzAmmR+lNN
         RtBRMqtJy0fTbnpiOW+ckELDhggG76pJAbJItizxgOFMAAyDjDoIHJYpGIk78IWeDP4N
         NKSC2I//GXL3mnxWA1PO6m1w1r91GtNyWqwj8HQrCVmZH3AuLrZSiITsq5CqtD651j5W
         i2z1tn5A6AuIxyLOveGfdFKo0uSNix4XCSONcoHaOrvt0MIRBPBlp619KmEDxBtn40oq
         S1Mw==
X-Gm-Message-State: AFqh2krzEYSN+fWco9/sc5QzKN+Ri59bTECMICBZj7EEmzkSdTh9EnoE
        h77euwR+9dhWY1r3jTFitjroRVr57no=
X-Google-Smtp-Source: AMrXdXvzRKuqhIHiQfXXxHHxzHDpWm04hsttWn1BapdxAhvoHC8YXqDY7RgWuRZU5/J4BXEWVJQC8g==
X-Received: by 2002:a17:907:2bdf:b0:86e:38ae:8713 with SMTP id gv31-20020a1709072bdf00b0086e38ae8713mr9564215ejc.51.1674125314297;
        Thu, 19 Jan 2023 02:48:34 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id la17-20020a170907781100b0084d3f3f9984sm14353447ejc.114.2023.01.19.02.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 02:48:33 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <cedc93ec-aa6f-65bf-65be-0dca3d4d0186@dunelm.org.uk>
Date:   Thu, 19 Jan 2023 10:48:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] worktree: teach find_shared_symref to ignore current
 worktree
Content-Language: en-US
To:     =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <xmqqilh491y6.fsf@gitster.g> <f209958f-e824-181b-f9d5-6e4bc8e53646@gmail.com>
In-Reply-To: <f209958f-e824-181b-f9d5-6e4bc8e53646@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rubén

On 18/01/2023 23:50, Rubén Justo wrote:
> On 17-ene-2023 15:27:29, Junio C Hamano wrote:
> 
>> being solved. Rather, it is unclear what problem you are solving.
> 
> Sorry, I didn't explain the motivation well in the message.

I'm afraid I'm still not totally clear from this message exactly what 
the problem is. Having looked at die_if_checked_out() I think it maybe 
the second of Junio's options

  - If the current branch the the current worktree is checked out in
    a different worktree, we get the current worktree back.

Here is the function:

void die_if_checked_out(const char *branch, int ignore_current_worktree)
{
	struct worktree **worktrees = get_worktrees();
	const struct worktree *wt;

	wt = find_shared_symref(worktrees, "HEAD", branch);
	if (wt && (!ignore_current_worktree || !wt->is_current)) {
		skip_prefix(branch, "refs/heads/", &branch);
		die(_("'%s' is already checked out at '%s'"), branch, wt->path);
	}

	free_worktrees(worktrees);
}


It takes a flag to ignore the current worktree but uses 
find_shared_symref() which does not have such a flag to see if the 
branch is checked out. This means that if a branch is checkout out twice 
find_shared_symref() may return the current worktree rather than the one 
we're interested in.

If that is the problem you're trying to solve I think it would be better 
to keep the signature of find_shared_symref() the same and add a helper 
function that is called by die_if_checked_out() and find_shared_symref() 
which can optionally ignore the current worktree. The commit message for 
such a patch should explain you're fixing a bug rather than trying to 
change the existing behavior.

Best Wishes

Phillip


> First, I'm not sure if "ignore_current_worktree" is correct, maybe needs
> to be "prefer_current_worktree".  Having said that, let me use an example.
> 
> With...
> 
> 	$ git worktree add wt1 -b main
> 	$ git worktree add wt2 -f main
> 
> ... we get confuse results:
> 
> 	$ git -C wt1 rebase main main
> 	Current branch main is up to date.
> 	$ git -C wt2 rebase main main
> 	fatal: 'main' is already checked out...
> 
> The problem I'm trying to solve is that find_shared_symref() returns the
> first matching worktree, and a possible matching "current worktree"
> might not be the first matching one.  That's why die_if_checked_out()
> dies with "git -C wt2".
> 
> find_shared_symref() searches through the list of worktrees that
> get_worktrees() composes: first the main worktree and then, as getdir()
> returns them, those in .git/worktrees/*.  The search is sequential and
> once a match is found, it is returned.  And so die_if_checked_out(),
> when asked to "ignore_current_worktree", is going to consider for
> "is_current" the worktree which may or may not be the "current" one,
> depending on the sequence from get_worktree(), and getdir() ultimately.
> 
> If we want to disallow operations on a worktree with a checked out
> branch also on another worktree, we need the "ignore_current_worktree".
> But, and now I'm more in favor of this, if we prefer to allow the
> operation, we need a "prefer_current_worktree", to induce
> find_shared_symref() to return the "current" one if it matches, or any
> other one that matches.
