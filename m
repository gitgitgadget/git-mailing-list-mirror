From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Using git-svn fetch after a directory change with rewrite-root
Date: Sat, 20 Aug 2011 19:18:37 +0000
Message-ID: <20110820191837.GA30509@dcvr.yhbt.net>
References: <CANWsHyfHtr0EaJtNsDK9UTcmb_AbLg-1jUA-0uWJ-nEeNosb7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: H Krishnan <hetchkay@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 21:18:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qur47-0003t6-06
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 21:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab1HTTSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 15:18:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46438 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754718Ab1HTTSi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 15:18:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535E32100F;
	Sat, 20 Aug 2011 19:18:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CANWsHyfHtr0EaJtNsDK9UTcmb_AbLg-1jUA-0uWJ-nEeNosb7w@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179781>

(Apologies for the late response, I don't pay attention to
 git svn much anymore.  Feel free to Cc: me when posting to
 the mailing list and remind me in a week if I forgot respond.)

H Krishnan <hetchkay@gmail.com> wrote:
> while (1) {
> 	# It is possible to tag two different subdirectories at
> 	# the same revision.  If the url for an existing ref
> 	# does not match, we must either find a ref with a
> 	# matching url or create a new ref by growing a tail.
> 	$gs = Git::SVN->init($u, $p, $repo_id, $ref_id, 1);
> 	my (undef, $max_commit) = $gs->rev_map_max(1);
> 	last if (!$max_commit);
> 	my ($url) = ::cmt_metadata($max_commit);
> 	last if ($url eq $gs->full_url);
> 	$ref_id .= '-';
> }
> print STDERR "Initializing parent: $ref_id\n" unless $::_q > 1;
> 
> I wonder if commit 3235b7053c45a734c1cdf9b117bda68b7ced29c9 handles
> rewrite-root correctly. Should the comparison be made with
> $gs->metadata_url instead of $gs->full_url?

I think you're right, can you submit a test case?  Current
tests all pass with  $gs->metadata_url  so I can probably
push it out in a bit regardless.

-- 
Eric Wong
