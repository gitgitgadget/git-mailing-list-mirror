From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] name-rev: --weight option (WIP)
Date: Wed, 29 Aug 2012 21:15:02 -0700
Message-ID: <7v4nnluibd.fsf@alter.siamese.dyndns.org>
References: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
 <1346275044-10171-1-git-send-email-gitster@pobox.com>
 <1346275044-10171-4-git-send-email-gitster@pobox.com>
 <7vligxuv6l.fsf@alter.siamese.dyndns.org>
 <20120830033611.GA32268@sigill.intra.peff.net>
 <7vharlujaq.fsf@alter.siamese.dyndns.org>
 <20120830035552.GC32268@sigill.intra.peff.net>
 <7v8vcxuiil.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 30 06:15:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6wAW-0004Wx-Pw
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 06:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755Ab2H3EPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 00:15:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61051 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711Ab2H3EPF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 00:15:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DFDE8F23;
	Thu, 30 Aug 2012 00:15:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eMQt3csPSPgSFLR1xOCZGnrJKrw=; b=JMsc7g
	f/aKdgcjvp30FEZNl7iCy2nUlrcmdAYJaY+HHnbxJe4/wr8QcT7QjUry9c3a1K20
	oIdknjSVOB9u+FeuoOoG72Hapnf7XUzJb6+apqf7vzSK2AcyUTwU32z2JTmxyYSF
	vuC6/87n0TRt1ZwYtuJAZ4rwkfuA84sXDDNnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L1PrhD5YvbMifd+YpknVcnebZMgDYPNa
	+OVhy0aLcdwuXcmC9ClVaJVN+A/9oCcpUtA00G1oqFPU+T+lCFxHm4ygEc0HlVBF
	X1G7KB3D3YWuv3Go52h3bcL3F34g7bUhsWrSWeOBSh4u+VzcfcaqAWDlZAQAints
	mr2Gw6H71lM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77C818F22;
	Thu, 30 Aug 2012 00:15:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8AD98F20; Thu, 30 Aug 2012
 00:15:03 -0400 (EDT)
In-Reply-To: <7v8vcxuiil.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 29 Aug 2012 21:10:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4600DADC-F259-11E1-8DC9-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204521>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> OK. I didn't think too hard about it, so I'll trust you that it is not
>> easy. I wonder if using the generation number would be another way of
>> defining "oldest" that would be easier to calculate.
>
> Go back to my illustration to Greg and think about the implication
> of "TONS!" side branch in the picture has on the generation numbers.

That is, we want some number (I called it "weight") that grows when
"TONS!" side branch is heavy.  Generation numbers are about giving
larger numbers for _longer_ chains, but a long and thin side branch
does not contribute as much as a medium length but a very fat side
branch when merged.

So generation numbers might be a candidate for approximation, but I
do not think it will give us a _good_ approximation.
