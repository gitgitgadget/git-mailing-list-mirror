From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Tue, 01 Jan 2013 12:02:28 -0800
Message-ID: <7v7gnwbrjf.fsf@alter.siamese.dyndns.org>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net>
 <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
 <20121229050707.GA14475@sigill.intra.peff.net>
 <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
 <20121229052747.GA14928@sigill.intra.peff.net>
 <20121230120542.GA10820@sigill.intra.peff.net>
 <CACsJy8C4UttGKcw11do1POcHZJM7iZ2r7F3ESOqEnWL8kdz+dQ@mail.gmail.com>
 <20121230213124.GA15946@sigill.intra.peff.net>
 <CAJo=hJtjtpiPVd6Koy9q5je7s7A4EyDa-CptJNCnHLSLgd9W7g@mail.gmail.com>
 <CACsJy8CygfaM+Ee6rURFB-cP2khO8URGDJMG2f3mqg0ebYz+8Q@mail.gmail.com>
 <CACsJy8DpnO6X6jdQVsr1NwrXF2MDBBcHZQTay=TyLFc5p_z9eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 21:02:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq835-0003LT-2L
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 21:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab3AAUCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 15:02:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38467 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab3AAUCb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 15:02:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0AEDB0E0;
	Tue,  1 Jan 2013 15:02:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A4t7LY8hYfLwX4AJzKCi/IA1LlY=; b=P8uUdx
	7r4BV74PzG+wKrEpflknhm+Am+wn1VjTgsNOUmPgpQ6cr130fwHmNune4Hrnk0Sq
	jqp4EmJ0TQy+pydIQKWa7NeQPIF7YQ2OiP4yB49M/udittqMyGcMogEY+BEtsEXI
	P878T1cKvv1AlgCBS2Do/7Gk/NaamChbxjLFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e8AvWUgSv4D+5iK2Mrw6a2ODoVeahArn
	lEisidVZKJW2u+hUiEXd1mTSz03MEBJRSgXQTnPwAHNeJ+yYbZ6jJfRqBon2uPAh
	wL+joGQzpiU/sHpIZu/EwJ/fMNNwbm1eh1e4ttOUuDytHvlAVHJdl8R51wrpgbEy
	kl7aIifyxb0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2B7FB0DF;
	Tue,  1 Jan 2013 15:02:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35A38B0DA; Tue,  1 Jan 2013
 15:02:30 -0500 (EST)
In-Reply-To: <CACsJy8DpnO6X6jdQVsr1NwrXF2MDBBcHZQTay=TyLFc5p_z9eg@mail.gmail.com> (Duy
 Nguyen's message of "Tue, 1 Jan 2013 19:10:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C51E246-544E-11E2-B9DB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212435>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Jan 1, 2013 at 11:15 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> Fix pack-objects to behave the way JGit does, cluster commits first in
>>> the pack stream. Now you have a dense space of commits. If I remember
>>> right this has a tiny positive improvement for most rev-list
>>> operations with very little downside.
>>
>> I was going to suggest a similar thing. The current state of C Git's
>> pack writing is not bad. We mix commits and tags together, but tags
>
> And I was wrong. At least since 1b4bb16 (pack-objects: optimize
> "recency order" - 2011-06-30) commits are spread out and can be mixed
> with trees too.

Really?  That certainly wasn't the intention of that change.

The compute_write_order() function first fills the commits in the
original recency order (the order in which rev-list discovered them
by traversing the history from the tips) until we find a commit that
is tagged by a ref in the refs/tags/ hierarchy.  When we reach that
point, we stop showing the commits and show all the tags in the
refs/tags/ hierarchy and commits that are tagged by them, breaking
the original ordering of commits so that ancient but tagged commits
clump at this point.  After that, we resume showing the rest of the
commits and tags in the original order they came to us.  Trees are
done next, and then the remainder.

So I am not sure how trees can appear between commits.
