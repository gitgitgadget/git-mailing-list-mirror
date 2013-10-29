From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3 2/2] merge-base: teach "--fork-point" mode
Date: Tue, 29 Oct 2013 08:51:11 +0000
Message-ID: <20131029085111.GA24023@serenity.lan>
References: <CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
 <xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
 <CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>
 <xmqqwql2l3ln.fsf@gitster.dls.corp.google.com>
 <xmqqsivql37i.fsf_-_@gitster.dls.corp.google.com>
 <526A19CA.9020609@viscovery.net>
 <xmqqmwlxjnq6.fsf@gitster.dls.corp.google.com>
 <xmqq61sljakf.fsf_-_@gitster.dls.corp.google.com>
 <20131026090034.GH10779@serenity.lan>
 <xmqq38nlfbu5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 09:51:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb51R-0000Mw-Ft
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 09:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202Ab3J2Iv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 04:51:29 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:44738 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab3J2Iv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 04:51:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id E3A1C19800B;
	Tue, 29 Oct 2013 08:51:25 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jxCeKPue48MK; Tue, 29 Oct 2013 08:51:25 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 8E8D260651E;
	Tue, 29 Oct 2013 08:51:16 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqq38nlfbu5.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236915>

On Mon, Oct 28, 2013 at 12:13:22PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > The --reflog name has the advantage that it makes clear that this is
> > looking at something more than the commit graph and I don't think
> > --fork-point does imply that.
> 
> I think I understand what you are saying, but that "more than the
> commit graph" part in your reasoning is exactly one of the two
> reasons why I do not think that it is a good idea to call it with
> "reflog" in its name.  The next round of update to the feature may
> find a better way to find the fork point than looking at the reflog.
> What the feature is meant to do, i.e. "find the fork point" can stay
> the same (i.e. people can use it in their script), while the way how
> the implementation achieves it (i.e. by looking at reflog) can
> evolve over time, and by not hardcoding "how" in the name, the users
> will benefit from the updated behaviour, without having to ask for a
> better heuristics by using a different option by updating all of
> their scripts.

OK - given this reasoning I agree that --fork-point makes sense.

I think this would have been clearer if the short description said
something like:

    Find the point at which a branch forked from another branch; this
    does not just look for the common ancestor of the two commits but
    also takes into account the reflog of <ref> to see if the branch
    forked from an earlier incarnation.
