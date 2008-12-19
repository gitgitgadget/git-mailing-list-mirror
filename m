From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to extract files out of a "git bundle", no matter what?
Date: Fri, 19 Dec 2008 11:32:56 -0800
Message-ID: <20081219193256.GU32487@spearce.org>
References: <87iqpgc6bn.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mdl123@verizon.net, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Dec 19 20:34:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDl73-0007hX-HS
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 20:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbYLSTc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 14:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbYLSTc6
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 14:32:58 -0500
Received: from george.spearce.org ([209.20.77.23]:35629 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbYLSTc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 14:32:57 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1983338200; Fri, 19 Dec 2008 19:32:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <87iqpgc6bn.fsf@jidanni.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103576>

jidanni@jidanni.org wrote:
> Someone has handed you a "git bundle".
> How do you get the files out of it?
> If it were cpio, you would use -i, if it were tar, you would use -x...
> You read the git-bundle man page.
> You only get as far as
> # git-bundle verify bundle.bdl
> The bundle contains 1 ref
> d01... /heads/master
> The bundle requires these 0 ref
> bundle.bdl is okay
> 
> The rest is mish-mosh. There should be an emergency example for non
> git club members, even starting from apt-get install git-core, of the
> all the real steps needed _to get the files out of the bundle_.
> 
> Assume the user _just wants to get the files out of the bundle_ and
> not learn about or participate in some project.

You can't just "get the files out".  A bundle contains deltas,
where you need the base in order to recreate the file content.
It can't be unpacked in a vacuum.

To unpack a bundle you need to clone the project and then fetch
from it:

	git clone src...
	git pull bundle.bdl master

If the bundle requires 0 refs (like above) then you can init a
new repository and should be able to fetch from it:

	git init
	git pull bundle.bdl master

-- 
Shawn.
