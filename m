From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] replace: parse revision argument for -d
Date: Mon, 29 Oct 2012 02:58:36 -0400
Message-ID: <20121029065836.GC5102@sigill.intra.peff.net>
References: <807340e40adb1fc97cd97161fe1fabd292bc79c3.1351258394.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 07:58:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSjJH-0002G7-Mo
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 07:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756Ab2J2G6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 02:58:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41845 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab2J2G6j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 02:58:39 -0400
Received: (qmail 16030 invoked by uid 107); 29 Oct 2012 06:59:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 02:59:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 02:58:36 -0400
Content-Disposition: inline
In-Reply-To: <807340e40adb1fc97cd97161fe1fabd292bc79c3.1351258394.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208594>

On Fri, Oct 26, 2012 at 03:33:27PM +0200, Michael J Gruber wrote:

>  	for (p = argv; *p; p++) {
> -		if (snprintf(ref, sizeof(ref), "refs/replace/%s", *p)
> +		q = *p;
> +		if (get_sha1(q, sha1))
> +			warning("Failed to resolve '%s' as a valid ref; taking it literally.", q);
> +		else
> +			q = sha1_to_hex(sha1);

Doesn't get_sha1 already handle this for 40-byte sha1s (and for anything
else, it would not work anyway)?

-Peff
