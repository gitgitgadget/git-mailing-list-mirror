From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule.sh: avoid "test <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 07:42:08 -0700
Message-ID: <xmqqbnu0bzcv.fsf@gitster.dls.corp.google.com>
References: <1402403313-22468-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 16:42:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuNFk-0001BO-7Q
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 16:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbaFJOmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 10:42:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50458 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbaFJOmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 10:42:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B7931C0DF;
	Tue, 10 Jun 2014 10:42:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MP79p1G01xHx7Fl8XMwEb3dJ6QM=; b=H55VsP
	cBytKQkX97ZvUlSIcO9MDDDENkZYBIcAAtTAE9+hTEeHE0vuii0e5v1eYKggEbiE
	4t4NQneb8+Zy7k+5iENL8g3izojUY6GfLrWuERopCWirr/la2fE6sgvjxWNRy8yt
	BKiS/GgvuDHakxPpfXOYQy4irJTfgJJBIACxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BBjVrrPrQp3Lqkma/o15hwvcGYKk9x+H
	y+ThGUq6/1fsyKNSl98bcEj7HXjx4wA3vfc+jyLqlwisJYQgQgzQX+lADzPiYNcN
	vbbIbWDj31Ut9lnJqS4PdHfur1A3GBLZAubday5o8OxWxog6Tg/fKb4izEFbGuaw
	hnEgVJ2Yjq4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F421E1C0DE;
	Tue, 10 Jun 2014 10:42:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0F3721C0D8;
	Tue, 10 Jun 2014 10:42:09 -0400 (EDT)
In-Reply-To: <1402403313-22468-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 10 Jun 2014 05:28:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6715E2FE-F0AD-11E3-A50C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251192>

Elia Pinto <gitter.spiros@gmail.com> writes:

> The construct is error-prone; "test" being built-in in most modern
> shells, the reason to avoid "test <cond> && test <cond>" spawning
> one extra process by using a single "test <cond> -a <cond>" no
> longer exists.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>
> This is the fourth revision of this patch.

Hmmmm.

When applied on top of 'master', this seems to break 7406; fails the
same way with either bash 4.2-2ubuntu2.1 which identifes itself as
4.2.25 or dash 0.5.7-2ubuntu2.

-- >8 --

t7406-submodule-update.sh .. Dubious, test returned 1 (wstat 256, 0x100)
Failed 14/43 subtests

Test Summary Report
-------------------
t7406-submodule-update.sh (Wstat: 256 Tests: 43 Failed: 14)
  Failed tests:  4-6, 10-15, 18, 30-33

-- 8< --

Which shell did you test this patch with?
