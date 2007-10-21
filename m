From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] gitweb: Provide title attributes for abbreviated author names.
Date: Sat, 20 Oct 2007 23:25:33 -0400
Message-ID: <20071021032533.GA30717@spearce.org>
References: <1192581277533-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: pasky@suse.cz, git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 05:25:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjRRl-0000Lw-5P
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 05:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbXJUDZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 23:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbXJUDZi
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 23:25:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58352 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbXJUDZh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 23:25:37 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjRRK-0007Ne-OU; Sat, 20 Oct 2007 23:25:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 75AE120FBAE; Sat, 20 Oct 2007 23:25:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192581277533-git-send-email-dsymonds@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61873>

Nice, but...

David Symonds <dsymonds@gmail.com> wrote:
> +++ b/gitweb/gitweb.perl
> @@ -3461,9 +3461,15 @@ sub git_shortlog_body {
>  			print "<tr class=\"light\">\n";
>  		}
>  		$alternate ^= 1;
> +		my $author = chop_str($co{'author_name'}, 10);
> +		if ($author ne $co{'author_name'}) {
> +			$author = "<span title=\"$co{'author_name'}\">" . esc_html($author) . "</span>";

Doesn't this produce invalid HTML if $co{'author_name'} has a special
HTML character in it such as & or "?  Note that " is much more likely
as it is often used for nicknames.  The old code properly escaped
the author name, and indeed you are doing it for the abbreviated
version but not the full version.

This bug seemed to exist in almost all (if not all) of the hunks.

-- 
Shawn.
