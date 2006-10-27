X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ben Greear <greearb@candelatech.com>
Subject: Question on multi-level git repository heiarchy.
Date: Thu, 26 Oct 2006 22:12:09 -0700
Organization: Candela Technologies
Message-ID: <45419529.3010207@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 05:11:14 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30292>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdJzX-0002QS-Jr for gcvg-git@gmane.org; Fri, 27 Oct
 2006 07:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422818AbWJ0FKs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 01:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423683AbWJ0FKs
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 01:10:48 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:16036 "EHLO
 ns2.lanforge.com") by vger.kernel.org with ESMTP id S1422818AbWJ0FKr (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 01:10:47 -0400
Received: from [71.112.210.101] (pool-71-112-210-101.sttlwa.dsl-w.verizon.net
 [71.112.210.101]) (authenticated bits=0) by ns2.lanforge.com (8.13.4/8.13.4)
 with ESMTP id k9R5AkKI024862 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 22:10:46 -0700
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Some time back, I cloned from the official kernel site.  I have created 
several
branches and patches and such, recently branching off of 2.6.18

I want to create an intermediate level..something like:

kernel.org git tree
       |
my git master tree
 /                          \
work-station-1   work-station-2  ....


Each of the work-station repositories should push/pull from my git 
master tree, and occasionally
the git master tree will also pull from the kernel.org git tree.

To attempt this, I uploaded the .git tree from my local work 
station..the tree I cloned a while
back, to the public server.

I was then able to clone the public server git tree on my local 
work-station in a clean directory.

So far so good...

Both pub server and work station had the current branch set to 
lf_v2.6.18, and gitk showed
the head and latest patch as what I would expect.  I then did a git 
checkout -f master on the
pub server and did a pull from the upstream kernel.
This seemed to work fine.

Then, on the work-station, I did a git checkout -f master, and also did 
a pull.
In this case, it seems that it is trying to merge with changes in the 
lf_v2.6.18 branch
instead of the the main 'master' tree (see below).

So, am I going about this all wrong, or did I just run into a glitch of 
some sort?  I should
mention that the work-station below is running git 1.3, where the master 
is running git 1.4.2.4 (latest in FC4).

[greear@xeon-dt linux-2.6.dev]$ git checkout -f master
[greear@xeon-dt linux-2.6.dev]$ git pull
greearb@ns2.lanforge.com's password:
Generating pack...
Done counting 1553 objects.
Result has 1056 objects.
Deltifying 1056 objects.
 100% (1056/1056) done
Unpacking 1056 objects
Total 1056, written 1056 (delta 894), reused 0 (delta 0)
 100% (1056/1056) done
* refs/heads/master: fast forward to branch 'master' of 
greearb@ns2.lanforge.com:/pub/linux-2.6
  from 04fed361dadb7921507a470947ac23d2f26352cf to 
e80391500078b524083ba51c3df01bbaaecc94bb
* refs/heads/lf_v2.6.17.x: same as branch 'lf_v2.6.17.x' of 
greearb@ns2.lanforge.com:/pub/linux-2.6
* refs/heads/lk_v2.6.16.x.sts: same as branch 'lk_v2.6.16.x.sts' of 
greearb@ns2.lanforge.com:/pub/linux-2.6
* refs/heads/lf_v2.6.17: same as branch 'lf_v2.6.17' of 
greearb@ns2.lanforge.com:/pub/linux-2.6
* refs/heads/lf_v2.6.16.x: same as branch 'lf_v2.6.16.x' of 
greearb@ns2.lanforge.com:/pub/linux-2.6
* refs/heads/lk_v2.6.15.x.sts: same as branch 'lk_v2.6.15.x.sts' of 
greearb@ns2.lanforge.com:/pub/linux-2.6
* refs/heads/lk_v2.6.17.x: same as branch 'lk_v2.6.17.x' of 
greearb@ns2.lanforge.com:/pub/linux-2.6
* refs/heads/lf_v2.6.16: same as branch 'lf_v2.6.16' of 
greearb@ns2.lanforge.com:/pub/linux-2.6
* refs/heads/origin: same as branch 'lf_v2.6.18' of 
greearb@ns2.lanforge.com:/pub/linux-2.6
* refs/heads/lk_v2.6.16.x: same as branch 'lk_v2.6.16.x' of 
greearb@ns2.lanforge.com:/pub/linux-2.6
greearb@ns2.lanforge.com's password:
Auto-following refs/tags/v2.6.19-rc3
greearb@ns2.lanforge.com's password:
Generating pack...
Done counting 1 objects.
Deltifying 1 objects.
 100% (1/1) done
Total 1, written 1 (delta 0), reused 0 (delta 0)
Unpacking 1 objects
 100% (1/1) done
* refs/tags/v2.6.19-rc3: storing tag 'v2.6.19-rc3' of 
greearb@ns2.lanforge.com:/pub/linux-2.6
Warning: fetch updated the current branch head.
Warning: fast forwarding your working tree from
Warning: 04fed361dadb7921507a470947ac23d2f26352cf commit.
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging HEAD with ea50583c9fba2e289d434bda9798a7b77ee8e3b4
Merging:
e80391500078b524083ba51c3df01bbaaecc94bb Merge 
master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6
ea50583c9fba2e289d434bda9798a7b77ee8e3b4 Initial work of merging pktgen 
changes into 2.6.18.
found 1 common ancestor(s):
e478bec0ba0a83a48a0f6982934b6de079e7e6b3 Linux v2.6.18. Arrr!
Auto-merging net/core/skbuff.c
Auto-merging include/net/sock.h
Auto-merging net/core/pktgen.c
CONFLICT (content): Merge conflict in net/core/pktgen.c
Auto-merging net/decnet/dn_table.c
CONFLICT (content): Merge conflict in net/decnet/dn_table.c
Auto-merging net/ipv4/fib_frontend.c
CONFLICT (content): Merge conflict in net/ipv4/fib_frontend.c
Auto-merging arch/i386/kernel/tsc.c
Auto-merging net/ipv4/fib_rules.c
CONFLICT (content): Merge conflict in net/ipv4/fib_rules.c
Auto-merging net/core/dev.c
Auto-merging drivers/net/e1000/e1000_main.c
CONFLICT (content): Merge conflict in drivers/net/e1000/e1000_main.c
Auto-merging net/ipv4/arp.c
CONFLICT (content): Merge conflict in net/ipv4/arp.c
Auto-merging net/decnet/dn_fib.c
CONFLICT (content): Merge conflict in net/decnet/dn_fib.c
Auto-merging net/socket.c
Auto-merging include/linux/if.h
Auto-merging include/linux/compat_ioctl.h
Auto-merging include/linux/skbuff.h
Auto-merging include/linux/rtnetlink.h
CONFLICT (content): Merge conflict in include/linux/rtnetlink.h
Auto-merging fs/cifs/cifsglob.h
Auto-merging include/linux/if_vlan.h
Auto-merging net/ipv4/route.c
CONFLICT (content): Merge conflict in net/ipv4/route.c
Auto-merging net/core/ethtool.c
CONFLICT (content): Merge conflict in net/core/ethtool.c
Auto-merging net/packet/af_packet.c
Auto-merging include/linux/nfs_fs_sb.h
CONFLICT (content): Merge conflict in include/linux/nfs_fs_sb.h
Auto-merging net/8021q/vlan_dev.c
Auto-merging net/ipv6/route.c
CONFLICT (content): Merge conflict in net/ipv6/route.c
Auto-merging net/ipv4/fib_trie.c
Auto-merging include/linux/sunrpc/xprt.h
Auto-merging include/net/neighbour.h
Auto-merging include/net/ip_fib.h
CONFLICT (content): Merge conflict in include/net/ip_fib.h
Auto-merging drivers/net/e100.c
Auto-merging drivers/net/e1000/e1000.h
CONFLICT (content): Merge conflict in drivers/net/e1000/e1000.h
Auto-merging net/ipv4/fib_semantics.c
CONFLICT (content): Merge conflict in net/ipv4/fib_semantics.c
Auto-merging drivers/pci/quirks.c
Auto-merging net/ipv4/fib_lookup.h
CONFLICT (content): Merge conflict in net/ipv4/fib_lookup.h
Auto-merging net/ipv4/fib_hash.c
Auto-merging net/core/sock.c
Auto-merging net/Makefile
CONFLICT (content): Merge conflict in net/Makefile
Auto-merging net/decnet/dn_rules.c
CONFLICT (content): Merge conflict in net/decnet/dn_rules.c
Auto-merging include/linux/netdevice.h
Auto-merging net/decnet/dn_route.c
Auto-merging net/sunrpc/xprtsock.c
Auto-merging net/Kconfig
Auto-merging drivers/net/e1000/e1000_ethtool.c
CONFLICT (content): Merge conflict in drivers/net/e1000/e1000_ethtool.c
Auto-merging include/net/dn_fib.h
CONFLICT (content): Merge conflict in include/net/dn_fib.h
Auto-merging fs/nfs/super.c
CONFLICT (content): Merge conflict in fs/nfs/super.c
Auto-merging fs/cifs/connect.c
CONFLICT (content): Merge conflict in fs/cifs/connect.c

Automatic merge failed; fix conflicts and then commit the result.
[greear@xeon-dt linux-2.6.dev]$ git branch
  lf_v2.6.16
  lf_v2.6.16.x
  lf_v2.6.17
  lf_v2.6.17.x
  lf_v2.6.18
  lk_v2.6.15.x.sts
  lk_v2.6.16.x
  lk_v2.6.16.x.sts
  lk_v2.6.17.x
* master
  origin
[greear@xeon-dt linux-2.6.dev]$ gitk

-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com

