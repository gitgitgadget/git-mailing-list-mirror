From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Mon, 25 Mar 2013 10:57:32 +0000
Message-ID: <20130325105731.GE2286@serenity.lan>
References: <cover.1363980749.git.john@keeping.me.uk>
 <cover.1364045138.git.john@keeping.me.uk>
 <e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
 <7vd2up4bo7.fsf@alter.siamese.dyndns.org>
 <20130324123620.GA2286@serenity.lan>
 <CAJDDKr7Uz44TQ8y2jpjhNadWUCD5Mo=GLdaLLh99eENARQSwcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 11:58:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK56U-0007PH-2D
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 11:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757323Ab3CYK5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 06:57:46 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:50159 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717Ab3CYK5p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 06:57:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id DEE00CDA594;
	Mon, 25 Mar 2013 10:57:44 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7kJZ4kkL7Eix; Mon, 25 Mar 2013 10:57:43 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 41C94CDA590;
	Mon, 25 Mar 2013 10:57:33 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr7Uz44TQ8y2jpjhNadWUCD5Mo=GLdaLLh99eENARQSwcw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219027>

On Sun, Mar 24, 2013 at 02:29:40PM -0700, David Aguilar wrote:
> This makes me wonder whether the modifiable mode should be made
> more explicit, either in the documentation or via a flag.
> 
> Imagine if --dir-diff also honored --edit and --no-edit flags.
> 
> Right now --edit is the default.  If we had foreseen these various
> edge cases and unintended copy-backs then we may have initially
> chosen --no-edit as the default, but that's not really my point.

I view --symlinks as the default, which avoids most of this pain ;-)
I guess we're talking about three different "working tree files" modes
here: symlink, copy-copyback and copy-readonly.

I wonder if anyone uses --no-symlinks when they are not forced to by
their operating system?  What is the use case if they do?

> What I'm thinking is that it might be good for the tool to
> learn --edit/--no-edit so that the symlink/copy-back heuristic
> can be documented alongside that option.  Users can then know
> what to expect when using this mode.  --no-edit would also be
> faster since it can avoid all these extra steps.
> 
> It could also learn "difftool.dirDiffEditable" to control the
> default, which would eliminate the pain in needing to supply
> the flag on every invocation.
> 
> What do you think about officially supporting a read-only mode?

How would that interoperate with symlink mode?  Should --no-edit imply
--no-symlinks or does the --[no-]edit option only have an effect if
--no-symlinks is in effect?

I don't think this is the first time this idea has been suggested, so
that's some indicator that it's a good idea.  I'm not sure about
--edit/--no-edit for this though.  The behaviour isn't really similar to
the way that option works with git-commit, git-merge, etc.  I don't have
a better suggestion at the moment though.


John
