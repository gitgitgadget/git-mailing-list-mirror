Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A770CC433E2
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 12:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C41E208B3
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 12:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vivaldi.com header.i=@vivaldi.com header.b="mrGadnlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgIFMzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 08:55:55 -0400
Received: from mail.vivaldi.com ([31.209.137.20]:35470 "EHLO mail.vivaldi.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgIFMzu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 08:55:50 -0400
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Sep 2020 08:55:50 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.vivaldi.com (Postfix) with ESMTP id 13EA81F8141
        for <git@vger.kernel.org>; Sun,  6 Sep 2020 12:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vivaldi.com; h=
        user-agent:in-reply-to:message-id:organization:from:from
        :content-transfer-encoding:mime-version:date:date:references
        :subject:subject:content-type:content-type:received:received; s=
        2019; t=1599396468; bh=A1xCrI/HxL4VVTsB8xrcrB7MYHTNtuHVkhkw1f6RG
        UU=; b=mrGadnlV4yOtQ+v5ytU0+dukKxozqw/+z9oMMSuRK4bRcSi4/PvgVgInL
        lO412ZSJfxfYX9lAkqxRo8jDPntm/hMla9GllKBGWenrn9UV5zElo7vW8dc8ZPgc
        mOJ/76CtImrZ6xMPRVJ/fVM6EWlPmiBfg3QFWjHBfCvXfs66oz45NDv5n7izH0BJ
        CRn8yeO94ikV/oYAYBw8ehapOlA8Z7sttiM4tPOD1/W4+Xp7xoD0CpwK7r4Lde5K
        IUaU0JMOeA+ul+bTFboRBU+d3xWp3bUMHY3B32T9ANaFuluhcNhAjeiN2qFy1Q24
        a4huBd0ovXfIVnA+xCJsMtdhHYj6Q==
X-Virus-Scanned: Debian amavisd-new at vivaldi.com
Received: from mail.vivaldi.com ([127.0.0.1])
        by localhost (mail.vivaldi.com [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YtMmBf2mjsRA for <git@vger.kernel.org>;
        Sun,  6 Sep 2020 12:47:48 +0000 (UTC)
Received: from rowan.vivaldi (195-159-146-211.customer.powertech.no [195.159.146.211])
        by mail.vivaldi.com (Postfix) with ESMTPSA id A70261F810C
        for <git@vger.kernel.org>; Sun,  6 Sep 2020 12:47:48 +0000 (UTC)
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     git@vger.kernel.org
Subject: Re: Git error message "Server does not allow request for unadvertised
 object"  
References: <op.0ks2w7r1pvqxoc@rowan.vivaldi>
Date:   Sun, 06 Sep 2020 14:47:47 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Yngve N. Pettersen" <yngve@vivaldi.com>
Organization: Vivaldi Technologies AS
Message-ID: <op.0qiwhxykpvqxoc@rowan.vivaldi>
In-Reply-To: <op.0ks2w7r1pvqxoc@rowan.vivaldi>
User-Agent: Opera Mail/1.0 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello again,

I wondered what is happening about this issue?

This continues to cause problems, especially now that Mac is using Git  
2.21 (without AFAICT any way to revert to 2.17).

The most recent case was last night, after a Work In Progress branch (that  
is, it was not used by any production code) in a submodule was pushed, but  
updates for at least one of the submodules wasn't pushed. Three different  
Mac autobuild jobs broke because of this error and had to be restarted.


On Mon, 18 May 2020 11:20:57 +0200, Yngve N. Pettersen <yngve@vivaldi.com>  
wrote:

> Hello all,
>
> A while back I reported an issue to the Windows Git project  
> <https://github.com/git-for-windows/git/issues/2218> that I observed in  
> Git for Windows 2.21.
>
> The error message "Server does not allow request for unadvertised  
> object" is reported when a commit updating a submodule pointer points to  
> a commit that does not exist in the repository for that submodule, even  
> if later commits in the branch points to a commit that do exist in the  
> submodule repo.
>
> This circumstance can easily occur if a developer (e.g)
>
>   * interactively rebases a branch "foo" in the submodule (e.g to  
> integrate commits from another branch before a larger rebase)
>   * commits the resulting submodule pointer "A" in the branch to the  
> parent repo
>   * then do further rebasing in the submodule, e.g to move up on top of  
> the "bar" branch
>   * commits that pointer "B" to the parent repo
>   * forgets to squash the history in the parent repo
>   * pushes the updated submodule "foo" branch to the online repo. (NOTE:  
> "B" is pushed, not "A")
>   * pushes the parent module branch to its online repo
>
> When the parent repo is pulled by another developer, or an autobuild  
> system, the fetch operation fails with the message "Server does not  
> allow request for unadvertised object". A second fetch will complete  
> successfully.
>
> IMO this kind of check should only happen if a commit with pointer to a  
> missing submodule is actively checked out. At most the above message  
> should be a warning, not a fatal error.
>
> For manual fetch operations this is mostly a nuisance, but for  
> autobuilders this breaks the update operation, and the entire build  
> operation fails. That is unacceptable behavior in an automatic system  
> (errors if it breaks the checkout, yes; issues that are not relevant to  
> the actual checkout, no).
>
> This issue prevents upgrading past 2.17 (since 2.18 and 2.19 had other  
> blocking issues, and 2.20 apparently introduced this issue). I have not  
> tested 2.22+ since I have not noticed any changelog messages that seem  
> related.
>
> A test case can be found in issue 2218, linked above.
>
> For reference, we do have a server-side git hook that verifies that  
> submodule pointers for the production branch is correct and exists in  
> the submodule's repo, and also is on branches that follows certain  
> naming conventions.
>
>
> As an aside, I think this kind of error message would be have been  
> better suited as either a client-side push check, to prevent pushes of  
> references to such missing commits (Smartgit seems to have something  
> like it, but I think it only checks for the current branch in the  
> submodule, not all submodule reference commits). Alternatively, there  
> could be a check of this server-side.
>
>
> Related to this, but not as problematic, just irritating, and also seen  
> in 2.17, is a message "warning: Submodule in commit deadbee at path:  
> '(NULL)' collides with a submodule named the same. Skipping it." I think  
> it is related to recreating a git modules file on a different branch.
>


-- 
Sincerely,
Yngve N. Pettersen
Vivaldi Technologies AS
