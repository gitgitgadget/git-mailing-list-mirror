From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 03/16] more tr portability test script fixes
Date: Wed, 19 Mar 2008 00:24:53 +0100
Message-ID: <20080318232453.GE3450@steel.home>
References: <cover.1205356737.git.peff@peff.net> <20080312213106.GD26286@coredump.intra.peff.net> <20080318222302.GA3450@steel.home> <20080318224436.GA6806@coredump.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:45:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4CT-0002JK-PK
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757830AbYCSTlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755301AbYCSTli
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:41:38 -0400
Received: from mo-p07-fb.rzone.de ([81.169.146.191]:48730 "EHLO
	mo-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757800AbYCSTle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:41:34 -0400
Received: from mo-p07-ob.rzone.de (klopstock-mo-p07-ob.mail [192.168.63.178])
	by charnel-fb-08.store (RZmta 16.11) with ESMTP id V04a17k2IHYXI8
	for <git@vger.kernel.org>; Wed, 19 Mar 2008 00:41:24 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTG+sg==
Received: from tigra.home (Fa830.f.strato-dslnet.de [195.4.168.48])
	by post.webmailer.de (klopstock mo11) (RZmta 16.13)
	with ESMTP id 002c32k2IL4mvp ; Wed, 19 Mar 2008 00:24:53 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 61753277BD;
	Wed, 19 Mar 2008 00:24:53 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 43BF556D28; Wed, 19 Mar 2008 00:24:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080318224436.GA6806@coredump.intra.peff.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77523>

Jeff King, Tue, Mar 18, 2008 23:44:37 +0100:
> On Tue, Mar 18, 2008 at 11:23:02PM +0100, Alex Riesen wrote:
> 
> > Jeff King, Wed, Mar 12, 2008 22:31:06 +0100:
> > > -    tr '\000' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
> > > -    tr '\000' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
> > > +    perl -pe 'y/\000/\012/' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
> > > +    perl -pe 'y/\000/\012/' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
> > 
> > These break in presence of ActiveState Perl on Windows.
> > 
> > I suggest replacing such simple construction with a simplified,
> > in-tree, version of tr.
> 
> <sigh> It's sad that it must come to that, but your test-tr patches seem
> like the only sane choice. They seem to work fine on my Solaris box.
> 
> Note that there are still a few uses of 'tr' in actual git scripts.
> However, they are pretty tame, so I think they should work everywhere.

Yes, I thought about them too and hope for the same (they'll do).

> Otherwise, test-tr must become "git tr". :)

We already use "git diff" and "git apply" as reliable "diff" and
"patch" :)
