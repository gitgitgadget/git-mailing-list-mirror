From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rev-parse: include HEAD in --all output
Date: Sun, 31 Aug 2014 11:30:54 -0400
Message-ID: <20140831153054.GD17449@peff.net>
References: <CAF7_NFRz6Zc-wTDSFdkW4N2wRATZ8-g05j6sFu1t7DB0X72dkg@mail.gmail.com>
 <1409437488-25233-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sun Aug 31 17:31:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XO75o-0000CU-22
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 17:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbaHaPa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 11:30:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:41903 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751234AbaHaPa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 11:30:56 -0400
Received: (qmail 16339 invoked by uid 102); 31 Aug 2014 15:30:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 31 Aug 2014 10:30:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Aug 2014 11:30:54 -0400
Content-Disposition: inline
In-Reply-To: <1409437488-25233-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256291>

On Sun, Aug 31, 2014 at 01:24:48AM +0300, Max Kirillov wrote:

> for_each_ref() does not include it itself, and without the hash
> the detached HEAD may be missed by some frontends (like gitk).
> 
> Add test which verifies the head is returned
> 
> Update test t6018-rev-list-glob.sh which relied on exact list of
> returned hashes.

I think the missing bit of the justification here is that "--all" _does_
include HEAD in other contexts (like in git-log), and rev-parse should
probably match it.

This is probably the right thing to do. It's possible that some caller
of rev-parse really depends on "--all" meaning "just the refs", but I
kind of doubt it. Being in sync with the revision.c parser seems saner.

-Peff
