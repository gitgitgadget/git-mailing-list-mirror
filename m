From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: document `creatordate` and `creator` fields
Date: Tue, 05 Jan 2016 09:43:12 -0800
Message-ID: <xmqqoaczkjm7.fsf@gitster.mtv.corp.google.com>
References: <20160105035157.GA1212@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jan 05 18:43:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGVe0-00088j-8f
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 18:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbcAERnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 12:43:20 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752059AbcAERnO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 12:43:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C876036B51;
	Tue,  5 Jan 2016 12:43:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4NYid/H/c6RWMULSqwjrrAjZxwM=; b=TIwB62
	Gv0Th6yVxwDg1rq67LE1ud8atZms1g4ZzilKScKm9XA+CsKtnVysvAOK/Q+EPJ2p
	qHYb69L2w7yR128w4UUQs8PrLRqbq26bTlNeIoiN7hkP3xnftETHl6XRoPERx7Qp
	BhPG6dDgK3w0LwYKhS2pgD1YQIqmJUZuOzVgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XLnTKLf9FbvkAFLrPOmUwTDKmSlama5u
	5Fm38Rs/DWfxZ2+o+23zubFNtB+oqQJ1nQuTqPDW/fuK0//lGJl+cgA2x9xV0Ftf
	/I+0qzNkBdaUBqT7lSzLUcU/7nTS3NUuaxzw+Baz/aMWmEpQwRI5rB8qQVMFqNGm
	hcbjIWIn6G0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C071936B50;
	Tue,  5 Jan 2016 12:43:13 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3FA0036B4F;
	Tue,  5 Jan 2016 12:43:13 -0500 (EST)
In-Reply-To: <20160105035157.GA1212@dcvr.yhbt.net> (Eric Wong's message of
	"Tue, 5 Jan 2016 03:51:57 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CB2B82B8-B3D3-11E5-A853-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283389>

Eric Wong <normalperson@yhbt.net> writes:

> These were introduced back in 2006 at 3175aa1ec28c but
> never documented.

Thanks, and I totally forgot about the feature ;-)

> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  And I just found these very useful, today!
>
>  I also noticed creator{name,email} aren't supported, yet.
>  Perhaps they're worth implementing for consistency.
>
>  Documentation/git-for-each-ref.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index c6f073c..06208c4 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -142,6 +142,11 @@ In addition to the above, for commit and tag objects, the header
>  field names (`tree`, `parent`, `object`, `type`, and `tag`) can
>  be used to specify the value in the header field.
>  
> +For commit and tag objects, the special `creatordate` and `creator`
> +fields will correspond to the appropriate date or name-email-date tuple
> +from the `committer` or `tagger` fields depending on the object type.
> +These are intended for working on a mix of annotated and lightweight tags.
> +
>  Fields that have name-email-date tuple as its value (`author`,
>  `committer`, and `tagger`) can be suffixed with `name`, `email`,
>  and `date` to extract the named component.
> @@ -153,8 +158,8 @@ line is 'contents:body', where body is all of the lines after the first
>  blank line.  The optional GPG signature is `contents:signature`.  The
>  first `N` lines of the message is obtained using `contents:lines=N`.
>  
> -For sorting purposes, fields with numeric values sort in numeric
> -order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
> +For sorting purposes, fields with numeric values sort in numeric order
> +(`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
>  All other fields are used to sort in their byte-value order.
>  
>  There is also an option to sort by versions, this can be done by using
