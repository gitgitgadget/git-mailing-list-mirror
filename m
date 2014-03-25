From: Jeff King <peff@peff.net>
Subject: Re: Git push race condition?
Date: Tue, 25 Mar 2014 10:57:00 -0400
Message-ID: <20140325145700.GA10132@sigill.intra.peff.net>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
 <20140324225434.GB17080@sigill.intra.peff.net>
 <557DE2F7-1024-42A5-8192-ACE910CE6C81@codeaurora.org>
 <CAAyEjTPtaKExJJSc3yrxVNzx0DmOyeUFH-Uxz3dn0iezqc5VKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nasser Grainawi <nasser@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Scott Sandler <scott.m.sandler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 15:57:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSSmr-0003Uh-77
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 15:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbaCYO5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 10:57:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:46810 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751787AbaCYO5D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 10:57:03 -0400
Received: (qmail 28370 invoked by uid 102); 25 Mar 2014 14:57:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 25 Mar 2014 09:57:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Mar 2014 10:57:00 -0400
Content-Disposition: inline
In-Reply-To: <CAAyEjTPtaKExJJSc3yrxVNzx0DmOyeUFH-Uxz3dn0iezqc5VKA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245041>

On Tue, Mar 25, 2014 at 09:45:20AM -0400, Scott Sandler wrote:

> Version of git on the server? git version 1.8.3-rc0

There was significant work done between v1.8.3 and v1.8.4 on handling
races in the ref code. As I said before, I don't think the symptoms you
are describing are anything we have seen, or that could be triggered by
the races we found (which were mostly to do with ref enumeration, not
ref writing). But I would suggest upgrading to a newer version of git as
a precaution.

You mentioned elsewhere turning on the reflog, which I think is a good
idea. If there is a race of this sort, you will see a "hole" in the
reflog, where a ref goes from A->B, then again from A->B' (whereas with
normal writes, it would be B->B').

-Peff
