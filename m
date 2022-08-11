Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFDDC19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 15:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiHKPvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbiHKPu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 11:50:29 -0400
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4976A9DB53
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 08:42:20 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4M3WJm26bmz5tlB;
        Thu, 11 Aug 2022 17:42:16 +0200 (CEST)
Message-ID: <a4c937ed-ea89-0564-db64-f0634fe7eeee@kdbg.org>
Date:   Thu, 11 Aug 2022 17:42:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Fwd: Idea: add --squash to cherry-pick
Content-Language: en-US
To:     Noam Yorav-Raphael <noamraph@gmail.com>
References: <CAO8o=D6p+aFOeRdTDHwPa1E+V45Uqh-TuSZbz0WU=rE-ksGj_w@mail.gmail.com>
 <CAO8o=D7QC71mnyKSceMpYJzVO4=POva=mJQ1bi0teUHPB9xesA@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
In-Reply-To: <CAO8o=D7QC71mnyKSceMpYJzVO4=POva=mJQ1bi0teUHPB9xesA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.22 um 10:53 schrieb Noam Yorav-Raphael:
> The need is described in this Stack Overflow question:
> https://stackoverflow.com/q/35123108. It's fairly popular (107 votes
> for the question, 154 for the best answer), but I find the suggested
> solution lacking.
> 
> Basically, I would like to add a flag --squash to the cherry-pick
> command, that would apply the diff between the start and end of the
> specified range in one operation.
> 
> The use case is that there's a feature branch which I would like to
> apply on another branch as one commit.
> 
> I could use the `-n` flag to apply all the commits from the source
> branch without committing them. However, if there are conflicts, I
> would have to deal with them on every commit applied. Instead, what I
> want is to just apply the diff between the first and last commit, and
> then deal with the conflicts.
> 
> I find this to be a very natural operation. Usual cherry-pick applies
> the difference between commit A^ and commit A over HEAD. The suggested
> `git cherry-pick --squash A..B` would apply the difference between
> commit A and commit B over HEAD.

That question on Stackoverflow asks "how to do X with Y". But Y (git
cherry-pick) is the wrong tool to do X (apply commits from a branch to
somewhere else in squashed form).

   git diff A...B | git apply --3way

would do what you want. You would have to come up with a new commit
message anyway, so cherry-pick would be of little use there.

-- Hannes
