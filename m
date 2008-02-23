From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 17:44:05 -0500
Message-ID: <20080223224405.GB13683@coredump.intra.peff.net>
References: <20080220235944.GA6278@coredump.intra.peff.net> <20080221000044.GB6429@coredump.intra.peff.net> <200802232113.40100.johannes.sixt@telecom.at> <20080223204005.GA12502@coredump.intra.peff.net> <7v1w732y97.fsf@gitster.siamese.dyndns.org> <20080223211219.GA13178@coredump.intra.peff.net> <20080223222837.GA13628@coredump.intra.peff.net> <7v4pbz1etm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 23:44:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT36z-0000rj-Eb
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 23:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbYBWWoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 17:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754139AbYBWWoI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 17:44:08 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3440 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754102AbYBWWoH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 17:44:07 -0500
Received: (qmail 11612 invoked by uid 111); 23 Feb 2008 22:44:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 23 Feb 2008 17:44:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Feb 2008 17:44:05 -0500
Content-Disposition: inline
In-Reply-To: <7v4pbz1etm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74870>

On Sat, Feb 23, 2008 at 02:35:33PM -0800, Junio C Hamano wrote:

> > Hmm. Actually, we just set SHELL_PATH to SHELL in the Makefile. So I
> > really don't see the point of SHELL_PATH at all, unless there are some
> > setups where it is already set outside of git.
> 
> Well, on one of my machines, I seem to be getting SHELL=bash
> (not /bin/bash).

My point is that nothing ever turns that into /bin/bash, unless there is
something totally outside of git setting up SHELL_PATH (which is not set
up on any of my systems). I would think to handle the case you're
talking about, you would want to change

  SHELL_PATH ?= $(SHELL)

to something like

  SHELL_PATH ?= $(shell which $(SHELL))

> Honestly, I do not think it matters getting the value from
> Makefile for this particular case, but I'd rather get people
> into habits to run "make tXXXX-name", not "sh ./tXXXX-name.sh",
> unless they know what they are doing.

Why?

-Peff
