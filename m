From: Junio C Hamano <gitster@pobox.com>
Subject: Re: grep --no-index and pathspec
Date: Fri, 11 Feb 2011 10:27:09 -0800
Message-ID: <7v8vxm1l6q.fsf@alter.siamese.dyndns.org>
References: <20110211095938.360726y1zinab9gk@webmail.df.eu>
 <4D55500B.1070603@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Noschinski <lars@public.noschinski.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 11 19:27:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnxiI-0002Om-4L
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 19:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757893Ab1BKS1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 13:27:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757887Ab1BKS1U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 13:27:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED08C4AAA;
	Fri, 11 Feb 2011 13:28:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iHwVOupV1VUtaF1lnoKCTrO82oo=; b=YaCYZn
	XBuSOkXCHNzy2VUY+SMvbVlc6EQybwu9ghXgq+4gt64I4vv3Aq5/0JKll+9JkeJ8
	p52x1/cRMsmfVqxJ5QJq0PQBqKbkK9I/s+CAqOvrjrS7YrX1xsCKtYQOPQksueQ7
	x46NGmasiwl66tggd5eBpfsAo9uA2bkrmwLHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bZDYz7JRIRbFeMy52MA6FZ5DulukjCpW
	/PqAEFFdFxQEQF5BHAvG7B8dTcoac2pJBPuVc2DJGQOsh2rjOv27r7kdvSPDWeIw
	tjEOYZFkYKZyGcZ/BG0rx0xuH3llgRga8gStQO50nECv/bT9dnsHbMgiWttdkbTM
	5lJEETdekNw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B37054AA2;
	Fri, 11 Feb 2011 13:28:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 62D5A4AA0; Fri, 11 Feb 2011
 13:28:13 -0500 (EST)
In-Reply-To: <4D55500B.1070603@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri\, 11 Feb 2011 16\:04\:43 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B2B57D46-360C-11E0-9D79-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166567>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> "grep --no-index" and "grep" have different codepaths for looking up the
> files/blobs. If I read that correctly then "grep --no-index -- pathspec"
> only does a literal match at the left boundary, whereas for the normal
> mode glob patterns are allowed.
>
> CC'ing Junio who created "--no-index".

Anything with --no-index is a quick hack, so I wouldn't be surprised if it
ignored the normal pathspec logic.  As I do not recall the details of the
particular codepath and offhand do not know how involved a change to pay
proper attention to the pathspecs would be, but I suspect that it would be
more appropriate to fix it on top of nd/struct-pathspec topic than writing
the current behaviour down in the documentation outside of BUGS section as
if it were a feature ;-).
