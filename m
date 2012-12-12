From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] mailmap from blobs
Date: Wed, 12 Dec 2012 09:54:23 -0800
Message-ID: <7vhanr5f74.fsf@alter.siamese.dyndns.org>
References: <20121212105822.GA15842@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 18:54:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiqW4-0006HJ-BX
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 18:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383Ab2LLRy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 12:54:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35622 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754166Ab2LLRy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 12:54:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30C48A0A1;
	Wed, 12 Dec 2012 12:54:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tj6louZi0F6ZFbuoO7yD0sQY3qw=; b=X1qFNk
	9dUGOOsrqffSd0wFFn32cbt0da9LxfrtR6vk0pO3RLznY75HD8YC2ls5gEyemG+K
	sxViyc7IlLsPSyuR25mBk6mms8kita2gGiBjXxLmGSDyGGFiM3dZFCgh61dK1UpW
	90a7gvdOcLPv9YcX9FbIG61O1a8T5+tGz1XSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=llQZaxGJQxugWLE0mqOD8d7lMZmWWSMw
	kSudZEyOdOv5GrwYmV3gXql4RFKxdcyBvqV6tZGZcmJ7XFeKRk9NrlxiWCBVsw2K
	/2DtJllm67hHZzEz7RwUtVtuWEOWU6TZE4Y2GFnqgzxyMw8UptfVtSK9PHtD3ELs
	UKqZWLG4Q80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D3E4A0A0;
	Wed, 12 Dec 2012 12:54:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BA5DA09F; Wed, 12 Dec 2012
 12:54:25 -0500 (EST)
In-Reply-To: <20121212105822.GA15842@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 12 Dec 2012 05:58:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7886E6E-4484-11E2-BD0D-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211374>

Jeff King <peff@peff.net> writes:

> I noticed recently that the GitHub contributions page for git.git did
> not seem very accurate. The problem is that while it uses shortlog, it
> does not respect .mailmap, because we do not have a working tree from
> which to read the .mailmap.
>
> This series adds a config option analogous to mailmap.file, but which
> reads from a blob in the repository (so the obvious thing to set it to
> is "HEAD:.mailmap" in a bare repo, and probably "master:.mailmap" if you
> frequently want to traverse while on unrelated branches). The obvious
> alternative is to checkout a temporary file of .mailmap and point
> mailmap.file at it, but this is a bit more convenient.

Yeah, I think this is sane.

Have you considered defaulting to read from HEAD:.mailmap even when
this new configuration is not there if core.bare is set?  I would
imagine that it would be the most convenient and match people's
expectations.
