From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] read-cache.c: use INDEX_FORMAT_{LB,UB} in
 verify_hdr()
Date: Fri, 22 Feb 2013 12:49:16 -0800
Message-ID: <7vmwuwcbw3.fsf@alter.siamese.dyndns.org>
References: <1361534964-4232-1-git-send-email-pclouds@gmail.com>
 <1361534964-4232-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 21:49:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8zYt-0001PF-BN
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 21:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758471Ab3BVUtT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2013 15:49:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757218Ab3BVUtS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2013 15:49:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43070B723;
	Fri, 22 Feb 2013 15:49:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GJbaceAeEtxk
	QHS0q7uzVs+l/1Q=; b=IQvCCaWijVWcaqPPI5uFQqcvM9tozFBJHoFmojl2DhsY
	6N+Dnkl07c/mBZKCC1wM4VlP+R/VtIbesmatgGa7vBJeVkCsutGECKUS6ttVyRTB
	WBhmP6B+uoX8ANqqqGB+xrJ/K+OHE+nXSWR/Rmm0VFS11iCfpcAKDrTF3Lku+Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UjlPng
	PSz1Npc7EROLlvoTpuBlM9WNC5kqMlhCXi5UPLqkZip0yMZITsQiKkOQkJwNtbcg
	7To05djdoW2KjVR1qpZ8YAOGR91bQzBKeSuv13oyQKjJdfIuQE7JPgNaLzM8cj4J
	pUFzZ6I6ibaCvM7yreQxJeyO6xtWYId1zfOKM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38058B722;
	Fri, 22 Feb 2013 15:49:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB21EB721; Fri, 22 Feb 2013
 15:49:17 -0500 (EST)
In-Reply-To: <1361534964-4232-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 22 Feb
 2013 19:09:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5330A828-7D31-11E2-881E-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216860>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> 9d22778 (read-cache.c: write prefix-compressed names in the index -
> 2012-04-04) defined these. Interestingly, they were not used by
> read-cache.c, or anywhere in that patch. They were used in
> builtin/update-index.c later for checking supported index
> versions. Use them here too.

Thanks.

> -	if (hdr_version < 2 || 4 < hdr_version)
> +	if (hdr_version < INDEX_FORMAT_LB ||
> +	    hdr_version > INDEX_FORMAT_UB)
>  		return error("bad index version %d", hdr_version);
