From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH v3] refs: Use binary search to lookup refs faster
Date: Thu, 29 Sep 2011 19:13:08 -0600
Organization: CAF
Message-ID: <201109291913.34196.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <7vvcsbqa0k.fsf@alter.siamese.dyndns.org> <20110929221143.23806.25666.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Sep 30 03:13:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Rfa-0006f3-Qh
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 03:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756614Ab1I3BNi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 21:13:38 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:57669 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448Ab1I3BNg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 21:13:36 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6484"; a="123480371"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 29 Sep 2011 18:13:35 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 90FDF10004BE;
	Thu, 29 Sep 2011 18:13:35 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <20110929221143.23806.25666.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182459>

On Thursday, September 29, 2011 04:11:42 pm Julian Phillips=20
wrote:
> Currently we linearly search through lists of refs when
> we need to find a specific ref.  This can be very slow
> if we need to lookup a large number of refs.  By
> changing to a binary search we can make this faster.
>=20
> In order to be able to use a binary search we need to
> change from using linked lists to arrays, which we can
> manage using ALLOC_GROW.
>=20
> We can now also use the standard library qsort function
> to sort the refs arrays.
>=20

This works for me, however unfortunately, I cannot find any=20
scenarios where it improves anything over the previous fix=20
by Ren=E9.  :(

I tested many things, clones, fetches, fetch noops,=20
checkouts, garbage collection.  I am a bit surprised,=20
because I thought that my hack of a hash map did improve=20
still on checkouts on packed refs, but it could just be that=20
my hack was buggy and did not actually do a full orphan=20
check.

Thanks,

-Martin
