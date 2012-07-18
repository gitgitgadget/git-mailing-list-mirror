From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: respect --no-ext-diff with typechange
Date: Wed, 18 Jul 2012 15:47:21 -0700
Message-ID: <7vd33swuti.fsf@alter.siamese.dyndns.org>
References: <000301cd63b2$e39a2130$aace6390$@vrana.cz>
 <20120717041603.GD20945@sigill.intra.peff.net>
 <000e01cd6481$bbd63970$3382ac50$@vrana.cz>
 <7v7gu1y7tg.fsf@alter.siamese.dyndns.org>
 <20120718062329.GA12942@sigill.intra.peff.net>
 <20120718070626.GA20938@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Vrana <jakub@vrana.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 19 00:47:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srd1l-0006nE-Lr
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 00:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab2GRWrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 18:47:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61773 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754438Ab2GRWrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 18:47:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73A8B836C;
	Wed, 18 Jul 2012 18:47:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=44AhD838Us6VcfgXytUVYdEL9TU=; b=maqU/S
	cYmZ0rvyWhnU29XHsqaQ3xId7/dN6+1V8O/WzLDaOYpoJ9RKGdxw9qzuXf9K5B73
	9dS3P6IkhYbdFVC49DI4Lh5wr7rj2qb0NbhP+dcq34OXlcZkA+DM8hS8aVBMoDAG
	NTH6ZYdy/tFBL9qlCKyTLDAXpWrEHVTCjWbTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VAdoQ4dATQdLexxVi43shwpglMN9Pcu8
	kMriD/PtdZOLBr9OuJ2BrHtg+uBp2DHGiprnocWVbt/oxow9foCycR9FflQP2nlF
	FBbdoQgbZTqgtAQXyRuIKGUjpVv8WNYwYJUhJhUmTNfd5WdsHiNex6uj6VQnyVoT
	tqJncM4f8TA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A087836B;
	Wed, 18 Jul 2012 18:47:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C26088368; Wed, 18 Jul 2012
 18:47:22 -0400 (EDT)
In-Reply-To: <20120718070626.GA20938@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 18 Jul 2012 03:06:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89C504DC-D12A-11E1-B9CA-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201706>

Jeff King <peff@peff.net> writes:

> I don't care too deeply either way, and it is technically a behavior
> change. So there is a chance of regression for something that nobody has
> actually complained about.

Thanks. I share the same feeling, but the code after the patch looks
much nicer, which is somewhat sad.

> To be honest, I doubt many people are using
> external diff at all these days; textconv is closer to what most people
> want, and is much easier to use.

It depends on the payload and the output you want.  I wouldn't think
it is fair to challenge anybody to come up with a solution based on
the textconv machinery to replicate what the compare-cooking.perl in
the 'todo' branch (used as an external diff driver for
whats-cooking.txt) does.
