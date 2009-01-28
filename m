From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] send-pack: Filter unknown commits from alternates of
	the remote
Date: Wed, 28 Jan 2009 04:58:04 +0100
Message-ID: <20090128035804.GC7503@atjola.homenet>
References: <7vk58gz04l.fsf@gitster.siamese.dyndns.org> <20090128013840.GA7224@atjola.homenet> <7vskn4xfyg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: PJ Hyett <pjhyett@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 05:01:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS1bn-0006Ta-M2
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 05:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbZA1D7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2009 22:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752480AbZA1D7H
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 22:59:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:45282 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753544AbZA1D7F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 22:59:05 -0500
Received: (qmail invoked by alias); 28 Jan 2009 03:59:02 -0000
Received: from i577BB3F1.versanet.de (EHLO atjola.local) [87.123.179.241]
  by mail.gmx.net (mp046) with SMTP; 28 Jan 2009 04:59:02 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/6L0QeHUz6+0pJo+FGfoHg0/kjG8EHEaM5XxuRzb
	EH4pwWprC6on6K
Content-Disposition: inline
In-Reply-To: <7vskn4xfyg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107467>

On 2009.01.27 19:33:11 -0800, Junio C Hamano wrote:
> It can be argued that at least in the "real ref" case you are in cont=
rol
> of both ends and if you have a disconnected chain in your local repos=
itory
> that you do not have a ref for, you are screwing yourself, and it is =
your
> problem.  But when you forked your repository from somebody else on a
> hosting site like github, you do not have much control over the other=
 end
> (because it is a closed site you cannot ssh in to diagnose what is re=
ally
> going on), and if you do not exactly know from whom your hosted repos=
itory
> is borrowing, it is more likely that you will get into a situation wh=
ere
> you may have objects near the tip without having the full chain after=
 an
> aborted transfer, and the insufficient check of doing only has_sha1_f=
ile()
> may become a larger issue in such a settings.

Uhm, it might be obvious, but what exactly could go wrong? Do we need t=
o
fetch from multiple repos when alternates are involved? Or how would we
end up with a broken chain? I mean, it starts to make some sense to me
why we would need the connectivity check, but how do we end up with a
"partial" fetch at all?

> I'd prefer a small helper function to consolidate the duplicated code=
,
> like the attached patch, though.  How about doing it like this?

Yeah, that looks a lot nicer :-)

Bj=F6rn
