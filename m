From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/15] branch: use ref-filter printing APIs
Date: Mon, 07 Mar 2016 15:11:38 -0800
Message-ID: <xmqqmvq9nas5.fsf@gitster.mtv.corp.google.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
	<1457265902-7949-15-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 00:12:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad4KE-0001rW-7K
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 00:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865AbcCGXMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 18:12:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932488AbcCGXLl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 18:11:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA17C4B1A7;
	Mon,  7 Mar 2016 18:11:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PdXg02cl+4YW+5bE5zPu4+ftFAI=; b=kRw2Zo
	jaaypsKdQVWhZW584F95EjJI6ElQYCXGQ7QIq+mr11MHvITj8r0accSxaaq9HEzy
	QJdgbn/RWT1qq/nUbLDHh/Yus+jF5Wt2qUiDBT8FaX0VHuiBOR5pX+BcKUOUTjDH
	ezp1L6kHUmg5OzlKQgOi/1wncZPspEjrvdM3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G9BFJMyPp0lRJImisMHJ9369w2SYqVwJ
	ztneWPTFrr1zIoOf62yOFTlIo5motZXHsAr+8o2RqMorrMCbBQAM+wsSdO6UNdc1
	wmiccxGlUdan2TSsXjEAXRI8GfsiYdOuzHnV4twLOcPtzK6ppnFOPo4//OORSZKo
	q1GCtKZQI6s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DFD7A4B1A6;
	Mon,  7 Mar 2016 18:11:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 517D04B1A5;
	Mon,  7 Mar 2016 18:11:39 -0500 (EST)
In-Reply-To: <1457265902-7949-15-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 6 Mar 2016 17:35:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F28399C4-E4B9-11E5-8571-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288408>

Karthik Nayak <karthik.188@gmail.com> writes:

> Port branch.c to use ref-filter APIs for printing. This clears out
> most of the code used in branch.c for printing and replaces them with
> calls made to the ref-filter library.
>
> Introduce build_format() which gets the format required for printing
> of refs. Make amendments to print_ref_list() to reflect these changes.
>
> Change calc_maxwidth() to also account for the length of HEAD ref, by
> calling ref-filter:get_head_discription().
>
> Also change the test in t6040 to reflect the changes.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/branch.c         | 226 ++++++++++++++---------------------------------
>  t/t6040-tracking-info.sh |   2 +-
>  2 files changed, 66 insertions(+), 162 deletions(-)

Nice reduction of the code ;-)
