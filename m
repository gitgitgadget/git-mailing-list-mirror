From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How git affects kernel.org performance
Date: Tue, 9 Jan 2007 08:23:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701090821550.3661@woody.osdl.org>
References: <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
 <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
 <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
 <20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org>
 <20070108030555.GA7289@in.ibm.com> <20070108125819.GA32756@thunk.org>
 <368329554.17014@ustc.edu.cn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-From: linux-ext4-owner@vger.kernel.org Tue Jan 09 17:28:50 2007
Return-path: <linux-ext4-owner@vger.kernel.org>
Envelope-to: gcfe-linux-ext4@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Jpu-0007ci-TD
	for gcfe-linux-ext4@gmane.org; Tue, 09 Jan 2007 17:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbXAIQ2S (ORCPT <rfc822;gcfe-linux-ext4@m.gmane.org>);
	Tue, 9 Jan 2007 11:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbXAIQ2S
	(ORCPT <rfc822;linux-ext4-outgoing>); Tue, 9 Jan 2007 11:28:18 -0500
Received: from smtp.osdl.org ([65.172.181.24]:51343 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932204AbXAIQ2Q (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
	Tue, 9 Jan 2007 11:28:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l09GNYWi011308
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 Jan 2007 08:23:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l09GNWPo009162;
	Tue, 9 Jan 2007 08:23:32 -0800
To: Fengguang Wu <fengguang.wu@gmail.com>
In-Reply-To: <368329554.17014@ustc.edu.cn>
X-Spam-Status: No, hits=-0.666 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36375>



On Tue, 9 Jan 2007, Fengguang Wu wrote:
> > 
> > The fastest and probably most important thing to add is some readahead
> > smarts to directories --- both to the htree and non-htree cases.  If
> 
> Here's is a quick hack to practice the directory readahead idea.
> Comments are welcome, it's a freshman's work :)

Well, I'd probably have done it differently, but more important is whether 
this actually makes a difference performance-wise. Have you benchmarked it 
at all?

Doing an

	echo 3 > /proc/sys/vm/drop_caches

is your friend for testing things like this, to force cold-cache 
behaviour..

		Linus
