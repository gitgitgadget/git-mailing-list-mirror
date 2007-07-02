From: Yann Dirson <ydirson@altern.org>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Mon, 2 Jul 2007 22:40:51 +0200
Message-ID: <20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
References: <46893F61.5060401@jaeger.mine.nu> <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net> <46895EA4.5040803@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Mon Jul 02 22:41:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Shv-0005jM-IL
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 22:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbXGBUlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 16:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754353AbXGBUlM
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 16:41:12 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:33082 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524AbXGBUlL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 16:41:11 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D34BE5A37C;
	Mon,  2 Jul 2007 22:41:10 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 32B941F176; Mon,  2 Jul 2007 22:40:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46895EA4.5040803@jaeger.mine.nu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51402>

On Mon, Jul 02, 2007 at 10:23:00PM +0200, Christian Jaeger wrote:
> I don't per se require undo actions. I just don't understand why git-rm
> refuses to remove the file from the index, even if I didn't commit it.

I'd say it does so, so you won't loose any uncommitted changes without
knowing it - and "git add -f" is available when you have checked that
you indeed want to discard that data.

> The index is just an intermediate record of the changes in my
> understandings, and the rm action would also be intermediate until it's
> being committed. And a non-committed action being deleted shouldn't need
> a special confirmation from me, especially not one which is consisting
> of a combination of two flags (of which one is a destructive one).

It already works as such: it will warn you if you have already staged
the file in the index, but it has not been committed, in which case
the data would be lost as well:

$ echo foo > bar
/tmp/test$ git rm bar
fatal: pathspec 'bar' did not match any files
/tmp/test$ git add bar
/tmp/test$ git rm bar
error: 'bar' has changes staged in the index (hint: try -f)

That is, "git rm" will only ever remove the file without asking, when
it is safe do so, in that you can retrieve your file from history.  Or
do you think of another way, in which more safety would be needed ?

Best regards,
-- 
Yann
