From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] gitweb: decorate a bit more remotes
Date: Mon, 20 Dec 2010 14:02:03 -0600
Message-ID: <20101220200203.GA24163@burratino>
References: <1292871681-4818-1-git-send-email-sylvain@abstraction.fr>
 <1292871681-4818-3-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Mon Dec 20 21:02:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUlwA-0002Df-8D
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 21:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933112Ab0LTUCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 15:02:21 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:51450 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933104Ab0LTUCU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 15:02:20 -0500
Received: by fxm18 with SMTP id 18so3489836fxm.2
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 12:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Etl1F5ZJbrkvC4Plm200Iw90sGDu2KJ7ga41Ewqw8Fk=;
        b=ijOpzGWQtrxcgkSj8qP1J8ppu+2OQFqs55eLQukblww+d3hl/ixGC/78J7ASyHpMgF
         2yLel1wIhp1ywtNgwwbwI2kofledh0IgEWIYAjBwlAb3D/yosmy52t6XX3HDUw7ANpmh
         DgYchOEmLV4aO/PIn5+PwMRCsQAkO6wyHGF0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jwJq9LmSskvteunlIduhzLn1PmHxOr2xqLT6fzbPPQHSDt+GKY5VVND80rGjafyLkx
         5KISMhicb1ZOMJioE556tm3Gxi/QxsaNFsDemjauD0rgALwrsDdV4qerYsYDTaMHULl0
         0hOkkdg5X7rblrVwdMphkvl5w9vtp2HCuVLtg=
Received: by 10.223.86.194 with SMTP id t2mr590117fal.40.1292875338898;
        Mon, 20 Dec 2010 12:02:18 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id n1sm1083203fam.40.2010.12.20.12.02.15
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Dec 2010 12:02:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1292871681-4818-3-git-send-email-sylvain@abstraction.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164010>

Sylvain Rabot wrote:

> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5127,13 +5127,13 @@ sub git_remote_block {
>  
>  	if (defined $fetch) {
>  		if ($fetch eq $push) {
> -			$urls_table .= format_repo_url("URL", $fetch);
> +			$urls_table .= format_repo_url("<span class=\"bold\">URL:</span>", $fetch);
>  		} else {
> -			$urls_table .= format_repo_url("Fetch URL", $fetch);
> -			$urls_table .= format_repo_url("Push URL", $push) if defined $push;
> +			$urls_table .= format_repo_url("<span class=\"bold\">Fetch URL:</span>", $fetch);
> +			$urls_table .= format_repo_url("<span class=\"bold\">Push URL:</span>", $push) if defined $push;

This makes the formatting of the remote URLs table inconsistent with
the other projects_list table (namely the

	description	...
	homepage URL	...
	repository URL	...
	owner	...
	last change	...

table on a repository's summary page).  Is that the right thing
to do?

If so, maybe something like the following would make sense.

-- 8< --
From: Sylvain Rabot <sylvain@abstraction.fr>
Date: Mon, 20 Dec 2010 20:01:20 +0100
Subject: gitweb: decorate a bit more remotes

Put the text "URL" introducing a remote's url in bold and follow it
with a colon.  This makes the url list easier to visually scan.

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The justification above is totally made up; I have not checked to
see whether it makes the table easier or harder to read.  Also:
untested.

Maybe the $url part should be esc_url($url)?

 gitweb/gitweb.perl       |   16 ++++++++++------
 gitweb/static/gitweb.css |   13 +++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d521c93..b870b56 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3862,7 +3862,11 @@ sub git_print_header_div {
 
 sub format_repo_url {
 	my ($name, $url) = @_;
-	return "<tr class=\"metadata_url\"><td>$name</td><td>$url</td></tr>\n";
+	my $row = "<tr class=\"metadata_url\">";
+	$row .= ($name eq "" ? "<td></td>" : "<td class=\"metadata_tag\">$name</td>");
+	$row .= "<td>$url</td>";
+	$row .= "</tr>\n";
+	return $row;
 }
 
 # Group output by placing it in a DIV element and adding a header.
@@ -5122,7 +5126,7 @@ sub git_remote_block {
 	my $fetch = $rdata->{'fetch'};
 	my $push = $rdata->{'push'};
 
-	my $urls_table = "<table class=\"projects_list\">\n" ;
+	my $urls_table = "<table class=\"remote_urls\">\n" ;
 
 	if (defined $fetch) {
 		if ($fetch eq $push) {
@@ -5368,10 +5372,10 @@ sub git_summary {
 
 	print "<div class=\"title\">&nbsp;</div>\n";
 	print "<table class=\"projects_list\">\n" .
-	      "<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
-	      "<tr id=\"metadata_owner\"><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
+	      "<tr id=\"metadata_desc\"><td class=\"metadata_tag\">description</td><td>" . esc_html($descr) . "</td></tr>\n" .
+	      "<tr id=\"metadata_owner\"><td class=\"metadata_tag\">owner</td><td>" . esc_html($owner) . "</td></tr>\n";
 	if (defined $cd{'rfc2822'}) {
-		print "<tr id=\"metadata_lchange\"><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
+		print "<tr id=\"metadata_lchange\"><td class=\"metadata_tag\">last change</td><td>$cd{'rfc2822'}</td></tr>\n";
 	}
 
 	# use per project git URL list in $projectroot/$project/cloneurl
@@ -5390,7 +5394,7 @@ sub git_summary {
 	if ($show_ctags) {
 		my $ctags = git_get_project_ctags($project);
 		my $cloud = git_populate_project_tagcloud($ctags);
-		print "<tr id=\"metadata_ctags\"><td>Content tags:<br />";
+		print "<tr id=\"metadata_ctags\"><td class=\"metadata_tag\">Content tags:<br />";
 		print "</td>\n<td>" unless %$ctags;
 		print "<form action=\"$show_ctags\" method=\"post\"><input type=\"hidden\" name=\"p\" value=\"$project\" />Add: <input type=\"text\" name=\"t\" size=\"8\" /></form>";
 		print "</td>\n<td>" if %$ctags;
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 79d7eeb..feb09e5 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -579,6 +579,19 @@ div.remote {
 	display: inline-block;
 }
 
+/*
+ * <b>URL:</b>	http://www.example.com/
+ * <b>Fetch URL:</b>	http://www.example.com/
+ * <b>Push URL:</b>	http://www.example.com/
+ */
+table.remote_urls tr.metadata_url td.metadata_tag:after {
+	content: ":"
+}
+
+table.remote_urls tr.metadata_url td.metadata_tag {
+	font-weight: bold;
+}
+
 /* Style definition generated by highlight 2.4.5, http://www.andre-simon.de/ */
 
 /* Highlighting theme definition: */
-- 
1.7.2.3.554.gc9b5c.dirty
