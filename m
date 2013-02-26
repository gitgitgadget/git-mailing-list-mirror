From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: prevent pprint_rename from underrunning input
Date: Tue, 26 Feb 2013 13:44:08 -0800
Message-ID: <7vsj4ilphz.fsf@alter.siamese.dyndns.org>
References: <1361638125-11245-1-git-send-email-apelisse@gmail.com>
 <d74fcfa693e5feb7249023feda8d3ad1f22ab16d.1361911196.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 26 22:44:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UASKC-0001JP-FJ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 22:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004Ab3BZVoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 16:44:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39150 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab3BZVoK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 16:44:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48E30AED3;
	Tue, 26 Feb 2013 16:44:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vh9pcUIDG80iz6UyMpOhqxOGD+Q=; b=xaoit6
	yLS8uP/Tfq7Trmq8IdpMbmKPJrgrLolN34LcJkm9PTf5vg2R577H2Su+TKzBWa/5
	riWA7sRcsk87HkHqlVUPL5Ntsioopj7+31e03JSWkAWNIfqKpOI+7Lg0/cOB4dM4
	jz8ccC0Ng97YgexQqXTK3Hxw4iSSfoyFFsTN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BCYGCtj5wOildALtI9MpCVlUJiFDHlGb
	xthzIPoW9Jk1bUTiX7BN2jaVUlKZmlLAdQsH0H8qPLagQbM1qne5qNo3QZ0lJN/B
	foaEWobBSMpUetg8tMT+keZl3q3TCSaJAhj4gc5SjGmm4pbI+TEIDtWsuRHtScyo
	E9ZOcHTt63c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C8A3AED2;
	Tue, 26 Feb 2013 16:44:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A52CAAED1; Tue, 26 Feb 2013
 16:44:09 -0500 (EST)
In-Reply-To: <d74fcfa693e5feb7249023feda8d3ad1f22ab16d.1361911196.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 26 Feb 2013 21:47:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7030EF8-805D-11E2-ADC3-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217184>

Thomas Rast <trast@student.ethz.ch> writes:

> The logic described in d020e27 (diff: Fix rename pretty-print when
> suffix and prefix overlap, 2013-02-23) is wrong: The proof in the
> comment is valid only if both strings are the same length.  *One* of
> old/new can reach a-1 (b-1, resp.) if 'a' is a suffix of 'b' (or vice
> versa).

Thanks.  I was also having hard time convincing myself why that -1
does not under-run yesterday.

Will queue.
