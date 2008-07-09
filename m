From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git push to amazon s3 [was: [GSoC] What is status of Git's
	Google Summer of Code 2008 projects?]
Date: Wed, 9 Jul 2008 03:26:34 +0000
Message-ID: <20080709032634.GB18520@spearce.org>
References: <905315640807072248w44ccdc4y2f1cf54a10c50c43@mail.gmail.com> <20080708055610.GA12591@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tarmigan <tarmigan+git@gmail.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Nick Hengeveld <nickh@reactrix.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 05:27:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGQLC-0004H8-GY
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 05:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbYGID0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 23:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbYGID0f
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 23:26:35 -0400
Received: from george.spearce.org ([209.20.77.23]:35811 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbYGID0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 23:26:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 882D438195; Wed,  9 Jul 2008 03:26:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080708055610.GA12591@glandium.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87834>

Mike Hommey <mh@glandium.org> wrote:
> FWIW, I'm starting to work again on the http backend overhaul. My idea
> is to provide a generic dumb protocol vfs-like interface, so that other
> dumb protocols could be built out of it.

jgit has a vfs abstraction for the different dumb protocols.  Not sure
if you would find it of any value to read as we are also able to use a
number of Java standard abstractions like InputStream/OutputStream,
but here it is:

  WalkRemoteObjectDatabase:
  http://repo.or.cz/w/egit.git?a=blob;f=org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java;h=915faac9eb85e59c0ed2c08b9631d03cbc4c6bf8;hb=8d085723b260f3b51a70d11b723608779160b090

Thus far this abstraction has worked for sftp:// and amazon-s3://.
WebDAV may make it more complicated due to locking being available
(and something we would want to use to protect writes) but S3 uses
HTTP PUT much like DAV does to upload content so there wouldn't be
too many changes to actually implement DAV support.

-- 
Shawn.
