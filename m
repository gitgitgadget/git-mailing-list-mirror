From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 20:13:29 -0500
Message-ID: <20070213011329.GB31377@spearce.org>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org> <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org> <7vps8f6l81.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702130020450.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vfy9b6iyt.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702130046450.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45D10D86.3030508@verizon.net> <Pine.LNX.4.63.0702130204120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 13 02:13:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGmEt-0008Oi-Px
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 02:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965456AbXBMBNk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 20:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965455AbXBMBNk
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 20:13:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48632 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965456AbXBMBNi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 20:13:38 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGmET-0005Hd-7C; Mon, 12 Feb 2007 20:13:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EFABC20FBAE; Mon, 12 Feb 2007 20:13:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702130204120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39472>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 12 Feb 2007, Mark Levedahl wrote:
> 
> > Perhaps I'm too paranoid, but I've been burnt way too many times by 
> > text/binary mode stuff to let this part be trivialized. Maybe it only 
> > gets enabled by core.ImReallyParanoid, but I want that option.
> 
> Be aware that what you proposed costs many CPU cycles. I am totally 
> opposed to enabling that option by default on all platforms. I am okay 
> with .gitattributes (but I would call it .gitfiletypes), but I am _not_ 
> okay with git being _too much_ fscked up by Windows. Microsoft has done 
> enough harm already.

Indeed; this type of checking should only occur if there is a filter
applied to a file.  Most files in most projects would hopefully
just be considered to be byte streams to Git, like they are today,
and thus not incur any additional overhead, beyond matching their
type to determine they are in fact just a byte stream.

The type could be cached in the index; or at least a single bit
which says "I'm just a byte stream, thanks" so that the matching
only needs to occur during an initial read-tree.

-- 
Shawn.
