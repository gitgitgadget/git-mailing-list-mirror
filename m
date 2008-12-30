From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: why still no empty directory support in git
Date: Tue, 30 Dec 2008 01:25:41 -0500 (EST)
Message-ID: <alpine.DEB.2.00.0812300113050.22107@vellum.laroia.net>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com> <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 07:27:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHY4M-0000Qt-T2
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 07:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbYL3GZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 01:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbYL3GZu
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 01:25:50 -0500
Received: from rose.makesad.us ([219.105.37.19]:60281 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbYL3GZt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 01:25:49 -0500
Received: from vellum.laroia.net (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id 080BAA010F
	for <git@vger.kernel.org>; Tue, 30 Dec 2008 01:25:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by vellum.laroia.net (Postfix) with ESMTPS id C8BA83A62BD
	for <git@vger.kernel.org>; Mon, 29 Dec 2008 22:25:41 -0800 (PST)
X-X-Sender: paulproteus@vellum.laroia.net
In-Reply-To: <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104164>

On Tue, 30 Dec 2008, Asheesh Laroia wrote:

> On Tue, 30 Dec 2008, Ping Yin wrote:
>
>> 2. unclear logic, for example, whether to remove the directory after the 
>> last file in it is deleted
>
> This is the thing I dislike most about git: that it sometimes calls rmdir() 
> for me.  At least, one should be able to turn it off in a per-repository 
> basis.  I'm going to see how hard a patch that would be to write.

Well, changing this behavior seems to be "as easy as" changing 
unlink_entry in unpack_trees.c to not always rmdir(). The most naive thing 
I can think of is to have unlink_entry in unpack_trees check against the 
git config. It's probably more sensible for unpack_trees to be passed an 
argument that determines if it rmdir()s; that argument could be set via 
argv at "git unpack-tree" time, which could be set out of a configuration 
value read at "git" time.

Would a change of the "more sensible" kind possibly be accepted by the git 
maintainer?

I ask about this because I'm using git to track email in Maildir 
repositories, and in that vein I'm getting bitten by git's removal of 
empty directories.

-- Asheesh.

-- 
You will gain money by an illegal action.
