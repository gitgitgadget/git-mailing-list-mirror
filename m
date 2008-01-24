From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH] git-gui: Use gitattribute "encoding" for file content display
Date: Wed, 23 Jan 2008 22:39:01 -0500
Message-ID: <20080124033901.GN24004@spearce.org>
References: <20080123054709.GA13166@spearce.org> <4FF40048-FCF4-4BAD-AD08-6ADAD30E7B6A@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Michele Ballabio <barra_cuda@katamail.com>
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jan 24 04:39:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHswP-0007qs-Hs
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 04:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbYAXDjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 22:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbYAXDjR
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 22:39:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59031 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbYAXDjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 22:39:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JHsvT-0004Xj-Rp; Wed, 23 Jan 2008 22:38:51 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1B7F720FBAE; Wed, 23 Jan 2008 22:39:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4FF40048-FCF4-4BAD-AD08-6ADAD30E7B6A@simplicidade.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71588>

Pedro Melo <melo@simplicidade.org> wrote:
> On Jan 23, 2008, at 5:47 AM, Shawn O. Pearce wrote:
> 
> >I've got the following change in my "pu" right now and am considering
> >adding it to git-gui 0.9.2, which would be in git 1.5.4.
> 
> Spoke too soon.
> 
> I can see the UTF-8 chars in the diffs, but if I use Stage Hunk for  
> Commit in a hunk with accentuated utf-8 chars, git-gui will throw an  
> error like "patch does not apply".

Yea, I know why.  It actually kept me awake for a little bit last
night after I sent the patch out for comment, but wasn't big enough
to get me out of bed to fix it.

The issue is git-gui doesn't convert back from character data to
binary correctly, so the patch won't apply, as the context will
not match.  Its simple enough to fix, we just have to remember
the encoding we used to go from git-diff --> Tcl and use that
same encoding in the other direction (Tcl --> git-apply).

-- 
Shawn.
