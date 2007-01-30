From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: blameview and file contents
Date: Tue, 30 Jan 2007 01:54:17 -0500
Message-ID: <20070130065417.GA32640@spearce.org>
References: <cc723f590701292246v282408d0o27a0d8320c027743@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 07:54:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBmst-0001Ln-I0
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 07:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965344AbXA3GyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 01:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965377AbXA3GyW
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 01:54:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42761 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965344AbXA3GyW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 01:54:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBmsm-0000Ol-4M; Tue, 30 Jan 2007 01:54:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3B56520FBAE; Tue, 30 Jan 2007 01:54:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <cc723f590701292246v282408d0o27a0d8320c027743@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38125>

Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> I guess blame view need to pull the file content from the repository
> rather than opening it directly. If i have a working copy that is not
> yet committed it gives wrong results. I tried some changes as below.
> But i guess there should be a much easier way.

> -open(my $fh, '<', $fn)
> -  or die "unable to open $fn: $!";
> +$fh = get_file_handle("HEAD", $fn);
>  while(<$fh>) {
>    chomp;
>    $fileview->{data}->[$.] = ['HEAD', '?', "$fn:$.", $_];

Doesn't the following work just as well, and use a lot less code?

  open(my $fh, '|-', 'git', 'cat-file', 'blob', "HEAD:$fn")

?

-- 
Shawn.
