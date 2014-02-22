From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] make commit --verbose work with --no-status
Date: Sat, 22 Feb 2014 03:31:10 -0500
Message-ID: <20140222083110.GE1576@sigill.intra.peff.net>
References: <1393009762-31133-1-git-send-email-rctay89@gmail.com>
 <1393009762-31133-2-git-send-email-rctay89@gmail.com>
 <1393009762-31133-3-git-send-email-rctay89@gmail.com>
 <1393009762-31133-4-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 22 09:31:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH7zR-00045S-Ih
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 09:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbaBVIbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 03:31:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:54941 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750749AbaBVIbM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 03:31:12 -0500
Received: (qmail 16476 invoked by uid 102); 22 Feb 2014 08:31:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Feb 2014 02:31:13 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Feb 2014 03:31:10 -0500
Content-Disposition: inline
In-Reply-To: <1393009762-31133-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242507>

On Sat, Feb 22, 2014 at 03:09:22AM +0800, Tay Ray Chuan wrote:

> @@ -1141,7 +1146,12 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  	if (all && argc > 0)
>  		die(_("Paths with -a does not make sense."));
>  
> -	if (status_format != STATUS_FORMAT_DEFAULT)
> +	if (verbose && !include_status) {
> +		include_status = 1;
> +		status_format = STATUS_FORMAT_NONE;
> +	}
> +
> +	if (status_format != STATUS_FORMAT_DEFAULT && !verbose)
>  		dry_run = 1;

What happens here when there is an alternate status format _and_
--verbose is used? If I say "git commit --porcelain" it should imply
--dry-run. But "git commit --porcelain --verbose" no longer does so
after your patch.

-Peff
