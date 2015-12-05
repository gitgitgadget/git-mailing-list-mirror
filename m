From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new
 repos
Date: Sat, 5 Dec 2015 02:44:44 -0500
Message-ID: <20151205074444.GD21639@sigill.intra.peff.net>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-14-git-send-email-dturner@twopensource.com>
 <CACsJy8DDKW4np7N+KA=dpz9uNke0+cyQD-J3U74VM=4WbsjrKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 08:45:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a57Wi-0005oI-CL
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 08:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbbLEHpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2015 02:45:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:37700 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752129AbbLEHo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2015 02:44:59 -0500
Received: (qmail 13011 invoked by uid 102); 5 Dec 2015 07:44:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Dec 2015 01:44:47 -0600
Received: (qmail 1186 invoked by uid 107); 5 Dec 2015 07:44:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Dec 2015 02:44:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Dec 2015 02:44:44 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8DDKW4np7N+KA=dpz9uNke0+cyQD-J3U74VM=4WbsjrKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282031>

On Sat, Dec 05, 2015 at 07:30:13AM +0100, Duy Nguyen wrote:

> On Thu, Dec 3, 2015 at 1:35 AM, David Turner <dturner@twopensource.com> wrote:
> > git init learns a new argument --refs-backend-type.  Presently, only
> > "files" is supported, but later we will add other backends.
> >
> > When this argument is used, the repository's core.refsBackendType
> > configuration value is set, and the refs backend's initdb function is
> > used to set up the ref database.
> 
> git-init can also be used on existing repos. What happens in that case
> if we use --refs-backend-type. Will existing  refs be migrated to the
> new backend or hidden away?

It would be neat if it migrated, but I suspect that may introduce
complications. It's probably OK in the initial implementation to bail if
the option is used in an existing repo.

I think the config option needs to be extensions.refsBackendType, too,
per the logic in 00a09d5 (introduce "extensions" form of
core.repositoryformatversion, 2015-06-23). And I guess it needs to bump
core.repositoryformatversion to "1".

-Peff
