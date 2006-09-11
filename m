From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 22:44:34 -0400
Message-ID: <20060911024434.GA29368@spearce.org>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com> <20060908184215.31789.qmail@science.horizon.com> <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com> <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org> <9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com> <17668.2019.732961.855446@cargo.ozlabs.ibm.com> <20060911000306.GA28927@spearce.org> <7vfyezqlny.fsf@assigned-by-dhcp.cox.net> <ee2cms$o18$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 04:44:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMbmu-0005bT-A3
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 04:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWIKCok (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 22:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWIKCok
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 22:44:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36809 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751054AbWIKCok (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 22:44:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GMbmc-0007Ia-1c; Sun, 10 Sep 2006 22:44:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1931820FB33; Sun, 10 Sep 2006 22:44:34 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ee2cms$o18$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26829>

Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano wrote:
> 
> >  the impact of changing the
> > one-file-per-ref implementation to something based on a single
> > simple databasy file (e.g. gdbm, bdb, sqlite, ...)
> 
> One of the complaints against Subversion was that it use BerkeleyDB
> (bdb) backend... but it was before it acquired fsfs interface. Perhaps
> we could use it too.

I'm against the latest Berkely DB (Sleepy Cat) implementations.
Every time I've stored data in them or in applications which use
them I've lost everything.  GNU dbm might not be too bad.  SQL Lite
is overkill.

I was thinking of using a tree object only because its a well
defined Git file format that's already in use.  Plus its "easy"
to repair by loading it into an index, twiddline it and invoking
git-write-tree to convert it back.  But there's a lot of downsides.

This is probably something that is easily solved by a simple fixed
record format holding a 20 byte SHA1 (binary) and a fixed width null
terminated string holding the ref name, with the records sorted
by ref name.  Its yet another file format with yet another set of
utilities needed but we pretty much have those (update-ref).
 
> Or perhaps it is for something like Electra, or ReiserFS file properites
> access...

Except not everyone has those filesystems.  :-)

-- 
Shawn.
