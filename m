From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC 0/2] Mixing English and a local language
Date: Thu, 13 Sep 2012 09:28:47 -0400
Message-ID: <20120913132847.GD4287@sigill.intra.peff.net>
References: <1345922816-20616-1-git-send-email-pclouds@gmail.com>
 <CACsJy8CG72PzvndV7C4a9hspxhprKn2tcb49HxeZ14pmEDycGQ@mail.gmail.com>
 <7vligfcdgh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 15:29:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC9TW-000180-RZ
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 15:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab2IMN2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 09:28:51 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43444 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299Ab2IMN2t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 09:28:49 -0400
Received: (qmail 2663 invoked by uid 107); 13 Sep 2012 13:29:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Sep 2012 09:29:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Sep 2012 09:28:47 -0400
Content-Disposition: inline
In-Reply-To: <7vligfcdgh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205370>

On Wed, Sep 12, 2012 at 11:18:06AM -0700, Junio C Hamano wrote:

> I am so far taking the silence in the thread to mean they do not mind
> seeing the diffstat summary untranslated and they do not mind seeing
> it in Klingon, as long as the three numbers are there with (+) and (-)
> markings.

Actually, I have found the "Klingon" appearing in the diffstat of recent
messages to the list to be mildly annoying. I can decipher it, of
course, but in some cases I do not even have the glyphs in my font to
render the string, and it is quite ugly.

I think in an ideal world each repo could specify a "project language"
and, and diffstat, Signed-off-by, and [PATCH] would all be in that
language. Practically speaking, I'm not sure how much effort that is
worth; it seems like non-English speakers adapt to a few English phrases
(for example, email headers and date formats are all in English; I
imagine many clients localize them behind the scenes, but certainly the
"git format-patch && $EDITOR && git send-email" workflow does not and
should not).

I think I'd prefer:

  1. Revert diffstat to always be in English/C locale for now. For all
     commands. People too frequently end up showing the output of things
     besides format-patch. It means they will have to read the English
     when they are just running locally, but since format-patch is
     generating it, it is something that they would need to
     understand anyway.

  2. If people on non-English projects find that too cumbersome, then we
     can switch the "English/C" above for `i18n.projectlang` or
     something. But it should not be per-command, but per-message, and
     should include all output that is not diagnostic and is not
     machine-parseable (e.g., what I mentioned above, request-pull
     output, etc). If it is the project's language, then the team
     members will need to know it anyway, so it should not be too big a
     burden to have a potentially different language there than in the
     diagnostic messages.

But take my opinion with a grain of salt. English is my first language,
so I have zero first-hand experience with these issues. For most open
source projects that operate in English, I think just (1) will be fine.
The real test for needing (2) would not be a project like git, but a
project conducted solely in another language, where some of the
participants do not speak English at all.

-Peff
