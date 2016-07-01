Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9E542018A
	for <e@80x24.org>; Fri,  1 Jul 2016 14:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbcGAOU0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 10:20:26 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57178 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752526AbcGAOUX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2016 10:20:23 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 6C040201BA;
	Fri,  1 Jul 2016 10:20:22 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute7.internal (MEProxy); Fri, 01 Jul 2016 10:20:22 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=qed0R3+CyTXCjh0IW/ugxIFLK5w=; b=XZKWSd
	MZo5bU/PyJrmxfUd2RZJ4IPq4ViInTH3LcWGDRn53c5PUpo1dPzlKa7jHVnm//lw
	dZruz62pnHPGQHQuvlN6QkomWViDKTm6Cx3z++TMI+f1XWqiHwxEI1qfs1ICRMRc
	sguGwNWViqSbbcpVizFGUgReKd95/DX6Ak5QU=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=qed0R3+CyTXCjh0
	IW/ugxIFLK5w=; b=jPi11Jj+sNSk2P+YTopha9o/pM85h/QSlpuuX3kmUK0zOkS
	MpXxNnNyOXyD0eMG1JH1mg0OhkiSMk6Q19L9ofuNuXX0D0AoA9QPGGOpVjzqaH5O
	XAlAUgUh4O/kzN+d+VaoiR5xq30cfS+62t/oVGhXxixye+/3BfPe0Y110dZ0=
X-Sasl-enc: qVbzDyeMjUZK02BSVDa1O0h1KdLVJmlTD4K7T3gOYB7h 1467382822
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8453BF29F4;
	Fri,  1 Jul 2016 10:20:21 -0400 (EDT)
Subject: Re: [PATCH] log: decorate HEAD -> branch with the same color for
 branch and HEAD
To:	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
	<pclouds@gmail.com>
References: <20160630163942.8353-1-pclouds@gmail.com>
 <20160701063129.GC5358@sigill.intra.peff.net>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	git@drmicha.warpmail.net, j.cretel@umail.ucc.ie
From:	Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <a7d7d959-1189-8170-04f4-ab097202ff45@drmicha.warpmail.net>
Date:	Fri, 1 Jul 2016 16:20:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160701063129.GC5358@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King venit, vidit, dixit 01.07.2016 08:31:
> On Thu, Jun 30, 2016 at 06:39:42PM +0200, Nguyễn Thái Ngọc Duy wrote:
> 
>> Commit 76c61fb (log: decorate HEAD with branch name under
>> --decorate=full, too - 2015-05-13) adds "HEAD -> branch" decoration to
>> show current branch vs detached HEAD. The sign of whether HEAD is
>> detached or not is "->" (vs ", "). It's too subtle for my poor
>> eyes. If color is used, we can make the branch name's color the same
>> as HEAD to visually emphasize that it's the current branch.
> 
> Hmm. I think I like this, as it uses color to make the grouping between
> HEAD and its referent more clear.
> 
> We do already use colors to indicate "type", though. Which means:
> 
>   1. The branch now uses the "symref" color. Probably OK, as that is the
>      point of the grouping (I wonder if the "->" in the middle should
>      match in color, too).
> 
>   2. We used to color based on current_and_HEAD->type, but now that
>      information isn't conveyed. However, can this really ever have been
>      anything _except_ a branch?
> 
> -Peff
> 

So, I rechecked, and I'm afraid I don't like the proposal.

Currently, we have a clear color code that colors refs according their
type (local branch, remote branch, tag, symref). This also corresponds
to status colors, for example.

Under the proposal, a checked out branch would not be colored like a
local branch - note that back then, the result of the discussion was:

- If a branch foo is checked out, do not decorate by "foo", but amend
the HEAD decoration with "foo" and a symbol that denotes the connection.

So, "HEAD -> foo" is an intentional union of two decorations.

I wouldn't mind changing the color of "- > foo" if it were just an
addition to "HEAD", but it is not - it's the decoration by the local
branch foo.

With git branch, we use "*" as a symbol for the checked out branch...

Michael
