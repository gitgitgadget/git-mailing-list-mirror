From: Jeff King <peff@peff.net>
Subject: Re: BUG: 'error: invalid key: pager.show_ref' on 'git show_ref'
Date: Sat, 7 Feb 2015 00:01:12 -0500
Message-ID: <20150207050112.GB15548@peff.net>
References: <20150206124528.GA18859@inner.h.apk.li>
 <20150206193313.GA4220@peff.net>
 <xmqqbnl6hljt.fsf@gitster.dls.corp.google.com>
 <CAHYJk3T8e6DgvQmq-y9iNrQroYu1Gd+kYuAMHDyCUgS2ybb=kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Krey <a.krey@gmx.de>, git <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 06:01:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJxWB-00078Q-D8
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 06:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbbBGFBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 00:01:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:46238 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750714AbbBGFBO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 00:01:14 -0500
Received: (qmail 30206 invoked by uid 102); 7 Feb 2015 05:01:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Feb 2015 23:01:14 -0600
Received: (qmail 14512 invoked by uid 107); 7 Feb 2015 05:01:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Feb 2015 00:01:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Feb 2015 00:01:12 -0500
Content-Disposition: inline
In-Reply-To: <CAHYJk3T8e6DgvQmq-y9iNrQroYu1Gd+kYuAMHDyCUgS2ybb=kQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263438>

On Sat, Feb 07, 2015 at 01:03:15AM +0100, Mikael Magnusson wrote:

> On Fri, Feb 6, 2015 at 8:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Jeff King <peff@peff.net> writes:
> >
> >> On Fri, Feb 06, 2015 at 01:45:28PM +0100, Andreas Krey wrote:
> >>
> >>>   $ git show_ref
> >>>   error: invalid key: pager.show_ref
> >>>   error: invalid key: alias.show_ref
> >>>   git: 'show_ref' is not a git command. See 'git --help'.
> >>>
> >>> Apparently we need to squelch this message from
> >>> within git_config_get_* in this case?
> 
> I reported this issue a few months ago,
> http://permalink.gmane.org/gmane.comp.version-control.git/258886
> Someone sent a patch that never went anywhere,
> http://comments.gmane.org/gmane.comp.version-control.git/258895

Thanks. I had thought this all seemed familiar, and I did find your
report in the archive, but not the follow-up patch[1].

It looks like that patch just squelches the error message. That fixes
the immediate error-message regression, but does not fix the larger
problem (that you cannot have an alias with an underscore, or set the
pager config for a command with an underscore). But it is at least a
start, and unless somebody is excited about taking it further, maybe it
is enough for now.

The thread ended with Tanay mentioning that new patches would be
forthcoming. I've cc'd him, so hopefully that can still happen.

-Peff

[1] This is a good lesson in why it is nice to make sure that the
    in-reply-to headers for patches are set properly; it makes it easier
    later on to find related parts of the discussion. This is something
    I think that git-send-email doesn't make especially easy.
