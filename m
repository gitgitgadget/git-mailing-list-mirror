From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] completion: handle unstuck form of base git options
Date: Fri, 28 Jun 2013 09:20:17 +0100
Message-ID: <20130628082017.GE2232@serenity.lan>
References: <adafd1a0c0d7d059d215d9fd1ea68579525efe6e.1371900318.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 10:20:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsTv1-0004rT-9U
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 10:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172Ab3F1IUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 04:20:30 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:35320 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab3F1IU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 04:20:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 86484CDA5EB;
	Fri, 28 Jun 2013 09:20:25 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6i14u7h2i8Ci; Fri, 28 Jun 2013 09:20:24 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 59B27CDA57E;
	Fri, 28 Jun 2013 09:20:18 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <adafd1a0c0d7d059d215d9fd1ea68579525efe6e.1371900318.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229180>

Hi Junio, I don't think you've picked this up.  Are you expecting a
re-roll or did it just get lost in the noise?

On Sat, Jun 22, 2013 at 12:25:17PM +0100, John Keeping wrote:
> git-completion.bash's parsing of the command name relies on everything
> preceding it starting with '-' unless it is the "-c" option.  This
> allows users to use the stuck form of "--work-tree=<path>" and
> "--namespace=<path>" but not the unstuck forms "--work-tree <path>" and
> "--namespace <path>".  Fix this.
> 
> Similarly, the completion only handles the stuck form "--git-dir=<path>"
> and not "--git-dir <path>", so fix this as well.
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  contrib/completion/git-completion.bash | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 6c3bafe..8fbf941 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2492,9 +2492,10 @@ __git_main ()
>  		i="${words[c]}"
>  		case "$i" in
>  		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
> +		--git-dir)   ((c++)) ; __git_dir="${words[c]}" ;;
>  		--bare)      __git_dir="." ;;
>  		--help) command="help"; break ;;
> -		-c) c=$((++c)) ;;
> +		-c|--work-tree|--namespace) ((c++)) ;;
>  		-*) ;;
>  		*) command="$i"; break ;;
>  		esac
> -- 
> 1.8.3.1.676.gaae6535
> 
