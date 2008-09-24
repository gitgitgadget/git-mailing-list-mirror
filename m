From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC 0/2] git-gui: issues with merge tool series
Date: Wed, 24 Sep 2008 10:48:23 -0700
Message-ID: <20080924174823.GY3669@spearce.org>
References: <200808310052.21595.angavrilov@gmail.com> <1221651652-3712-1-git-send-email-johannes.sixt@telecom.at> <bb6f213e0809170550q5be339d1s825f95b1165e6507@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 19:51:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiYWT-0003CI-9E
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 19:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbYIXRsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 13:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbYIXRsY
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 13:48:24 -0400
Received: from george.spearce.org ([209.20.77.23]:34337 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbYIXRsX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 13:48:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 505373835F; Wed, 24 Sep 2008 17:48:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <bb6f213e0809170550q5be339d1s825f95b1165e6507@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96667>

Alexander Gavrilov <angavrilov@gmail.com> wrote:
> On Wed, Sep 17, 2008 at 3:40 PM, Johannes Sixt <johannes.sixt@telecom.at> wrote:
> > 1. The inability to stage a conflicted file by clicking the icon is
> >   *very* disruptive. The new menu entry "Stage Working Copy" is
> >   really only a workaround, and it shows.
> 
> I can see two ways to fix it:
> 
> 1) Allow that icon to work only if the diff is currently displayed,
> and also ask for confirmation if there are any conflict markers
> present.
> 
>    Problem: What should it do with modify/delete conflicts, which
> don't have any conflict markers?

I'm inclined to say we should just let the icon work like it used
to, stage the whole working copy.  That's exactly what it does on
a non-merge, and thus is what it should do on a merge.

As a safety feature we can scan the working copy for merge marks if
we are currently in a merge and prompt the user for confirmation
if it looks like they are merging an unmerged working copy.
 
> 2) Much harder: implement complete one-click undo. This involves
> saving information from the index somewhere, and forcing such items to
> remain in the 'staged' list, even if the index isn't different from
> the tree version any more.
> 
>    By the way, is there a simple way to re-create a conflict file from
> the saved multistage index entries?

Run git-merge-file after extracting the stages to temporary files.
You can also jam the stages back into the index with update-index
--index-info.

-- 
Shawn.
