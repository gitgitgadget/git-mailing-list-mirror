From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is anyone working on a next-gen Git protocol?
Date: Wed, 10 Oct 2012 13:46:30 -0700
Message-ID: <7vlifeawd5.fsf@alter.siamese.dyndns.org>
References: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com>
 <5072973D.4080703@op5.se> <7vtxu5lyjr.fsf@alter.siamese.dyndns.org>
 <035A66D9-FAF0-48EE-B161-7D0CAD92F2FB@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, spearce@spearce.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 22:46:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM3Ay-00028Q-AQ
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 22:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab2JJUqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 16:46:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781Ab2JJUqd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 16:46:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ACB29A23;
	Wed, 10 Oct 2012 16:46:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FSkLhJO1oc/ZJZ/zM2mC2GL3KzA=; b=jwfKC2
	Zt3XPFeWwmb9tG3S2mrdyUWjcuna1N5NLfGsvP3yxtSrsBm5+66+rFyHo+8081uu
	+hflGSUV0fS9SesL9JQJNO25Pt8oqGHdg7ulohI10qGi/uir/3P2T/UH2nzzGOgs
	4ii+T3lAxZxPwJSi4VKjNOhIi8vbaaVLkQvaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kOP2tntOPehpx1B7Q5QRowqurPstGmS0
	C4guv1bXnS25bQQMarE3ZxX5yl1495+etVso3wkGp1ulYD/DHRxu2OPvx2OplVQa
	TevD3Ws+kDe7g0+sZ9O1kFnUsDvl4WYDp/UXmy4vdWNGQ/zbFonK0JEGlGC5RzBz
	0rVCfrJa8as=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67E109A22;
	Wed, 10 Oct 2012 16:46:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D10CC9A18; Wed, 10 Oct 2012
 16:46:31 -0400 (EDT)
In-Reply-To: <035A66D9-FAF0-48EE-B161-7D0CAD92F2FB@zib.de> (Steffen
 Prohaska's message of "Wed, 10 Oct 2012 21:13:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92928CFA-131B-11E2-97AF-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207439>

Steffen Prohaska <prohaska@zib.de> writes:

> I've recently discovered that the current protocol can be amazingly
> inefficient when it comes to transferring binary objects.  Assuming two
> repositories that are in sync.  After a 'git checkout --orphan && git
> commit', a subsequent transfers sends all the blobs attached to the new
> commit, although the other side already has all the blobs.

I do not think it has anything to do with binary, but what you
deserve from using orphan, where you declared that the history does
not have anything to do with the original.

If both of your repositories had the two paralle lines of these
histories as branches, the transfer would have went well with or
without binary objects.
