From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run_diff_files: do not look at uninitialized stat data
Date: Thu, 15 May 2014 09:37:50 -0700
Message-ID: <xmqqsiobgfq9.fsf@gitster.dls.corp.google.com>
References: <CAPZ477Ot8MiTUNx1AwDTb5sGDDerDvBY=znsK4Fhcb5taYsaHA@mail.gmail.com>
	<20140514221306.GA5020@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elliott Cable <me@ell.io>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 15 18:38:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkyfj-0001m9-5o
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 18:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbaEOQiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 12:38:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55270 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754122AbaEOQiL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 12:38:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 77FBA1541A;
	Thu, 15 May 2014 12:38:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HRtYpgHpShhpeoxCaaTw2eBunF8=; b=ZXY8Qg
	x1+DecOPS2k0PC92DH0Ew379vN6y4emiRancTNyIEj5694CUwUzEEmQ+3SH4wg8e
	H3h0cQVyY4jJ9jor7xWSvdhOoe73ehQKYqJy6+MEdPUUtCVQaOZD8Bvt8PXS06Y3
	GG4E3gNDbuFyY12e2rcwyUhzPUVVv6RffiXnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mde0T8cY9gx58zPGoTLa4fFzdsYPBjoH
	rlQu545T0zPhBMf06VHGyMsgzJaUrf4JJND5Dt7eVATn2fNPTH8pMFoaUqT/usfj
	XFslyJ8R9TAoH8MkDPnTPhKXQcAC292l1UFc3x9xS8vynPCAxLNxKelgEaSJkR33
	lGMUcLx53s8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E98615419;
	Thu, 15 May 2014 12:38:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B4A34153D8;
	Thu, 15 May 2014 12:37:52 -0400 (EDT)
In-Reply-To: <20140514221306.GA5020@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 14 May 2014 18:13:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4281216E-DC4F-11E3-B4B0-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249111>

Jeff King <peff@peff.net> writes:

> Thanks for a thorough bug report. I was able to reproduce it. The
> ...
> -- >8 --
> Subject: run_diff_files: do not look at uninitialized stat data
> ...
> We can fix both by splitting the CE_VALID and regular code
> paths, and making sure only to look at the stat information
> in the latter. Furthermore, we push the declaration of our
> "struct stat" down into the code paths that actually set it,
> so we cannot accidentally access it uninitialized in future
> code.
>
> Signed-off-by: Jeff King <peff@peff.net>

Thanks for an excellent work, as always.  Will queue.
