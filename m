From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 00:17:05 -0400
Message-ID: <20060814041705.GD18667@spearce.org>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com> <20060814035603.GB18667@spearce.org> <9e4733910608132107j7bca0271g360de3447febbf51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 06:17:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCTtE-0002Kx-05
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 06:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbWHNERK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 00:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWHNERK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 00:17:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47500 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751845AbWHNERJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 00:17:09 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GCTsx-0000b2-Pn; Mon, 14 Aug 2006 00:17:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D72B220FB77; Mon, 14 Aug 2006 00:17:05 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608132107j7bca0271g360de3447febbf51@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25316>

Jon Smirl <jonsmirl@gmail.com> wrote:
> The zlib doc says to put your most common strings into the fixed
> dictionary. If a string isn't in the fixed dictionary it will get
> handled with an internal dictionary entry.  By default zlib runs with
> an empty fixed dictionary and handles everything with the internal
> dictionary.
 
> Since we are encoding C many strings will always be present (if,
> static, define, const, char, include, int, void, while, continue,
> etc).  Do you have any tools to identify the top 500 strings in C
> code? The fixed dictionary would get hardcoded into the git apps.

Actually GIT itself may also benefit from other strings beyond
those common found in C-like languages:

	'10644 '
	'40000 '
	'parent '
	'tree '
	'author '
	'committer '

as these occur frequently in trees and commits.
 
> A fixed dictionary could conceivably take 5-10% off the size of each entry.

Could be an interesting experiment to see if that's really true
for common loads (e.g. the kernel repo).  I don't think anyone has
tried it.

-- 
Shawn.
