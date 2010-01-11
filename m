From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Problem creating commits/trees with commit-tree/mktree
Date: Mon, 11 Jan 2010 10:17:12 -0800
Message-ID: <20100111181712.GQ32155@spearce.org>
References: <f6d77fed1001111014g73a06923na05cd14d37968b04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gavin Beatty <gavinbeatty@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 19:17:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUOpO-0000Yv-7B
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 19:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab0AKSRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 13:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189Ab0AKSRS
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 13:17:18 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:65393 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab0AKSRS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 13:17:18 -0500
Received: by ywh6 with SMTP id 6so21670950ywh.4
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 10:17:17 -0800 (PST)
Received: by 10.150.81.6 with SMTP id e6mr20308176ybb.93.1263233837363;
        Mon, 11 Jan 2010 10:17:17 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 15sm10536939yxh.40.2010.01.11.10.17.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Jan 2010 10:17:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <f6d77fed1001111014g73a06923na05cd14d37968b04@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136650>

Gavin Beatty <gavinbeatty@gmail.com> wrote:
> I want to write commits to a branch without touching the index or
> having a checkout (for a git subcommand I'm writing).
> 
> I can create new blobs and trees but can't figure out how to commit a
> new tree/blob _with_ the old tree.
> 
> Currently, I do something a lot like:
> 
> objsha=$(echo 'contents' | git hash-object -w --stdin)
> objtreesha=$(printf "100644 blob $objsha\tfile.txt\000" | git mktree -z)
> newtreesha=$(printf "040000 tree $objtreesha\ttreefileisin\000" | git mktree -z)

You aren't feeding in the old tree contents as part of this command.

If you are really doing this via a script, you should look at
git-fast-import.  Its faster, and its language better supports
this notion of editing an existing tree.

-- 
Shawn.
