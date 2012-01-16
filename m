From: Jeff King <peff@peff.net>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Mon, 16 Jan 2012 14:09:56 -0500
Message-ID: <20120116190956.GA13802@sigill.intra.peff.net>
References: <loom.20120112T193624-86@post.gmane.org>
 <4F1028AD.9080701@ira.uka.de>
 <4F106DDF.4040408@unclassified.de>
 <4F1085EC.9010708@ira.uka.de>
 <4F128AD0.5020101@unclassified.de>
 <4F1404E7.9040805@ira.uka.de>
 <4F14718B.80209@unclassified.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Holger Hellmuth <hellmuth@ira.uka.de>, git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Yves Goergen <nospam.list@unclassified.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 20:10:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmrwU-0003T5-GS
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 20:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879Ab2APTKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 14:10:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39395
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760Ab2APTJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 14:09:59 -0500
Received: (qmail 13512 invoked by uid 107); 16 Jan 2012 19:16:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jan 2012 14:16:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2012 14:09:56 -0500
Content-Disposition: inline
In-Reply-To: <4F14718B.80209@unclassified.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188644>

On Mon, Jan 16, 2012 at 07:50:51PM +0100, Yves Goergen wrote:

> It's getting more weird. I believe that (msys)Git doesn't really know
> how the filesystem on its operating system works. I have made some more
> changes now and want to commit them. TortoiseGit reports the files
> Form1.Designer.cs and Form1.designer.cs (note the case difference) as
> modified and ready to commit. How is that supposed to work? On Windows,
> file names are case-insensitive (as on MacOS X) and both names refer to
> the absolute same file. 'git status' has the very same listing with that
> same file twice.

What is the output of "git config core.ignorecase" in your repository?

> If the index is such a problem child, how can I safely delete it
> completely and maybe have it regenerated if Git can't live without it?

If you delete your index, it will appear to git as if you have staged
all files for deletion (if you run "git status", for example). You can
then run "git reset" to regenerate it based on the last commit.

But I doubt that will help your problem. It seems unlikely to me that
the source of the problem is a corrupted index, but rather is some
corner case in case-insensitive comparisons between the index and the
working tree.

-Peff
