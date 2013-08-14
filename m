From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Wed, 14 Aug 2013 15:51:27 -0700
Message-ID: <7vhaersx74.fsf@alter.siamese.dyndns.org>
References: <520BAF9F.70105@googlemail.com>
	<1376497661-30714-1-git-send-email-stefanbeller@googlemail.com>
	<CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com>
	<201308141125.59991.mfick@codeaurora.org>
	<520C01C3.2060804@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Fick <mfick@codeaurora.org>,
	Antoine Pelisse <apelisse@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	iveqy@iveqy.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 00:51:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9jui-0004CA-Ee
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 00:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933400Ab3HNWvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 18:51:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51013 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933390Ab3HNWvb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 18:51:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 221B6381F7;
	Wed, 14 Aug 2013 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LGXIZESkkqUxCkyI4uiCMpS3CTA=; b=gUdd47
	mmdTgMWhjrHd6igUgIuiVixsC4FbxtaeheIgMdex7FAw6XuwAPvLQILefAFuyjxY
	UFh1CgHCaDt4CONckgRAmnYoY4+2Z85MfjwoOme3XxyYnCMWivMNtIbuTePQfrTl
	PvKZwj5yJrVrqIZlXq89SHDRxhcFuYPwPTcYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OlPrUrD8tWegsjodYolfb4gskwzjtSw6
	phYYi76kjYOzV9p5wZSmmP0LkquobNDR4ElfUGySGJ1wfbRsWG//fzq9Gx6+xp80
	PmfNJ6h2UrR4aDwOIEjYssT90sfW2ZidcfGU7Z+/KVhVCgQf2EcTypSGeSG6/aGL
	YYkx57dxXMA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 151D2381F6;
	Wed, 14 Aug 2013 22:51:30 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DFF1381F5;
	Wed, 14 Aug 2013 22:51:29 +0000 (UTC)
In-Reply-To: <520C01C3.2060804@googlemail.com> (Stefan Beller's message of
	"Thu, 15 Aug 2013 00:16:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0EB09178-0534-11E3-839D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232318>

Stefan Beller <stefanbeller@googlemail.com> writes:

> I asked for a todo wish list a few weeks ago, but got no real answer,
> but rather: "Pick your choice and try to come up with good patches".

Hmph, I hope that wasn't me.

There are some good ones here;

  http://git-blame.blogspot.com/search?q=leftover

Some are trivial, some are moderate complexity, and some are
pie-in-the-sky.
