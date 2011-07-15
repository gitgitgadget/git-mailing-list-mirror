From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 11:58:09 -0700
Message-ID: <CA+55aFzeN9jdzU1RBVZ6UDGUT0YvNkzpycKG_mT-z+dt_3GnMw@mail.gmail.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net> <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net> <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net> <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net> <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net> <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
 <CAJo=hJtuxNLhSjn_sDJxG7xu5k2wbJ_QLf_n+Z1E=o2AndAuJQ@mail.gmail.com>
 <CA+55aFw_XjWm+4XwsN6CRJnsrcEu5YEChOHSHN51UUBN6PynWw@mail.gmail.com> <CA+8MBbJNZdkpOhA5Kke0VqUA9qCFdzfEP5cWPTMF3eUfDsGRiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tony Luck <tony.luck@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 20:59:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhnbV-000314-Fa
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 20:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913Ab1GOS7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 14:59:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57305 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751658Ab1GOS7H (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2011 14:59:07 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6FIwVrY017436
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 15 Jul 2011 11:58:32 -0700
Received: by wwe5 with SMTP id 5so1560934wwe.1
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 11:58:29 -0700 (PDT)
Received: by 10.216.58.135 with SMTP id q7mr3350659wec.48.1310756309115; Fri,
 15 Jul 2011 11:58:29 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Fri, 15 Jul 2011 11:58:09 -0700 (PDT)
In-Reply-To: <CA+8MBbJNZdkpOhA5Kke0VqUA9qCFdzfEP5cWPTMF3eUfDsGRiQ@mail.gmail.com>
X-Spam-Status: No, hits=-102.888 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177211>

On Fri, Jul 15, 2011 at 11:46 AM, Tony Luck <tony.luck@intel.com> wrote:
>
> What if my clock is wrong in the opposite direction - set to some time
> out in 2025.
> It would pass the check you propose and let the commit go in - but would
> cause problems for everyone if that tree was pulled into upstream.

I think Shawn suggested that we just notice it at merge time.

But yes, it's why (a) I'd suggest we have a "-f" to override and (b) I
do think that generation counts are a better idea. You could still
screw them up, but it would be due to an outright bug or malicious
behavior, rather than simple incompetence on the part of a user.

Incompetent users (where "date on the machine set to the wrong
century" is just _one_ sign of incompetence) are something git should
pretty much take for granted. It may not be the common case, but it's
certainly something we should design for and take into account.

In contrast, if somebody *wants* to screw his repository up by
re-writing objects with "git hash-object" etc, be my guest. We should
just make sure fsck catches anything serious.

So I would suggest checking the date regardless of any generation
count issues, because it would possibly find badly configured machines
that should be fixed. The same way we complain when we find no name.

Whether it should then be a correctness issue or not is kind of separate.

> You'd also want a check in pull(merge) that none of the commits being
> added were in the future (as defined by the time on your machine).

I don't think you need to care about "none of the commits", just
making sure the tip is reasonable. That would not only be expensive,
and not what we normally do (we show the diff against endpoints, not
all changes, etc). It would also cause problems for "fixed"
repositories (ie anything that has historical dates that are wrong,
but are ok now).

                  Linus
