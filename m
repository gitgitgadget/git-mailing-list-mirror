From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange effect merging empty file
Date: Thu, 22 Mar 2012 10:03:02 -0700
Message-ID: <7vty1gy3eh.fsf@alter.siamese.dyndns.org>
References: <4F69AD3C.4070203@ericsson.com> <4F69B375.5050205@in.waw.pl>
 <86iphwomnq.fsf@red.stonehenge.com> <4F6B1F48.3040007@in.waw.pl>
 <20120322140140.GA8803@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 18:03:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAlQ7-0008FY-UH
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 18:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031003Ab2CVRDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 13:03:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031000Ab2CVRDE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 13:03:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4367A6677;
	Thu, 22 Mar 2012 13:03:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=htkVfx//rSrV1s9Ul6s64Dytgu8=; b=ye6xMS
	s4TteNAqfjT8bj3crZzoLTppOh0lp/5jE3dAWThM0gkV2AoXvtm8VAKpGN+bseIX
	RdRakgM4OsdbxhpWxD/mD3FwqJJzRHwMvITcxvOgxd3zIThiMRUalw0pA1HPMLlm
	d2Pah4PAHNCVky58BtUw5s3Do5ZSbkDC4/m3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S7qLMI6GN0q41oTOw1jj/kHmv00dr+ay
	qhVROPlf2t7pKe6S91YX4SbORp1fBjR9Mwq1ULI9Hl+mRUsUsB6XIu/e6bwHqpmd
	Xb5IUoOSiBYlFNWGlSMdT4VNoMmPKaVKQnvZPa7uvLS34ET9xdwQoW47lAeW4d+3
	2VoaZA39LFg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 396436676;
	Thu, 22 Mar 2012 13:03:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C63BA6675; Thu, 22 Mar 2012
 13:03:03 -0400 (EDT)
In-Reply-To: <20120322140140.GA8803@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 22 Mar 2012 10:01:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3504A76-7440-11E1-80BB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193668>

Jeff King <peff@peff.net> writes:

> I was thinking the same thing. And it seems this came up once before,
> and the list seemed to favor special-casing merge-recursive (but not
> diffcore):
>
>   http://thread.gmane.org/gmane.comp.version-control.git/116917/focus=117082

Yeah, thanks for digging up the old thread. I was looking at the patch to
merge-recursive from Dscho on that thread and I think it identified the
place that needs patching correctly. I was on a tablet, without the access
to the surrounding code outside the patch context, so I do not know if the
logic to detect the pure-rename of an empty file in the patch was correct,
or the patch still applies to the current codebase, though.
