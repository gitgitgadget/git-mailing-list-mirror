From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] gitk: refresh index before checking for local
 changes
Date: Tue, 06 Apr 2010 22:47:41 -0700
Message-ID: <7vfx37g6f6.fsf@alter.siamese.dyndns.org>
References: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com>
 <20100406233601.GA27533@progeny.tock>
 <n2kc6c947f61004061647ybb6c2f55zc70197362764ef8@mail.gmail.com>
 <20100407004353.GA11346@progeny.tock> <4BBBEC43.5000100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 07 07:47:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzO7K-0000p1-LG
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 07:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813Ab0DGFry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 01:47:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab0DGFrx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 01:47:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EF3DA8CEB;
	Wed,  7 Apr 2010 01:47:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BwiSrekxl/tqbFFYWoA3ACeOj9I=; b=VHqTiw
	UCoBR8iWZFltNhwuqNAtyKmNheRjVni6OLmYL183FhvKwBlS1JiIC4lxgXqynUHo
	FhmTjwD9VNSFMODMIPfIRa687zMe3NEFTS/f1YYKtg7CzrXhlI8Z5X/ozBJRsUmv
	Iuu8WHFH8pRX4HTLF0rKjqco7xVzgvUWUH+sE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u1x5HpM7iV7lUgKamI07T4QyW4e8wfeI
	PpQ8mR+VQUsGk4x9IUkA1b58lU5SOjxYtHrnc2EqzO8dKHLNiiMj0MqPAQ6yfwqL
	Th1wnIxgoPgkL2hlVtTl67AVisIFa/Fa1OWzGw4cSOR9ZDJZQmtoTmMWoxhuKNSh
	Gy+f2fRXDVQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B417A8CE9;
	Wed,  7 Apr 2010 01:47:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A109A8CE7; Wed,  7 Apr
 2010 01:47:43 -0400 (EDT)
In-Reply-To: <4BBBEC43.5000100@gmail.com> (A. Large Angry's message of "Tue\,
 06 Apr 2010 22\:21\:55 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 18A77B98-4209-11DF-B60B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144196>

A Large Angry SCM <gitzilla@gmail.com> writes:

> NAK - gitk should not modify a repository and/or working dir unless
> _explicitly_ prompted to by the user.

I used to think that way, until I realized that gitk has operations like
"Tag this commit" that does write into the repository.
