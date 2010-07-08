From: Jeff King <peff@peff.net>
Subject: Re: git rebase bug?
Date: Thu, 8 Jul 2010 07:37:31 -0400
Message-ID: <20100708113731.GC2294@sigill.intra.peff.net>
References: <20100707150545.GA24814@glandium.org>
 <20100707180004.GA3165@atjola.homenet>
 <20100707205126.GA11240@glandium.org>
 <m3bpajm0gw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Hommey <mh@glandium.org>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 13:37:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWpQA-0005O2-VB
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 13:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab0GHLhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 07:37:33 -0400
Received: from peff.net ([208.65.91.99]:39968 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631Ab0GHLhd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 07:37:33 -0400
Received: (qmail 2505 invoked by uid 107); 8 Jul 2010 11:38:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 08 Jul 2010 07:38:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Jul 2010 07:37:31 -0400
Content-Disposition: inline
In-Reply-To: <m3bpajm0gw.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150564>

On Wed, Jul 07, 2010 at 02:44:50PM -0700, Jakub Narebski wrote:

> > Oh, makes sense. Thanks. So that's a quite troubling corner case...
> > I wonder if empty files shouldn't be special cased...
> 
> Well, similarity score (of contents and of filename) is weighted by
> contents length, but perhaps empty files / zero length somehow fall
> out as an edge case...

Exact rename detection is handled before inexact detection, so the
contents length are irrelevant. So it is not about empty files, but
about exact matches. I'm not sure if the basename-matching code is used
for exact matches, though. But ideally we would break exact-match ties
based on filename. I'd have to read through the code and/or perform some
tests to be sure, though.

-Peff
