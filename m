From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: How to merge FETCH_HEAD?
Date: Tue, 16 Jan 2007 23:33:40 +0200
Message-ID: <20070116213340.GB4329@mellanox.co.il>
References: <20070116195914.GA29100@spearce.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 22:33:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6vvm-0000tT-8M
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 22:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbXAPVdT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 16:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbXAPVdS
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 16:33:18 -0500
Received: from p02c11o143.mxlogic.net ([208.65.145.66]:52550 "EHLO
	p02c11o143.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbXAPVdS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 16:33:18 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o143.mxlogic.net (mxl_mta-4.0.2-1)
	with ESMTP id d944da54.2617514928.12733.00-003.p02c11o143.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Tue, 16 Jan 2007 14:33:17 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 16 Jan 2007 23:35:00 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Tue, 16 Jan 2007 23:32:02 +0200
To: "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20070116195914.GA29100@spearce.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 16 Jan 2007 21:35:00.0783 (UTC) FILETIME=[2D28D3F0:01C739B6]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14940.000
X-TM-AS-Result: No--12.850600-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36969>

> Quoting Shawn O. Pearce <spearce@spearce.org>:
> Subject: Re: How to merge FETCH_HEAD?
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> wrote:
> > OK, I did a fetch and now I can see remote history by
> > 
> > $git log FETCH_HEAD
> 
> Wow, I'm suprised that works.  Handy feature.  Too bad rev-parse
> --verify then chokes on it when we'll somehow consider it a ref
> otherwise...
>  
> > But, how to merge it?
> 
> Look at git-pull.sh:
> 
> 	merge_head=$(sed -e '/  not-for-merge   /d' \
> 		-e 's/  .*//' "$GIT_DIR"/FETCH_HEAD | \
> 			tr '\012' ' ')
> 	merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD")
> 	git-merge "$merge_name" HEAD $merge_head
> 
> The not-for-merge keyword is included on lines that were fetched
> into tracking branches during the last fetch and which you don't
> want to merge right now.  So those lines get dropped.  Then the
> remainder of the line is stripped away, leaving you with only
> the sha1 sum.  merge_name is computed from the FETCH_HEAD file,
> to get the pretty log message for git-merge.

Would it be useful to have git-pull . FETCH_HEAD work?

-- 
MST
