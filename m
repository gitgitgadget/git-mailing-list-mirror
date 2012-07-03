From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add test case for rebase of empty commit
Date: Tue, 03 Jul 2012 12:00:27 -0700
Message-ID: <7vtxxovfec.fsf@alter.siamese.dyndns.org>
References: <1340814121-23813-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vr4t079jp.fsf@alter.siamese.dyndns.org>
 <20120703182000.GB10864@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 21:00:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm8Ky-00085t-GB
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 21:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933044Ab2GCTAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 15:00:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64485 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932767Ab2GCTAa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 15:00:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9A4C8015;
	Tue,  3 Jul 2012 15:00:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o/huG5jP7BdoTnIMBg1VqHJoZLE=; b=QgRx8T
	V1WhP7ElZ5KQCfzEqg04vEenGQ9Iv5mAlnGtMxPlKkbCv+I6CPlpVUtTjaTkmIw5
	5otpPUJO8z7/lv7fVKe0mTCdw84xXCT5OcevfvNwamI9vN77jXflJ15HzxbgpPLj
	dNApYD0RLnCp1c2lDXD1cpdmjR9gE/sEAsE20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oO+KcBoY/HbPYYGS/5WTs1brIMA64Hcq
	yxNyQMoubWeY10DG2QwieYaZdKgcCGtf4IRXDGIzPNdwp8MJYJ+ZOJWx4Ii+4cl9
	eQpj0SxcB4J65ROjI9uKxdMCTksuMgKYBkioiR3f6UIA8Q3bVKzxvKUpP1RHuRj0
	ubM7GKo8mYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D09EB8014;
	Tue,  3 Jul 2012 15:00:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E12F8010; Tue,  3 Jul 2012
 15:00:29 -0400 (EDT)
In-Reply-To: <20120703182000.GB10864@hmsreliant.think-freely.org> (Neil
 Horman's message of "Tue, 3 Jul 2012 14:20:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B597686-C541-11E1-8001-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200933>

Neil Horman <nhorman@tuxdriver.com> writes:

> So, I've been thinking about this some, and I'm a bit stuck on it.  Reading the
> test description for t3401, I see that we're testing gits ability to detect
> patches merged upstream when doing a rebase.  That said, how are we supposed to
> differentiate between upstream empty patches that have been cherry-picked or
> merged, and local branch empty changes that haven't.  As humans we can see that
> the changelog might be the same, but git has no way to detect that, and if
> --allow-empty is specified will just apply any empty patch it finds between the
> two branches merge base and the topic branch head.  Does anyone have an idea as
> to how we should detect such duplication?

The changelog might be similar or textually identical, but it is
entirely a different matter if it makes sense taken out of the
context (i.e. cherry-picked).  So I would personally do not bother
"filtering" about them too much---if you ask for empties, you will
get all empties.
