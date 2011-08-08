From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Support specific color for a specific remote branches
Date: Mon, 8 Aug 2011 14:52:14 -0600
Message-ID: <20110808205214.GG18294@sigill.intra.peff.net>
References: <1312818553-25042-1-git-send-email-avivey@gmail.com>
 <7v8vr3zsh1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Aviv Eyal <avivey@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 22:52:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqWoA-0002aP-Ai
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 22:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640Ab1HHUwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 16:52:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36962
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150Ab1HHUwR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 16:52:17 -0400
Received: (qmail 30075 invoked by uid 107); 8 Aug 2011 20:52:52 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Aug 2011 16:52:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Aug 2011 14:52:14 -0600
Content-Disposition: inline
In-Reply-To: <7v8vr3zsh1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178981>

On Mon, Aug 08, 2011 at 11:08:26AM -0700, Junio C Hamano wrote:

> > +	return 0;
> > +}
> > +
> > +static char *git_branch_get_custom_color_remote(const char *name)
> > +{
> > +	int name_len;
> > +	char* repo_name;
> > +	struct string_list_item *custom;
> > +	name_len = strchr(name, '/') - name;
> 
> Who said a remote name is terminated with (and cannot contain) a slash?
> 
> Shouldn't this code be consulting the configuration file to learn the
> remote mapping, e.g.
> 
>     [remote "frotz"]
>         fetch = +refs/heads/*:refs/remotes/nitfol/*
> 
> so that remote branches from "frotz" remote, that happen to be stored
> under refs/remotes/nitfol/ hierarchy, are painted in the correct color?

This seems related to the recent thread about showing branches only for
a specific remote:

  http://article.gmane.org/gmane.comp.version-control.git/178668

Maybe the two should share code.

Right now, "git branch -r" means "show everything under refs/remotes
instead of refs/heads". This would be easy to implement if it instead
meant "show all refs created by the RHS of a fetch refspec in a
configured remote". The two are equivalent in the default config, but
the latter may make more sense in a complex case.

-Peff
