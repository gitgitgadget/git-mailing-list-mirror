From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/7] commit: fix patch hunk editing with "commit -p -m"
Date: Mon, 10 Mar 2014 16:07:56 -0400
Message-ID: <20140310200756.GC24568@sigill.intra.peff.net>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
 <1394477377-10994-5-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jun Hao <jhao12@bloomberg.net>, git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 21:08:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN6UV-0001bB-A1
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 21:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbaCJUH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 16:07:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:36742 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753695AbaCJUH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 16:07:58 -0400
Received: (qmail 18978 invoked by uid 102); 10 Mar 2014 20:07:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Mar 2014 15:07:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Mar 2014 16:07:56 -0400
Content-Disposition: inline
In-Reply-To: <1394477377-10994-5-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243806>

On Mon, Mar 10, 2014 at 07:49:34PM +0100, Benoit Pierre wrote:

> Don't change git environment: move the GIT_EDITOR=":" override to the
> hook command subprocess, like it's already done for GIT_INDEX_FILE.
> 
> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
> ---
>  builtin/checkout.c                |  8 +++----
>  builtin/clone.c                   |  4 ++--
>  builtin/commit.c                  | 35 ++++++++++++++++++++++++-------
>  builtin/gc.c                      |  2 +-
>  builtin/merge.c                   |  6 +++---
>  commit.h                          |  3 +++
>  run-command.c                     | 44 ++++++++++++++++++++++++++++-----------
>  run-command.h                     |  6 +++++-
>  t/t7513-commit_-p_-m_hunk_edit.sh |  2 +-
>  9 files changed, 79 insertions(+), 31 deletions(-)

This is a lot of change, and in some ways I think it is making things
better overall. However, the simplest fix for this is basically to move
the setting of GIT_EDITOR down to after we prepare the index.

Jun Hao (cc'd) has been preparing a series for this based on the
Bloomberg git hackday a few weeks ago, but it hasn't been sent to the
list yet.

Commits are here:

  https://github.com/bloomberg/git/compare/commit-patch-allow-hunk-editing

if you care to look. I'm not sure which solution is technically
superior, but it's worth considering both.

I regret not encouraging Jun to post to the list sooner, as we might
have avoided some duplicated effort. But that's a sunk cost, and we
should pick up whichever is the best for the project.

-Peff
