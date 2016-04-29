From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 10/10] ce_compare_data() did not respect conversion
Date: Fri, 29 Apr 2016 14:09:12 -0700
Message-ID: <xmqqvb30w29z.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1461942126-16296-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Fri Apr 29 23:09:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awFf8-0007EJ-Cj
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 23:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbcD2VJS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 17:09:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750875AbcD2VJS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 17:09:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DFAC1831C;
	Fri, 29 Apr 2016 17:09:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YACBnLTncdBN
	g8n4t6jX1wTlQ5c=; b=lvsGw6KREqzjs0eaVnhhvNbTSCYB/ppPPxA9cSMU8fa4
	5lQHqqFRgSNh22ZO35WNgg9zUVTblIOAzUNkKxDUah/UsXkmSbWJMeyTDx2kZKnI
	uKwEW9uhw9BCIW3V3+QJPHgl5gq/z6uazVNK+3rdhiKFpJ8H0qtvQlzMqebqzGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vd8OAR
	Ir/HQvLKTLKodszbOFV46ODIrW1BQyxXUGsFHNYs1T3YriDFoL3iPDtEn4Juo6eC
	tZ23lsOPRhqbTDbF14xNp6iijXO0UYkPu7/6LxNSs7Ii9ZKmhYerpFS+3Lpc60nw
	JHYbnVRTxro/SHuFHpR8D0kW1uRD/4Jfahfhk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 851081831B;
	Fri, 29 Apr 2016 17:09:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB11A1831A;
	Fri, 29 Apr 2016 17:09:13 -0400 (EDT)
In-Reply-To: <1461942126-16296-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Fri, 29 Apr 2016 17:02:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A02F8714-0E4E-11E6-8B5E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293057>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> We define the working tree file is clean if either:
>
>   * the result of running convert_to_git() on the working tree
>     contents matches what is in the index (because that would mean
>     doing another "git add" on the path is a no-op); OR
>
>   * the result of running convert_to_working_tree() on the content
>     in the index matches what is in the working tree (because that
>     would mean doing another "git checkout -f" on the path is a
>     no-op).
>
> Add an extra check in ce_compare_data() in read_cache.c.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>

Well, didn't I do exactly the above much earlier and discarded it
because that breaks the definition of "diff"?  Or is this doing
something differently?
