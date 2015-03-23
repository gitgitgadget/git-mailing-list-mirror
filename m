From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/7] introduce capture_command to avoid deadlocks
Date: Sun, 22 Mar 2015 23:53:02 -0400
Message-ID: <20150323035302.GA30279@peff.net>
References: <20150322095924.GA24651@peff.net>
 <20150322100724.GC11615@peff.net>
 <CAPig+cR5Ur4xOKZ6K=bOwOVM8bHHjJJXHxzCbvYBhqOTtD6dXg@mail.gmail.com>
 <xmqqwq28bq3e.fsf@gitster.dls.corp.google.com>
 <xmqqiodsbnyi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 04:53:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZtQO-0004NV-Gn
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 04:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbbCWDxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 23:53:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:36996 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751985AbbCWDxG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 23:53:06 -0400
Received: (qmail 14506 invoked by uid 102); 23 Mar 2015 03:53:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 22:53:05 -0500
Received: (qmail 12158 invoked by uid 107); 23 Mar 2015 03:53:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 23:53:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 23:53:02 -0400
Content-Disposition: inline
In-Reply-To: <xmqqiodsbnyi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266115>

On Sun, Mar 22, 2015 at 04:40:37PM -0700, Junio C Hamano wrote:

> Now I read the callers, it does look like this new function better
> fits in the run-command suite, essentially allowing us to do what we
> would do with $(cmd) or `cmd` in shell and Perl scripts, even though
> I do not particularly agree with the phrase "layering violation" to
> call its current placement.

I was on the fence, and you both seem to prefer it in run-command, so
here is a re-roll in that direction (no other changes).

  [1/7]: wt-status: don't flush before running "submodule status"
  [2/7]: wt_status: fix signedness mismatch in strbuf_read call
  [3/7]: run-command: introduce capture_command helper
  [4/7]: wt-status: use capture_command
  [5/7]: submodule: use capture_command
  [6/7]: trailer: use capture_command
  [7/7]: run-command: forbid using run_command with piped output

-Peff
