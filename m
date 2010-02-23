From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v5 02/11] Support showing notes from more than one notes tree
Date: Tue, 23 Feb 2010 18:10:18 +0100
Message-ID: <201002231810.18960.trast@student.ethz.ch>
References: <cover.1266885599.git.trast@student.ethz.ch> <3dbcdcf1a364d14968c07e99564acb232c6a5c43.1266885599.git.trast@student.ethz.ch> <7vsk8sn2o3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 18:10:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjyHe-0003Ci-Ah
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 18:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426Ab0BWRKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 12:10:49 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:29261 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127Ab0BWRKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 12:10:48 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 18:10:47 +0100
Received: from thomas.localnet (129.132.210.179) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 18:10:26 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <7vsk8sn2o3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140813>

On Tuesday 23 February 2010 02:47:40 Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > * remove NOTES_SHOW_HEADER_WITH_REF distinction
> 
> Note that there is a leftover caller that uses the symbol without noticing
> that it has been retired.  I'll fix it up locally when I queue the series
> to 'pu'.

Thanks.  That was the breakage I hinted at in the last mail last
night; since it (hopefully) was the only problem with the series, I'll
dispense with the replacement for now.

> > @@ -68,6 +70,9 @@ struct non_note {
> >  
> >  struct notes_tree default_notes_tree;
> >  
> > +struct string_list display_notes_refs;
> > +struct notes_tree **display_notes_trees;
> 
> Unlike default_notes_tree, the above two can become static, as you made
> the new logic better contained to this file and accessible only via
> accessor functions.

Oh, so that's what you hinted at with the 'extern' question...

> As you are retiring format_note() as a public interface, and instead
> making format_display_notes() as the primary API for the callers, the

I still need it for the "format-patch from notes" patch, to be posted
soonish.  So unless someone comes up with an alternative for that, it
stays a public interface.

> former should be made static to notes.c along with the large comment
> describing how to call it.  It may also be worth telling people how to
> call this new public interface with similar comment here.

You caught me on my comment laziness...  I suspect even the ones I can
add won't match Johan's excellent comments :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
