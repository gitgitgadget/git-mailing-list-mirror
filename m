From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fetch: better alignment in ref summary
Date: Thu, 26 May 2016 12:31:24 -0700
Message-ID: <xmqqk2igvcoj.fsf@gitster.mtv.corp.google.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
	<20160522112019.26516-2-pclouds@gmail.com>
	<xmqqfut9bnff.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BS2n8T1smxEJMPNiXBvMYHWnQ9BQGk_OKqJd1GFcuk7w@mail.gmail.com>
	<574706A1.8040606@xiplink.com>
	<20160526162940.GB18210@sigill.intra.peff.net>
	<xmqq8tywwwab.fsf@gitster.mtv.corp.google.com>
	<57473CDA.5000408@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu May 26 21:31:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b610H-00023U-48
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 21:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbcEZTb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 15:31:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754597AbcEZTb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 15:31:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D9A8E1DA30;
	Thu, 26 May 2016 15:31:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+MfG8gsbC4vjOG/kqLOGMxRmRqI=; b=mD/Fo5
	tST0n4B4g4scMVKELk2HCa/YJz/B4rAJSqLXpB8bj0AM9PpxLg/lAcoPTrbENaho
	yrtmXPkOInhTeW2yynHMPTTpQ8N/Vc17JNCv3TD8VPfP9SEvwjtPeqhkaPA+yFSo
	y+21brLWPMaZxvJSloWE2kf8lw/RwNpKkwI5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ghjlo25kk4i5HvkpjQ7JXTUO27SekHpC
	F3cuEOhUYRXPkYc/mr8HMDMk3K0oTDId2ShWCT2OBNxB/Xgxi+MDOevVzQ6FABSY
	/pVY5fN+K8DNZspijR1N5/Ho3qrh4Zb3g+FBgoEvbCimDtq2FmCKwkg6iLisnHdT
	ox2QZjLrKro=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D11911DA2F;
	Thu, 26 May 2016 15:31:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F5C51DA2E;
	Thu, 26 May 2016 15:31:26 -0400 (EDT)
In-Reply-To: <57473CDA.5000408@xiplink.com> (Marc Branchaud's message of "Thu,
	26 May 2016 14:13:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6FFEDF24-2378-11E6-8859-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295687>

Marc Branchaud <marcnarc@xiplink.com> writes:

> The fact that something is buried in some odd part of the ref tree is
> less relevant, IMO.  If I'm using custom fetch refspecs or other
> oddities, I'll have that in the back of my head.  But what I really
> care about is what ref I can use with commands like log and checkout.
>
> So, regarding Peff's examples:
>
>> $ git fetch origin refs/pull/*/head:refs/remotes/pr/*
>
> Just show me the "pr/foo" refs.  I know where things are coming
> from. Even if I configured that fetch refspec a long time ago, I don't
> need to see the exact mapping every time I fetch.

That is only because you are used to seeing them.  You cannot claim
"I'll remember forever without seeing them" without actually
experiencing not seeing them for a long time.

> I think the output should show the plain SHA values, since those are
> the only things the user can use to work with those refs.

When they tell others how to reproduce what they did (or record what
they did so that they can reproduce it later), they need what it is
called at the remote end.

I would hesitate to go in the approach based on discarding
information, as if it is the only way to shorten and clarify the
output.  Let's not do so before thinking things through to achieve
the same while keeping the information we give to the users.
