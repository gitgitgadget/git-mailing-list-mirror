From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Fri, 20 May 2016 09:21:01 -0700
Message-ID: <xmqqfutcg0pe.fsf@gitster.mtv.corp.google.com>
References: <nhlqd4$ekr$1@ger.gmane.org>
	<c07df4ac-08c9-8eaa-0233-06616945c857@web.de>
	<c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com>
	<ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de>
	<xmqqy474g3cv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri May 20 18:21:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3nAv-0001iX-T2
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 18:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbcETQVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 12:21:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751701AbcETQVF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 12:21:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 193311C5F5;
	Fri, 20 May 2016 12:21:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JlcehWKKxziRKhjhX2EgkA6wSrU=; b=ElHXsu
	iZ5ofZY047JX+UJ0b1BkNrteLJCj18Af7Vg9cUljlH5jXBXFHohvCr4zjryPX71V
	kyR4EaXaoJpjszaN1/3QMIIh4Lv4/5vb1cauDaW6DpQBkTFnlaYm6Sok2HHvg4gE
	nWsNdiRqnBoNtMnz8LqjE0rdQ/NEyhqdv566E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YCxE9s7ZoFLRl9Cm3nlpCCQY3sBc3aUa
	203EmkfB6AqERCZMNw/CEVyAX3xT3DfBu+F0zFaA0szZ5L6oukeE9Zolxio2jlz+
	VV5MXMAGh9u0QPlwe84g5j8/JfKIu8vl6E4iRkry0xtdTyS2tE+w1eMFrz+Qktcc
	S4+s9Rgk3Ks=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B1311C5F4;
	Fri, 20 May 2016 12:21:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8187A1C5F3;
	Fri, 20 May 2016 12:21:03 -0400 (EDT)
In-Reply-To: <xmqqy474g3cv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 20 May 2016 08:23:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D8FFAFC0-1EA6-11E6-AF99-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295183>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks for asking a great question.  I somehow expected that we
> probe in init-db.c::create_default_files() for this when we probe
> for case sensitivity, symlinks, etc., but apparently we don't.

Ah, we do probe by using "config" as a guinea pig file.

Of course, if you are doing network mount between systems with and
without filemode support, the result would depend on where you did
the "git init", so that would not help.

Which means that other probed things like symlink support and case
sensitivity are likely to be wrong in the .git/config that the user
may want to fix.
