From: Jeff King <peff@peff.net>
Subject: Re: checkout extra files
Date: Mon, 10 Sep 2012 12:19:04 -0400
Message-ID: <20120910161904.GC9435@sigill.intra.peff.net>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
 <7vpq61dfn9.fsf@alter.siamese.dyndns.org>
 <7v8vcpdat2.fsf@alter.siamese.dyndns.org>
 <7vk3w5woc4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 18:19:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB6hh-00084Q-Cg
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757716Ab2IJQTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:19:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39715 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416Ab2IJQTI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:19:08 -0400
Received: (qmail 29143 invoked by uid 107); 10 Sep 2012 16:19:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 12:19:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 12:19:04 -0400
Content-Disposition: inline
In-Reply-To: <7vk3w5woc4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205135>

On Fri, Sep 07, 2012 at 01:49:15PM -0700, Junio C Hamano wrote:

> -- >8 --
> gitcli: contrast wildcard given to shell and to git
> 
> People who are not used to working with shell may intellectually
> understand how the command line argument is massaged by the shell
> but still have a hard time visualizing the difference between
> letting the shell expand fileglobs and having Git see the fileglob
> to use as a pathspec.

I think this is an improvement, but...

> diff --git c/Documentation/gitcli.txt w/Documentation/gitcli.txt
> index ea17f7a..220621b 100644
> --- c/Documentation/gitcli.txt
> +++ w/Documentation/gitcli.txt
> @@ -38,6 +38,22 @@ arguments.  Here are the rules:
>     you have to say either `git diff HEAD --` or `git diff -- HEAD` to
>     disambiguate.
>  
> + * Many commands allow wildcards in paths, but you need to protect
> +them from getting globbed by the shell.  These two mean different things:
> ++
> +--------------------------------
> +$ git checkout -- *.c
> +$ git checkout -- \*.c
> +--------------------------------
> ++
> +The former lets your shell expand the fileglob, and you are asking
> +the dot-C files in your working tree to be overwritten with the version
> +in the index.  The latter passes the `*.c` to Git, and you are asking
> +the paths in the index that match the pattern to be checked out to your
> +working tree.  After running `git add hello.c; rm hello.c`, you will _not_
> +see `hello.c` in your working tree with the former, but with the latter
> +you will.
> +
>  When writing a script that is expected to handle random user-input, it is
>  a good practice to make it explicit which arguments are which by placing
>  disambiguating `--` at appropriate places.

Look at the paragraph below your addition. It is typographically outside
of the bulleted list you are adding to, but it really makes sense
directly after the prior two bullet points, which are explicitly about
disambiguation between revisions and paths. Your addition splits them
apart.

Does it make sense to join that final paragraph into what is now the
third bullet, and then add your new text (the fourth bullet) after?

-Peff
