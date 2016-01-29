From: Jeff King <peff@peff.net>
Subject: Re: fast-import fails in read-only tree
Date: Fri, 29 Jan 2016 01:08:02 -0500
Message-ID: <20160129060802.GA23106@sigill.intra.peff.net>
References: <jwvfuxhz72e.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stefan Monnier <monnier@iro.umontreal.ca>
X-From: git-owner@vger.kernel.org Fri Jan 29 07:08:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aP2Ei-0007PA-Ku
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 07:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbcA2GIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 01:08:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:34150 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751352AbcA2GIF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 01:08:05 -0500
Received: (qmail 27973 invoked by uid 102); 29 Jan 2016 06:08:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jan 2016 01:08:04 -0500
Received: (qmail 28003 invoked by uid 107); 29 Jan 2016 06:08:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jan 2016 01:08:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jan 2016 01:08:02 -0500
Content-Disposition: inline
In-Reply-To: <jwvfuxhz72e.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285061>

On Thu, Jan 28, 2016 at 05:17:36PM -0500, Stefan Monnier wrote:

> I recently discovered that "git fast-import" signals an error if used in
> a tree to which we do not have write-access, because it tries to create
> a "objects/pack/tmp_pack_XXX" file even before starting to process
> the commands.
> 
> Usually this is not a problem (we'll create new commits and such, so
> write-access is indeed necessary), but in my case I was using
> fast-import only for its "reading" operations (in order to combine
> several inter-dependent "cat-file" operations into a single git
> session).

The primary goal of fast-import is to write that packfile. It kind of
sounds like you are using the wrong tool for the job.

Can you elaborate on what you are sending to fast-import (preferably
with a concrete example)? There may be a way to accomplish the same
thing with read-only tools like cat-file.

-Peff
