From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Show project's README.html if available
Date: Tue, 24 Oct 2006 01:43:08 -0700 (PDT)
Message-ID: <350280.74860.qm@web31804.mail.mud.yahoo.com>
References: <20061024032346.4185.85330.stgit@rover>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 10:43:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcHsQ-0001qY-4Q
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 10:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWJXInK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 04:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWJXInK
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 04:43:10 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:33196 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030217AbWJXInJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 04:43:09 -0400
Received: (qmail 77115 invoked by uid 60001); 24 Oct 2006 08:43:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=G1l8AyozsXf1pzMbL1cPgnggDUKNLnKOsGZj+HZ5lUx3ycdHNYlJyaSDhjRXpdldBPiZnBwxdEzzYJpLL0xT/rpUn/Z++mxBW7uZcqwKHJlOdfxqpUoHPvMbCioqLtDMoNB0gBPbjlm8dEtVOqbyZNHGztHkeiN9Fj1msneIjSc=  ;
X-YMail-OSG: Lr8_VfMVM1n7SyEY.cIs4uLo93zH5SmC6caI7onr365X1hStQVUHN7WMkqMah1Jp86yHGRDfzLG74Vwe6RPRhiiJlnVEfo0lI9J4LE2Yxdl3bVlmhP5FhmAsmwxm6gk8BvNAkU8dOwo-
Received: from [71.80.233.118] by web31804.mail.mud.yahoo.com via HTTP; Tue, 24 Oct 2006 01:43:08 PDT
To: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <20061024032346.4185.85330.stgit@rover>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29946>

--- Petr Baudis <pasky@suse.cz> wrote:
> If the repository includes a README.html file, show it in the summary page.
> The usual "this should be in the config file" argument does not apply here
> since this can be larger and having such a big string in the config file
> would be impractical.
> 
> I don't know if this is suitable upstream, but it's one of the repo.or.cz
> custom modifications that I've thought could be interesting for others
> as well.
> 
> Compared to the previous patch, this adds the '.html' extension to the
> filename, so that it's clear it is, well, HTML.
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---

Why not instead re-submit a patch implementing what was discussed
in this thread bearing the same name:

http://marc.theaimsgroup.com/?t=116044914900001&r=1&w=2

     Luben


> 
>  gitweb/gitweb.perl |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3b26ec3..81adc71 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2538,6 +2538,14 @@ sub git_summary {
>  	}
>  	print "</table>\n";
>  
> +	if (-s "$projectroot/$project/README.html") {
> +		if (open my $fd, "$projectroot/$project/README.html") {
> +			print "<div class=\"title\">readme</div>\n";
> +			print $_ while (<$fd>);
> +			close $fd;
> +		}
> +	}
> +
>  	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=17",
>  		git_get_head_hash($project)
>  		or die_error(undef, "Open git-rev-list failed");
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
