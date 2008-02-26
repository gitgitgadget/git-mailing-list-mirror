From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] help: respect aliases
Date: Tue, 26 Feb 2008 12:43:21 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802261222570.17164@racer.site>
References: <cover.1203890846.git.peff@peff.net>  <20080224221737.GD31309@coredump.intra.peff.net> <76718490802241810m5f473156nc350eea07016e8f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 13:44:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTzAt-0000Bs-QR
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 13:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758701AbYBZMnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 07:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbYBZMnv
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 07:43:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:43958 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758925AbYBZMnu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 07:43:50 -0500
Received: (qmail invoked by alias); 26 Feb 2008 12:43:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp014) with SMTP; 26 Feb 2008 13:43:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PFWoXM9IPAQgE/05TXTJrP6eqBvo35+aiimSfrM
	cIDaOudInhGc7N
X-X-Sender: gene099@racer.site
In-Reply-To: <76718490802241810m5f473156nc350eea07016e8f9@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75132>

Hi,

On Sun, 24 Feb 2008, Jay Soffian wrote:

> This too would be less ugly as a built-in:
> 
>     alias      = "! sh -c 'if test -z \"$1\"; then git config --list \
>                   | expand \
>                   | sed \"/^alias\\./!d; s/^alias\\.//; s/=/ /; s/  */ /g\" \
>                   | sort | while read n v; do \
>                   printf \"%-16s\" \"$n\"; echo \"$v\" | gnused \
>                   \"s/\\(.\\{68\\}\\) /\\1\\n\t\t/g\" | expand; \
>                   done; else git config \"alias.$1\"; fi' -"

Wow.  This would look less ugly as an alias like this, too:

alias = "!sh -c 'case $# in \
        0) git config --get-regexp \"^alias\\.\" | sed \"s/^alias\\.//\";; \
        *) git config \"alias.$0\" ;; \
        esac'"

which incidentally fixes a bug in your alias: you ignore $0 which is the 
first parameter when using the sh -c '' idiom.

Of course, you can change the sed call to your liking...

Ciao,
Dscho
