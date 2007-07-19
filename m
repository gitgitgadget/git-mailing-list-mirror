From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-sh-setup::set_editor()
Date: Thu, 19 Jul 2007 19:46:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707191944560.14781@racer.site>
References: <Pine.LNX.4.64.0707191053230.14781@racer.site>
 <11848694482569-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 20:47:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBb1h-0000j7-HG
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 20:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938268AbXGSSq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 14:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932770AbXGSSq5
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 14:46:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:59362 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S936736AbXGSSq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 14:46:56 -0400
Received: (qmail invoked by alias); 19 Jul 2007 18:46:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 19 Jul 2007 20:46:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+CwggFlcSCloOkCyRnYEOmhPzK1/xibd+0hburJ/
	xohLd56QqTRnHZ
X-X-Sender: gene099@racer.site
In-Reply-To: <11848694482569-git-send-email-aroben@apple.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53017>

Hi,

On Thu, 19 Jul 2007, Adam Roben wrote:

> This function can be used to set the GIT_EDITOR variable to the user's
> preferred editor.

Much nicer, thank you.

However,

> -	commit_editor=$(git config core.editor || echo ${VISUAL:-$EDITOR})
> -	case "$commit_editor,$TERM" in
> +	case "$GIT_EDITOR,$TERM" in
>  	,dumb)

This can no longer happen, since ...

> +set_editor() {
> +    GIT_EDITOR=$(git config core.editor || echo ${VISUAL:-${EDITOR:-vi}})
> +    export GIT_EDITOR
> +}

... "vi" is the last resort, not "", right?

So I guess you just want to drag that test and warning into git-sh-setup 
(where I think it has a better home anyway).

Ciao,
Dscho
