From: Jeff King <peff@peff.net>
Subject: Re: What's the definition of a valid Git symbolic reference?
Date: Tue, 15 Feb 2011 02:09:39 -0500
Message-ID: <20110215070939.GB28634@sigill.intra.peff.net>
References: <AANLkTinsJkzYggMtNrLRv-qNxRncrXSe6A46Z=d8xkw7@mail.gmail.com>
 <F624322D-359A-48ED-A241-622042F77CDA@sb.org>
 <AANLkTi=FKXqu_psoT+gvyq2c_o8Mej+DgpccecOpQd8H@mail.gmail.com>
 <7vsjvpq0jk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Emeric Fermas <emeric.fermas@gmail.com>,
	Kevin Ballard <kevin@sb.org>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>, libgit2@librelist.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 08:09:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpF2g-0007nm-B4
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 08:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969Ab1BOHJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 02:09:42 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58076 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090Ab1BOHJl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 02:09:41 -0500
Received: (qmail 28766 invoked by uid 111); 15 Feb 2011 07:09:40 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 15 Feb 2011 07:09:40 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Feb 2011 02:09:39 -0500
Content-Disposition: inline
In-Reply-To: <7vsjvpq0jk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166818>

On Mon, Feb 14, 2011 at 10:22:55PM -0800, Junio C Hamano wrote:

> Emeric Fermas <emeric.fermas@gmail.com> writes:
> 
> > Once again, by reading at the code I can understand how those commands
> > currently work. What I'm trying to achieve is to understand what
> > should be their recommended usage.
> 
> There are only two valid kinds of symrefs right now:
> 
>  - .git/HEAD, pointing at somewhere under refs/heads/ hierarchy;
> 
>  - .git/refs/remotes/<some remote name>/HEAD, pointing at somewhere under
>    refs/remotes/<the same remote name>/ hierarchy.

Nit: the notes merge code uses NOTES_MERGE_REF as a symref to a notes
ref. See the create_symref call in builtin/notes.c.

I don't think that changes your point much, though.

> The code may be prepared to resolve recursive symrefs, symrefs other than
> the above two kinds, symrefs that point at elsewhere, but all of them are
> outside of the design scope of what the mechanism was intended to support.
> What the code do to them (without crashing) is not the design, but simply
> an undefined behaviour.

I was always under the impression that you could generally use symbolic
refs to point wherever you wanted inside the refs hierarchy as a
replacement for symlinks (I don't know how the latter would deal with
ref packing, though). But I think that was just my assumption rather
than anything that was ever communicated officially.

-Peff
