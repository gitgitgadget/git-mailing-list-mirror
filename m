From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/3] gpg: Close stderr once finished with it in
 verify_signed_buffer()
Date: Thu, 31 Jan 2013 17:37:10 -0500
Message-ID: <20130131223710.GD21729@sigill.intra.peff.net>
References: <20130131055053.GA11912@sigill.intra.peff.net>
 <1359656320-4434-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 23:37:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U12lF-0007Bd-5k
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 23:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756940Ab3AaWhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 17:37:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54985 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755169Ab3AaWhN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 17:37:13 -0500
Received: (qmail 15642 invoked by uid 107); 31 Jan 2013 22:38:37 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Jan 2013 17:38:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2013 17:37:10 -0500
Content-Disposition: inline
In-Reply-To: <1359656320-4434-1-git-send-email-sboyd@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215181>

On Thu, Jan 31, 2013 at 10:18:40AM -0800, Stephen Boyd wrote:

> Failing to close the stderr pipe in verify_signed_buffer() causes
> git to run out of file descriptors if there are many calls to
> verify_signed_buffer(). An easy way to trigger this is to run
> 
>  git log --show-signature --merges | grep "key"
> 
> on the linux kernel git repo. Eventually it will fail with
> 
>  error: cannot create pipe for gpg: Too many open files
>  error: could not run gpg.
> 
> Close the stderr pipe so that this can't happen.
> 
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks, looks good to me (obviously :) ). The rest of the series looks
fine, too, with the caveat I mentioned on 2/3. Thanks for fixing this.

-Peff
