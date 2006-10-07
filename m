From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 1/2] gitweb: Show snapshot links for tree entries in tree listing
Date: Sat, 7 Oct 2006 11:37:02 -0700 (PDT)
Message-ID: <20061007183702.40162.qmail@web31802.mail.mud.yahoo.com>
References: <20061007141040.16912.50717.stgit@rover>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 20:37:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWH32-0001Ir-91
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 20:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWJGShE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 14:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWJGShE
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 14:37:04 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:60799 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751757AbWJGShD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 14:37:03 -0400
Received: (qmail 40164 invoked by uid 60001); 7 Oct 2006 18:37:02 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=K1aFEcQM+zeTvsyGniRv2IOrItxweIj1Rpmy6ZWLGomGGbumpgFTQm1Ipz5RfGSj20agaQkiMQA3OZRofd/QRqfNNu21R9bMeGDqBC/v+1ctGPwlHoL7HcCyBXzZgbJSXKKUYwT3dUdKge6rsM6YZ319RWKJctW1Ns47kme+a5k=  ;
Received: from [71.80.233.118] by web31802.mail.mud.yahoo.com via HTTP; Sat, 07 Oct 2006 11:37:02 PDT
To: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <20061007141040.16912.50717.stgit@rover>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28492>

--- Petr Baudis <pasky@suse.cz> wrote:
> Currently that's inconsistently reachable only by first displaying the
> tree.

I cannot say that there is any "inconsistency" there per se.  I also
fail to see the value of this patch.

It looks like it just adds interface to gitweb, just because "we can"
and "gitweb can do it".

    Luben

> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
> 
>  gitweb/gitweb.perl |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index c4970f4..096a01b 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1752,7 +1752,7 @@ sub git_print_simplified_log {
>  
>  # print tree entry (row of git_tree), but without encompassing <tr> element
>  sub git_print_tree_entry {
> -	my ($t, $basedir, $hash_base, $have_blame) = @_;
> +	my ($t, $basedir, $hash_base, $have_blame, $have_snapshot) = @_;
>  
>  	my %base_key = ();
>  	$base_key{hash_base} = $hash_base if defined $hash_base;
> @@ -1798,6 +1798,13 @@ sub git_print_tree_entry {
>  			print $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
>  			                             file_name=>"$basedir$t->{'name'}")},
>  			              "history");
> +			if ($have_snapshot) {
> +				print " | ";
> +			}
> +		}
> +		if ($have_snapshot) {
> +			print $cgi->a({-href => href(action=>"snapshot", hash=>$t->{'hash'})},
> +				      "snapshot");
>  		}
>  		print "</td>\n";
>  	}
> @@ -2931,7 +2938,7 @@ sub git_tree {
>  		}
>  		$alternate ^= 1;
>  
> -		git_print_tree_entry(\%t, $base, $hash_base, $have_blame);
> +		git_print_tree_entry(\%t, $base, $hash_base, $have_blame, $have_snapshot);
>  
>  		print "</tr>\n";
>  	}
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
