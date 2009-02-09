From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: Print revision while searching for
	earliest use of path
Date: Mon, 9 Feb 2009 13:22:44 -0800
Message-ID: <20090209212244.GA26706@dcvr.yhbt.net>
References: <86d4c5e00902050542n74b10bfdw5e9249ac23fdc9e7@mail.gmail.com> <1234139598-13703-1-git-send-email-deskinm@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Deskin Miller <deskinm@umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:24:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdc2-0004oA-FO
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 22:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbZBIVWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 16:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754147AbZBIVWr
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 16:22:47 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:34524 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898AbZBIVWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 16:22:46 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6060113007;
	Mon,  9 Feb 2009 21:22:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234139598-13703-1-git-send-email-deskinm@umich.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109133>

Deskin Miller <deskinm@umich.edu> wrote:
> When initializing a git-svn repository from a Subversion repoository,
> it is common to be interested in a path which did not exist in the
> initial commit to Subversion.  In a large repository, the initial fetch
> may take some looking for the earliest existence of the path time while
> the user receives no additional feedback.  Print the highest revision
> number scanned thus far to let the user know something is still
> happening.
> 
> Signed-off-by: Deskin Miller <deskinm@umich.edu>

Thanks Deskin,

The carriage return actually looks quite good :)

Acked-by: From: Eric Wong <normalperson@yhbt.net>

> ---
> I'd never looked closely enough at gs_fetch_loop_common to grok what was
> going on, and my previous experience with svn's get_log led me to think
> that git-svn would slurp up log info for all commits at once.  Silly of
> me.
> 
> Eric, things are much cleaner doing as you suggest.  I added a
> carriage-return at the end of the message because I like it that way,
> and the line will be overwritten once it actually starts fetching data
> from svn.  I don't feel strongly about it though, so if it's better to
> make it a newline, please feel free to change it and apply.
> 
> Deskin Miller
> 
>  git-svn.perl |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 79888a0..601e2a3 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -4348,6 +4348,9 @@ sub gs_fetch_loop_common {
>  		}
>  		$self->get_log([$longest_path], $min, $max, 0, 1, 1,
>  		               sub { $revs{$_[1]} = _cb(@_) });
> +		if ($err) {
> +			print "Checked through r$max\r";
> +		}
>  		if ($err && $max >= $head) {
>  			print STDERR "Path '$longest_path' ",
>  				     "was probably deleted:\n",
> -- 
