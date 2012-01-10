From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: [PATCH] gitignore: warn about pointless syntax
Date: Tue, 10 Jan 2012 06:42:11 +0100 (CET)
Message-ID: <alpine.LNX.2.01.1201100639340.11534@frira.zrqbmnf.qr>
References: <1326123647-18352-1-git-send-email-jengelh@medozas.de> <1326123647-18352-2-git-send-email-jengelh@medozas.de> <20120109162802.GA2374@sigill.intra.peff.net> <7vhb04ek6e.fsf@alter.siamese.dyndns.org> <20120109223358.GA9902@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	trast@student.ethz.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 06:42:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkUTU-0002Vk-A6
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 06:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913Ab2AJFmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 00:42:15 -0500
Received: from seven.medozas.de ([188.40.89.202]:46769 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644Ab2AJFmO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 00:42:14 -0500
Received: by seven.medozas.de (Postfix, from userid 25121)
	id E644421A0A0D; Tue, 10 Jan 2012 06:42:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id B6D2321A0A0C;
	Tue, 10 Jan 2012 06:42:11 +0100 (CET)
In-Reply-To: <20120109223358.GA9902@sigill.intra.peff.net>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188219>


On Monday 2012-01-09 23:33, Jeff King wrote:
>On Mon, Jan 09, 2012 at 11:43:21AM -0800, Junio C Hamano wrote:
>
>>>>+static inline void check_bogus_wildcard(const char *file, const char *p)
>>>>+{
>>>>+	if (strstr(p, "**") == NULL)
>>>>+		return;
>>>>+	warning(_("Pattern \"%s\" from file \"%s\": Double asterisk does not "
>>>>+		"have a special meaning and is interpreted just like a single "
>>>>+		"asterisk.\n"), file, p);
>
>You only have to implement proper backslash decoding, so I think it is
>not as hard as reimplementing fnmatch:
>[...]
>
>That being said, if this is such a commonly-requested feature

Was it actually requested, or did you mean "commonly attempted use"?

As I see it, foo/**/*.o for example is equal to placing "*.o" in
foo/.gitignore, so the feature is already implemented, just not
through the syntax people falsely assume it is. And that is the
reason for wanting to output a warning. If it was me, I'd even make
it use error(), because that is the only way to educate people (and
it works), but alas, some on the list might consider that too harsh.
