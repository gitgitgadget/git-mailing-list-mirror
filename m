From: Jeff King <peff@peff.net>
Subject: Re: bash-completion now loads completions dynamically, so __git_ps1
 is not defined when you open a shell
Date: Thu, 29 Mar 2012 01:49:43 -0400
Message-ID: <20120329054942.GB27604@sigill.intra.peff.net>
References: <CANaWP3wu3260uFNzCLJ=YSG1BWFr=ge_6CmMGrG6zLThvFnjcQ@mail.gmail.com>
 <20120328230642.GA16925@burratino>
 <CANaWP3w9KDu57aHquRRYt8td_haSWTBKs7zUHy-xu0B61gmr9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, bash-completion-devel@lists.alioth.debian.org
To: Kerrick Staley <mail@kerrickstaley.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 07:49:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD8F5-0003ka-3q
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 07:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197Ab2C2Ftr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 01:49:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36788
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159Ab2C2Ftq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 01:49:46 -0400
Received: (qmail 27686 invoked by uid 107); 29 Mar 2012 05:49:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Mar 2012 01:49:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2012 01:49:43 -0400
Content-Disposition: inline
In-Reply-To: <CANaWP3w9KDu57aHquRRYt8td_haSWTBKs7zUHy-xu0B61gmr9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194230>

On Wed, Mar 28, 2012 at 07:00:35PM -0500, Kerrick Staley wrote:

> bash-completion 1.99 (still a "beta", but Arch Linux now ships it)
> will automatically source the git-completion.bash script when you type
> git <tab>. The script is no longer sourced when you first open a
> shell.
> 
> There are two main ways to fix this:
> 1) define __git_ps1 (and friends) in a different script, which will
> get installed in /etc/profile.d (this is the "proper way")
> 2) require that git-completion.bash always be loaded in the beginning
> instead of on-the-fly (which is how it works now now)

I would much rather see (1). There is a very good reason for
bash-completion doing dynamic loading, which is that loading all of the
completions made shell startup horribly slow. We should do our part to
help keep startup fast by splitting the dynamically-loadable bits from
the must-be-loaded-at-start bits.

-Peff
