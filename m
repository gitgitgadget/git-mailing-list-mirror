X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-recursive: configurable 'merge' program
Date: Tue, 5 Dec 2006 15:07:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612051459380.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061204235647.9BA8B139B0E@magnus.utsl.gen.nz> <el2cpj$cna$1@sea.gmane.org>
 <Pine.LNX.4.63.0612050836570.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612051123.33210.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 14:07:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612051123.33210.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33341>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grax0-0002x4-IY for gcvg-git@gmane.org; Tue, 05 Dec
 2006 15:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759986AbWLEOHK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 09:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760026AbWLEOHK
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 09:07:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:56751 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1759986AbWLEOHI
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 09:07:08 -0500
Received: (qmail invoked by alias); 05 Dec 2006 14:07:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 05 Dec 2006 15:07:06 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Jakub Narebski wrote:

> By the way, is it [ed: xdl_merge()] replacement for RCS merge, i.e. is 
> it file-level merge tool, merge.onefile rather than merge.tool?

It is a C function, but yes, it does what RCS merge does.

> What happens if there are multiple merge [contents] conflicts: is 
> merge.tool invoked in parallel for each conflict, or is it waiting for 
> earlier merge.tool to finish (well, in which case we can always do set 
> merge.tool to "<program> &")?

Recursively. It is merge-recursive, so the merges are done sequentially. 
(Have to be, since the result of one merge is reused as one input for the 
next merge.)

> And is merge.tool invoked for recursive part of recursive merge 
> strategy?

Yes.

> This merge startegy depended on resolving conflict markers, i.e. had 
> built-in knowledge of 'merge'/'diff3 -E' output.

No. git-merge-recursive never resolved conflict markers, but treated them 
as text.

> Besides, it would be useful not only to spawn interactive merge tools, 
> but also to use mergers specific for file-type, for example 3DM or 
> xmlcmp tools for merging XML files.

If you need that, write a wrapper script, which detects the file type and 
execs the corresponding merge program.

Ciao,
Dscho
