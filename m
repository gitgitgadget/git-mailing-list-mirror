From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] Git.pm: Allow pipes to be closed prior to calling
 command_close_bidi_pipe
Date: Wed, 6 Feb 2013 18:04:06 -0500
Message-ID: <20130206230406.GK27507@sigill.intra.peff.net>
References: <cover.1360183427.git.mina86@mina86.com>
 <c0966644278b0addbef6a03289ef9c553addf573.1360183427.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ted Zlatanov <tzz@lifelogs.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 00:04:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3E2b-0002VW-H3
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 00:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593Ab3BFXEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 18:04:11 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37219 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755931Ab3BFXEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 18:04:09 -0500
Received: (qmail 11820 invoked by uid 107); 6 Feb 2013 23:05:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 18:05:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 18:04:06 -0500
Content-Disposition: inline
In-Reply-To: <c0966644278b0addbef6a03289ef9c553addf573.1360183427.git.mina86@mina86.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215660>

On Wed, Feb 06, 2013 at 09:47:04PM +0100, Michal Nazarewicz wrote:

> From: Michal Nazarewicz <mina86@mina86.com>
> 
> The command_close_bidi_pipe() function will insist on closing both
> input and output pipes returned by command_bidi_pipe().  With this
> change it is possible to close one of the pipes in advance and
> pass undef as an argument.
> 
> This allows for something like:
> 
>   my ($pid, $in, $out, $ctx) = command_bidi_pipe(...);
>   print $out "write data";
>   close $out;
>   # ... do stuff with $in
>   command_close_bidi_pipe($pid, $in, undef, $ctx);

Should this part go into the documentation for command_close_bidi_pipe
in Git.pm?

-Peff
