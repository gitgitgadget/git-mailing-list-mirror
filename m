From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Remove usernames from all commit messages, not just when using svmprops
Date: Tue, 24 Apr 2007 18:33:11 -0700
Message-ID: <20070425013221.GC7169@muzzle>
References: <9F361BEA-54A1-479F-9552-1E2170A83DAF@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Adam Roben <aroben@apple.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 03:33:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgWNj-0000Xp-6L
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 03:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbXDYBdO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 21:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169AbXDYBdO
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 21:33:14 -0400
Received: from hand.yhbt.net ([66.150.188.102]:60866 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106AbXDYBdN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 21:33:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 699587DC0A0;
	Tue, 24 Apr 2007 18:33:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9F361BEA-54A1-479F-9552-1E2170A83DAF@apple.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45495>

Adam Roben <aroben@apple.com> wrote:
> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
> Signed-off-by: Adam Roben <aroben@apple.com>

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index efc4c88..077d6b3 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1866,11 +1866,14 @@ sub make_log_entry {
>  	} elsif ($self->use_svnsync_props) {
>  		my $full_url = $self->svnsync->{url};
>  		$full_url .= "/$self->{path}" if length $self->{path};
> +		remove_username($full_url);
>  		my $uuid = $self->svnsync->{uuid};
>  		$log_entry{metadata} = "$full_url\@$rev $uuid";
>  		$email ||= "$author\@$uuid"
>  	} else {
> -		$log_entry{metadata} = $self->metadata_url. "\@$rev " .
> +		my $url = $self->metadata_url;
> +		remove_username($url);
> +		$log_entry{metadata} = "$url\@$rev " .
>  		                       $self->ra->get_uuid;
>  		$email ||= "$author\@" . $self->ra->get_uuid;
>  	}
> -- 
> 1.5.2.rc0.14.g520d-dirty

-- 
Eric Wong
