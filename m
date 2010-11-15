From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Multiple clients accessing git over NFS
Date: Mon, 15 Nov 2010 20:56:41 +0100
Message-ID: <20101115195641.GG30870@efreet.light.src>
References: <AANLkTimyFkVFAw4s2fiWKZFPvnx15K6U6GbxmRgznx7Z@mail.gmail.com>
 <rmi39r3mrf6.fsf@fnord.ir.bbn.com>
 <AANLkTim1bUbofDzC5HJnB--0WkT45ewbWCa25RebEgae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Khawaja Shams <kshams@usc.edu>
X-From: git-owner@vger.kernel.org Mon Nov 15 20:56:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI5AX-0003bh-7o
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 20:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283Ab0KOT4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 14:56:44 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:59919 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758183Ab0KOT4n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 14:56:43 -0500
X-ASG-Debug-ID: 1289851000-0701296c0001-QuoKaX
Received: from efreet.light.src (152-31-80-78.praha.adsl.tmcz.cz [78.80.31.152]) by cuda1.bluetone.cz with ESMTP id f7gtXLv54xbhqdtY; Mon, 15 Nov 2010 20:56:40 +0100 (CET)
X-Barracuda-Envelope-From: bulb@ucw.cz
X-Barracuda-Apparent-Source-IP: 78.80.31.152
Received: from bulb by efreet.light.src with local (Exim 4.72)
	(envelope-from <bulb@ucw.cz>)
	id 1PI5AP-0001Mv-Dx; Mon, 15 Nov 2010 20:56:41 +0100
X-ASG-Orig-Subj: Re: Multiple clients accessing git over NFS
Content-Disposition: inline
In-Reply-To: <AANLkTim1bUbofDzC5HJnB--0WkT45ewbWCa25RebEgae@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Barracuda-Connect: 152-31-80-78.praha.adsl.tmcz.cz[78.80.31.152]
X-Barracuda-Start-Time: 1289851000
X-Barracuda-URL: http://212.158.128.5:8000/cgi-mod/mark.cgi
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5576 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=4.5 KILL_LEVEL=4.8 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.46725
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161508>

On Sun, Nov 14, 2010 at 15:42:29 -0800, Khawaja Shams wrote:
> Hi Greg,
>    Thank you for the insightful response. We have multiple automated
> clients pushing and pulling changes from git as events occur. We have
> not hit any real performance issues just yet. Our main goal is to
> improve the availability of the repository in case the box running the
> apache server has an outage during a mission critical period.

If you are out for availability, NFS isn't an answer, because the NFS server
remains a single point of failure. There are distributed filesystems
(Gluster, Lustre etc.) that can provide redundancy of storage nodes too or
you could have shared storage array with appropriate filesystem (GlobalFS,
OCFS2, etc.), but that requires special hardware. These will probably give
you better performance too -- git network protocol is optimized to send
minimal data, but that often means a lot more needs to be read from the disk.

I don't have personal experience with them though, so I can't give you more
specific recommendation.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
