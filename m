From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 ] commit -v: strip diffs and submodule shortlogs from the commit message
Date: Tue, 19 Nov 2013 12:34:33 -0800
Message-ID: <xmqqd2lw871i.fsf@gitster.dls.corp.google.com>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de>
	<loom.20131111T214646-550@post.gmane.org> <52814C35.6040205@web.de>
	<5281DCC5.2000209@kdbg.org> <5282A90A.4030900@web.de>
	<xmqqy54tfeje.fsf@gitster.dls.corp.google.com>
	<5283C701.8090400@web.de>
	<xmqq7gccdq67.fsf@gitster.dls.corp.google.com>
	<5287F735.3030306@web.de>
	<20131117090935.GC17016@sigill.intra.peff.net>
	<xmqqk3g5d7gy.fsf@gitster.dls.corp.google.com>
	<528BB23D.4020001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Ari Pollak <ari@debian.org>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 19 21:35:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vis13-0005RA-5I
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 21:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab3KSUfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 15:35:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34898 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab3KSUfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 15:35:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7188C520E7;
	Tue, 19 Nov 2013 15:35:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5440Qmg584ZlGC/+VLXiIfQsJHU=; b=IWl65a
	zt2WEj/oqxX9ztlSbrVof6O7XEV31El5o+UuA/DMJTepsUgBhLPCND992CnCYIJF
	v9+MCr2XqlwSeRGa5s7zV03yS70edyBaSupoKqMYy0o31ntEgcddRh6rrpLHhjDj
	JlexsXqAeTJacLvtV8ASvCBHaqFiq5RT6A6pg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k3RBKuPdzaTB51Lhf5IcSmb+lWrJ3Hi/
	tijFaufnOp2vVTrtcFtPzpGFyfFZ9yUs/TzMfZn2nyw5qSk3VOnN/k5jCHXa9thE
	htDEUbdfTyEES6oLty6DWeg3VpJS4Iu4bgmVIxR1VG6ZbjqqeEcN2cp1766yHsE9
	Lx47J8vQo7M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52915520E5;
	Tue, 19 Nov 2013 15:35:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F7D9520CA;
	Tue, 19 Nov 2013 15:34:37 -0500 (EST)
In-Reply-To: <528BB23D.4020001@web.de> (Jens Lehmann's message of "Tue, 19 Nov
	2013 19:47:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0BF4E200-515A-11E3-9AE9-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238040>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 18.11.2013 17:01, schrieb Junio C Hamano:
>> Jeff King <peff@peff.net> writes:
>> 
>>> I found this hard to parse, I think because of the "keeping" (why would
>>> I not keep it?), and because you are talking about lines above and
>>> below. It is not as accurate to say:
>>>
>>>   # ------------------ >8 --------------------
>>>   # Everything below this line will be removed.
>>>
>>> because it is technically the line above that is the cutoff. But I think
>>> the meaning is clear, and it is simpler to parse.
>
> Ok, changed in this version.
>
>> I agree with your rewording suggestion....
>
> Which is what my last version already did :-)  But it didn't mention
> that in the commit message, which it does now).

Oh, another thing. Does this interact with the core.commentChar in
any way, and if so how?
