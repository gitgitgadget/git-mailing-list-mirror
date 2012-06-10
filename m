From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Sun, 10 Jun 2012 00:31:19 -0700
Message-ID: <7vipezaaig.fsf@alter.siamese.dyndns.org>
References: <1339122742-28677-1-git-send-email-martin@laptop.org>
 <4FD31476.90104@in.waw.pl> <7v8vfvbrjt.fsf@alter.siamese.dyndns.org>
 <20120610072431.GA20320@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Martin Langhoff <martin@laptop.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:32:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdccu-0004MG-GU
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 09:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab2FJHbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 03:31:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48744 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab2FJHbV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 03:31:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CBE23EE9;
	Sun, 10 Jun 2012 03:31:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9Gfpqmo7AznH479d3aDBt63t4NI=; b=dnD+Ms
	LayVNlD68wivgEgvvOSKJPFV4W57BOnktmBsKtuKX8mqID0Vz4wO6DLSuaIdHKrY
	0JsG6T6o8osCJ+XCvjSCJmrLAupQjqakQG91THuceyFu8yTTm1/pdQuArbsOxfzU
	7/MbaniJapZnSHelyjuxj9p2ixgx7Qhw6XLOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OnJoALXEF567ZuNRXa5/Ti/BNxz4q5lF
	DfB7ZRUl3NA0S85TwfCyu7fE/Bi19C3sqakymUoY3z2QeZNf8tEMZaXkylSpgrXz
	Z6aotzyH6azEPsQ/0c5+mXYntmZFRH/9K5xlXSZX2HXKT6iqLhr7W7/wLDaCXSfh
	Ml/CpGEc+LA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6450F3EE8;
	Sun, 10 Jun 2012 03:31:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E13FC3EE7; Sun, 10 Jun 2012
 03:31:20 -0400 (EDT)
In-Reply-To: <20120610072431.GA20320@bloggs.ozlabs.ibm.com> (Paul Mackerras's
 message of "Sun, 10 Jun 2012 17:24:31 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 463E9694-B2CE-11E1-9D1B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199574>

Paul Mackerras <paulus@samba.org> writes:

> What exactly does git log -G do?

Unlike

    git log -S'this
    and
    that
    line'

which finds commits that changes the number of occurrences of the
given lines in the blob (typically 1 to 0 or 0 to 1),

    git log -G'frotz'

internally runs "git log -U0", and finds commits that adds or
removes a line that matches the given pattern 'frotz'.
