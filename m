From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/16] more tr portability test script fixes
Date: Thu, 13 Mar 2008 09:09:18 -0400
Message-ID: <20080313130918.GI19485@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net> <20080312213106.GD26286@coredump.intra.peff.net> <20080313082807.GT10103@mail-vs.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 14:10:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZnC4-0004ve-00
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 14:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbYCMNJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 09:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbYCMNJU
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 09:09:20 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1858 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbYCMNJU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 09:09:20 -0400
Received: (qmail 30846 invoked by uid 111); 13 Mar 2008 13:09:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 09:09:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 09:09:18 -0400
Content-Disposition: inline
In-Reply-To: <20080313082807.GT10103@mail-vs.djpig.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77077>

On Thu, Mar 13, 2008 at 09:28:07AM +0100, Frank Lichtenheld wrote:

> > -    tr '\000' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
> > -    tr '\000' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
> > +    perl -pe 'y/\000/\012/' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
> > +    perl -pe 'y/\000/\012/' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
> 
> It might make sense performance-wise to integrate the job of the sed
> call into the perl call here. Haven't tested it, though.

Probably. My changes were pretty mechanical, and I tried to keep them as
small as possible.

I'm not sure we care too much about an extra fork in a test script for
performance, though it would probably end up more readable.

-Peff
