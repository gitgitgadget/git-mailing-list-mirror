From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Replace perl code with pure shell code
Date: Mon, 29 Jan 2007 04:28:16 -0500
Message-ID: <20070129092815.GA22486@spearce.org>
References: <<7vtzya8b4g.fsf@assigned-by-dhcp.cox.net>> <45BDBBCA.6030107@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Mon Jan 29 10:28:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBSoY-0006Qp-DG
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 10:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbXA2J21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 04:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbXA2J21
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 04:28:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57491 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbXA2J2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 04:28:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBSnY-0001vj-Ta; Mon, 29 Jan 2007 04:27:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3577320FBAE; Mon, 29 Jan 2007 04:28:16 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <45BDBBCA.6030107@fs.ei.tum.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38070>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> I already wondered.  What's those ^{} tags, and why is CLONE_HEAD littered 
> with them?

They are the deref of the thing without them.

As in, "foo" is a tag pointing at some object (probably a commit
but not necessarily) then "foo^{}" is whatever "foo"'s tag points at.
 
> +		case "$name" in
> +		*^{*)
> +			continue ;;

Probably could just be:

		case "$name" in
		*^{})
			continue ;;

This is common in Git.  ^{} on the end of a ref name shows up in
the peek-remote/ls-remote output, but certainly is *not* a ref.

Sorry I missed that case eariler when I reviewed the patch. I thought
about it and why it wasn't handled here, but then thought maybe it
wasn't actually occuring in the input (that someone else higher up
had filtered them out).

-- 
Shawn.
