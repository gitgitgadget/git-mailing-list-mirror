From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v4 2/4] completion: simplify __git_remotes
Date: Mon, 6 Feb 2012 21:53:15 +0100
Message-ID: <20120206205315.GI16099@goldbirke>
References: <1328214625-3576-1-git-send-email-felipe.contreras@gmail.com>
	<1328214625-3576-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Todd Zullinger <tmz@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 21:53:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuVYz-0006xg-84
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 21:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172Ab2BFUxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 15:53:21 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:52692 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab2BFUxU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 15:53:20 -0500
Received: from localhost6.localdomain6 (p5B1304FC.dip0.t-ipconnect.de [91.19.4.252])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MXTlq-1S0ZZc1qVi-00WoJg; Mon, 06 Feb 2012 21:53:14 +0100
Content-Disposition: inline
In-Reply-To: <1328214625-3576-3-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:Natk9eIYpE/KQusw4DGxKWfhQPALH0PdwEBi10H7U+0
 JYHsTTWiy3V57Ief+OC51YASc4jryC4EkYl2QI7sksnbDaLYjK
 ZJlxou6Ev9JM+pUl9ii3dsANdxRBkmxRjFyyrskkg1j2CAoKwk
 ykdD2gWEDYFYsz2GG+3/FZ72KdLj6pPVSRvaLk2HjUomAtYYFq
 XJey6jZafst//TBmYajMTYXwL4TjAp5293OnLT4LFsWZUZd/Ai
 sn/x66fDFkOIbfM7rwDG7u5TsMOtj6MYOcC2dtC/LOnP+7Qk5o
 zyymq4T3iUAbXOZQYdkDIuaJ2hUh5g288a9C2OuTiW+vq8aMVI
 SdymCoS3u+vx4rrsD4RA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190101>

Hi,


On Thu, Feb 02, 2012 at 10:30:23PM +0200, Felipe Contreras wrote:
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index b435b6d..f86b734 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -644,12 +644,7 @@ __git_refs_remotes ()
>  __git_remotes ()
>  {
>  	local i ngoff IFS=$'\n' d="$(__gitdir)"

You could also remove the ngoff variable, because with this patch it's
not used anymore.

> -	__git_shopt -q nullglob || ngoff=1
> -	__git_shopt -s nullglob
> -	for i in "$d/remotes"/*; do
> -		echo ${i#$d/remotes/}
> -	done
> -	[ "$ngoff" ] && __git_shopt -u nullglob
> +	test -d "$d/remotes" && ls -1 "$d/remotes"
>  	for i in $(git --git-dir="$d" config --get-regexp 'remote\..*\.url' 2>/dev/null); do
>  		i="${i#remote.}"
>  		echo "${i/.url*/}"
> -- 
> 1.7.9
> 
