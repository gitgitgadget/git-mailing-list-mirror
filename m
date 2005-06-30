From: Junio C Hamano <junkio@cox.net>
Subject: Re: verify_pack.c vs verify-pack.c
Date: Thu, 30 Jun 2005 13:29:26 -0700
Message-ID: <7vy88r1tcp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0506301336460.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 22:29:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do5eD-0003Um-RR
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 22:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263116AbVF3Ufb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 16:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbVF3UfA
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 16:35:00 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:39073 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S263127AbVF3U3a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 16:29:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050630202926.VWLI12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 30 Jun 2005 16:29:26 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.63.0506301336460.1667@localhost.localdomain> (Nicolas Pitre's message of "Thu, 30 Jun 2005 13:41:12 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

NP> This is confusing.  Isn't possible to rename git-verify-pack to, say, 
NP> git-fsck-pack instead?

Yes it is possible (I am not attached to the name).  The
question is what to name it.

git-fsck-cache (which is not about cache, whose name somehow
implies it is trying to see consistency of the index file, but
in reality which is about the object database --- it should be
renamed to git-fsck-objects) does the same verification when the
pack is placed under objects/pack/, and the way I envision
git-verify/check/fsck-pack to be used is to run it _before_ you
place a pack in your object database; it is like running sha1sum
on a tarball before extracting it.

Also I would like to add some "info" output options to the
git-verify/check/fsck-pack program that:

 - lists all the contained SHA1 objects;
  - with their type and size;
  - with their delta depth (if deltified);
  - with the delta-data size for each delta step.

to help optimizing the git-pack-objects.

BTW, is there a filesystem that would house the source to the
core GIT that do not like names that differ only in underscore
and dash?
