Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA66C77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 20:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjDJUS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 16:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDJUSz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 16:18:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3F81715
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 13:18:54 -0700 (PDT)
Received: (qmail 2978 invoked by uid 109); 10 Apr 2023 20:18:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 Apr 2023 20:18:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 654 invoked by uid 111); 10 Apr 2023 20:18:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Apr 2023 16:18:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Apr 2023 16:18:53 -0400
From:   Jeff King <peff@peff.net>
To:     Mervin Guy <mail@mervin.works>
Cc:     git@vger.kernel.org
Subject: Re: 'git config --edit' unexpected behavior
Message-ID: <20230410201853.GD104097@coredump.intra.peff.net>
References: <0E8CDEA4-21CC-4CF1-809F-3FE37849ED47@mervin.works>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0E8CDEA4-21CC-4CF1-809F-3FE37849ED47@mervin.works>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2023 at 03:44:26PM -0400, Mervin Guy wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> - Changed my directory to a git-repo I was working on, using 'cd <directory_name>'. Then I ran 'git config --global -e'.
> 
> What did you expect to happen? (Expected behavior)
> 
> - I exepected the command to display my current-config file, with all settings included, in my editor.
> 
> What happened instead? (Actual behavior)
> 
> - My config-file was overwritten and displayed a default-setup message, the config-file was lost after this point.
>   I experimented with different ways of activating the command, but they all led to an overwrite of the file.

That's certainly unexpected. "git config --global -e" works fine for me.
And Git itself won't overwrite the file; it will run your editor with
the name of the file, and the editor is responsible for any writing.
Which editor are you trying to use? Can you try running with:

  GIT_TRACE=1 git config --global -e

which should show the editor command that Git runs.

-Peff
