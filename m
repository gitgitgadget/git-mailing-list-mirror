From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] cat-file: Fix an gcc -Wuninitialized warning
Date: Tue, 26 Mar 2013 15:38:05 -0400
Message-ID: <20130326193805.GA28880@sigill.intra.peff.net>
References: <5151F4EB.80909@ramsay1.demon.co.uk>
 <20130326193539.GB28244@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Mar 26 20:38:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKZhg-0005Lw-70
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 20:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760201Ab3CZTiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 15:38:10 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40593 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759905Ab3CZTiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 15:38:09 -0400
Received: (qmail 6902 invoked by uid 107); 26 Mar 2013 19:39:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 15:39:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 15:38:05 -0400
Content-Disposition: inline
In-Reply-To: <20130326193539.GB28244@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219194>

On Tue, Mar 26, 2013 at 03:35:39PM -0400, Jeff King wrote:

> I note that we do not actually check that contents != NULL after calling
> read_sha1_file, either (nor that sha1_object_info does not return an
> error). I suspect cat-file could segfault under the right conditions.

Oh nevermind, we do. We just do it by checking that "type" was filled in
correctly, which can combine the check for both read_sha1_file and
sha1_object_info. Sorry for the noise.

-Peff
