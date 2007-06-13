From: David Kastrup <dak@gnu.org>
Subject: Stupid quoting...
Date: Wed, 13 Jun 2007 13:30:49 +0200
Message-ID: <86ir9sw0pi.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 13:43:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyRGV-0001vK-B6
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 13:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757740AbXFMLmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 07:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757625AbXFMLmy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 07:42:54 -0400
Received: from main.gmane.org ([80.91.229.2]:52242 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758220AbXFMLmx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 07:42:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HyRAL-0008Mz-ML
	for git@vger.kernel.org; Wed, 13 Jun 2007 13:37:33 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 13:37:33 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 13:37:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:rifVQop0rNb95MuyWjOGV+ei+I4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50048>


Hi,

what is the point in quoting file names and their characters in
git-diff's output?  And what is the recommended way of undoing the
damage?

I have something like

git-diff -M -C --name-status -r master^ master | {
    while read -r flag name
    do
	case "$name" in *\\[0-3][0-7][0-7]*)
		name=$(echo -e $(echo "$name"|sed 's/\\\([0-3][0-7][0-7]\)/\\0\1/g;s/\\\([^0]\)/\\\\\1/g'))
	esac
        [...]

in order to get through the worst with utf-8 file names, and it is a
complete nuisance (double quotemarks are treated later).

Is there any utility or pipe or invocation that can take a sequence of
filenames as printed by git and turn them back into what they actually
were in the first place?

-- 
David Kastrup
