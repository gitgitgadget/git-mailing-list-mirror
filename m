From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Introduce the GIT_HOME environment variable
Date: Mon, 21 Dec 2009 10:59:02 -0500
Message-ID: <20091221155902.GA22665@sigill.intra.peff.net>
References: <4B2C0828.4010505@signalbeam.net>
 <20091219013246.GD25474@genesis.frugalware.org>
 <7vhbrnodd9.fsf@alter.siamese.dyndns.org>
 <4B2C5A1A.8000201@signalbeam.net>
 <7vzl5fik3o.fsf@alter.siamese.dyndns.org>
 <20091219153046.GG25474@genesis.frugalware.org>
 <vpqeimq51pq.fsf@bauges.imag.fr>
 <7vskb6bwvu.fsf@alter.siamese.dyndns.org>
 <vpqhbrkd3o6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Moe <moe@signalbeam.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Dec 21 16:59:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMkfI-0001Ou-HU
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 16:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756656AbZLUP7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 10:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756622AbZLUP7M
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 10:59:12 -0500
Received: from peff.net ([208.65.91.99]:48329 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756124AbZLUP7K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 10:59:10 -0500
Received: (qmail 17301 invoked by uid 107); 21 Dec 2009 16:03:42 -0000
Received: from c-71-206-170-120.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.170.120)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 21 Dec 2009 11:03:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Dec 2009 10:59:02 -0500
Content-Disposition: inline
In-Reply-To: <vpqhbrkd3o6.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135558>

On Mon, Dec 21, 2009 at 11:25:45AM +0100, Matthieu Moy wrote:

> You may not care about consistancy between applications, but I do.
> Currently, to version-control my user's configuration, I have
> $HOME/etc containing my user's config files, and the actual config
> files are symlinks to it. If applications were agreeing on a directory
> where configuration files would be stored (is it is the case on
> systems like MS Windows, and I think Mac OS), I would just had done
> "cd this-config-directory; git init".

Are we even close to having this sort of universal support for
~/.config? I also keep my dot-files in a git repository. I don't have a
single one in ~/.config[1], but I do have ~/.profile, ~/.vimrc,
~/.netrc, ~/.gitconfig, and others[2]. Traditionally, the standard for
Unix has been for config files to be $HOME/.something. You can argue
that ~/.config is a better standard, but I don't think git is failing to
use a standard; it is simply following a different one.

[1] I'll grant that is probably because I am a curmudgeon, and spend 99%
    of my computing time in xterm+bash+vim.

[2] Don't even get me started on ~/.mozilla/firefox/$RAND_HEX.default/user.js.

> With the proposed $GIT_HOME, I have a way to specify _Git_'s path to
> config files. Another application may propose $WHATEVER_ELSE_HOME, and
> yet another would say $HOME_YET_ANOTHER_ONE, and so on. There's a
> proposal to have a single environment variable for all this, why
> reject it?

But we do have such a variable: $HOME. The concept of $GIT_HOME was
proposed to provide a way to divert _just_ git to a different config
directory, something that would not be any easier with $XDG_CONFIG_HOME.


Anyway, as far as the future of git goes, even if we did want to switch
to $XDG_CONFIG_HOME, we could not do so suddenly without breaking
everybody's current setup. Which would mean any implementation of it
would have to handle both the current and the new proposed locations.
You can obviously just read from both, but there are a lot of open
questions, like "which should take precedence?" and "what does git
config --global --edit do?". I am not opposed to hearing a clever
proposal that handles all such issues, but I am not going to think too
hard about it myself. :)

-Peff
