From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: add ignore non-existent files option.
Date: Mon, 1 Sep 2008 22:35:03 -0700
Message-ID: <20080902053503.GD13248@spearce.org>
References: <94a0d4530809011501n651c42c8xebb5cc39a93aac4c@mail.gmail.com> <1220308173-20392-1-git-send-email-felipe.contreras@gmail.com> <20080901223802.GK7482@spearce.org> <94a0d4530809011552h59e476e0q9033f0b917288a8f@mail.gmail.com> <20080902043951.GB13248@spearce.org> <7vfxojrvvp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 07:36:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaOYx-0007hU-9r
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 07:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbYIBFfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 01:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbYIBFfG
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 01:35:06 -0400
Received: from george.spearce.org ([209.20.77.23]:54056 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbYIBFfF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 01:35:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 954CF38375; Tue,  2 Sep 2008 05:35:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vfxojrvvp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94646>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > OK, that argument makes sense.  Then I wonder if more specific
> > error ignoring would be better:
> >
> >   --ignore-error=already-deleted
> >   --ignore-error=already-deleted,missing-mark,missing-copy-source
> >
> > I'm not really fond of turning an existing error condition that
> > exists to catch broken frontends into a generic tolerant flag.
> > But being able to selectively turn it off while leaving other
> > errors as errors isn't entirely unreasonable.
> 
> I think selective loosening of consistency check makes sense very much,
> but I have been wondering if these should be command line options.
> 
> The only example we saw so far is about output from one exporter.  Perhaps
> it should be given to fast-import as initial set of commands ("#pragma"!)
> that describes the nature of the input file?

Yea, I briefly considered that when I added the timestamp format
option.  I didn't bother because it was a single option and I figured
most frontends start git-fast-import directly.  But with this being
added a "format pragrma header thingy" makes a lot of sense.

Since comments are supported we could backdoor it with #pragma or
something like that, so existing files can still be (mostly) parsed
by an earlier git-fast-import.  But I wonder if that is wise given
that some classes of errors would still fail on the older import,
but would work on a newer one.  Might as well just make it a proper
command that would cause an older importer to fail out of the gate.

-- 
Shawn.
