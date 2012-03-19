From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: don't require both bad and good when bisecting
Date: Mon, 19 Mar 2012 09:49:21 -0700
Message-ID: <7vobrsbkoe.fsf@alter.siamese.dyndns.org>
References: <20120318212957.GS1219@chaosreigns.com> <4F67468B.4070502@op5.se>
 <20120319153006.GD24848@sigill.intra.peff.net> <4F675DD3.3040004@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, darxus@chaosreigns.com,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Mar 19 17:49:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9flx-0005AA-QJ
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 17:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161976Ab2CSQtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 12:49:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60466 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030563Ab2CSQtY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 12:49:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 977717628;
	Mon, 19 Mar 2012 12:49:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+U8t9GSVHzAmxeAJOzaoEG7o0Yo=; b=RlSXfQ
	w3SRO8YBZ3qO3Y5Fea+rkm6vCT+k8qmhyjrR16SftoYlciq3QdjQ3j9Y76L3oJJT
	xOaCXgWo8sIiVBPaMjqX76xsbo3iHCGcc9zVX2TV5EryAbr3aO51a+GYha9VhqVE
	PHDCNeHTz4k1QRi63xk57GujrO2ydzjaYq1qw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wO+/MIEbwH7K0uurc7bAtQy/t+J5UGjG
	GvM6R0lgHZxOTlct4jmZE0NYNTm8vH2JMuA3vRAH0K4VeRgTmbgFrs/27YHyRssi
	gp8Fjdv2RoWHhgE8MExgLM2so2qDa6Px+HuoJ8Aq2emiXDiEczIvx3TqPv3yVLnF
	NS7cHq9Ndps=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F3207627;
	Mon, 19 Mar 2012 12:49:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9D117626; Mon, 19 Mar 2012
 12:49:22 -0400 (EDT)
In-Reply-To: <4F675DD3.3040004@op5.se> (Andreas Ericsson's message of "Mon,
 19 Mar 2012 17:24:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AB07324-71E3-11E1-850C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193439>

Andreas Ericsson <ae@op5.se> writes:

> It's sort of beside the point though. Using git as experiment (again),
> we're looking at less than 30000 revisions and 289 non-rc tags. With only
> 30k revisions, you'll do *worse* testing 15 tags sequentially than you
> would by just letting the bisection machinery get on with it and use
> the full history as base for bisection.

I think you are missing the primary point in what Jeff said.

It does not matter if you inspect increasingly older versions based on
exponentially longer strides or if you test tagged releases. What matters
is to making intelligent determination after seeing a failure, between the
failure due to "the feature being tested did not even exist" and "the
feature when introduced was good but at this commit it is broken".
