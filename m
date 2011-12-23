From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Specify a precision for the length of a subject string
Date: Fri, 23 Dec 2011 12:58:00 -0800
Message-ID: <7v1urvc8fb.fsf@alter.siamese.dyndns.org>
References: <20111220220754.GC21353@llunet.cs.wisc.edu>
 <20111221043843.GA20714@sigill.intra.peff.net>
 <20111221145112.GA13097@llunet.cs.wisc.edu>
 <20111223100957.GA1247@sigill.intra.peff.net>
 <20111223103511.GA10029@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nathan.panike@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 23 21:58:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReCBs-0004Xz-JD
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 21:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757766Ab1LWU6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 15:58:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757715Ab1LWU6D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 15:58:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63B0654C1;
	Fri, 23 Dec 2011 15:58:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=45i5074NeWhyWWQf2rqh8bd7hJ8=; b=FBBhFT
	Or3aY2d4Bbu2yJysWKjwvc7iIpDPMB+7j13FYlOgtxdCJVjPgnA/zo6JmZnnhKE9
	mhl0/LOdzTy33QGNr15M/Zf5f6ZU48PSdjBEB/kbAdYNDljKztr+9FQJkEdmv4y9
	Wx71QQbnzyeENZ/jjeXFWCUAEMDfyHrF6rtx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MMddwQurZ4juBT118fyu/8Nou/Dpr5uJ
	aOsZlsO9sQEdXhOZJtk/Jd7uG2ZncxCvPVJLV8qT2HbCBPczBhZ5E6C6sHQUpHRq
	RgocGiA4pwds0e9FQGzhGX0m3JIP+4ckvHyg+bRMHXTQ+6eMPtzYBleSpQLd3P9q
	Clbc1fRpQS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44A0854C0;
	Fri, 23 Dec 2011 15:58:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5A8954BF; Fri, 23 Dec 2011
 15:58:01 -0500 (EST)
In-Reply-To: <20111223103511.GA10029@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 23 Dec 2011 05:35:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD3253BC-2DA8-11E1-939D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187641>

Jeff King <peff@peff.net> writes:

> Here's how I would have done it. Not involving %w at all, but applying
> equally to all placeholders.

Hmm, just curious why you rejected the %w() approach, as enhancing %w
sounded to me like a better approach at the design level, but that was a
knee-jerk reaction without inspecting the codepaths involved myself hence
not knowing the potential amount of work required.

>   - userformat_want_item should also respect the same magic (it already
>     duplicates some of the "-/+/ " magic. It might be nice to factor
>     that part out).

I recall this was a bit of a bear when I looked at the area last time.
