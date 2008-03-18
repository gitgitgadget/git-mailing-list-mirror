From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/16] more tr portability test script fixes
Date: Tue, 18 Mar 2008 18:44:37 -0400
Message-ID: <20080318224436.GA6806@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net> <20080312213106.GD26286@coredump.intra.peff.net> <20080318222302.GA3450@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:49:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5Dd-000683-ID
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933551AbYCSUbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 16:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933559AbYCSUbX
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:31:23 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3821 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933551AbYCSUbW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:31:22 -0400
Received: (qmail 16808 invoked by uid 111); 18 Mar 2008 22:44:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 18 Mar 2008 18:44:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Mar 2008 18:44:37 -0400
Content-Disposition: inline
In-Reply-To: <20080318222302.GA3450@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77538>

On Tue, Mar 18, 2008 at 11:23:02PM +0100, Alex Riesen wrote:

> Jeff King, Wed, Mar 12, 2008 22:31:06 +0100:
> > -    tr '\000' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
> > -    tr '\000' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
> > +    perl -pe 'y/\000/\012/' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
> > +    perl -pe 'y/\000/\012/' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
> 
> These break in presence of ActiveState Perl on Windows.
> 
> I suggest replacing such simple construction with a simplified,
> in-tree, version of tr.

<sigh> It's sad that it must come to that, but your test-tr patches seem
like the only sane choice. They seem to work fine on my Solaris box.

Note that there are still a few uses of 'tr' in actual git scripts.
However, they are pretty tame, so I think they should work everywhere.
Otherwise, test-tr must become "git tr". :)

-Peff
