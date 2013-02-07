From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/4] show: obey --textconv for blobs
Date: Thu, 7 Feb 2013 04:43:14 -0500
Message-ID: <20130207094314.GC16832@sigio.peff.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
 <883f0163cb732932061a368ea9bc187c13e4ecca.1360162813.git.git@drmicha.warpmail.net>
 <20130206220644.GB27507@sigill.intra.peff.net>
 <51136E56.7060703@drmicha.warpmail.net>
 <20130207091116.GB15727@sigill.intra.peff.net>
 <51137522.3010005@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:42:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Nzg-00087L-FI
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 10:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757566Ab3BGJlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 04:41:51 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38529 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757329Ab3BGJlt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 04:41:49 -0500
Received: (qmail 16983 invoked by uid 1000); 7 Feb 2013 09:43:14 -0000
Content-Disposition: inline
In-Reply-To: <51137522.3010005@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215686>

On Thu, Feb 07, 2013 at 10:34:26AM +0100, Michael J Gruber wrote:

> > Just as we record the path from the surrounding tree, we record the
> > mode. It's that mode which gets put into the pending object list by the
> > revision parser (see the very end of handle_revision_arg). Storing an
> > object_context instead of the mode would be a strict superset of what we
> > store now (right now we just throw the rest away).
> 
> Sure. But why does object_context have a mode member at all? Maybe it is
> not alway used together with another struct which has the mode already,
> then that's a reason.

Exactly. It's purely for pulling information out of
get_sha1_with_context, and does not know that you are going to put its
output into an object_array_entry (and many call sites do not).

-Peff
