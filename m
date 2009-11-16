From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rebase: refuse to rebase with -s ours
Date: Mon, 16 Nov 2009 13:45:55 -0800
Message-ID: <7viqdannxo.fsf@alter.siamese.dyndns.org>
References: <cover.1258309432.git.trast@student.ethz.ch>
 <efd7770d166a97481e8e31e407b9c2da02a341e5.1258309432.git.trast@student.ethz.ch> <alpine.DEB.1.00.0911161333470.4985@pacific.mpi-cbg.de> <7vpr7ip7ji.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0911162213590.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 16 22:46:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA9P0-0002Af-V0
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 22:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbZKPVqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 16:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbZKPVqJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 16:46:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbZKPVqI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 16:46:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 93CF69EB74;
	Mon, 16 Nov 2009 16:46:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wyqqPUEbfLdP4RWR84De5bWOyGQ=; b=nCiQbc
	NdT9VHYowhpek6u5lauq3BdvnbvSy8HQU7ECJmmasnS/p9fccLTc3YbNY9NRnUhj
	4g8h578PkN9jg0uvKxbUfPr0KqqG2erY149ckDnJdHYxm0ISs3vnxUE2H2DEX6/J
	ZxnCKF+ONgDwzS5ufMg7pwIcmRl1efSjv/3Ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZAQUaqBTdLadrgwPwQs8iHIdNHTrbJ7K
	eD5RxPcxc4jmwKAJyaGPNkD/xC4EL1E9pwwDiVaalopemv8p+YnMol0Ytg9+N1nR
	zAHktIvBxinIpWirdokNP2LxHlsE+EAGam238vhcSVKP+3Sto69c7HCA5Ma2qAm/
	Ezl292ZhJTc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C9469EB68;
	Mon, 16 Nov 2009 16:46:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ABF6F9EB56; Mon, 16 Nov 2009
 16:45:56 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0911162213590.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon\, 16 Nov 2009 22\:25\:13 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 718225F8-D2F9-11DE-894F-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133026>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I meant the following: if "rebase -s ours" refuses to run, but my boss has 
> written this cunning merge strategy "superduper" which is equally unlikely 
> to yield a sensible result, "rebase -s superduper" should still refuse to 
> run, no?

Why should it?

> Now, this scenario might be too rare to take care of, but maybe it shows 
> that we have a design flaw here?

The decision is up to the user who is much more familiar with such a
custom 'superduper' strategy, and git itself is in no position to make
that decision for the user.  It is none of our business to forbid users
from using what he wrote, when we do not know what it is.

I do not think the "rarity" is relevant.

What do you mean by a design flaw?  In other words, how should things look
like in your ideal design?

Certainly you are not talking about a design that enforces users who want
to use custom strategy to first submit the strategy implementation to us
for a review and have our blessings (perhaps we digitally sign approved
strategy implementations) before being able to use it in "merge -s" and
"rebase -s".

I can _guess_ what you are _not_ talking about but I cannot tell what you
_are_ talking about; sorry.
