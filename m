From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Thu, 27 Oct 2011 17:03:29 -0700
Message-ID: <7v1utyx9ri.fsf@alter.siamese.dyndns.org>
References: <7vehy459bg.fsf@alter.siamese.dyndns.org>
 <20111023160744.GA22444@sigill.intra.peff.net>
 <7v39ej5uqb.fsf@alter.siamese.dyndns.org>
 <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
 <20111024224558.GB10481@sigill.intra.peff.net>
 <7vvcrd411x.fsf@alter.siamese.dyndns.org>
 <20111027181303.GF1967@sigill.intra.peff.net>
 <7v7h3qz2yo.fsf@alter.siamese.dyndns.org>
 <20111027185220.GA26621@sigill.intra.peff.net>
 <7v39eez1ph.fsf@alter.siamese.dyndns.org>
 <20111027234429.GA28187@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 28 02:03:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJZv7-0004HI-0o
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 02:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923Ab1J1ADc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 20:03:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46051 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698Ab1J1ADc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 20:03:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AE4562F9;
	Thu, 27 Oct 2011 20:03:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vZIKeRrv1zWgij/QqmqlwMBriro=; b=ecufX+
	YDSj3FGIljJuU0K2T/7UALs2y++vwfR6NBNhJ0WGbKJcTdX494JIoyzTGKsj2L9U
	1zwwuu9ydD/lMN794e1kQERqmieNcLScrbWQ4RGu4HopAW61ePhvQvDis9RqyDQJ
	WCIBt396mTHGZWuqjZs7H2UnjJG5V4qTBxlxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fbBc4IAx6f21riUB+bRZSq8dPm84y+q5
	1vNhyw0rT3umT56fgdENMejUZ8okvkatejiG6MKohQqHz7os9a3MttNREmGDd06D
	nMxWmDuGbnhb7owBEAIdhNHJNjjeBIrRDWWyLSJo6I9CrESu3JXqTdxfW/vulmM0
	1l+1yQTZGAs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1113C62F8;
	Thu, 27 Oct 2011 20:03:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76E2262F7; Thu, 27 Oct 2011
 20:03:30 -0400 (EDT)
In-Reply-To: <20111027234429.GA28187@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 27 Oct 2011 16:44:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44DBEA50-00F8-11E1-9137-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184332>

Jeff King <peff@peff.net> writes:

> My interest is to make things like bare-repository diff (and everything
> built on it; i.e., things like github, gitweb, or whatever) do the sane
> thing for these people, even if I think what they're doing is wrong.

I do not think we are talking about right or wrong. I was primarily saying
that textconv may not be the right thing (think github/gitweb showing blob
contents, nicely formatted inside the chrome the site provides).

The solution you suggested feels like a gross layering violation, unless
we do it everywhere, in which case I wouldn't mind too much.

We have in-repository representation that diff and grep and friends work
on, and output conversion layer that externalizes the result of them in
the form of "smudge". Another layer above the in-repository representation
and below operations could convert UTF-16 to UTF-8 when going outward and
in the opposite when going inward.
