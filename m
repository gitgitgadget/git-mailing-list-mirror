From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] repack.c: rename and unlink pack file if it exists
Date: Tue, 4 Feb 2014 20:16:32 -0500
Message-ID: <20140205011632.GA3923@sigill.intra.peff.net>
References: <xmqqwqha5twg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 02:17:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAr6s-0000cE-8Y
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 02:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbaBEBQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 20:16:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:44734 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751732AbaBEBQf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 20:16:35 -0500
Received: (qmail 26126 invoked by uid 102); 5 Feb 2014 01:16:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Feb 2014 19:16:34 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Feb 2014 20:16:32 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwqha5twg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241589>

On Tue, Feb 04, 2014 at 03:40:15PM -0800, Junio C Hamano wrote:

>  * Somehow this came to my private mailbox without Cc to list, so I
>    am forwarding it.
> 
>    I think with 1190a1ac (pack-objects: name pack files after
>    trailer hash, 2013-12-05), repacking the same set of objects may
>    have less chance of producing colliding names, especially if you
>    are on a box with more than one core, but it still would be a
>    good idea to get this part right in the upcoming release.

Actually, since 1190a1ac, if you have repacked and gotten the same pack
name, then you do not have to do any rename dance at all; you can throw
away what you just generated because you know that it is byte-for-byte
identical.

You could collide with a pack created by an older version of git that
used the original scheme, but that is quite unlikely (on the order of
2^-160).

-Peff
