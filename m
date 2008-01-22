From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email, fix breakage in combination with --compose
Date: Mon, 21 Jan 2008 22:19:32 -0500
Message-ID: <20080122031932.GA24758@coredump.intra.peff.net>
References: <m2y7aj9glo.fsf@userprimary.net> <1200945466-21154-1-git-send-email-hendeby@isy.liu.se> <1200945466-21154-2-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Falcon <seth@userprimary.net>, gitster@pobox.com,
	git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Tue Jan 22 04:20:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH9gN-0004SN-Bi
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 04:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763374AbYAVDTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 22:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762186AbYAVDTg
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 22:19:36 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1301 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763248AbYAVDTf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 22:19:35 -0500
Received: (qmail 30471 invoked by uid 111); 22 Jan 2008 03:19:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 21 Jan 2008 22:19:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jan 2008 22:19:32 -0500
Content-Disposition: inline
In-Reply-To: <1200945466-21154-2-git-send-email-hendeby@isy.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71407>

On Mon, Jan 21, 2008 at 08:57:46PM +0100, Gustaf Hendeby wrote:

> This fixes the subtile bug in git send-email that was introduced into
> git send-email with
> 
> commit aa54892f5ada8282643dc7387b33261c7135d784
> send-email: detect invocation errors earlier

Sorry, this was my fault. I have looked over the code again to make sure
there are not any other places where the movement of @files should
matter, but this seems to be the only one.

As penance, I'll send some tests in a moment.

> -	@files = ($compose_filename . ".final");
> +	@files = ($compose_filename . ".final", @files);

I think this might be more readable as

  unshift @files, "$compose_filename.final";

but either way it fixes the bug, so

Acked-by: Jeff King <peff@peff.net>

-Peff
