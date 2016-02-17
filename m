From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2016, #05; Wed, 17)
Date: Wed, 17 Feb 2016 18:25:56 -0500
Message-ID: <20160217232556.GA26077@sigill.intra.peff.net>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 00:26:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWBTx-0005ii-2v
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 00:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424583AbcBQX0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 18:26:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:44480 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1424577AbcBQXZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 18:25:59 -0500
Received: (qmail 16660 invoked by uid 102); 17 Feb 2016 23:25:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Feb 2016 18:25:58 -0500
Received: (qmail 13725 invoked by uid 107); 17 Feb 2016 23:26:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Feb 2016 18:26:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Feb 2016 18:25:56 -0500
Content-Disposition: inline
In-Reply-To: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286565>

On Wed, Feb 17, 2016 at 02:34:08PM -0800, Junio C Hamano wrote:

> * jk/tighten-alloc (2016-02-15) 18 commits
>  - ewah: convert to REALLOC_ARRAY, etc
>  - convert ewah/bitmap code to use xmalloc
>  - diff_populate_gitlink: use a strbuf
>  - transport_anonymize_url: use xstrfmt
>  - git-compat-util: drop mempcpy compat code
>  - sequencer: simplify memory allocation of get_message
>  - test-path-utils: fix normalize_path_copy output buffer size
>  - fetch-pack: simplify add_sought_entry
>  - fast-import: simplify allocation in start_packfile
>  - write_untracked_extension: use FLEX_ALLOC helper
>  - use st_add and st_mult for allocation size computation
>  - convert trivial cases to FLEX_ARRAY macros
>  - use xmallocz to avoid size arithmetic
>  - convert trivial cases to ALLOC_ARRAY
>  - add helpers for allocating flex-array structs
>  - harden REALLOC_ARRAY and xcalloc against size_t overflow
>  - tree-diff: catch integer overflow in combine_diff_path allocation
>  - add helpers for detecting size_t overflow
> 
>  Update various codepaths to avoid manually-counted malloc().
> 
>  Will merge to 'next'.

Please hold off a bit; I have a re-roll coming for this one.

> * nd/dwim-wildcards-as-pathspecs (2016-02-10) 3 commits
>  - get_sha1: don't die() on bogus search strings
>  - check_filename: tighten dwim-wildcard ambiguity
>  - checkout: reorder check_filename conditional
> 
>  "git show 'HEAD:Foo[BAR]Baz'" did not interpret the argument as a
>  rev, i.e. the object named by the the pathname with wildcard
>  characters in a tree object.
> 
>  I lost track of this topic; did we decide that this is a good thing
>  to do, or unnecessary noise to only cater to a crazy use case?

I think what we ended up with (and what you have queued here) is an
improvement.

I had some question about the tip one, which is a kind-of follow-on, and
makes the error message you get in certain cases a bit less
non-specific. You were "on the fence...but slightly inclined to take"
it.

Even if we drop it, I think the first two patches are an improvement.

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/285935
