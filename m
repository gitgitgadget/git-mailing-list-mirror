From: Alex Merry <kde@randomguy3.me.uk>
Subject: Re: [PATCH] Fix git-completion.bash for use in zsh
Date: Tue, 20 Mar 2012 11:53:06 +0000
Message-ID: <4F686FA2.8070803@randomguy3.me.uk>
References: <4E5F8CF3.3060304@randomguy3.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 13:15:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9xyJ-0008BN-E0
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 13:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759873Ab2CTMPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 08:15:21 -0400
Received: from fallback0.mail.ox.ac.uk ([129.67.1.175]:49569 "EHLO
	fallback0.mail.ox.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759861Ab2CTMPU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 08:15:20 -0400
X-Greylist: delayed 1130 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Mar 2012 08:15:19 EDT
Received: from relay2.mail.ox.ac.uk ([163.1.2.161])
	by fallback0.mail.ox.ac.uk with esmtp (Exim 4.69)
	(envelope-from <kde@randomguy3.me.uk>)
	id 1S9xfw-0007ut-34
	for git@vger.kernel.org; Tue, 20 Mar 2012 11:56:28 +0000
Received: from mailer.cs.ox.ac.uk ([129.67.151.81])
	by relay2.mail.ox.ac.uk with esmtp (Exim 4.75)
	(envelope-from <kde@randomguy3.me.uk>)
	id 1S9xch-0001jc-78; Tue, 20 Mar 2012 11:53:07 +0000
Received: from clpc343.cs.ox.ac.uk ([129.67.149.183]:50095)
	by mailer.cs.ox.ac.uk with esmtp (Exim 4.76)
	(envelope-from <kde@randomguy3.me.uk>)
	id 1S9xch-00038t-3X; Tue, 20 Mar 2012 11:53:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120209 Thunderbird/10.0.1
In-Reply-To: <4E5F8CF3.3060304@randomguy3.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193502>

This is just a reminder message, since I haven't heard anything back on 
this, and it hasn't made its way into the repo.

I realise Felipe Contreras has been pushing a different approach to 
making it work properly in zsh, but this should be a fairly innocuous 
fix in the meantime.

Alex

On 01/09/11 14:47, Alex Merry wrote:
> Certain versions (or option combinations) of zsh appear to treat
> things like
> local some_var=()
> as a function declaration.  This makes errors appear when using it in
> combination with the GIT_PS1_SHOWUPSTREAM option.
>
> Signed-off-by: Alex Merry<dev@randomguy3.me.uk>
> ---
>   contrib/completion/git-completion.bash |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 5a83090..89de45d 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -106,8 +106,9 @@ __gitdir ()
>   __git_ps1_show_upstream ()
>   {
>          local key value
> -       local svn_remote=() svn_url_pattern count n
> +       local svn_remote svn_url_pattern count n
>          local upstream=git legacy="" verbose=""
> +       svn_remote=()
>
>          # get some config options from git-config
>          while read key value; do
