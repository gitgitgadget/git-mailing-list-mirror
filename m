From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Sat, 29 Mar 2008 05:52:38 -0400
Message-ID: <20080329095238.GB21814@coredump.intra.peff.net>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803290944.55273.robin.rosenberg.lists@dewire.com> <20080329085304.GC19200@coredump.intra.peff.net> <200803291038.48847.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 10:53:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfXkn-000408-6y
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 10:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbYC2Jwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 05:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYC2Jwn
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 05:52:43 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4618 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354AbYC2Jwm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 05:52:42 -0400
Received: (qmail 23729 invoked by uid 111); 29 Mar 2008 09:52:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 29 Mar 2008 05:52:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Mar 2008 05:52:38 -0400
Content-Disposition: inline
In-Reply-To: <200803291038.48847.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78463>

On Sat, Mar 29, 2008 at 10:38:48AM +0100, Robin Rosenberg wrote:

> The environment variables are only part of the story. There is a langinfo API 
> for this. See I18N::Langinfo(3pm) that knows about those and something else.
> 
> # perl -e 'require I18N::Langinfo; I18N::Langinfo->import(qw(langinfo 
> CODESET)); $codeset = langinfo(CODESET()); print "My codeset=".
> $codeset."\n";'
> My codeset=ISO-8859-15

Hmm, neat. So perhaps it would make sense to just use this value instead
of utf-8, and not worry about examining the actual text (since any such
examination is at best a guess, anyway)?

Any idea what version of perl started shipping I18N::Langinfo? I
couldn't see anything useful from grepping the Changes files.

-Peff

PS Your 'require' is more simply written as 'use I18N::Langinfo
qw(langinfo CODESET)', or perhaps even simpler:

  perl -MI18N::Langinfo=langinfo,CODESET ...
