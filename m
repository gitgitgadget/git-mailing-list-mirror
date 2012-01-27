From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] config: allow including config from repository blobs
Date: Thu, 26 Jan 2012 21:30:56 -0800
Message-ID: <7vd3a51zlb.fsf@alter.siamese.dyndns.org>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126074208.GD30474@sigill.intra.peff.net>
 <7vbopq2mk9.fsf@alter.siamese.dyndns.org>
 <20120126230054.GC12855@sigill.intra.peff.net>
 <7vsjj20yog.fsf@alter.siamese.dyndns.org>
 <20120127004902.GA15257@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 27 06:31:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqeOv-0000Or-LI
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 06:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab2A0FbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 00:31:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41680 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727Ab2A0Fa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 00:30:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F46942C3;
	Fri, 27 Jan 2012 00:30:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xGm7Fr0trcmhsQqG1yKwV9vtqv4=; b=xw0Ate
	Ieh1+LOGiRiiFkOVH6GAt6UAR8iaxR34j/pSuqCAnV+cYGVYw9bofUYOYxLFGC0N
	D5FvcFdUHL6lxzVYA3KBZSqEK81TlRevOvMEVfrX8i019AoK6+RnT4vD7ywQ8mZ+
	g9n862CPXuB6dp62hMK0ka6fYL6igYPSAMlio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jf9gm8rY9ohV/J8SdU9lSpe9zG0ob9jh
	TGrB/vLhx8zOq1czRtOs5xtc8O7rv6/UpJUr3EXqyf2A+ZN0qkA8pfWffrdiLy5v
	eLObROVQwQMvRutMSWHetGkPVuH8Q7FwBOchzUlFdLWKHOd3o8yqhLWjZpxWaOxw
	6U27PtmctAg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1727442C2;
	Fri, 27 Jan 2012 00:30:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D9DB42C0; Fri, 27 Jan 2012
 00:30:58 -0500 (EST)
In-Reply-To: <20120127004902.GA15257@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jan 2012 19:49:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17823FA8-48A8-11E1-B0E3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189191>

Jeff King <peff@peff.net> writes:

> No, I meant it explicitly to be about this single user hating it. Note
> how the resulting commits are never pushed. It is purely a local
> override, but with the added bonus that history is tracked so you can
> merge in further changes from upstream.
> ...
> It also does allow "[include]ref = origin/meta:gitconfig" if you want to
> live dangerously. I consider that a feature, because it lets the user
> make the security tradeoff they deem appropriate.

While I do not think origin/meta:config is a sensible default, I actually
do think that:

	[include]
        	ref = meta:gitconfig
        [branch "meta"]
		remote = origin
        	merge = refs/heads/meta

makes some sense. The earlier example with the in-tree dev_tools/config in
the same line of history as the usual source material to keep track of
private changes ("this single user hating it") was not realistic as it
forbids the user from sharing the rest of the source once she decides to
fork the config preference.
