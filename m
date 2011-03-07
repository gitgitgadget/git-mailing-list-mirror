From: Jeff King <peff@peff.net>
Subject: Re: how can we git out source code base on git log?
Date: Mon, 7 Mar 2011 13:32:10 -0500
Message-ID: <20110307183210.GB20411@sigill.intra.peff.net>
References: <AANLkTimAPBoHJX0iZOt949xQ8HeGPXRyKfD4CDNJFv7u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: loody <miloody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 19:32:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwfEE-0005NO-95
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 19:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037Ab1CGScR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 13:32:17 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37126 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447Ab1CGScQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 13:32:16 -0500
Received: (qmail 6611 invoked by uid 111); 7 Mar 2011 18:32:14 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Mar 2011 18:32:14 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2011 13:32:10 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimAPBoHJX0iZOt949xQ8HeGPXRyKfD4CDNJFv7u@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168600>

On Tue, Mar 08, 2011 at 01:25:53AM +0800, loody wrote:

> Below I use uboot for example:
> 
> commit 3831530dcb7b71329c272ccd6181f8038b6a6dd0
> Author: Mikhail Zolotaryov <lebon@lebon.org.ua>
> Date:   Wed Sep 8 17:06:03 2010 +0300
>
> [...]
>
> Is it possible I can check out the commit as
> 3831530dcb7b71329c272ccd6181f8038b6a6dd0,?

Yes, just do "git checkout 3831530d" (you don't need to use the whole
id; any prefix that is unique within the repository is enough).

> Meanwhile, is there any command can help me to get the history that
> combine tag and commit such that I can know know the closest tag of
> some specific commit?
> 
> take below for example, I will know ccdd is the closest tag of commit
> b75a2dde47cc0ffb686e21cbf1aea4a45e23df10.

Yes:

  $ git describe b75a2dde
  v2010.09-250-gb75a2dd

This means that the commit is 250 commits past v2010.09. If you want to
know which tags already have the commit, try:

  $ git describe --contains b75a2dde
  v2010.12-rc1~126

which means it is inside v2010.12-rc1, and it is 126 commits back
(following each commit's first parent).

You may also want to know all tags that contain it:

  $ git tag --contains b75a2dde
  v2010.12
  v2010.12-rc1
  v2010.12-rc2
  v2010.12-rc3
  v2011.03-rc1

See "git help describe" for more information.

-Peff
