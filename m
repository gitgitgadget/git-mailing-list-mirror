From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] diff --cc: relax too strict paths picking
Date: Thu, 02 Apr 2015 13:59:48 -0700
Message-ID: <xmqqtwwyi6uz.fsf@gitster.dls.corp.google.com>
References: <1428006853-21212-1-git-send-email-max@max630.net>
	<1428006853-21212-4-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:59:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdmDT-0006Uw-MZ
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 22:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbbDBU7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 16:59:51 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751255AbbDBU7v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 16:59:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F093430F5;
	Thu,  2 Apr 2015 16:59:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fulMte9keZi4bmD6fFYrL2TJpUA=; b=WqJFFe
	xzIa6caSNgekcLNFZkDZ/R3QP7R14aOHjzh/hNUYxje/Wx4NfOFsJwuixRcdBMO9
	dX3FB1amAkQmykZIxkNBGSeVic9GAcbyVS5B9kNI5/1TbYt+/w47kBND9nQQCHrq
	2HTrwlYeLHR7Xu78OjjaD+YUilAC4ncFSdgL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VzLHg3gqARPWvEDXpR0N++c16fUysFuv
	AxWAc8c2fYV/YsUE6cFMnqNJaRrEhiZrqaHQgFoXueuYSMHmrtR/3lMV48VpVyCi
	/8NWW6atxdy3AaDgWfsGF0MXfrfVjP5Mf/4VsdarIFTie0CFW9VFwtwJEYYl8SdE
	NxfQuWWlNOw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 780A4430F4;
	Thu,  2 Apr 2015 16:59:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00E00430F2;
	Thu,  2 Apr 2015 16:59:49 -0400 (EDT)
In-Reply-To: <1428006853-21212-4-git-send-email-max@max630.net> (Max
	Kirillov's message of "Thu, 2 Apr 2015 23:34:12 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 33BCCC6C-D97B-11E4-BFAF-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266675>

Max Kirillov <max@max630.net> writes:

Again, just surface nitpicks.

[side: Kirill Smelkov <kirr@mns.spb.ru> removed from CC, as the
ddress just bounced for me]

> +static int changed_parents(struct combine_diff_path *p, int n)
> +{
> +	int parent_idx;
> +	int result = 0;
> +
> +	for (parent_idx = 0; parent_idx < n; ++parent_idx) {
> +		if (p->parent[parent_idx].status != ' ')
> +			++result;

We write C (not C++) and favor post_increment++ over ++pre_increment
when there is no valid reason to do otherwise (e.g. the result of
increment getting used in a larger expression).

Thanks.
