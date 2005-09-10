From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multi-ancestor read-tree notes
Date: Sat, 10 Sep 2005 15:50:04 -0700
Message-ID: <7virx87d2b.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
	<7virxeycod.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509061228090.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 00:50:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEEAn-00068P-59
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 00:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVIJWuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 18:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVIJWuI
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 18:50:08 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42225 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932326AbVIJWuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2005 18:50:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050910225005.HLYA20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Sep 2005 18:50:05 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509061228090.23242@iabervon.org> (Daniel
	Barkalow's message of "Tue, 6 Sep 2005 13:43:08 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8265>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Do you know if there's anything like case #16 in there? I'd be interested 
> to know if there's anything that gets handled automatically in different 
> ways depending on which single base is used, and doesn't require manual 
> intervention with multiple bases, because that's probably wrong.

I was playing with a handful of non-Linus 2.6 kernel
repositories today, and found two case #16 merges.

0c3e091838f02c537ccab3b6e8180091080f7df2

	case #16; stupid resolves the same way as the actual
	commit, but that might mean the actual commit is bad.

84ffa747520edd4556b136bdfc9df9eb1673ce12

	case #16; stupid also fails.

0c168775709faa74c1b87f1e61046e0c51ade7f3
0e396ee43e445cb7c215a98da4e76d0ce354d9d7

	These two fails both in stupid and resolve.

a855f9a4d29f0ec338c337358844389171b0bae0

	This one stupid fails but resolve succeeds.

19925d7e0af7de645d808fd973ef99049fce52f0
3190186362466658f01b2e354e639378ce07e1a9
467ca22d3371f132ee225a5591a1ed0cd518cb3d
539aeb871b52233b189ae976dfded20e14db645a
6358924b06cd1aaa031b8ba0c33e5a15e795bef0
cf70be167c085af820c0c2a606cab8c3ee819dc6
da28c12089dfcfb8695b6b555cdb8e03dda2b690

	These give good merges in both stupid and resolve.

Here are the logs for the commits involved in the above
experiments; some of them might be contained in only one
maintainer tree but I do not keep track of whose tree they came
from.  The repository I am testing in is `fetch but not merge
many random trees derived from Linus linux-2.6' repository.

----------------------------------------------------------------
commit 0c168775709faa74c1b87f1e61046e0c51ade7f3
tree c40fd8818c64c5d7d1d90afab0bd6ffd94505526
parent 9bd481f85940726bf66aae5cd03c5b912ad0ae4c
parent 9b4311eedb17fa88f02e4876cd6aa9a08e383cd6
author Jeff Garzik <jgarzik@pobox.com> 1120106958 -0400
committer Jeff Garzik <jgarzik@pobox.com> 1120106958 -0400

    Merge upstream 2.6.13-rc1-git1 into 'ieee80211' branch of netdev-2.6.

commit 0c3e091838f02c537ccab3b6e8180091080f7df2
tree 61a407356d1e897e0badea552ce69e657cab6108
parent 7ffacc1a2527c219b834fe226a7a55dc67ca3637
parent a4cce10492358b33d33bb43f98284c80482037e8
author Tony Luck <tony.luck@intel.com> 1124808655 -0700
committer Tony Luck <tony.luck@intel.com> 1124808655 -0700

    Pull release into test branch

commit 0e396ee43e445cb7c215a98da4e76d0ce354d9d7
tree a6fde6a33965abb6077420cda31e3f1fbe8d3891
parent b8112df71cae7d6a86158caeb19d215f56c4f9ab
parent 2089a0d38bc9c2cdd084207ebf7082b18cf4bf58
author Linus Torvalds <torvalds@ppc970.osdl.org> 1119120155 -0700
committer Linus Torvalds <torvalds@ppc970.osdl.org> 1119120155 -0700

    Manual merge of rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
    
    This is a fixed-up version of the broken "upstream-2.6.13" branch, where
    I re-did the manual merge of drivers/net/r8169.c by hand, and made sure
    the history is all good.

commit 19925d7e0af7de645d808fd973ef99049fce52f0
tree 01e7bf7717582bd70fbf1ba86132c33e61d044d5
parent cce3217e147b46ec4b7d20d922dadd3016b5fd49
parent 85f265d887d2389376f1caa191e9682085feb76e
author Tony Luck <tony.luck@intel.com> 1124143503 -0700
committer Tony Luck <tony.luck@intel.com> 1124143503 -0700

    Pull CONFIG_PCI description fix

commit 3190186362466658f01b2e354e639378ce07e1a9
tree 4ef50e96c385ed076465aac23f52902467e7d825
parent 08848e446bcd2130c26945be966446389d25bcc2
parent f60f700876cd51de9de69f3a3c865d95e287a24d
author Tony Luck <tony.luck@intel.com> 1121628606 -0700
committer Tony Luck <tony.luck@intel.com> 1121628606 -0700

    Auto merge with rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

commit 467ca22d3371f132ee225a5591a1ed0cd518cb3d
tree 0e3d6de84b4ffa379c2c7ddcebd3f55de52b9844
parent 12725675e26d52c39e856d341035b94bf7802458
parent 1e86d1c648508fd50e6c9960576b87906a7906ad
author Steve French <sfrench@hera.kernel.org> 1117748543 -0700
committer Steve French <sfrench@hera.kernel.org> 1117748543 -0700

    Merge with rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
    

commit 539aeb871b52233b189ae976dfded20e14db645a
tree ad028270f2b79d74886418014f971d52cb729e11
parent 04141b215a2a0ba7c2052b53a912c9412f2ed8ea
parent 30d5b64b63fa69af31b2cba32e6d71d68526eec9
author Tony Luck <tony.luck@intel.com> 1124407778 -0700
committer Tony Luck <tony.luck@intel.com> 1124407778 -0700

    Auto-update from upstream

commit 6358924b06cd1aaa031b8ba0c33e5a15e795bef0
tree 9cc45ad48ba1c1171ceb949294223839c89d1f8c
parent 1da21e73bdc458f8131e6071072632b4c3b0430f
parent 344a076110f4ecb16ea6d286b63be696604982ed
author Tony Luck <tony.luck@intel.com> 1126214972 -0700
committer Tony Luck <tony.luck@intel.com> 1126214972 -0700

    Pull release into test branch

commit 84ffa747520edd4556b136bdfc9df9eb1673ce12
tree 1cfe20bd31fce1b5b3024384fcb324c3338d1d32
parent 702c7e7626deeabb057b6f529167b65ec2eefbdb
parent 81065e2f415af6c028eac13f481fb9e60a0b487b
author Len Brown <len.brown@intel.com> 1124849543 -0400
committer Len Brown <len.brown@intel.com> 1124849543 -0400

    Merge from-linus to-akpm

commit a855f9a4d29f0ec338c337358844389171b0bae0
tree 211824376a8b170a8087956c8d5ec25269f2bc49
parent 04c573e1d1625b48b3c90f988579d7835f4c55f3
parent f505380ba7b98ec97bf25300c2a58aeae903530b
author Tony Luck <tony.luck@intel.com> 1125729479 -0700
committer Tony Luck <tony.luck@intel.com> 1125729479 -0700

    Update from linus with manual merge for include/asm-ia64/sn/sn_sal.h

commit cf70be167c085af820c0c2a606cab8c3ee819dc6
tree 0a587cec3a6bd4fdd53fcfb75f87bc45da5d1a7f
parent 3844dcf8faae3a163ca2d263ba6468085ffaceb8
parent ff67b59726a8cd3549b069dfa78de2f538d3b8e3
author Tony Luck <tony.luck@intel.com> 1125439229 -0700
committer Tony Luck <tony.luck@intel.com> 1125439229 -0700

    Pull release into test branch

commit da28c12089dfcfb8695b6b555cdb8e03dda2b690
tree b3ff509f21352ef053cb3d490cb13528090d32ac
parent 6de7dc2c4c713d037c19aa1e310d240f16973414
parent 577a4f8102d54b504cb22eb021b89e957e8df18f
author Dave Kleikamp <shaggy@austin.ibm.com> 1122559416 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> 1122559416 -0500

    Merge with /home/shaggy/git/linus-clean/
    /home/shaggy/git/linus-clean/
    /home/shaggy/git/linus-clean/
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
