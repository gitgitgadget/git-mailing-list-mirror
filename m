From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] config: add support for http.<url>.* settings
Date: Sun, 14 Jul 2013 21:02:19 -0700
Message-ID: <7v8v18fp2s.fsf@alter.siamese.dyndns.org>
References: <9e7edfbc83a7284615af4ca0de39c1b@f74d39fa044aa309eaea14b9f57fe79>
	<7voba8pu6r.fsf@alter.siamese.dyndns.org>
	<455666C5-7663-4361-BF34-378D3EAE2891@gmail.com>
	<7vsizjn390.fsf@alter.siamese.dyndns.org>
	<7v4nbyic57.fsf@alter.siamese.dyndns.org>
	<47B58075-3FDD-48E5-9047-8650F7FC5E3B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Schrab <aaron@schrab.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 06:02:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyZzX-0006L8-0N
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 06:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817Ab3GOECX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 00:02:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65227 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777Ab3GOECW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 00:02:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD79129EB4;
	Mon, 15 Jul 2013 04:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZH34tXxPZEMn3k4TWss0dTqA82M=; b=q+KXQe
	jUjHwBB7XcBJ7XJkAzIAsYD+666ejzyPlWPTqtkUMsOI9kxWYYCutMy76Y69/Mxs
	eQiZIVIe6Atl+u0eyTfzQM5E3Na2lBOSR7QsUVil08MDX51dJHje6kBtZ2mrR5zc
	/cQsxqkKM+VdDHcFH0hhWyhlFFRxfK/Cgtdzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZeCIv1aIQYACWuXmzffS5nEWylnF9lVJ
	uxAcAGe+V8lQHarTpaX6VPZe8z7lBnnDTJX3/Je+FDcNDFYORy0ZnvKaJ7ZfDGKG
	CRuQqsyZxf9KCauoqK4sjaTX56IOjLH43Acx3QB/bT51pqogIed+NV6fDQLn0PBD
	R/RLUZwxlLE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C071F29EB3;
	Mon, 15 Jul 2013 04:02:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E649429EB1;
	Mon, 15 Jul 2013 04:02:20 +0000 (UTC)
In-Reply-To: <47B58075-3FDD-48E5-9047-8650F7FC5E3B@gmail.com> (Kyle J. McKay's
	message of "Sat, 13 Jul 2013 12:46:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 591FC16E-ED03-11E2-A183-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230409>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> On Jul 12, 2013, at 13:58, Aaron Schrab wrote:
> ...
> This should guarantee a match in the scenario Aaron proposes above and
> still has pretty much the same easy explanation to the user.
>
> Shall I go ahead and add that to the next patch version?
>
> Or proceed with what's there right now (there are a few pending
> updates from reviewers) and then, as Junio says above, adjust it later
> if needed?

I have been assuming that "strictly textual match" will be a subset
of the matching semantics Aaron and Peff suggested.  That is, if we
include your version in the upcoming release, the user writes the
http.<URLpattern>.<variable> configuration so that the entries match
what they want them to match, the enhanced URL matcher Aaron and
Peff suggested will still make them match.

Am I mistaken?  Will there be some <URLpattern> that will not match
with the same URL literally?

Assuming that Aaron and Peff's enhancement will not be a backward
incompatible update, my preference is to take the posted matching
semantics as-is (you may have some other changes that does not
change the "strictly textual match" semantics).

I do not have strong opinion but Aaron and Peff seem to know what
they are talking about, so they will be a better guide to work with
you and polish such enhancement on top of what you have now, as a
separate change that may need more time to mature.
