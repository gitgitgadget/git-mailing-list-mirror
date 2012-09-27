From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: introduce GIT_GLOBAL_CONFIG to override
 ~/.gitconfig
Date: Thu, 27 Sep 2012 13:35:32 -0400
Message-ID: <20120927173532.GD1547@sigill.intra.peff.net>
References: <CALkWK0nYnyaoOsH_x8U96ADZT7VuP-pR36+RRcjTw39Kp1qCnw@mail.gmail.com>
 <1348757171-3223-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, David Aguilar <davvid@gmail.com>,
	Anurag Priyam <anurag08priyam@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 19:35:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THHzz-00031W-Qz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 19:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124Ab2I0Rff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 13:35:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32922 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab2I0Rfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 13:35:34 -0400
Received: (qmail 3504 invoked by uid 107); 27 Sep 2012 17:36:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Sep 2012 13:36:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2012 13:35:32 -0400
Content-Disposition: inline
In-Reply-To: <1348757171-3223-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206494>

On Thu, Sep 27, 2012 at 08:16:11PM +0530, Ramkumar Ramachandra wrote:

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index eaea079..c8db03f 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -205,6 +205,9 @@ $GIT_DIR/config::
>  	User-specific configuration file. Also called "global"
>  	configuration file.
>  
> +$GIT_GLOBAL_CONFIG::
> +	Overrides the path of the global configuration file.
> +

Like the other reviews, I am not overly enthused. If we are going to add
a new variable, I think $GIT_HOME makes a lot more sense. But it really
sounds like using $XDG_CONFIG_HOME would be even simpler.

Also, have you considered using a config include? Like:

  $ echo '[include]path = ~/my-dotfiles/gitconfig' >~/.gitconfig

It's a one-time setup, and then you get updates inside my-dotfiles
forever. The one-time setup is annoying, but you have to bootstrap
somehow (e.g., you're going to have to copy a .profile or similar to get
the GIT_GLOBAL_CONFIG variable set).

-Peff
