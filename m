From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/9] Add a mode parameter to the remove_path function
Date: Sat, 10 Apr 2010 18:25:26 -0700
Message-ID: <7vfx32sruh.fsf@alter.siamese.dyndns.org>
References: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
 <1270923830-11830-7-git-send-email-peter@pcc.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Collingbourne <peter@pcc.me.uk>
X-From: git-owner@vger.kernel.org Sun Apr 11 03:25:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0lvv-0001ts-2p
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 03:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab0DKBZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 21:25:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab0DKBZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 21:25:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 850C1A9D7C;
	Sat, 10 Apr 2010 21:25:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=fiDejVnGpiD+Yg/kJYMAtQ1DbI0=; b=UuOwE+ofeqRMnxJp2+sIpQi
	Tq2tLQAXBvs8Am8Zr3Lh3kZH0c3AgFAmmqZJ1r4XX54yOEedIWLcwySzstCn6gCq
	QLDG1i0DjxAVlgwwASzCHTx+q4SdTS4M/a5Iu8Y10C/jnn7SJa0A7Ch4mOABjXXz
	2o8pTRzZSY8mWPMCM7yI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=lVSsTwwvu4ICFbdommRZii7yjg4T6349VHL2SNd1DNmh5Gb3o
	gZhtlnTHvmxu5wAWCzM3SS5JXaBmZPD/lqT0RO1MTXRvFAxiWZn+WAq+pct99emN
	hDlMMcdrXVDOlAdjfnxkEcqv6kWyWwZSGUI8acFz8zpyRTgVPkn7IJP0CM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 63D39A9D77;
	Sat, 10 Apr 2010 21:25:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05C1AA9D75; Sat, 10 Apr
 2010 21:25:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1E882316-4509-11DF-8F69-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144621>

Peter Collingbourne <peter@pcc.me.uk> writes:

> This patch adds a mode parameter to remove_path which determines
> whether unlink or rmdir is used.  All calls to remove_path have
> been modified to supply the mode parameter.
>
> This patch also adds a test case for a bug fixed by the addition
> of the mode parameter to remove_path.

When the mode of the thing on the filesystem doesn't match with what your
callers expect (e.g. the caller "merge-recursive" thought there should be
a gitlink but the filesystem actually had a plain file there), what should
happen?  What happens with your patch?
