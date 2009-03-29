From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: don't output git commits in quiet mode
Date: Sun, 29 Mar 2009 15:43:24 -0700
Message-ID: <20090329224324.GB20675@dcvr.yhbt.net>
References: <49CFCD5A.1080801@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Simon Arlott <simon@fire.lp0.eu>
X-From: git-owner@vger.kernel.org Mon Mar 30 00:44:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo3kP-0006g3-E6
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 00:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbZC2Wn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 18:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbZC2Wn1
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 18:43:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59514 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbZC2Wn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 18:43:26 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2271F79C;
	Sun, 29 Mar 2009 22:43:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49CFCD5A.1080801@simon.arlott.org.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115046>

Simon Arlott <simon@fire.lp0.eu> wrote:
> Ideally only errors should be output in this mode so fetch
> can be run from cron and normally produce no output. Without
> this change it would output a single line on each git commit,
> e.g.
> r1909 = 32ef87860662526d4a62f903949ed21e0341079e (u2_10_12_branch)
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>

Thanks Simon,

Acked-by: Eric Wong <normalperson@yhbt.net>

and pushed to git://git.bogomips.org/git-svn

> ---
>  git-svn.perl |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 8be6be0..e100b69 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2331,13 +2331,13 @@ sub do_git_commit {
>  
>  	$self->{last_rev} = $log_entry->{revision};
>  	$self->{last_commit} = $commit;
> -	print "r$log_entry->{revision}";
> +	print "r$log_entry->{revision}" unless $::_q;
>  	if (defined $log_entry->{svm_revision}) {
> -		 print " (\@$log_entry->{svm_revision})";
> +		 print " (\@$log_entry->{svm_revision})" unless $::_q;
>  		 $self->rev_map_set($log_entry->{svm_revision}, $commit,
>  		                   0, $self->svm_uuid);
>  	}
> -	print " = $commit ($self->{ref_id})\n";
> +	print " = $commit ($self->{ref_id})\n" unless $::_q;
>  	if (--$_gc_nr == 0) {
>  		$_gc_nr = $_gc_period;
>  		gc();
> -- 
> 1.6.2
