From: Jeff King <peff@peff.net>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] cpu: add device_add foo-x86_64-cpu
 support
Date: Thu, 5 Feb 2015 14:57:58 -0500
Message-ID: <20150205195758.GC15326@peff.net>
References: <cover.1421214154.git.zhugh.fnst@cn.fujitsu.com>
 <20150205114914.GA10126@stefanha-thinkpad.redhat.com>
 <54D38B73.4060803@redhat.com>
 <xmqqiofgkvi4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Blake <eblake@redhat.com>,
	Stefan Hajnoczi <stefanha@gmail.com>,
	Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org,
	tangchen@cn.fujitsu.com, chen.fan.fnst@cn.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, imammedo@redhat.com,
	guz.fnst@cn.fujitsu.com, anshul.makkar@profitbricks.com,
	afaerber@suse.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:58:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJSZ0-0002MO-AT
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 20:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbbBET6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 14:58:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:45667 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750990AbbBET6B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 14:58:01 -0500
Received: (qmail 8408 invoked by uid 102); 5 Feb 2015 19:58:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Feb 2015 13:58:00 -0600
Received: (qmail 1842 invoked by uid 107); 5 Feb 2015 19:58:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Feb 2015 14:58:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Feb 2015 14:57:58 -0500
Content-Disposition: inline
In-Reply-To: <xmqqiofgkvi4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263394>

On Thu, Feb 05, 2015 at 11:29:07AM -0800, Junio C Hamano wrote:

> Eric Blake <eblake@redhat.com> writes:
> 
> > On 02/05/2015 04:49 AM, Stefan Hajnoczi wrote:
> >> On Wed, Jan 14, 2015 at 03:27:23PM +0800, Zhu Guihua wrote:
> >>> This series is based on the previous patchset from Chen Fan:
> >>> https://lists.nongnu.org/archive/html/qemu-devel/2014-05/msg02360.html
> >> 
> >> This email has an invalid charset:
> >> Content-Type: text/plain; charset="y"
> >> 
> >> I guess you entered "y" when asked how the message was encoded.
> >> 
> >> Please don't do that, it means we can only guess at the charset.
> >
> > In the past, people made a similar problem when 'git send-email' was
> > asking if a message was in-reply-to something else (the number of
> > messages incorrectly threaded to a message-id of 'y' or 'n' was evidence
> > of the poor quality of the question).  git.git commit 51bbccfd1b4a
> > corrected that problem.  Sounds like charset encoding is another case
> > where the interactive parser should be taught to balk at nonsense
> > encoding answers?
> 
> I think I answered this in $gmane/263354; care to come up with a
> plausible valid_re?  It is inpractical to attempt to cover all valid
> charset names, so whatever you do I'd imagine you would want to pass
> the confirm_only parameter set to true.

Would "length() > 1" be enough[1]? Or are people really typing "yes" and
not just "y"?

I cannot imagine a charset name that is smaller than two characters. It
may be that there are none smaller than 4, and we could cut it off
there. Googling around for some lists of common charsets, it seems like
that might be plausible (but not any larger; "big5" is 4 characters, and
people may spell "utf8" without the hyphen).

-Peff

[1] Of course, to match the existing regex code, we may want to spell
    this as "/../" or "/..../".
