From: Kjetil Barvik <barvik@broadpark.no>
Subject: git repack: --depth=100000 causing larger not smaler pack file?
Date: Tue, 17 Mar 2009 20:05:25 +0100
Organization: private
Message-ID: <867i2ot1fu.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 20:07:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljecu-00052z-2e
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 20:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291AbZCQTF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 15:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756962AbZCQTF2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 15:05:28 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:56281 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756280AbZCQTF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 15:05:28 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGN00AP6ZP1UR40@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 17 Mar 2009 20:05:25 +0100 (CET)
Received: from localhost ([80.202.166.137]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGN00BH5ZP1I310@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 17 Mar 2009 20:05:25 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113518>

  aloha!

  Yesterday I run the following command on the updated GIT respository:

    git repack -adf --window=250000 --depth=100000

  After 280 minutes or so it finished, but the strange thing was that
  the resulting pack-file was larger than before.  I had expected that
  it should be smaler, or at least the same size as before.

  kjetil git (my_next)$ ls -l .git/objects/pack/*
-r-------- 1 kjetil kjetil  2757280 2009-03-16 15:18 .git/objects/pack/pack-c5f15d5c48d6b3902a49046d7e8a8d717e167051.idx
-r-------- 1 kjetil kjetil 19961120 2009-03-16 15:18 .git/objects/pack/pack-c5f15d5c48d6b3902a49046d7e8a8d717e167051.pack

  Before I started the pack file was around 19 250 000 bytes, and was
  the result of the following commands:

  1) git repack -adf --window=250000 --depth=20000
          - not completly sure about the --window number here
          - the resulting pack file was a litle less than 19 100 000

  2) 'git fetch' to get the latest GIT patches

  3) since 'git fetch' always make an extra new "smal" pack file, I run
     the command 'git repack -ad --window=40000 --depth=10000' to be
     able to get one singel pack file of 19 250 000 bytes or so.

  I can think of one thing which is spesial with the "--depth=100000"
  number, and that is that it is now larger than the total number of
  objects in the pack, which is around 96000 to 97000, or so.

  I have run 'git fsck --strict --full' on the pack with no resulting
  error/debug output or change in the file size.

  Any help on how to debug this?

  -- kjetil
