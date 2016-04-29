From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 29/29] lock_ref_sha1_basic(): only handle REF_NODEREF mode
Date: Fri, 29 Apr 2016 08:43:46 -0700
Message-ID: <xmqqinz01kul.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<a3d853510719a37c1e4bbb52261169c25b19c148.1461768690.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 29 17:43:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awAaA-00080C-2v
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 17:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbcD2Pnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 11:43:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753496AbcD2Pnt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 11:43:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A343163BF;
	Fri, 29 Apr 2016 11:43:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GnlMP06OTAlELFP6PuIDrs04kHg=; b=ryCY06
	00XAAA0Aas9fgpeS32uFZzvWcBKiuoNf/pfgZA1rL1Mro/Em1XEHS8Oop17BNRG8
	rTxj6eUDtdLZVZns+LZhWasuWVcF3wTt1puwTBWJ8ky6KQ+w/gu2x/3VIAWg4did
	lgELYVrxHUx5LDHYGn/3XnmtlpLYMfnqSepS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=llMdB54N0FidR/hTfpmGmOPQQJ+nsgJW
	4YoHItgdsxMEgq3q4RC24dk5UoTHoul27jVfXpdM3TrsjuLNTaobOcLQSXPf6+IT
	3OfhLWTpIf5wUgmyQawdyEEwIqPOOPTJmt6aeeVHKluByYL85bGpZDGArCGJIPfp
	Djb6S6u+EC0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FE5A163BE;
	Fri, 29 Apr 2016 11:43:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7131163BD;
	Fri, 29 Apr 2016 11:43:47 -0400 (EDT)
In-Reply-To: <a3d853510719a37c1e4bbb52261169c25b19c148.1461768690.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Wed, 27 Apr 2016 18:57:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 29C5C2B4-0E21-11E6-B532-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293019>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Now lock_ref_sha1_basic() is only called with flags==REF_NODEREF. So we
> don't have to handle other cases anymore.
>
> This enables several simplifications, the most interesting of which come
> from the fact that ref_lock::orig_ref_name is now always the same as
> ref_lock::ref_name:
>
> * Remove ref_lock::orig_ref_name
> * Remove local variable orig_refname from lock_ref_sha1_basic()
> * commit_ref_update() never has to write to the reflog for
>   lock->orig_ref_name
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs/files-backend.c | 54 ++++++++++++++++++++--------------------------------
>  1 file changed, 21 insertions(+), 33 deletions(-)

Finished reading the whole thing and it made quite a lot of sense.

Thanks.
