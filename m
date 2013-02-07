From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/4] show: obey --textconv for blobs
Date: Thu, 7 Feb 2013 04:11:16 -0500
Message-ID: <20130207091116.GB15727@sigill.intra.peff.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
 <883f0163cb732932061a368ea9bc187c13e4ecca.1360162813.git.git@drmicha.warpmail.net>
 <20130206220644.GB27507@sigill.intra.peff.net>
 <51136E56.7060703@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3NWG-0005zj-M2
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 10:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab3BGJLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 04:11:25 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38489 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528Ab3BGJLU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 04:11:20 -0500
Received: (qmail 16603 invoked by uid 107); 7 Feb 2013 09:12:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Feb 2013 04:12:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2013 04:11:16 -0500
Content-Disposition: inline
In-Reply-To: <51136E56.7060703@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215682>

On Thu, Feb 07, 2013 at 10:05:26AM +0100, Michael J Gruber wrote:

> > Would it be better if object_array_entry replaced its "mode" member with
> > an object_context?
> 
> Do all callers/users want to deal with object_context?

Wouldn't it just mean replacing "entry->mode" with "entry->oc.mode" at
each user?

> I'm wondering why o_c has a mode at all, since it is mostly used in
> conjunction with an object, isn't it?

Just as we record the path from the surrounding tree, we record the
mode. It's that mode which gets put into the pending object list by the
revision parser (see the very end of handle_revision_arg). Storing an
object_context instead of the mode would be a strict superset of what we
store now (right now we just throw the rest away).

-Peff
