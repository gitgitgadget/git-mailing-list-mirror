From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] GitWeb + TopGit
Date: Tue, 3 Nov 2009 21:39:30 +0100
Message-ID: <20091103203930.GB17748@machine.or.cz>
References: <1244027352-24055-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 21:39:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5QAJ-0002B3-MH
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 21:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183AbZKCUj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 15:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755173AbZKCUj2
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 15:39:28 -0500
Received: from w241.dkm.cz ([62.24.88.241]:59620 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465AbZKCUj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 15:39:27 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id EB15186201A; Tue,  3 Nov 2009 21:39:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1244027352-24055-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131992>

  Hi!

On Wed, Jun 03, 2009 at 01:09:12PM +0200, Bert Wesarg wrote:
> I have changed gitweb to show topgit topics. log and shortlog shows
> only the history for refs/top-bases/$topic..$topic.
> 
> You can see it in action here:
> 
> http://kgb2.thruhere.net/git/?p=bertw/topgit.git;a=summary
> 
> This patch is based on the debian package gitweb-1.6.3.1-1.  If you'r
> interested I can rebase the patch on git.git.

  I'm very sorry I never got around to replying to this patch; I'd like
to add it to repo.or.cz now, would you still be interested in improving
it a little?

  Specifically, it would be necessary to show the topics section only if
the repository actually is topgit-controlled, that is it has the
refs/top-bases/ tree. If you could add that, I'm wondering if it would
be also suitable for gitweb upstream inclusion? Anyone...?

  Your gitweb above also has an extra 'patches' link in the shortlog
view - this would indeed be much useful to actually get the patch
introduced by the topic branch, however:

  (i) It is not included in this patch?
  (ii) It doesn't seem to work, giving a 400 error.
  (iii) It would be cool if it could also be added to the links in the
topic list.

  Thanks!

> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> 
> ---
> diff --git a/gitweb.cgi b/gitweb.cgi
> index 820f073..fd9e64b 100755
> --- a/gitweb.cgi
> +++ b/gitweb.cgi
> @@ -5054,7 +5148,11 @@ sub git_log {
>  	}
>  	my $refs = git_get_references();
>  
> -	my @commitlist = parse_commits($hash, 101, (100 * $page));
> +	my $commit_hash = $hash;
> +	if (defined $hash_parent) {
> +		$commit_hash = "$hash_parent..$hash";
> +	}
> +	my @commitlist = parse_commits($commit_hash, 101, (100 * $page));
>  
>  	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist >= 100);
>  

  And this seems like overally useful gitweb addition.

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
