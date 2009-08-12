From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Update russian translation
Date: Wed, 12 Aug 2009 08:40:17 -0700
Message-ID: <20090812154016.GG1033@spearce.org>
References: <4A4A77A6.1020905@lawrence.edu> <20090810153859.GT1033@spearce.org> <4A81B738.7090507@zwell.net> <20090811202927.GZ1033@spearce.org> <4A81BD58.8070300@zwell.net> <20090812144345.GC1033@spearce.org> <20090812152409.GA5407@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@zwell.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 17:40:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbFwF-0002cO-Ah
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 17:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbZHLPkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 11:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbZHLPkR
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 11:40:17 -0400
Received: from george.spearce.org ([209.20.77.23]:56641 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbZHLPkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 11:40:16 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3107C381FD; Wed, 12 Aug 2009 15:40:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090812152409.GA5407@blimp.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125713>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Shawn O. Pearce, Wed, Aug 12, 2009 16:43:45 +0200:
> > Dan Zwell <dzwell@zwell.net> wrote:
> > > When there is a large number of new or modified files,
> > > "display_all_files" takes a long time, and git-gui appears to
> > > hang. This change limits the number of files that are displayed.
> > > This limit can be set as gui.maxfilesdisplayed, and is
> > > 5000 by default.
> > >
> > > A warning is shown when the list of files is truncated.
> > 
> > Thanks, applied.
> 
> But now, when I really think about the change, it looks useless.
> What has the _number_ of files has to do with the files you actually
> have to handle? As the sorting of the file list cannot be changed (and
> it wouldn't be a big help anyway), you have no chance to get to your
> file if it happens to be past the limit!
> 
> Wouldn't a pathname/glob filter in the command-line (or file/path
> selection dialog) to limit the scope be more appropriate and useful?
> And have the file list reading to happen in background, as gitk does?

Good point.  I suspect the problem wasn't so much with Tcl doing the
list processing as it was with Tk actually creating the underlying
icons and stuff for each file name.  But with the list clipped,
you are right, you are basically SOL.  You can't do much beyond
dropping back to the CLI and using the CLI tools.

IMHO, if we aren't going to handle 20k file names, we should at least
punt and tell the user we aren't going to handle 20k file names,
rather than just play Outlook wannabe and lockup the entire UI until
the user gets bored and kill -9's us.  So this patch is better than
nothing, it at least lets the user know we have given up on them.

-- 
Shawn.
