From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] clone: allow --no-local to turn off local
 optimizations
Date: Wed, 30 May 2012 10:20:19 -0700
Message-ID: <7vzk8pziuk.fsf@alter.siamese.dyndns.org>
References: <20120530110305.GA13445@sigill.intra.peff.net>
 <20120530111016.GB15550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Emeric Fermas <emeric.fermas@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 30 19:20:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZmZP-0007EK-3j
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 19:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982Ab2E3RUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 13:20:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170Ab2E3RUW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 13:20:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 872478EC7;
	Wed, 30 May 2012 13:20:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+MHxBPA9+yjMFcUZn0RcfiuJFAs=; b=esWs+K
	hFn62GbbRCiIXm7spkxDuf9t1yP4X/S4u0IKSFdbouEJVHpQfZh0DI7igcZgpE2e
	WH7qtAN9RdnP7bF3STjPujwKXuPZzTrBhpPcDgwffYm59W7sSi7R1IZCGxWMilGj
	OcZWVJ+jK/poZ9b7My49mm1Vepzjx0CXMT8mU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fHRYGqlaWP80NNnZOtZ+0vG5FIUX6eW6
	/c0Vf9/c02o90Qt2NMPZZVqUSL+Pfbc9n6TTb/LMEdKDdwFcploCOPSp1vZtAvep
	Nz61hRa+am2PsGU8UlBQyZfcEn4FLmr99sQvyk7tssf5JQ7Kzyh1Vxq3FBF3kech
	qKyHLCWoZKI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CF758EC6;
	Wed, 30 May 2012 13:20:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E67FD8EC5; Wed, 30 May 2012
 13:20:20 -0400 (EDT)
In-Reply-To: <20120530111016.GB15550@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 30 May 2012 07:10:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBFEC742-AA7B-11E1-8756-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198823>

Makes sense; thanks.

By the way, a somewhat funny exercise I found last night is this:

	$ cd /var/tmp
        $ mkdir -p foo.xz:pub/git.git
        $ cd foo.xz:pub/git.git
        $ git init
        $ git commit --allow-empty -m initial
        $ cd /var/tmp
        $ git clone foo.xz:pub/git.git x

This does not work as the transfer phase wants to run ssh on it.
