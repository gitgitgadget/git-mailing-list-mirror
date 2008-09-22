From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH]  Test and fix handling of quotes in ~/.ssh/config
Date: Mon, 22 Sep 2008 14:07:34 -0700
Message-ID: <20080922210734.GE3669@spearce.org>
References: <12219428213749-git-send-email-ggoudsmit@shebang.nl> <bd6139dc0809201819o5d6eb5b1r7bf0e46702c711d7@mail.gmail.com> <20080921112519.GA24200@diku.dk> <200809222242.29165.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonas Fonseca <fonseca@diku.dk>, sverre@rabbelier.nl,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 23:08:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhseG-0006j7-4b
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 23:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbYIVVHg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Sep 2008 17:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbYIVVHg
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 17:07:36 -0400
Received: from george.spearce.org ([209.20.77.23]:33697 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbYIVVHf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 17:07:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DECFC3835F; Mon, 22 Sep 2008 21:07:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809222242.29165.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96512>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> s=C3=B6ndagen den 21 september 2008 13.25.19 skrev Jonas Fonseca:
> > +		assertEquals("bad.tld\"", osc.lookup("bad").getHostName());
> This one is really (as you noted) bad so we shouldn't allow it at all=
=2E A new=20
> subclass of TransportExcpeption should be thrown to indicate a seriou=
s
> configuration problem when attempting to use the option.

Probably so.

But then we need to mark that the Host is invalid, because we
are serving requests from a cache, not from the file itself.
And TransportException isn't something that the SshSessionFactory
knows about.  Probably better to use a a subclass of IOException.

--=20
Shawn.
