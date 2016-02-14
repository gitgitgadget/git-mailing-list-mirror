From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] config: add 'type' to config_source struct that
 identifies config type
Date: Sun, 14 Feb 2016 11:07:34 -0500
Message-ID: <20160214160734.GB5875@sigill.intra.peff.net>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
 <1455373456-64691-3-git-send-email-larsxschneider@gmail.com>
 <20160213172435.GG30144@sigill.intra.peff.net>
 <394CD8BC-49CF-4D07-A9C2-CC8C60373A2B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:07:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUzD2-0006fH-Li
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 17:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbcBNQHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 11:07:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:41826 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751468AbcBNQHg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 11:07:36 -0500
Received: (qmail 13023 invoked by uid 102); 14 Feb 2016 16:07:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Feb 2016 11:07:36 -0500
Received: (qmail 1327 invoked by uid 107); 14 Feb 2016 16:07:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Feb 2016 11:07:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Feb 2016 11:07:34 -0500
Content-Disposition: inline
In-Reply-To: <394CD8BC-49CF-4D07-A9C2-CC8C60373A2B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286155>

On Sun, Feb 14, 2016 at 01:24:55PM +0100, Lars Schneider wrote:

> > Should git_config_from_buf() take a "type" parameter, and
> > git_config_from_blob_sha1() pass in "blob"?
> Haha, fun fact: this was how I implemented it initially. Because of that
> I noticed that "submodule-config.c" also uses "git_config_from_buf" :-)
> 
> However, then I thought the list wouldn't like it if I change the
> interfaces. I will add the type parameter, again.

Changing internal interfaces is preferable to carrying a sub-optimal
interface forever, I think.

The thing we really have to watch out for is changing the assumptions or
output of a function without changing its signature. The interface
change breaks loudly on a merge, and is easy to fix. Changing the
internals creates quiet and subtle bugs.

-Peff
