From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Tue, 03 Sep 2013 10:33:47 -0700
Message-ID: <xmqq4na1u7wk.fsf@gitster.dls.corp.google.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
	<1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
	<20130903071256.GD3608@sigill.intra.peff.net>
	<20130903075107.GA25540@goldbirke>
	<20130903080358.GA30158@sigill.intra.peff.net>
	<CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
	<20130903111006.GJ29840@goldbirke>
	<CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<xmqq8uzdu817.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:34:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGuUK-000775-Mt
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061Ab3ICRd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:33:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44215 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754406Ab3ICRd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:33:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09D763F7DE;
	Tue,  3 Sep 2013 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tk+EjNHF0ZF4IxiYpdok9LDVtLs=; b=g2PQtF
	VuqEAfN+eOLgA7oNi++xaUxsk5S2A9sHtU9qZXhPt48+X/xnCRpLi4scUi90AOoe
	vU9aNwxVGJwGxyQJPX1Q1YOkTIRTiy1h1gdHEQlBqQs58wLyEd1IEFasL6Gcmjcy
	UFWE+G+wvW0eEZuRwfu1CJ2tUbWo5Yf7XLwNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hAXMwDI0W8Utmz7UEYrIWzsYdVUHm9QU
	AqngxOKdZARDHl4ZxDLNL6tfJ+K0iaYSjhmEPsBYHybYR1YVSfJj/TZDqCD32bj4
	gQ+ZhgY8SBMvf0oTBcW2MdXZSv6ArcuVuF405ugVOJrrjEpbZCTTgfyBxNVy6L8N
	NLcnuVC2I9U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02E173F7D4;
	Tue,  3 Sep 2013 17:33:54 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAD143F7C3;
	Tue,  3 Sep 2013 17:33:50 +0000 (UTC)
In-Reply-To: <xmqq8uzdu817.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 03 Sep 2013 10:31:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 001C2CF4-14BF-11E3-A33B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233749>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> There are two ways to fix an inconsistency, the other way is to fix
>> test_cmp. But that would be a change, and change is not welcome in
>> Git.
>
> If you want to do "test_cmp $actual $expect", you would have to
> first "fix" people's expectation that "diff A B" produces a change
> necessary to bring A to B, which would not likely to happen.  We do
> the 'test_cmp expect actual' for a reason.

By the way, I found the other changes (especially the last one) very
sensible.
