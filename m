From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: reword --author error message
Date: Thu, 15 Jan 2015 09:31:21 -0500
Message-ID: <20150115143120.GA16736@peff.net>
References: <54B7CCCD.1070708@drmicha.warpmail.net>
 <84cf10a22858275d6e213311c93df7f6a5408f60.1421331608.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Gunnar Wagner <gunnar.wagner@irisgermanica.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:31:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBlSL-0005SZ-0J
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 15:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbbAOObY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 09:31:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:34972 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751033AbbAOObY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 09:31:24 -0500
Received: (qmail 15091 invoked by uid 102); 15 Jan 2015 14:31:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 08:31:23 -0600
Received: (qmail 13809 invoked by uid 107); 15 Jan 2015 14:31:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 09:31:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 09:31:21 -0500
Content-Disposition: inline
In-Reply-To: <84cf10a22858275d6e213311c93df7f6a5408f60.1421331608.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262482>

On Thu, Jan 15, 2015 at 03:23:08PM +0100, Michael J Gruber wrote:

> If an --author argument is specified but does not contain a '>' then git tries
> to find the argument within the exiting authors; and gives the error
> message "No existing author found with '%s'" if there is no match.
> 
> This is confusing for users who try to specify a valid complete author
> name.
> 
> Rename the error message to make it clearer that the failure has two
> reasons in this case:
> "Bad --author parameter '%s': neither completely wellformed nor part of
> an existing one"

I really like the intent of this patch, but I actually find the new
message even more confusing.

Is this a time when we could use hint() to give a multi-line explanation
(and probably a matching advice.* config)? Like:

  hint: If the --author parameter contains angle brackets ("<>"), it
  hint: is treated as a literal name/email pair to use. If not, then
  hint: the history is searched for an existing matching author.

or something?

-Peff
