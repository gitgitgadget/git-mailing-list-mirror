From: Marc Zonzon <marc.zonzon+git@gmail.com>
Subject: git-relink status (or bug?)
Date: Sat, 21 Jun 2008 12:36:36 +0200
Message-ID: <20080621103636.GA696@kernoel.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 21 12:38:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA0Tu-0001Z4-ON
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 12:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbYFUKgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 06:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbYFUKgj
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 06:36:39 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:33228 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbYFUKgi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 06:36:38 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 63CC817B562;
	Sat, 21 Jun 2008 12:36:37 +0200 (CEST)
Received: from kernoel.kernoel.fr (lns-bzn-47f-81-56-187-30.adsl.proxad.net [81.56.187.30])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 38D1917B553;
	Sat, 21 Jun 2008 12:36:37 +0200 (CEST)
Received: by kernoel.kernoel.fr (Postfix, from userid 206)
	id C07B1300DD; Sat, 21 Jun 2008 12:36:36 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85704>

When trying to use git-relink, I found it quite disappointing when
going over packs. Git relink seem to make the assumption that there is
a unique mapping from object name to object identity, which is of
course acceptable for loose objects that are named with their sha-1
but false for .pack and .idx, to pack objects with the same name have
contains the same objects but may be not packed in the same order, or
compression.
Moreover .idx files can not be considered alone, but depends on the
associated .pack.

When it happen that you have two different packs with the same name
but of different sizes, git relink does not hard link the .packs
because the size differ, and hard link the idx. And your repository is
corrupted.

It happen when you clone a repository, repack the clone and relink the
clone to the original one.

I found very few information about git relink, but as it appears in
changelog of v1.5.4 I suppose it is not obsoleted.

What about the use of this script?

Marc
