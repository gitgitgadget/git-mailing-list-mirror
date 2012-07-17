From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Fix notes handling in rev-list
Date: Mon, 16 Jul 2012 23:17:28 -0400
Message-ID: <20120717031727.GA20945@sigill.intra.peff.net>
References: <20120325005504.GA27651@sigill.intra.peff.net>
 <1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
 <7vipdn1qb7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 05:17:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqyI8-00061z-T4
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 05:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487Ab2GQDRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 23:17:36 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33840
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112Ab2GQDRf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 23:17:35 -0400
Received: (qmail 3017 invoked by uid 107); 17 Jul 2012 03:17:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jul 2012 23:17:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2012 23:17:28 -0400
Content-Disposition: inline
In-Reply-To: <7vipdn1qb7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201583>

On Mon, Jul 16, 2012 at 12:03:40PM -0700, Junio C Hamano wrote:

> Jukka Lehtniemi <jukka.lehtniemi@gmail.com> writes:
> 
> > Display notes in the rev-list when switch '--notes' is used.
> > Also expand notes place holder (%N) in user format.
> > Previously rev-list ignored both of these.
> >
> > Signed-off-by: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>
> > ---
> >
> > Thanks for your feedback Peff!
> 
> If it is an update for some old patch (I am guessing that is the
> case from "v2" and "feedback" above), please hint where the
> original can be found not to waste reviewers' time.

Agreed. For reference, v1 is here:

  http://thread.gmane.org/gmane.comp.version-control.git/193842

> As "git rev-list -h" does not say anything about "notes", I do not
> think this should be even called "Fix"; rather it is "teach rev-list
> to show notes with --notes", a new feature.

It does not, but "git rev-list --help" does (and it mentions "%N" for
the pretty userformat). So it's debatable whether it is a code bug or a
documentation bug. But whatever we call it, I think it is an
improvement.

> And as a new feature, "git rev-list -h" should be taught to include
> this new option in its output.  I didn't check the documentation but
> you may also want to add --notes there, too (hint: grep for "--pretty"
> to find where you may need to add the new option).

"rev-list -h" is already an unwieldy 35 lines, yet still manages to miss
many options (e.g., --grep, --author, --cherry-*, variations of
--left-right, --boundary, history simplification options like
--full-history, and so on). I don't think one more option is going to
break the camel's back, but I wonder if "rev-list -h" could use some
cleanup. E.g., maybe drop seldom used stuff like --bisect-vars, format
similar options on a single line to save space, and add in some missing
options.

My preference would actually be to just give up and refer people to the
manpage after a one or two line usage. But I think we have had that
discussion before and you did not agree.

-Peff
