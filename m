From: Jeff King <peff@peff.net>
Subject: Re: bug in os x - deleted file on clone
Date: Thu, 3 Jul 2014 12:42:51 -0400
Message-ID: <20140703164250.GA20571@sigill.intra.peff.net>
References: <CAG+Rngi4q_Se0dGUKLuSEmub=srrhtDNfEh5n977DL+XZxJjsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Salib <dsalib@fibrenoire.ca>
X-From: git-owner@vger.kernel.org Thu Jul 03 18:43:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2k66-0007IT-S1
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 18:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708AbaGCQmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 12:42:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:55574 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752890AbaGCQmy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 12:42:54 -0400
Received: (qmail 29562 invoked by uid 102); 3 Jul 2014 16:42:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Jul 2014 11:42:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jul 2014 12:42:51 -0400
Content-Disposition: inline
In-Reply-To: <CAG+Rngi4q_Se0dGUKLuSEmub=srrhtDNfEh5n977DL+XZxJjsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252868>

On Thu, Jul 03, 2014 at 11:53:28AM -0400, David Salib wrote:

> When I clone a repository using git on osx this happens :
> [...]
> deleted:    modules/areversat-nidautoprov/files/dhcp/staticDHCPd/staticDHCPd
> [...]
> This does not happen under linux so the repository isn't the issue.

Does the repository have similar paths distinguished only by case? Try
looking at the output of:

  git ls-tree HEAD

If your file system is case-insensitive, then it might not be possible
to represent the repository contents on disk (git has some workarounds
to handle case-insensitivty, but fundamentally such filesystems cannot
represent "FOO" and "foo" with different contents, and you are best off
not trying to store that in your repository).

-Peff
