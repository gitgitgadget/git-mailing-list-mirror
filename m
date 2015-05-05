From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] prefix_path(): Unconditionally free result of prefix_path
Date: Tue, 5 May 2015 13:56:12 -0400
Message-ID: <20150505175612.GA9709@peff.net>
References: <1430766714-22368-1-git-send-email-sbeller@google.com>
 <20150505032158.GA23587@peff.net>
 <CAGZ79kZjeG8UG5ALE-KSO52fD5gJk4xks=VtSV9bHQVA=ST+5Q@mail.gmail.com>
 <xmqqr3qvdizd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 19:56:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yph59-0000ba-RN
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 19:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762304AbbEER43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 13:56:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:54339 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762305AbbEER4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 13:56:16 -0400
Received: (qmail 18504 invoked by uid 102); 5 May 2015 17:56:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 12:56:15 -0500
Received: (qmail 8790 invoked by uid 107); 5 May 2015 17:56:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 13:56:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 May 2015 13:56:12 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr3qvdizd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268409>

On Tue, May 05, 2015 at 10:36:38AM -0700, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> >> Should we also squash in these sites? I think they are adequately
> >> covered under the proposed log message.
> >
> > That sounds good to me.
> >>
> >> Found by grepping for prefix_path calls. The only remainders are:
> >>
> >>   1. in blame, we assign the result to a const char that may also point
> >>      straight into to argv, but we never actually free either way
> 
> The return value from add_prefix() that is what prefix_path()
> returned eventually becomes scoreboard.path that needs to be kept
> during the lifetime of the process, and I think there isn't much
> point doing the "free() immediately before exiting".

Yeah, sorry, I meant to say that more explicitly, but clearly didn't. I
think it is fine as-is.

> Anyway, here is what I'd queue for now.

Looks good, thanks.

-Peff
