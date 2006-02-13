From: Andrew Morton <akpm@osdl.org>
Subject: git-bisect problem
Date: Mon, 13 Feb 2006 00:25:02 -0800
Message-ID: <20060213002502.5c23122c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Feb 13 09:26:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Z27-0002zg-OH
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 09:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWBMIZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 03:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWBMIZx
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 03:25:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35508 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751239AbWBMIZw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 03:25:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1D8PpDZ018375
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Mon, 13 Feb 2006 00:25:51 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k1D8PoEU009216
	for <git@vger.kernel.org>; Mon, 13 Feb 2006 00:25:51 -0800
To: git@vger.kernel.org
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16054>


I've been trying to locate an ipw2200 regression in Jeff's tree
(git+ssh://master.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git#ALL)
and it ended up leading me to 

826eeb53a6f264842200d3311d69107d2eb25f5e is first bad commit
diff-tree 826eeb53a6f264842200d3311d69107d2eb25f5e (from 33052057e3e2db7f37fc78aa3f25c98f7e989fae)
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Thu Feb 2 22:03:08 2006 -0800

    Linux v2.6.16-rc2

which wasn't very useful.

I don't _think_ I screwed anything up.

git-bisect start
# good: [2664b25051f7ab96b22b199aa2f5ef6a949a4296] Linux v2.6.16-rc1
git-bisect good 2664b25051f7ab96b22b199aa2f5ef6a949a4296
# bad: [826eeb53a6f264842200d3311d69107d2eb25f5e] Linux v2.6.16-rc2
git-bisect bad 826eeb53a6f264842200d3311d69107d2eb25f5e
# good: [10379a25fee8ddc8698d2f6c54ccedd4664c2941] Merge master.kernel.org:/pub/scm/linux/kernel/git/davej/agpgart
git-bisect good 10379a25fee8ddc8698d2f6c54ccedd4664c2941
# good: [9a2dba4b4912b493070cbc170629fdbf440b01d7] slab: rename ac_data to cpu_cache_get
git-bisect good 9a2dba4b4912b493070cbc170629fdbf440b01d7
# good: [9ad11ab48b1ad618bf47076e9e579f267f5306c2] compat: fix compat_sys_openat and friends
git-bisect good 9ad11ab48b1ad618bf47076e9e579f267f5306c2
# good: [1494a92f4c2b1d5abdaa1f823dd19f797bb137de] [ALSA] hda-codec - Fix typos in alc882 model table
git-bisect good 1494a92f4c2b1d5abdaa1f823dd19f797bb137de
# good: [9fdb62af92c741addbea15545f214a6e89460865] [ACPI] merge 3549 4320 4485 4588 4980 5483 5651 acpica asus fops pnpacpi branches into release
git-bisect good 9fdb62af92c741addbea15545f214a6e89460865
# good: [cf41f8ac386e8d62122e7e394b4c6b3e3ab30ede] Merge branch 'drm-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6
git-bisect good cf41f8ac386e8d62122e7e394b4c6b3e3ab30ede
# good: [00b464debf0038b1628996065f0be564ccfbfd86] SUNRPC: Remove obsolete rpcauth #defines
git-bisect good 00b464debf0038b1628996065f0be564ccfbfd86
# good: [35849c75d7750a254119c1a4b88c90156919df2a] md: Add sysfs access to raid6 stripe cache size
git-bisect good 35849c75d7750a254119c1a4b88c90156919df2a
# good: [33052057e3e2db7f37fc78aa3f25c98f7e989fae] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
git-bisect good 33052057e3e2db7f37fc78aa3f25c98f7e989fae
