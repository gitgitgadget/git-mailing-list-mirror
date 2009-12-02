From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer at any
 time
Date: Wed, 2 Dec 2009 10:19:00 +0100 (CET)
Message-ID: <alpine.DEB.2.00.0912021011430.19179@tvnag.unkk.fr>
References: <25718488.post@talk.nabble.com>  <20091127234110.7b7e9993.rctay89@gmail.com>  <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st>  <alpine.DEB.2.00.0912011236360.5582@cone.home.martin.st>  <20091201161428.GC21299@spearce.org> 
 <alpine.DEB.2.00.0912011914270.30348@tvnag.unkk.fr> <be6fef0d0912011803u2ec9ab1bsa167cf59de4dd47c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Martin Storsj? <martin@martin.st>, git@vger.kernel.org,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 10:19:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFlMi-00031U-L9
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 10:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbZLBJTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 04:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbZLBJTD
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 04:19:03 -0500
Received: from giant.haxx.se ([83.168.254.42]:41873 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbZLBJTB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 04:19:01 -0500
Received: from giant.haxx.se (giant.haxx.se [83.168.254.42])
	by giant.haxx.se (8.14.3/8.14.3/Debian-9) with ESMTP id nB29J0MN024139;
	Wed, 2 Dec 2009 10:19:00 +0100
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <be6fef0d0912011803u2ec9ab1bsa167cf59de4dd47c@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134315>

On Wed, 2 Dec 2009, Tay Ray Chuan wrote:

> According to Martin, Expect: 100-continue is not working due to libcurl.

Right, that is/was a bug in how libcurl behaves when the application itself 
has set the "Expect: 100-continue" header. Martin has provided a fix for that 
for the next libcurl version though, but that won't make a lot of existing 
users happy.

Thinking about this particular problem, what is the motivation for git to 
forcily add that header in the first place? I mean, libcurl does add the 
header by itself when it thinks it is necessary and then it handles it 
correctly.

I'm just suggesting (and speculating widely since I don't know git internals) 
that a possible way to work around this particular bug may be to reconsider 
how git adds the Expect header.

It's just an idea. Please ignore it if it is totally crazy.

-- 

  / daniel.haxx.se
