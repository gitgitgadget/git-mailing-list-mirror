From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [fyi] patches used by git distributors
Date: Tue, 08 Nov 2011 12:41:36 -0800
Message-ID: <7vmxc6xs73.fsf@alter.siamese.dyndns.org>
References: <20111108090251.GB17954@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 21:41:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNsUN-000154-Mx
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 21:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392Ab1KHUlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 15:41:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755809Ab1KHUlj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 15:41:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 833B468DE;
	Tue,  8 Nov 2011 15:41:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gGatSytQllcSmEgCXvIOL4lXNow=; b=htt+MY
	T3Q++K0uGt9SLHr0R7uXVVBZUGj7bUfsRHoW8JO5ZAIKGJVR35IJ6cWK3tRp+5cz
	uNtpZoRggW+zYwYoqQB8VG7W8/MsYff3Zw2bsF4dzxQwXoY2C0eOEd0uY52kNnL5
	2IVSUmlxXm6Y5iafimCKNMtE+y8SrWxQnol44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EXakEXyH9D/IdJI40xXVYLSj5t2wrMBP
	47HAgJDRBmUzMvQmPmcsy6jwqlHu+/s1jFSahCnOQonxhHi9wZkfW2z07QBldLWm
	8MMM9OxufuBkOUj+4y7d53zRKs4OktStLTBMdtjtgb6ko19quPJQk6gAhhsxVcwv
	GgUYtAuhvQM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A88A68DD;
	Tue,  8 Nov 2011 15:41:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00B2A68DB; Tue,  8 Nov 2011
 15:41:37 -0500 (EST)
In-Reply-To: <20111108090251.GB17954@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Tue, 8 Nov 2011 03:02:51 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E369864-0A4A-11E1-A973-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185106>

Jonathan Nieder <jrnieder@gmail.com> writes:

Note that I didn't check any of the patches that are not linked in
references section.


> Gerrit Pape (1):
>       bug#506445: hooks/post-receive-email: set encoding to utf-8 [2]
>
> Jonathan Nieder (12):
>       remove shebang line from shell libraries [3]

If this is about git-sh-setup, I think it is probably a good idea to
upstream it.

>       pre-rebase hook: capture documentation in a <<here document [4]

I do not mind this but if you are to do so you should remove the "exit 0"
before that block.

>       transport: expose git_tcp_connect and friends in new tcp.h [5]
>       daemon: make host resolution into a separate function [5]
>       daemon: move locate_host to tcp.c [5]
>       tcp: unify ipv4 and ipv6 code paths [5]
>       daemon: check for errors retrieving IP address [5]
>       tcp: make dns_resolve return an error code [5]
>       transport: optionally honor DNS SRV records [5]
>       srv: make errors less quiet [5]

It seems that this received almost no interest from anybody. I suspect
that the reason was because the cover letter was poorly written that
people did not realize the need for it.

>       Makefile: add a knob to turn off hardlinks within same directory [6]

I think the real fix for this issue should be either made in btrfs or even
better "tar x", instead of forcing everybody who consumes a tarball to use
symlink or copies. That is, work-around should be made when a _particular_
recipient wants to extract a tarball that stores hardlinks to the same
inode than the filesystem the recipient _happens_ to be trying to extract
it on, not before.
