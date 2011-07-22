From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REGRESSION, BISECTED] `git checkout <branch>` started to be
 memory hog
Date: Fri, 22 Jul 2011 13:26:17 -0700
Message-ID: <7vaac6ysd2.fsf@alter.siamese.dyndns.org>
References: <20110722130518.GA9873@tugrik.mns.mnsspb.ru>
 <20110722170001.GB20700@sigill.intra.peff.net>
 <7vipquz0d0.fsf@alter.siamese.dyndns.org>
 <20110722173601.GA9422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Kirill Smelkov <kirr@mns.spb.ru>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 22 22:26:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkMIk-000781-1E
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 22:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083Ab1GVU0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 16:26:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132Ab1GVU0U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 16:26:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E11F2424B;
	Fri, 22 Jul 2011 16:26:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oZ4uo++Q/hDODOUSky7tBnGHPWY=; b=EfKSY3
	IG+z/BL4m7QFWfzTr3Yp6YWniBFQWXMuZloS+AK/mGNMRdZe8yL2Yc9xJSy4S1a/
	l3WA+g4bINUXPvXreQ3mKhcdAnzPOteHPsJEDDc52UVEn8T+ez0Kcv/v9NnAzmv1
	gMyzIbYo79/DDPji2Ly+eOe2HNXJuSZb8o92U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xePXd2Zrm/38w9N+kcNW2LkfXl2EoYQ5
	125VBADkUAPrs9iqW4HjPAZVQUdp8kwIuKEMG3E30FZUSzFDmvvwb33U3Y24J+KF
	jW71hQMd361gor0bvsU/zGcCaPLmL7Jmxxg1bv62+pRvoLRLbB74RHFBhtnhfCZj
	h/ygdc60//E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D88FD424A;
	Fri, 22 Jul 2011 16:26:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67B2B4249; Fri, 22 Jul 2011
 16:26:19 -0400 (EDT)
In-Reply-To: <20110722173601.GA9422@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Jul 2011 11:36:02 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBABED9E-B4A0-11E0-A77D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177663>

Jeff King <peff@peff.net> writes:

> Did you want me to write a commit message? I think you might do a better
> job of writing a coherent one for this particular patch.

I didn't do a very good job.

commit 06a21454b424d5bc0a36ed76ce46bb16ed156774
Author: Jeff King <peff@peff.net>
Date:   Fri Jul 22 11:00:03 2011 -0600

    streaming: free git_istream upon closing
    
    Kirill Smelkov noticed that post 1.7.6 "git checkout" started leaking
    tons of memory. close_istream() forgot to release its buffer and the
    caller was not freeing it, either.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

At least it needs your S-o-b ;-).
