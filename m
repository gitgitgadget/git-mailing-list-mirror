From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] move setting of object->type to alloc_* functions
Date: Tue, 15 Jul 2014 13:12:48 -0700
Message-ID: <xmqqvbqytm7z.fsf@gitster.dls.corp.google.com>
References: <20140713064116.GA4768@sigill.intra.peff.net>
	<20140713064155.GC4852@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 15 22:13:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X795x-00082L-4B
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 22:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933388AbaGOUM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 16:12:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56708 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757029AbaGOUM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 16:12:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ACA8D2977B;
	Tue, 15 Jul 2014 16:12:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aKy1XiVRGiUSgs9WMKaddLbBsCU=; b=D1IOgn
	UhlkkHmRNv8VIIxQ4QdJVINf85luvGIGSgx3/m/Yl2fCTo+dfk2fJe7GToKT9L6g
	A8b7hDfLouubp0R3U+0mtVISHABP3L8yIwShztGc00MnQP9jJLh7q+rqKtiB4oOO
	oiYDEVk6k/PXBT+sJ/6IIlkn0bxJ8g+Ygm5Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IThM8RsLJ0lCR4YdAmnQGTpvWBUSqNA5
	we/CWC2K9GaXPVVagJxGt1ghDP3GDfTipLZlFYPTLZrNw08kd1DE8KsFgDAISWbY
	MTwfyQ8aOO4NWmiXg9vevown4gsNbv0bM2v2cNelWaMWW/wCFywnm7rOkbvZJHCK
	dlqcHxNuyTY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A04702977A;
	Tue, 15 Jul 2014 16:12:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7C18929771;
	Tue, 15 Jul 2014 16:12:32 -0400 (EDT)
In-Reply-To: <20140713064155.GC4852@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 13 Jul 2014 02:41:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5AA41D4A-0C5C-11E4-AF2F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253599>

Jeff King <peff@peff.net> writes:

> diff --git a/alloc.c b/alloc.c
> index 03e458b..fd2e32d 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -52,6 +52,7 @@ static struct alloc_state blob_state;
>  void *alloc_blob_node(void)
>  {
>  	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
> +	b->object.type = OBJ_BLOB;
>  	return b;
>  }

Ahh, please disregard my question on 2/8 ;-)
