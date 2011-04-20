From: Jeff King <peff@peff.net>
Subject: Re: [RFC 0/5] Date Mode: Add --time-zone; deprecate --date=local
Date: Wed, 20 Apr 2011 02:43:18 -0400
Message-ID: <20110420064318.GF28597@sigill.intra.peff.net>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 08:43:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCR8J-0003zp-Qc
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 08:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680Ab1DTGnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 02:43:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59378
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325Ab1DTGnW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 02:43:22 -0400
Received: (qmail 16498 invoked by uid 107); 20 Apr 2011 06:44:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Apr 2011 02:44:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2011 02:43:18 -0400
Content-Disposition: inline
In-Reply-To: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171844>

On Wed, Apr 20, 2011 at 02:53:36AM +0000, Michael Witten wrote:

> One of the possible values for a date format is `local', which
> specifies that a date should be output as though the date format
> were instead `default' but in terms of the user's time zone
> instead of the time zone stored by git; clearly, then, `local'
> does not really provide just another format, but rather the
> combination of 2 specifications:
> 
>   * A format for the date (`default')
>   * A time zone in which to interpret the date (`local', if you will)
>
> [...]
>
> This patch series reimplements the original purpose of `--date' by allowing
> the time zone mode to be specified independently of the date format
> (see the commit message for [2] and the documentation provided by [3]):

I think the intent of this series is good. See also this thread from
quite a while back:

  http://article.gmane.org/gmane.comp.version-control.git/112026

> The date format `local' has thus been deprecated, though it is still
> supported (with a warning on stderr).

I don't know if we need to go that far. We can leave it forever as a
historical compatibility feature. Its existence is not really hurting
anyone as long as the documentation marks it as deprecated (or doesn't
even mention it).

> These patches apply cleanly to the current tip of Junio's `next' branch:

Why not "master"? Usually we try to develop features independently on
top of master, and then merge them. That way topics can graduate
independently to master, and it is easier to see which topics are
responsible for breakages. If you really need something in another topic
(because you are directly building on it, or the merge would just be too
painful), then build straight on that topic's commits, not on top of
next (and of course tell everyone which topic it's built on).

> There are some whitespace warnings (a la `git diff --check'), but I
> have reviewed them and personally approve of them; if you think that
> appraisal is incorrect, then you don't know what you're talking about :-P

All of the warnings I saw are related to indentation with spaces, and it
looks like your intent in each case is to line up the opening paren of a
function call with a line of arguments below, like:

   foo(bar, baz
       bleep, moof);

That's fine, style-wise, but the run of spaces should be collapsed into
tabs followed by spaces, with each tab representing 8 spaces (some would
argue that it should be "one tab for each level of structural
indentation, plus spaces to line up the arguments", but I don't find
that we tend to follow such a rule in git).

-Peff
