From: Chris Mason <mason@suse.com>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 07:56:57 -0400
Message-ID: <200504280756.58293.mason@suse.com>
References: <200504271251.00635.mason@suse.com> <200504271831.47830.mason@suse.com> <20050428084156.GK17682@himi.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 13:52:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR7Ya-00081t-62
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 13:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVD1L5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 07:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVD1L5H
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 07:57:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:65505 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262087AbVD1L5D (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 07:57:03 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id B9157160DA76;
	Thu, 28 Apr 2005 13:57:02 +0200 (CEST)
To: simon@dreamcraft.com.au
User-Agent: KMail/1.8
In-Reply-To: <20050428084156.GK17682@himi.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 28 April 2005 04:41, Simon Fowler wrote:
> I've got a version of this written in C that I've been working on
> for a bit - some example output:
>
> +040000 tree    bfb75011c32589b282dd9c86621dadb0f0bb3866        ppc
> +100644 blob    5ba4fc5259b063dab6417c142938d987ee894fc0        ppc/sha1.c
> +100644 blob    c3c51aa4d487f2e85c02b0257c1f0b57d6158d76        ppc/sha1.h
> +100644 blob    e85611a4ef0598f45911357d0d2f1fc354039de4       
> ppc/sha1ppc.S commit
> b5af9107270171b79d46b099ee0b198e653f3a24->a6ef3518f9ac8a1c46a36c8d27173b1f7
>3d839c4
>
> You run it as:
> find-changes commit_id file_prefix ...
>
> The file_prefix is a path prefix to match - it's not as flexible as
> regexes, but it shouldn't be too much less useful.

I dropped the regexes for speed with diff-tree, they weren't that important to 
me...The features I was going for are:

1) ability to see the changeset comments in the output.
2) ability to look for revs on more than one file at a time.  The single file 
limit in bk revtool always bugged me.
3) Some quick cut n' paste method to generate the changeset diff.  This is why 
I do diff-tree -r in the output, so I can just copy into a different window 
and go.

Your c version would hopefully end up faster on cpu time by limiting the 
number of times we read/decompress the commit files.

-chris
