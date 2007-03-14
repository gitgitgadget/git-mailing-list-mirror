From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [GIT PULL] Please pull mergetool.git
Date: Wed, 14 Mar 2007 01:59:23 -0400
Message-ID: <20070314055923.GA20978@spearce.org>
References: <E1HRI5K-0008T9-9e@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 14 06:59:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRMWM-0007jM-V7
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 06:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbXCNF7b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 01:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbXCNF7b
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 01:59:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49028 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965131AbXCNF7a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 01:59:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HRMWE-0002fp-Iz; Wed, 14 Mar 2007 01:59:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 89B1920FBAE; Wed, 14 Mar 2007 01:59:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <E1HRI5K-0008T9-9e@candygram.thunk.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42173>

Theodore Ts'o <tytso@mit.edu> wrote:
> +    base_mode=`git ls-files -u -- "$path" | awk '{if ($3==1) print $1;}'`
> +    local_mode=`git ls-files -u -- "$path" | awk '{if ($3==2) print $1;}'`
> +    remote_mode=`git ls-files -u -- "$path" | awk '{if ($3==3) print $1;}'`
> +
> +    base_present   && git cat-file blob ":1:$path" > "$BASE" 2>/dev/null
> +    local_present  && git cat-file blob ":2:$path" > "$LOCAL" 2>/dev/null
> +    remote_present && git cat-file blob ":3:$path" > "$REMOTE" 2>/dev/null

Why not use `git checkout-index --stage=all "$path"` ?
E.g.:

	git checkout-index --stage=all "$path" |
	read base_temp local_temp remote_temp path

I'm not trying to nitpick, I'm just curious about why this particular
feature of checkout-index was not useful here.

-- 
Shawn.
