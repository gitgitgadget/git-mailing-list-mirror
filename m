From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] git-imap-send: Allow the program to be run from
	subdirectories of a git tree.
Date: Tue, 8 Jul 2008 00:10:37 -0400
Message-ID: <20080708041037.GB7186@sigill.intra.peff.net>
References: <1096648c0807070105l49a6dc38ra1710b0aadb220d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Rob Shearman <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:11:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG4YK-0005i0-TX
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbYGHEKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 00:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbYGHEKs
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:10:48 -0400
Received: from peff.net ([208.65.91.99]:3883 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbYGHEKr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:10:47 -0400
Received: (qmail 27963 invoked by uid 111); 8 Jul 2008 04:10:46 -0000
Received: from c-75-75-1-159.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.1.159)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 08 Jul 2008 00:10:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jul 2008 00:10:37 -0400
Content-Disposition: inline
In-Reply-To: <1096648c0807070105l49a6dc38ra1710b0aadb220d9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87701>

On Mon, Jul 07, 2008 at 09:05:22AM +0100, Rob Shearman wrote:

> Call setup_git_directory_gently to allow git-imap-send to be used from
> subdirectories of a git tree.
> [...]
> +	setup_git_directory_gently( NULL );

I don't think this is right; now we _must_ be in a git tree to run the
command, which was not the case previously. You need to pass a non-NULL
parameter to setup_git_directory_gently, which is where it will store
the "are we in a git dir" return value (even if you don't want to look
at it, if the parameter is NULL, it will die("not a git repository")).

-Peff
