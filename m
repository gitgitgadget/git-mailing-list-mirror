From: Sam Vilain <sam@vilain.net>
Subject: Re: [GSoC update extra!] git-remote-svn: Week 8
Date: Wed, 30 Jun 2010 13:51:05 +1200
Message-ID: <1277862665.23613.8.camel@wilber>
References: <1277386408-29943-1-git-send-email-artagnon@gmail.com>
	 <20100624173956.GA1600@burratino>  <20100624180752.GA1642@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 03:51:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTmSM-0005Ne-8w
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 03:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab0F3BvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 21:51:12 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:34580 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529Ab0F3BvL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 21:51:11 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 5DF1DFCD2F; Wed, 30 Jun 2010 13:51:05 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from [IPv6:::1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id F0C9CFCD2D;
	Wed, 30 Jun 2010 13:50:58 +1200 (NZST)
In-Reply-To: <20100624180752.GA1642@burratino>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149933>

On Thu, 2010-06-24 at 13:07 -0500, Jonathan Nieder wrote:
> operation.  In other words, it needs the tree for
> http://path/to/some/svn/root/branches@r11.  This does not correspond
> to a single git tree, since the content of each branch has been given
> its own commit.

I wrote at length about this near the beginning of the project;
essentially, figuring out whether particular paths are roots or not is
not defined, as SVN does not distinguish between them (a misfeature
cargo culted from Perforce).  It becomes a data mining problem, you have
this scattered data, and you have to find a history inside.

As I recommended before, it probably makes more sense to keep a "remote
tracking" branch which mirrors the *entire* repository, and sort out
efficient ways to convert SVN revision paths like the above into tree
IDs.

I consider it very important to separate the data import and tracking
stage from the data mining stage.

Once the data mining stage is well solved, then it makes sense to look
at ways that a tracking branch which only tracks a part of the
Subversion repository can be achieved.  In the simple case, where no
repository re-organisation or cross-project renames have occurred it is
relatively simple.  But in general I think this is a harder problem,
which cannot always be solved without intervention - and so not
necessary to be solved in short-term milestones.  As you are
discovering, it is a can of worms which you avoid if you know you always
have the complete SVN repository available.

Sam
