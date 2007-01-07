From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How git affects kernel.org performance
Date: Sun, 07 Jan 2007 00:58:38 -0800
Message-ID: <45A0B63E.2020803@zytor.com>
References: <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 10:00:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Tsw-000308-0g
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 10:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbXAGI7T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 03:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbXAGI7T
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 03:59:19 -0500
Received: from terminus.zytor.com ([192.83.249.54]:33012 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932441AbXAGI7R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 03:59:17 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l078wcfK000693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 7 Jan 2007 00:58:39 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
To: Willy Tarreau <w@1wt.eu>
In-Reply-To: <20070107085526.GR24090@1wt.eu>
X-Virus-Scanned: ClamAV 0.88.7/2417/Sat Jan  6 15:06:17 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=1.2 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_24_48,RCVD_IN_SORBS_DUL,SARE_MILLIONSOF autolearn=no 
	version=3.1.7
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36138>

Willy Tarreau wrote:
> 
> At work, we had the same problem on a file server with ext3. We use rsync
> to make backups to a local IDE disk, and we noticed that getdents() took
> about the same time as Peter reports (0.2 to 2 seconds), especially in
> maildir directories. We tried many things to fix it with no result,
> including enabling dirindexes. Finally, we made a full backup, and switched
> over to XFS and the problem totally disappeared. So it seems that the
> filesystem matters a lot here when there are lots of entries in a
> directory, and that ext3 is not suitable for usages with thousands
> of entries in directories with millions of files on disk. I'm not
> certain it would be that easy to try other filesystems on kernel.org
> though :-/
> 

Changing filesystems would mean about a week of downtime for a server. 
It's painful, but it's doable; however, if we get a traffic spike during 
that time it'll hurt like hell.

However, if there is credible reasons to believe XFS will help, I'd be 
inclined to try it out.

	-hpa
