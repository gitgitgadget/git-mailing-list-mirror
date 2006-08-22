From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Paginate history output
Date: Mon, 21 Aug 2006 23:15:52 -0700
Message-ID: <7vveols3c7.fsf@assigned-by-dhcp.cox.net>
References: <200608220053.10741.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 22 08:16:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFPYL-0003WC-D1
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 08:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWHVGPy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 02:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWHVGPy
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 02:15:54 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34270 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750785AbWHVGPx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 02:15:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822061553.EAPF18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 02:15:53 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608220053.10741.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 22 Aug 2006 00:53:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25831>

Jakub Narebski <jnareb@gmail.com> writes:

> @@ -1559,6 +1562,7 @@ sub git_history_body {
>  			next;
>  		}
>  
> +		#my $ref = defined $refs ? format_ref_marker($refs, $commit) : '';
>  		my $ref = format_ref_marker($refs, $commit);
>  
>  		if ($alternate) {

Do you want to change this or not?  Make up your mind.

> +		$paging_nav .= " &sdot; " .
> +			$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base,
> +			                       file_name=>$file_name, page=>$page-1),
> +			         -accesskey => "p", -title => "Alt-p"}, "prev");

This is something you inherited from the original and not your
fault, but I am not sure if these -title entries are of good
taste (we have corresponding "Alt-n" for "next").  Something
more descriptive like "<Alt-p> for 100 newer changes", perhaps?

Also, "first", "prev" and "next" have always confused me.  Maybe
"latest", "older" and "newer" are better labels for them?

Is 100 a good default?  It feels a bit unbalanced compared to
the height of the default summary page with descriptions, 16
shortlog entries, 16 tags and 12 heads.
