From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool: export variables for use by custom
	mergetools
Date: Sun, 18 May 2008 00:34:14 +0100
Message-ID: <20080517233414.GA28196@hashpling.org>
References: <8b4e944ac849029f31f403ab75198ed6fb4197c1.1211056369.git.davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tytso@mit.edu, git@vger.kernel.org, evgeny.zislis@gmail.com
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 18 02:15:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxWYd-00022J-7p
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 02:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbYERAOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 20:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755514AbYERAOd
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 20:14:33 -0400
Received: from pih-relay04.plus.net ([212.159.14.131]:40776 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393AbYERAOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 20:14:33 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1JxVup-0005cV-Fw; Sun, 18 May 2008 00:34:15 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m4HNYFue028721;
	Sun, 18 May 2008 00:34:15 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m4HNYEq2028720;
	Sun, 18 May 2008 00:34:14 +0100
Content-Disposition: inline
In-Reply-To: <8b4e944ac849029f31f403ab75198ed6fb4197c1.1211056369.git.davvid@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: e5c1a453dcc21ed0e949bf7c8624f273
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82371>

On Sat, May 17, 2008 at 01:39:26PM -0700, David Aguilar wrote:
> The MERGED, BACKUP, LOCAL, REMOTE and BASE variables were not being
> exported from the git-mergetool.sh script.  This prevented custom
> mergetools from being able to use them.
> 
> We now export them so that arbitrary mergetools can easily interact
> with git mergetool.
> 
> This problem was Reported-By: Evgeny <evgeny.zislis@gmail.com>
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>

I think there must be a misunderstanding here. The variables are not
designed to be exported. The point of the custom merge tool patch to
git mergetool was to support custom mergetools without the need for a
wrapper script, just a git config variable.

I know that (with the right config) git mergetool supports p4merge as
it is one of a selection of tools that I tested it with. You should be
able to get p4 merge to work by setting the config variable:

mergetool.p4merge.cmd

to the value (IIRC, and I don't have the p4merge documentation to hand):

p4merge "$BASE" "$REMOTE" "$LOCAL" "$MERGED"

Getting the quoting correct on this depends on whether you set it via
commandline or via editing a git config file and can be a little
tricky.

If you have a wrapper shell script then you can easily pass these as
positional parameters and re-export them as necessary.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
