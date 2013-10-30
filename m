From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 20/19] count-objects: consider .bitmap without .pack/.idx
 pair garbage
Date: Wed, 30 Oct 2013 02:59:22 -0400
Message-ID: <20131030065922.GC11317@sigill.intra.peff.net>
References: <20131025060442.GQ23098@sigill.intra.peff.net>
 <1382782796-5495-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, vicent@github.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 07:59:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbPkW-0007BX-TF
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 07:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950Ab3J3G7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 02:59:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:58229 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752827Ab3J3G7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 02:59:24 -0400
Received: (qmail 14370 invoked by uid 102); 30 Oct 2013 06:59:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 01:59:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 02:59:22 -0400
Content-Disposition: inline
In-Reply-To: <1382782796-5495-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236989>

On Sat, Oct 26, 2013 at 05:19:56PM +0700, Nguyen Thai Ngoc Duy wrote:

>  Maybe squash this in some place, or leave it separate. I'm fine either way.

Thanks, this makes sense.  I've left it as a separate commit.

Your subject did not quite make sense to me, as the effect is to _not_
report .bitmap files as garbage. I updated the commit message to this:

    count-objects: recognize .bitmap in garbage-checking
    
    Count-objects will report any "garbage" files in the packs
    directory, including files whose extensions it does not
    know (case 1), and files whose matching ".pack" file is
    missing (case 2).  Without having learned about ".bitmap"
    files, the current code reports all such files as garbage
    (case 1), even if their pack exists. Instead, they should be
    treated as case 2.

-Peff
