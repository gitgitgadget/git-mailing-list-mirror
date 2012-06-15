From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: exit(1) if 'diff --quiet <repo file> <external
 file>' finds changes
Date: Fri, 15 Jun 2012 13:10:14 -0700
Message-ID: <7vipes9w0p.fsf@alter.siamese.dyndns.org>
References: <1339781463-13536-1-git-send-email-tim.henigan@gmail.com>
 <7vzk849zxg.fsf@alter.siamese.dyndns.org>
 <20120615193724.GB26473@sigill.intra.peff.net>
 <CAFoueth2Hfcv0p0SZmichi_6e5--SNkemrSsSivnU73bdFOB4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 22:10:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfcqc-0004w6-MM
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 22:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757129Ab2FOUKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 16:10:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38345 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958Ab2FOUKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 16:10:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78F9F82C7;
	Fri, 15 Jun 2012 16:10:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MIKUtSSr7ZXLrzb8dPBxMtzNpe4=; b=G0FxpO
	K3HPXnNU+mHotroy1ImA2lxEEOpJDJ37VOWtIO7eab0gO76cUQPU/YKgwnQfGzCJ
	slurvvJDBQxvFZqEmGlmshnBu5flEyap6h9oeyg7YxhhTBPZKODuRHxZJEt+hjfv
	+ye+MplHRvKXFyAeHRHxNAzvmJPAIvYTaEU+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VbMQgQPerXIRSorQZBkCcCfPdj4h7Ng3
	cCF4KY7RQ7wDEdtmWNZ2y/Yc4CThBIEFLJdcgz0Ee41bIM8rzMyw97L5XcPjnMpp
	8OeuVMr13EJjqiDjFNs3rIlEV+ArtP8b8mJuHQ19EsWC1rYO2LPSHcFn2qqzecPA
	0r3ZRI1PONQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 710B782C6;
	Fri, 15 Jun 2012 16:10:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0915B82C3; Fri, 15 Jun 2012
 16:10:15 -0400 (EDT)
In-Reply-To: <CAFoueth2Hfcv0p0SZmichi_6e5--SNkemrSsSivnU73bdFOB4g@mail.gmail.com> (Tim
 Henigan's message of "Fri, 15 Jun 2012 15:56:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F5A3428-B726-11E1-874D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200090>

Tim Henigan <tim.henigan@gmail.com> writes:

> I will send v2 with the change to 'diff-no-index.c' suggested by
> Junio.  I will also include the 'test_expect_code' improvement
> suggested by Jeff.

Also the test script shouldn't be just testing a simplest case, I
would think.

For example, comparing two files with "a b c" and "a  b c" in them
with "--quiet" should yield "They are different!" while running the
same comparison with "--quiet -w" should say "They are the same!",
no?
