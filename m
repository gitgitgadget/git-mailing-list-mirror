From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] completion: Add '--edit-todo' to rebase
Date: Mon, 13 Jul 2015 14:11:07 +0100
Message-ID: <20150713131107.GC1451@serenity.lan>
References: <1436786876.6619.0.camel@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Mon Jul 13 15:11:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEdWB-0000rE-QG
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 15:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbbGMNLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 09:11:31 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:47555 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbbGMNLb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 09:11:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 42FD186600F;
	Mon, 13 Jul 2015 14:11:30 +0100 (BST)
X-Quarantine-ID: <RwryK8kYCm6x>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.5
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_05=-0.5] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RwryK8kYCm6x; Mon, 13 Jul 2015 14:11:23 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 52A67CDA5E8;
	Mon, 13 Jul 2015 14:11:09 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1436786876.6619.0.camel@virtuell-zuhause.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273918>

On Mon, Jul 13, 2015 at 01:27:56PM +0200, Thomas Braun wrote:
> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c97c648..2567a61 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1668,7 +1668,7 @@ _git_rebase ()
>  {
>  	local dir="$(__gitdir)"
>  	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
> -		__gitcomp "--continue --skip --abort"
> +		__gitcomp "--continue --skip --abort --edit-todo"

git-rebase.sh contains:

	if test "$action" = "edit-todo" && test "$type" != "interactive"
	then
		die "$(gettext "The --edit-todo action can only be used during interactive rebase.")"
	fi

I wonder if it's worth doing a similar check here, which presumably
means testing if "$dir"/interactive exists.

>  		return
>  	fi
>  	__git_complete_strategy && return
> 
> 
