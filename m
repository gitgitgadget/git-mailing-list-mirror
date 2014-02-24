From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: allow initial sparse checkouts
Date: Mon, 24 Feb 2014 09:47:16 -0800
Message-ID: <xmqqzjlg9zdn.fsf@gitster.dls.corp.google.com>
References: <1393122713-4308-1-git-send-email-robbat2@gentoo.org>
	<CACsJy8BKJ4HzXLcajC8cXviD4hboRPOYhWSen7H5Ta=_JuXNjw@mail.gmail.com>
	<robbat2-20140223T072340-334493350Z@orbis-terrarum.net>
	<CACsJy8ApmVPAnhQmVAsFyXtV49S+9VULsEYZ7W3x7HMMoVtDzA@mail.gmail.com>
	<robbat2-20140223T204934-225383635Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Feb 24 18:49:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHzck-00082S-Tz
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 18:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbaBXRrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 12:47:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579AbaBXRrV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 12:47:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCE2B6B944;
	Mon, 24 Feb 2014 12:47:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MjHxLnLn1Jy6C6NcnVn3oxuKMZk=; b=Y2x4F3
	UoheKcQaPFMjc1uq1MEJLW/VZZed8qfwKRS4RNNRW6W/eMzUVXnd0TV4GK+y8o8m
	ilYVKfnywDuMoIoQvVefYwW7kMK7xbosQEW66Z34YMTlmGboyKfBuIxO0kWs8oEH
	UBU0qw6p5LXfwasnT4RyywxPkK2BImULNxrHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YxWrNxFAHh1XOu+YCnUYWDky9icMWuSx
	WdRg+J/qzL3IKyc+7hpuv7FX2MUAtiBuhLLf1J7QmHNHfwJqFL3ULtuVl90mFVPO
	2neYVqe8Y3FD9d9Fl0xSWPYwNWTKTmdFCkzwPyRiST+FWuwViG6lQhIJhntUGDCP
	D3DJzzcNXmE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4CD76B943;
	Mon, 24 Feb 2014 12:47:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9683C6B940;
	Mon, 24 Feb 2014 12:47:19 -0500 (EST)
In-Reply-To: <robbat2-20140223T204934-225383635Z@orbis-terrarum.net> (Robin
	H. Johnson's message of "Sun, 23 Feb 2014 20:58:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B51B5004-9D7B-11E3-8269-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242619>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> The only other clean alternative would be implementing ONLY
> --sparse-checkout-from, and letting uses use fds creatively:
> --sparse-checkout-from <(echo X; echo Y)

Not all POSIX shells have such an abomination that is process
substitution.  You can easily work it around by adopting the usual
convention to use "-" to read from the standasrd input, though.

	(echo X; echo Y) | cmd --sparse-checkout-from -
