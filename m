From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git notes merge' implementation questions
Date: Wed, 21 Apr 2010 17:12:38 -0700
Message-ID: <7v8w8g8hvt.fsf@alter.siamese.dyndns.org>
References: <201004210957.48138.johan@herland.net>
 <7viq7ka3zr.fsf@alter.siamese.dyndns.org>
 <201004220208.03706.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Apr 22 02:12:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4k2F-00046h-6X
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 02:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948Ab0DVAMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 20:12:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab0DVAMp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 20:12:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A3BEAC5DE;
	Wed, 21 Apr 2010 20:12:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=euZ5E6VBpeGEAlYgGrziXxeaikk=; b=dbC1oP
	G9rIXgIyIWjc1OIlf8AKjmQ1y9SgIHsYFgVri4ICiqa3+NIj4JzYC07WmjD9NSvx
	Gr+KIYokoq3nK5ahG/EfM4c0/EC319W1yLB7GVoQGwk9llTACGx75qe181+wjqJC
	Z3yn204dMy52i5HmCBXMlnlydGUZyFmperWXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tHz8LhXhwzthcj9gkJ/YIhdJr9Wabw+s
	tYC+Ot/qKdgUQBWvOq1eK6a33N6+Btnb2hkAVT/LQDf+ax9GzkTzims3uoxYX4i2
	c1hkoU/i9wyzDUhkUQ/om56PEHA0HSgWEKFNjPahlbKZskg2cUetAhiXHHqO1WiC
	W/1apZMQ7ww=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D8448AC5DC;
	Wed, 21 Apr 2010 20:12:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51F6EAC5DB; Wed, 21 Apr
 2010 20:12:39 -0400 (EDT)
In-Reply-To: <201004220208.03706.johan@herland.net> (Johan Herland's message
 of "Thu\, 22 Apr 2010 02\:08\:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C4A53390-4DA3-11DF-B951-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145482>

Johan Herland <johan@herland.net> writes:

> Ok, I'm just worried that it'll force us to re-implement much of the three-
> way merge logic that's already implemented in the merge machinery.

There is no way around it, as long as you have that variable fan-out in
the notes structure.  Changing and unstabilizing "merge" for dubious
benefit of code reuse is unacceptable, as the part that deals with
variable fan-out has no benefit to the regular "merge".
