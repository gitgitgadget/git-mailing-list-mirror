From: Mike Hommey <mh@glandium.org>
Subject: Announcing a new (prototype) git-remote-hg tool
Date: Sat, 6 Dec 2014 05:53:35 +0900
Message-ID: <20141205205335.GA28935@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 22:27:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx0PY-0001ke-W1
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 22:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbaLEV1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 16:27:34 -0500
Received: from [12.216.224.110] ([12.216.224.110]:50993 "EHLO glandium.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751030AbaLEV1c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 16:27:32 -0500
X-Greylist: delayed 2035 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Dec 2014 16:27:32 EST
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Xwzsd-000866-Uv; Sat, 06 Dec 2014 05:53:35 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260894>

Hi,

I've (re)started work on a longstanding idea of mine of having a git tool
talking the mercurial wire protocol directly. I'm now at a stage where
the tool can clone and pull/fetch from mercurial.

As it is a prototype, there are many things that it doesn't handle (like
named branches, bookmarks, phases, obsolescence markers), but it
currently transposes a complete mercurial dag to git and maintains
metadata about the original mercurial data.

Code on https://github.com/glandium/git-remote-hg

It doesn't support push, but support for that should come in the coming
weeks.

More background on http://glandium.org/blog/?p=3382

This is meant to be a prototype, and will stay that way for now.
It's a validation that this can actually work. Now that I have pull
support I know I can make it push.
I'm currently evaluating what the final tool would look like. I'm *very*
tempted to implement it in C, based on core git code, because there are
many things that this helper does that would be so much easier to do
with direct access to git's guts. And that wouldn't require more
dependencies than git currently has: it would "just" need curl and ssh,
and git already uses both.

If I were to go in that direction, would you consider integrating it
in git core? If not, would you rather see git helpers to make this
git-remote-hg helper more efficient?

Cheers,

Mike
