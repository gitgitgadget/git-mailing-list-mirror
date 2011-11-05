From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I get a squashed diff for review
Date: Sat, 05 Nov 2011 16:53:14 -0700
Message-ID: <7vobwq86tx.fsf@alter.siamese.dyndns.org>
References: <CAH_EFyZ_0JB0-5cw-6VEJkfJhSjbmA=3upByQ3YpmnVSvR+9Pg@mail.gmail.com>
 <20111105091514.GA97860@gmail.com>
 <CAH_EFyYUja4cKY5YM4Uqn-bnQZCnhnJCNsxGsUitL+SSqj9qxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Roland Kaufmann <rlndkfmn+git@gmail.com>
To: Alexander Usov <a.s.usov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 00:53:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMq37-0003Jq-LA
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 00:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669Ab1KEXxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 19:53:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64743 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762Ab1KEXxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 19:53:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 860376E1F;
	Sat,  5 Nov 2011 19:53:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kiz9CUD0OhblF7pr6eOI9fAQndw=; b=O/wop8
	8RslxEZaDc108Zg+Caao99N7yUHp7GiWjVlMh4NuIAGvQLL/UdOqCBX6ZAlgSstm
	9u91fERmoXglOAPfA8xg/li7R/j8SK/g9ipyl34R7XOs2GgAHieQgfEPFrVkXpMP
	NUToRiTE16BH/IAls8Ikf18XMbkcOUDCWpRg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LnbSacLTaiJ9YJ/rHfZRTcea0Ja6yWLX
	IstDNzk0M2VgEpy+M2gJ7DWvzOX2dfB8Ka4SI9euDlIgo2PEh6/k+Di1B3uik2ea
	iSPrMV97nsM17zB6F6NX82MUw9/seOTVJ+C73Bg7o4NAKn7oGSARdOkVx4XWExEi
	d6qZOHmGHWk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 779246E1E;
	Sat,  5 Nov 2011 19:53:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D0C66E1D; Sat,  5 Nov 2011
 19:53:15 -0400 (EDT)
In-Reply-To: <CAH_EFyYUja4cKY5YM4Uqn-bnQZCnhnJCNsxGsUitL+SSqj9qxQ@mail.gmail.com>
 (Alexander Usov's message of "Sat, 5 Nov 2011 17:56:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 545882E6-0809-11E1-87CE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184881>

Alexander Usov <a.s.usov@gmail.com> writes:

> Consider the following history:
>
> master: A---B---D---F
>             \    \
> branch:      .-C--E--G
>
> ...
> - "git diff D..branch" would do a trick, but I'm not sure how to
> correctly determine
> D (if I'm to write a script).

D is the merge-base between F and G. So "git diff $(git merge-base F G) G"
would compare D and G.

Modern git lets you write it as "git diff F...G" as this is a fairly
useful short-hand.
