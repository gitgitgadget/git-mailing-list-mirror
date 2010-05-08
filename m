From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: do not dump core when iconv fails
Date: Sat, 08 May 2010 16:55:56 -0700
Message-ID: <7veihmaqyb.fsf@alter.siamese.dyndns.org>
References: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com>
 <r2s302ed1461004281249xd1b65e41l43fa7b639db7c97d@mail.gmail.com>
 <h2v76c5b8581004281259yfaca7abfz5a455ff8fd6cdc6b@mail.gmail.com>
 <o2j2cfc40321004281539j28fe44e0r5d029061e3e08b90@mail.gmail.com>
 <20100428233758.GA1654@progeny.tock>
 <20100429191150.GA10526@inner.home.ulmdo.de>
 <20100429194936.GA31941@progeny.tock>
 <20100429202139.GW10879@inner.home.ulmdo.de>
 <20100430133228.GA1620@progeny.tock> <20100508231729.GA6718@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 01:56:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAtsW-0004tD-7P
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 01:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab0EHX4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 19:56:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab0EHX4I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 19:56:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89954B1D76;
	Sat,  8 May 2010 19:56:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=exsoBbxnf6gVzPChOMhLK/B8c5E=; b=dy2ZWr
	RDoRygkLX5viF1iiX5v9h5j7Zka7fPvadRF3i89GF71fI6WkMh+QUDNBQ0qMn3vC
	+RKCwOY4KMGYx7GPXkSkDvUXhW59uFOylzuOnZh0Sfm0FH2sWAvO015duGgWbWKl
	hP8K09IeIrGsDwyi8ZmWAMi2gZ/dGJM9M+LRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jhmnviMJBFWhm/JhFCAR5ig0URReBOW4
	kJeYYa1W5M/iEsLmausm5WoVxpHKLN1YqIXcYI/TREpXuloXx7sMlAF3ulb+pnH5
	yWKRsiOiJgpRJ6LZQyYHvgfEFPDrv1SRc2ivPxZzRgv+j0FjHvBTXTSgwveLr7bM
	y/p8TfDm1aI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DEEBB1D75;
	Sat,  8 May 2010 19:56:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A987EB1D74; Sat,  8 May
 2010 19:55:57 -0400 (EDT)
In-Reply-To: <20100508231729.GA6718@progeny.tock> (Jonathan Nieder's message
 of "Sat\, 8 May 2010 18\:17\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 414811C2-5AFD-11DF-9E5E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146688>

Jonathan Nieder <jrnieder@gmail.com> writes:

> When cherry-picking, usually the new and old commit encodings are both
> UTF-8.  Most old iconv implementations do not support this trivial
> conversion, so on old platforms, out->message remains NULL, and later
> attempts to read it segfault.

This agrees with what builtin/commit.c does around ll.896; even if the
encoding pair says "utf8" and "UTF-8", we would do the right thing.

Thanks.
