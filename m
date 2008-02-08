From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] gitweb: Use the config file to set repository owner's
	name.
Date: Fri, 8 Feb 2008 12:30:27 -0200
Message-ID: <20080208143027.GA707@c3sl.ufpr.br>
References: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br> <1202445714-28971-2-git-send-email-ribas@c3sl.ufpr.br> <m3myqbhg4o.fsf@localhost.localdomain> <20080208135327.GC30264@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Git Managment for C3SL <git@git.c3sl.ufpr.br>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 15:31:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNUGJ-0007sk-Ss
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 15:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757165AbYBHOa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 09:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757198AbYBHOa6
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 09:30:58 -0500
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:56705 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757130AbYBHOa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 09:30:57 -0500
Received: from localhost (unknown [189.1.136.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 19201700003DB;
	Fri,  8 Feb 2008 12:30:56 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <20080208135327.GC30264@c3sl.ufpr.br>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73097>

On Fri, Feb 08, 2008 at 11:53:27AM -0200, Bruno Cesar Ribas wrote:
> On Fri, Feb 08, 2008 at 02:55:33AM -0800, Jakub Narebski wrote:
> > Bruno Ribas <ribas@c3sl.ufpr.br> writes:
> > 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8ef2735..e8a43b7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1767,7 +1767,12 @@ sub git_get_project_owner {
>       if (exists $gitweb_project_owner->{$project}) {
>               $owner = $gitweb_project_owner->{$project};
>       }
> -     if (!defined $owner) {
> +
> +     if (!defined $owner){
> +             $owner = git_get_project_config('owner');
> +     }
> +
> +     if (!$owner) {
>               $owner = get_file_owner("$projectroot/$project");
>       }
>


I that last 3lines should be inside the block that we call
git_get_project_config, don't you think?

> > First, I think the empty lines added are not needed.
> 
> I made those empty lines because original code had same empty lines above, I
> just let it to have same pattern, but I can remove. Should I remove?! I'll
> resend without it, and with $git_dir set.
> > 
> > Second, git_get_project_config() subroutine _REQUIRES_ for $git_dir to
> > be set. So you have to set $git_dir before checking repo config; then
> > you can reuse $git_dir in checking file owner.
> > 
> > -- 
> > Jakub Narebski
> > Poland
> > ShadeHawk on #git
> 
> -- 
> Bruno Ribas - ribas@c3sl.ufpr.br
> http://web.inf.ufpr.br/ribas
> C3SL: http://www.c3sl.ufpr.br 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
