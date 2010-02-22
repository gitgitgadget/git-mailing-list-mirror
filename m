From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v4 02/11] Support showing notes from more than one notes tree
Date: Tue, 23 Feb 2010 00:25:57 +0100
Message-ID: <201002230025.57975.trast@student.ethz.ch>
References: <cover.1266797028.git.trast@student.ethz.ch> <d51082ad62153e182298242a2e4b7c3c76000a2e.1266797028.git.trast@student.ethz.ch> <7v1vgc26zd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 00:26:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjhfF-0003Lf-9y
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 00:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137Ab0BVX0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 18:26:03 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:2075 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754846Ab0BVX0A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 18:26:00 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 00:25:57 +0100
Received: from thomas.localnet (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 00:25:58 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <7v1vgc26zd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140738>

Umm, since I'm currently working on another reroll that has pretty
args to add notes refs for display...

On Tuesday 23 February 2010 00:20:06 Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > +	if (flags & NOTES_SHOW_HEADER_WITH_REF && t->ref) {
> > +		const char *ref = t->ref;
> > +		if (!strcmp(ref, GIT_NOTES_DEFAULT_REF)) {
> > +			strbuf_addstr(sb, "\nNotes:\n");
> > +		} else {
> > +			if (!prefixcmp(ref, "refs/"))
> > +				ref += 5;
> > +			if (!prefixcmp(ref, "notes/"))
> > +				ref += 6;
> > +			strbuf_addf(sb, "\nNotes (%s):\n", ref);
> > +		}
> > +	} else if (flags & (NOTES_SHOW_HEADER|NOTES_SHOW_HEADER_WITH_REF))
> >  		strbuf_addstr(sb, "\nNotes:\n");
> 
> It is not clear what the distinction between NOTES_SHOW_HEADER and
> NOTES_SHOW_HEADER_WITH_REF.  Does anybody still call this function with
> NOTES_SHOW_HEADER alone without NOTES_SHOW_HEADER_WITH_REF?

No.

> I expected to see "Notes:\n" regardless of the mode if the notes is coming
> from the default refs/notes/commits tree, but it probably is better to say
> "Notes (commits):\n" like your patch does.

I special-cased GIT_NOTES_DEFAULT_REF (which is "refs/notes/commits")
above *at your request* to not change the output in the default case.
So which way do you want it?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
