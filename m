From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] builtin-fetch: add --prune option
Date: Tue, 10 Nov 2009 01:03:07 -0800
Message-ID: <7vbpjag3as.fsf@alter.siamese.dyndns.org>
References: <4AF92133.6070005@gmail.com>
 <7vfx8mg3mw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 10:03:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7mdW-0000dt-04
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 10:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbZKJJDX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 04:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbZKJJDX
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 04:03:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbZKJJDQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2009 04:03:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B2FA99E31;
	Tue, 10 Nov 2009 04:03:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BuH35zlb/VrU
	c8Bxow7KtgiCniQ=; b=XhZAyonHIX+bkQqVN7b4iH5ZeGbbE+oFkOvGwXU3vxYi
	Whh6y4u6+mQZ5h5cB9CPaoMg4Q4dPjpBl4vDbxFWq81+phtM4TEn7Hlqr8/4ht7N
	CZuREtOi1OzCItNSkTtsxyRL3rpRpf9LdHq3CXa0YmcygkKxg/EhTL3tbmICyEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N6i1LF
	4lAJywzbnmCmxH0GQo0WsZema2HCLm1kiv1fIRL6pBaMea8wMvJlEbXZuUhK6YlU
	w2t1uPUYrKMIBwfifMj+5GOGwP9D42jPN8Ggu5atB0z6iPVraADaAE+Dnv+1NoWc
	oJ0npDmNarRHFo4DaDZJoilLBhPEvUNE5F09E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C7DA99E30;
	Tue, 10 Nov 2009 04:03:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AD85699E2F; Tue, 10 Nov 2009
 04:03:14 -0500 (EST)
In-Reply-To: <7vfx8mg3mw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 10 Nov 2009 00\:55\:51 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E3BBB3B8-CDD7-11DE-8EDE-BD45BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132553>

Junio C Hamano <gitster@pobox.com> writes:

> Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:
>
>> From: Jay Soffian <jaysoffian@gmail.com>
>
> Thanks for being careful; it would be even better if you preserve the
> author date by copying Date: from the original.
>
>> Teach fetch to cull stale remote tracking branches after fetching vi=
a --prune.
>>
>> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
>> Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
>
> Yuck...
>
> builtin-fetch.c: In function 'prune_refs':
> builtin-fetch.c:500: error: implicit declaration of function 'get_sta=
le_heads'
> builtin-fetch.c:500: error: initialization makes pointer from integer=
 without a cast
> builtin-fetch.c:501: error: 'dry_run' undeclared (first use in this f=
unction)
> builtin-fetch.c:501: error: (Each undeclared identifier is reported o=
nly once
> builtin-fetch.c:501: error: for each function it appears in.)
> make: *** [builtin-fetch.o] Error 1

Ah, I know.  You forgot the first one from Jay's series.
