From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in
 prepare_revision_walk()
Date: Sat, 31 Mar 2012 16:45:21 -0700
Message-ID: <7vlimgibce.fsf@alter.siamese.dyndns.org>
References: <201203291818.49933.mfick@codeaurora.org>
 <7v7gy2q1kq.fsf@alter.siamese.dyndns.org>
 <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com>
 <20120330093207.GA12298@sigill.intra.peff.net>
 <20120330094052.GB12298@sigill.intra.peff.net>
 <4F7780F5.3060306@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Martin Fick <mfick@codeaurora.org>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Apr 01 01:46:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE7za-0003kE-Uf
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 01:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab2CaXpY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Mar 2012 19:45:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849Ab2CaXpX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Mar 2012 19:45:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10AEB74FC;
	Sat, 31 Mar 2012 19:45:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QQvEhUaD/qvF
	bZ5hAAdo8K/6DWY=; b=MiNR3ztg6gDVFntOsMzPj9T1kOu4dF/JjbMSUGM+KmC2
	Ix0sIpftlOUQuFVeJi1OtW9FM5BefNTW13Hy74o1Q3/r2jk+Bd3sVkeCpxvYsPB1
	NLgdbdC2+Xhd6EpdUdruppyZAhjI2tNRLxM2ND8sGIqrqmJq6E2MNSbv/IGxx90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mbysLc
	51L303BD4px01+9KybAKPlfur8lG+Ta07ZgfJAEbO5HoaMZaNFWIgfOwsrRmSY5l
	bm6ajdXwxzKCbOaonlVORHj8Q1drQhkbK83ms+IFWYBN3GhdWh2p+O3OdNgj/bSw
	PdhOwZsN4z8+aqTIcsLSi8TKhNxnToRrvpD6U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05FB474FB;
	Sat, 31 Mar 2012 19:45:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77BE674FA; Sat, 31 Mar 2012
 19:45:22 -0400 (EDT)
In-Reply-To: <4F7780F5.3060306@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sun, 01 Apr 2012 00:11:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94CDF5C2-7B8B-11E1-B897-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194471>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Speed up prepare_revision_walk() by adding commits without sorting
> to the commit_list and at the end sort the list in one go.  Thanks
> to mergesort() working behind the scenes, this is a lot faster for
> large numbers of commits than the current insert sort.

This is one of these moments I am reminded why I am grateful to have yo=
u
in the community.  The first message from you in a topic that needs to
touch a quite core part of the system often is not a participation in t=
he
discussion, but is a solution that is already well crafted.

Thanks, will queue.
