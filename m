From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] dir.c::match_basename(): pay attention to the length
 of string parameters
Date: Thu, 28 Mar 2013 18:49:28 -0400
Message-ID: <20130328224928.GA20242@sigill.intra.peff.net>
References: <20130328214358.GA10685@sigill.intra.peff.net>
 <20130328214728.GB10936@sigill.intra.peff.net>
 <20130328224027.GA9911@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 23:50:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULLe7-0005B4-Pc
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 23:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786Ab3C1Wtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 18:49:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44138 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563Ab3C1Wte (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 18:49:34 -0400
Received: (qmail 31423 invoked by uid 107); 28 Mar 2013 22:51:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 18:51:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 18:49:28 -0400
Content-Disposition: inline
In-Reply-To: <20130328224027.GA9911@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219476>

On Thu, Mar 28, 2013 at 06:40:27PM -0400, Jeff King wrote:

> On Thu, Mar 28, 2013 at 05:47:28PM -0400, Jeff King wrote:
> 
> > From: Junio C Hamano <gitster@pobox.com>
> > 
> > The function takes two counted strings (<basename, basenamelen> and
> > <pattern, patternlen>) as parameters, together with prefix (the
> > length of the prefix in pattern that is to be matched literally
> > without globbing against the basename) and EXC_* flags that tells it
> > how to match the pattern against the basename.
> > 
> > However, it did not pay attention to the length of these counted
> > strings.  Update them to do the following:
> > 
> >  * When the entire pattern is to be matched literally, the pattern
> >    matches the basename only when the lengths of them are the same,
> >    and they match up to that length.
> 
> Hrm. Though the tip of this series passes all tests, this one actually
> breaks bisectability. What happens is that the existing code passes:

Ugh. That is a problem, but this series does _not_ pass all tests. I
think I failed to run the complete test suite on the correct tip.

My match_pathspec fix breaks at least t1011.

-Peff
