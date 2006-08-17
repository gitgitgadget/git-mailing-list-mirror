From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/7] gitweb: Expand href() function to use key as param name for no mapping
Date: Thu, 17 Aug 2006 02:58:26 -0700
Message-ID: <7v8xlnsmyl.fsf@assigned-by-dhcp.cox.net>
References: <11558064883957-git-send-email-jnareb@gmail.com>
	<11558064893139-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 11:58:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDee9-0007Ef-Es
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWHQJ63 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWHQJ63
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:58:29 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39627 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932466AbWHQJ62 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 05:58:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060817095827.XRFQ6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Aug 2006 05:58:27 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25579>

Jakub Narebski <jnareb@gmail.com> writes:

> Expand href() function to use key name of params hash as a query param
> name, if there is no mapping for given key name.
>
> It is now safer to use href(); no errors, but links might not work
> correctly if caller didn't provide correct arguments.
>
> Future proofing.

I think that is not a "future proofing" but is "sweeping mess
under the rug" ;-). 

> @@ -1174,66 +1179,6 @@ sub git_print_page_path {
>  	}
>  }
>  
> -sub git_print_log {
> -	my $log = shift;
> -
> -	# remove leading empty lines
>...
> -}
> -
> -sub git_print_simplified_log {
> -	my $log = shift;
> -	my $remove_title = shift;
> -
>...
> -	print "<br/>\n" unless $empty;
> -}
> -
>  ## ......................................................................
>  ## functions printing large fragments of HTML
>...
> @@ -2215,10 +2160,27 @@ sub git_log {
>  		      "<br/>\n" .
>  		      "</div>\n" .
>  		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
> -		      "</div>\n";
> -
> -		print "<div class=\"log_body\">\n";
> -		git_print_simplified_log($co{'comment'});
> +		      "</div>\n" .
> +		      "<div class=\"log_body\">\n";
>...
> +			print format_log_line_html($line) . "<br/>\n";
> +		}
> +		if (!$empty) {
> +			print "<br/>\n";
> +		}
>  		print "</div>\n";
>  	}

Obviously unrelated and probably unplanned revert of [2/7] in
the series, so will not apply.
