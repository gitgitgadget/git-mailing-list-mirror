From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/6] rev-list/log: document logic with several limiting
 options
Date: Thu, 13 Sep 2012 13:18:39 -0700
Message-ID: <7vr4q57k2o.fsf@alter.siamese.dyndns.org>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
 <cover.1347544259.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 13 22:18:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCFsB-0002UZ-O6
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 22:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757840Ab2IMUSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 16:18:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756091Ab2IMUSm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 16:18:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A09BD94CD;
	Thu, 13 Sep 2012 16:18:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Z/SkjmRvi1FKuomoFEtwACYDFs=; b=kEpCBN
	9nyNJTrLwYc4bpz3JRmtuaewDi0kporx62UNCv4HOJhrxWmPH5qdoMwryAUpLZv/
	Pzy0s+dtq2SOu9kZMJYhlEzlrzAaFTylqaylCgJUum3FiGlVJ+lZfrP/hWI2R10I
	c652rZsUsW5NUsJsu0Yl+BVZOVJP8tlq5a8Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vOR4g7RTIrgSy/KZfcVsUGj7LxKPFE9y
	MYMl/5vHZR4RhN2QO3oh+pg3/6qb9AHAVhMz/yT8cyei/2SbK0OVkCyb10rVuVqk
	7fXimLeSEDPSkAQ8R3ElEeLLokGK+9sH/1BnuGFJ7auPULAKASaKBw7oskM1z9vH
	P+5dvKOmltI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D7FC94CC;
	Thu, 13 Sep 2012 16:18:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CF1394CB; Thu, 13 Sep 2012
 16:18:40 -0400 (EDT)
In-Reply-To: <cover.1347544259.git.git@drmicha.warpmail.net> (Michael J.
 Gruber's message of "Thu, 13 Sep 2012 16:04:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 358A8D32-FDE0-11E1-BDEB-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205417>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> So, this turned out to be a bit longer.
> I decided not to implement "--debug" for "git log --grep" and such
> because the current code does a lot of special casing, so that the
> existing debug code happily outputs OR nodes in cases where the code
> in grep.c effectively does AND (without changing the expression nodes).

Is that something we (not necessarily you) would want to fix?  How
many are they?

The reason I am asking is because I do not think of any.  The entire
document is considered unmatched unless all of the OR nodes in the
top-level backbone have triggered for some line in the document when
"all-match" is in effect, but that is quite different from turning
OR nodes into AND nodes (they both are about "does this line match
the pattern?"), so...
