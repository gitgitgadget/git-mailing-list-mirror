From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 07/11] gitweb: add 'remotes' action
Date: Sat, 15 Nov 2008 13:16:30 +0100
Message-ID: <200811151316.32024.jnareb@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-7-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-8-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 13:18:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1K6A-0000MN-HF
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 13:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927AbYKOMQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 07:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755032AbYKOMQn
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 07:16:43 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:16331 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915AbYKOMQm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 07:16:42 -0500
Received: by ey-out-2122.google.com with SMTP id 6so719089eyi.37
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 04:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SBJQ2Cef8NbEbS27YEs/YFYxINwJu5pb4yS11zoLNbg=;
        b=YdPaDwIcB3dXK3/7ZxWK6l+Myy2N61QV0J9zc/CzDMJnwOGeTTRM3GHpw/TPHidwdj
         lRdnuT5b9NkcbnAO4iot7ypeZMrSZ7cHVQQ80/A+BOX+i5rTZwnvwd1BbwBv96/p1W0o
         g5X/SPDCddOvGjMzRYrhF7FsbB7ApT0hBoj4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YWZHnZbhGHFF1HUE3oxKoQsf17+qO82p81Au5x69UQdx2md95IxApSuoeQJqmhk1/1
         42y1VKbTMAOd3/Lde26x2nB/HYUXscV9nPjIVF4IzmoQVhrw2yxcOYyFY7ctaXb8Q8dY
         UmMk4gKyN1m1YAYqcS6U3ncmwWYc7j2lwfLXg=
Received: by 10.210.58.13 with SMTP id g13mr2059410eba.192.1226751400935;
        Sat, 15 Nov 2008 04:16:40 -0800 (PST)
Received: from ?192.168.1.11? (abwb4.neoplus.adsl.tpnet.pl [83.8.225.4])
        by mx.google.com with ESMTPS id 5sm891692eyh.2.2008.11.15.04.16.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Nov 2008 04:16:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1226616555-24503-8-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101064>

On Thu, 13 Nov 2008, Giuseppe "Oblomov" Bilotta wrote:

> This action is similar to the 'heads' action, but it displays
> remote heads, grouped by remote repository.

I think I would prefer would go together with the change that split
the 'heads' ('branches') part of summary view into 'heads' and
'remotes', so that both section title header, and '...' continuation
if present, lead to proper view.

So either

  [heads]  # or [branches]
  master
  to-submit
  origin/master
  origin/next
  ...

where both '[heads]' and (possibly) '...' link to 'heads' view showing
_both_ local branches (refs/heads/*) and remote-tracking branches
(refs/remotes/*), like in first patch of series (perhaps with some
subdivision).

Or

  [heads]
  master
  to-submit
  ...
  [remotes]
  origin/master
  origin/next
  ...

where '[heads]' link to 'heads' view which shows only local branches
(refs/heads/*), and '[remotes]' link to 'remotes' view which shows only
remote-tracking branches.
 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   16 +++++++++++++++-
>  1 files changed, 15 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 03e0b21..09728cb 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -507,6 +507,7 @@ our %actions = (
>  	"commit" => \&git_commit,
>  	"forks" => \&git_forks,
>  	"heads" => \&git_heads,
> +	"remotes" => \&git_remotes,
>  	"history" => \&git_history,
>  	"log" => \&git_log,
>  	"rss" => \&git_rss,
> @@ -4755,13 +4756,26 @@ sub git_heads {
>  	git_print_page_nav('','', $head,undef,$head);
>  	git_print_header_div('summary', $project);
>  
> -	my @headslist = git_get_heads_list();
> +	my @headslist = git_get_heads_list(undef, 'heads');

Hmmm... I wonder if it would be possible to use some DWIM-mery on
the side of git_get_heads_list (for example checking if first argument
is a number, and assuming that nobody would be insane enough to use
refs/15 for namespace), and just use git_get_heads_list('heads') here.

But I guess that this form is good enough...

>  	if (@headslist) {
>  		git_heads_body(\@headslist, $head);
>  	}
>  	git_footer_html();
>  }
>  
> +sub git_remotes {
> +	my $head = git_get_head_hash($project);
> +	git_header_html();
> +	git_print_page_nav('','', $head,undef,$head);
> +	git_print_header_div('summary', $project . ' remotes');
> +
> +	my @headslist = git_get_heads_list(undef, 'remotes');
> +	if (@headslist) {
> +		git_split_heads_body(\@headslist, $head);
> +	}
> +	git_footer_html();
> +}

Nice. I see the difference from git_heads is using $project . ' remotes'
in place of $project in git_print_header_div() (why?), and using 
'remotes' in call to git_get_heads_list().

> +
>  sub git_blob_plain {
>  	my $type = shift;
>  	my $expires;
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
