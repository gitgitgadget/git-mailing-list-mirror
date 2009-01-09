From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: support the rel=vcs microformat
Date: Fri, 09 Jan 2009 15:49:25 -0800 (PST)
Message-ID: <m3skns11mk.fsf@localhost.localdomain>
References: <20090107042518.GB24735@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jan 10 00:50:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLR7u-0005BU-1C
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 00:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbZAIXta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 18:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbZAIXt3
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 18:49:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:19285 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbZAIXt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 18:49:28 -0500
Received: by ug-out-1314.google.com with SMTP id 39so69912ugf.37
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 15:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=rJiUIJAg1XDTCOj8lXXTcfEeDMncBC2ZRik4X2z7Tdc=;
        b=rghZzuu+WH+ahaRgECsCsr2Czq0UaufLaJS/db/jsDeGUGqavJ7m1nIFxXpaneNiG7
         NGpMgbUxevLOJ/82n35t3Gik9QL0eAH3ajAVhMY01BieeU2y1OLjKZc+VQQTGGowp6Tw
         s2hlGmeRC0FkWnh8MPgj8XLzzwFXGfLFO5Vsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ggQzeiELac9WOM0CSDIZuFx/cwyyMQxN0PGc2Ax6DjidHNoSw2pq5b2h//gBXoj1Fv
         WBeQYoSIpGmYJcadq5wCKFQVtqHdR1R8u2e+nUal9vP3bvqmEoY45YY5dLK+oMWm/0zz
         BzS1gUK/NdBK6e4pL4L0xE29HW36OoD+0wvzI=
Received: by 10.67.115.16 with SMTP id s16mr15275926ugm.47.1231544966435;
        Fri, 09 Jan 2009 15:49:26 -0800 (PST)
Received: from localhost.localdomain (abwp34.neoplus.adsl.tpnet.pl [83.8.239.34])
        by mx.google.com with ESMTPS id l4sm30446529ugf.2.2009.01.09.15.49.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 15:49:25 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n09NnPC3028174;
	Sat, 10 Jan 2009 00:49:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n09NnNp7028171;
	Sat, 10 Jan 2009 00:49:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090107042518.GB24735@gnu.kitenet.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105046>

Joey Hess <joey@kitenet.net> writes:

> The rel=vcs microformat allows a web page to indicate the locations of
> repositories related to it in a machine-parseable manner.
> (See http://kitenet.net/~joey/rfc/rel-vcs/)

Let me put here an example from avove mentioned page:

  <head>
  <link rel="vcs-git" href="git://example.org/foo.git" 
        title="foo git repository" />
  </head>

  <a rel="vcs-git" href="git://example.org/foo.git" 
     title="git repository">git://example.org/foo.git</a>
  <a rel="vcs-git" href="git://example.org/foo.git">git repository</a>

There is one problem that is not solved in above microformat, but it
is problem only for git hosting sites like repo.or.cz or GitHub,
namely it does not allow to distinguish between fetch (read) link, and
push (write, publish) link.  This is not a problem for standard
(unmodified) gitweb as it shows only read-only git repositories links.

We also have to decide what to put in the 'title' attribute; I think
the simplest would be to put "$project git repository" or something
(for example "git/git.git git repository").

One thing I worry about is that those links (or at least some of those
links) are not meant for the browser to open; also SCP/SSH-like syntax
for SSH protocol in the form of 'user@host:/path/to/repo.git/' which
does not follow URL rules.

> 
> Make gitweb use the microformat in the header of pages it generates,
> if it has been configured with project url information in any of the usual
> ways.

There are two bit separate issues here: marking existing and future
URLs (current project fetch URLs which IIRC are not hyperlinked now;
planned/future 'git' links in project list page; perhaps also links in
OPML and RSS/Atom feeds) with 'rel="vcs-git"', and adding <link .../>
elements to page header.

> 
> Since getting the urls can require hitting disk, I avoided putting the
> microformat on *every* page gitweb generates. Just put it on the project
> summary page, the project list page, and the forks list page.
>
> The first of these already looks up the urls, so adding the microformat was
> free. 

I assume that this patch is only about adding <link ... /> elements to
head?  I think in the case of 'summary' view for a project it is an
excellent idea (similar to having 'prev' and 'next' link elements in
chaptered on-line book in HTML), and would allow for automation using
gitweb as a kind of service announcement.

> There is a small overhead in including the microformat on the latter
> two pages [projects list and list of forks], but getting the project
> descriptions for those pages already incurs a similar overhead, and
> the ability to get every repo url in one place seems worthwhile.

There is also OPML, which might be worth checking.

By the way, for 'projects_list' action and 'forks' actions we have to
decide whether to show _all_ links for each project (there can be more
than one), or whether we show only some main git link (like in the
case of proposed 'git' link).  And whether we trust @git_base_url_list
or do we take it as default and examine per-repository configuration
(more costly).

What is more important: 'project_list' page is already overly large
when hosting very large number of repositories (there were some
patches adding pagination for 'project_list', and perhaps they would
be resend).  Adding <link .../> elements would only add to its size;
and if will be divided into pages we would have also to take it into
account.

> 
> This changes git_get_project_description() to not check wantarray, and only
> return in list context -- the only way it is used AFAICS.

Errr... what? Why do you change git_get_project_description()
subroutine? I don't think it would be good source for 'title'
attribute; perhaps for 'desc' attribute, and only aftre sanitizing
"Unnamed repository; edit this file to name it for gitweb."

Errata: ah, it is git_get_project_url_list() subroutine...

> 
> Signed-off-by: Joey Hess <joey@gnu.kitenet.net>
> ---
>  gitweb/gitweb.perl |   38 ++++++++++++++++++++++++++------------
>  1 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 99f71b4..3f8a228 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -789,6 +789,9 @@ $git_dir = "$projectroot/$project" if $project;
>  our @snapshot_fmts = gitweb_get_feature('snapshot');
>  @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
>  
> +# populated later with git urls for the project
> +our @git_url_list;
> +

I'm not sure why this have to be global, but I assume that you want to
avoid recalculationg it in git_header_html

>  # dispatch
>  if (!defined $action) {
>  	if (defined $hash) {
> @@ -2100,17 +2103,22 @@ sub git_show_project_tagcloud {
>  }
>  
>  sub git_get_project_url_list {
> +	# use per project git URL list in $projectroot/$path/cloneurl
> +	# or make project git URL from git base URL and project name

I'd rather use separate subroutine for the second, I think.

>  	my $path = shift;
>  
> +	my @ret;
> +
>  	$git_dir = "$projectroot/$path";
> -	open my $fd, "$git_dir/cloneurl"
> -		or return wantarray ?
> -		@{ config_to_multi(git_get_project_config('url')) } :
> -		   config_to_multi(git_get_project_config('url'));
> -	my @git_project_url_list = map { chomp; $_ } <$fd>;
> -	close $fd;
> +	if (open my $fd, "$git_dir/cloneurl") {
> +		@ret = map { chomp; $_ } <$fd>;
> +		close $fd;
> +	}
> +	else {

Style: "} else {"

> +	       @ret = @{ config_to_multi(git_get_project_config('url')) };
> +	}
>  
> -	return wantarray ? @git_project_url_list : \@git_project_url_list;
> +	return @ret ? @ret : map { "$_/$project" } @git_base_url_list;
>  }

Hmmm... currently gitweb does it at caller:

	my @url_list = git_get_project_url_list($project);
	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;

Why do you want to put this in git_get_project_url_list()? Please
explain (here and in the commit message too; it has to be mentioned in
commit message that you cnage semantics a bit, and explain why you did
so).

>  
>  sub git_get_projects_list {
> @@ -2953,6 +2961,10 @@ EOF

Sidenote: this should be

  @@ -2953,6 +2961,10 @@ sub git_header_html {

but I'm not sure if it would be possible to automate...

>  		print qq(<link rel="shortcut icon" href="$favicon" type="image/png" />\n);
>  	}
>  
> +	foreach my $url (@git_url_list) {
> +		print qq{<link rel="vcs" type="git" href="$url" />\n};
> +	}
> +

Errr... in mentioned http://kitenet.net/~joey/rel-vcs/ it is

  <link rel="vcs-git" href="$url" title="$project git repository" />

and not

  <link rel="vcs" type="git" href="$url" />

Besides, 'type' attribute for A and LINK elements is about advisory
conent-type of the document pointed by link:

 type = content-type [CI]
    This attribute gives an advisory hint as to the content type of
    the content available at the link target address. It allows user
    agents to opt to use a fallback mechanism rather than fetch the
    content if they are advised that they will get content in a
    content type they do not support.  Authors who use this attribute
    take responsibility to manage the risk that it may become
    inconsistent with the content available at the link target
    address.  
    For the current list of registered content types, please consult
    [MIMETYPES].

>  	print "</head>\n" .
>  	      "<body>\n";
>  
> @@ -4380,6 +4392,8 @@ sub git_project_list {
>  		die_error(404, "No projects found");
>  	}
>  
> +	@git_url_list = map { git_get_project_url_list($_->{path}) } @list;
> +
>  	git_header_html();
>  	if (-f $home_text) {
>  		print "<div class=\"index_include\">\n";
> @@ -4400,6 +4414,8 @@ sub git_forks {
>  	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
>  		die_error(400, "Unknown order parameter");
>  	}
> +	
> +	@git_url_list = map { git_get_project_url_list($_->{path}) } @list;
>  
>  	my @list = git_get_projects_list($project);
>  	if (!@list) {

Those two are pretty straightforward, but please note that
'project_list' view (action) might be _already_ too large...

> @@ -4457,6 +4473,8 @@ sub git_summary {
>  		@forklist = git_get_projects_list($project);
>  	}
>  
> +	@git_url_list = git_get_project_url_list($project);
> +
>  	git_header_html();
>  	git_print_page_nav('summary','', $head);
>  
> @@ -4468,12 +4486,8 @@ sub git_summary {
>  		print "<tr id=\"metadata_lchange\"><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
>  	}
>  
> -	# use per project git URL list in $projectroot/$project/cloneurl
> -	# or make project git URL from git base URL and project name
>  	my $url_tag = "URL";
> -	my @url_list = git_get_project_url_list($project);
> -	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
> -	foreach my $git_url (@url_list) {
> +	foreach my $git_url (@git_url_list) {
>  		next unless $git_url;
>  		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
>  		$url_tag = "";
> -- 
> 1.5.6.5

This is also pretty straightforward: it moves calculation earlier for
results to be shared with git_header_html (and uses global variable).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
