From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fixing volatile HEAD in push.default = current
Date: Thu, 23 May 2013 07:49:08 -0700
Message-ID: <7vip29hhuj.fsf@alter.siamese.dyndns.org>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
	<7v38tgno2k.fsf@alter.siamese.dyndns.org>
	<CALkWK0m3QP_eE14y8UoJ+HeFzkKM=1nVKAnYJcTrwQMp+Atphg@mail.gmail.com>
	<7vppwkm682.fsf@alter.siamese.dyndns.org>
	<CALkWK0np7o0eH8ZsWQSwk1Cdwnnpj5B==gS8kAE+OkTskASOsQ@mail.gmail.com>
	<7v7girks4s.fsf@alter.siamese.dyndns.org>
	<CALkWK0kXonM+J92KHs+dW31A_kZ8h9jNqwYn8AqT_V+GJhe_vg@mail.gmail.com>
	<7vppwjj5ws.fsf@alter.siamese.dyndns.org>
	<CALkWK0mfGWA3aBntQQU5fkCJDPx+MUOScvMRJjS+JzjNucFzPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 16:49:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfWpQ-0007DV-7r
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 16:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758267Ab3EWOtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 10:49:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55241 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757920Ab3EWOtL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 10:49:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFDF320E8E;
	Thu, 23 May 2013 14:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PXUuYZU52F4UJu4ZZlUXKr3K5Iw=; b=rjOHhr
	qqipeYqSMorg+yM53FWzj2GTL73bMdyE/T2McBSbBi1Ed1Q00ARMrHtHp85ZIIaX
	SszXQ9KVr7hZyFrkLsa0g3TnO997Pv80AuKE3MZ8plkhRZUXMq1R2coqJB5G0d+w
	wrPH+45q1o85MzR1eKAhz0TmIRYXXUM+EtxTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iSKgTunhliNX0n/p6n1cFejl3TjsGxCf
	1cLRGWxc6wiVdEGtAFaRWewHqxbIglqCwh1fls3V5liR8JvsLUUF3LXaFtBbbEMK
	XxavNbho/8s0qqWEbFr7PKSAHmsOHxb6aMXCuz6E9+dWye8XEGjfQt2R5AMxw3kr
	tuPc13AFll0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5BBD20E8D;
	Thu, 23 May 2013 14:49:10 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5839A20E8C;
	Thu, 23 May 2013 14:49:10 +0000 (UTC)
In-Reply-To: <CALkWK0mfGWA3aBntQQU5fkCJDPx+MUOScvMRJjS+JzjNucFzPw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 23 May 2013 13:25:55 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED638E8E-C3B7-11E2-AAF8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225253>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I would argue that there is something to "fix", but that fix involves
> making the cp a purely atomic operation which is super-complicated,
> and totally not worth it.  Would you _not_ like the above example to
> work?

No.  I do not think I like the above example to "work", at all.

I know we live in the real world, and I do not want to see such
serializing implementations of cp or rm that try to "fix", as it
will interfere my everyday use where such a race does not matter.
