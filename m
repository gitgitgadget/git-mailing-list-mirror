From: Yann Droneaud <ydroneaud@opteya.com>
Subject: git fetch --reference
Date: Tue, 03 Sep 2013 18:55:29 +0200
Organization: OPTEYA
Message-ID: <ae657fa74373b58feba41615d335504e@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: ydroneaud@opteya.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 03 18:55:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGttB-0001JM-5o
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 18:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757634Ab3ICQzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 12:55:33 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:52514 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756012Ab3ICQzc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 12:55:32 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1VGtt2-000IJd-9F; Tue, 03 Sep 2013 18:55:28 +0200
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.9.2
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233734>

Hi,

I surprised myself trying to run git fetch --reference <local directory> 
<remote>
in the hope git would use my <local directory> to resolve objects 
present in <remote> but not
in my current repository ... just like git clone --reference <local 
directory> <URL>:

--reference <repository>
            If the reference repository is on the local machine, 
automatically setup
            .git/objects/info/alternates to obtain objects from the 
reference repository.
            Using an already existing repository as an alternate will 
require fewer objects
            to be copied from the repository being cloned, reducing 
network and local storage
            costs.

git fetch --reference would set up a temporary objects/info/alternates 
... and skrew everything up.

Having a git fetch --reference option would be great, so that I could 
fetch one remote and the other related one in a row without any special 
setup. [At this point, you're likely to suggest me to use a local mirror 
that I would git clone/fetch from, and your probably right, but for a 
one time hack, it's cumbersome.]

In the end I've read 
http://git-blame.blogspot.fr/2012/08/bringing-bit-more-sanity-to-alternates.html

First I thought having "git alternatives add" would enable me to 
temporary add the --reference <directory>
before running git fetch ... But it seems --reference doesn't work as I 
first understand it:
git clone --reference don't *copy* object from the --reference 
<repository> instead of *copying* them from the cloned <url>, eg. using 
--reference <repository> as kind of mirror.
Instead --reference <repository> seems to add a kind of a symlink. And 
if the --reference <repository> disappear, things are going to be lost.  
See this : 
http://randyfay.com/content/git-clone-reference-considered-harmfu

So setting a temporary alternate with git fetch --reference is a 
non-sense ...
To achieve what I intend to do with this option, a git repack would need 
to be issued to actually
copy the objects from the --reference <repository>.

So what's the best way to do a git fetch <remote>, copying objects from 
another local repository
to resolve delta ?

Regards.

-- 
Yann Droneaud
OPTEYA
