From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t6044 broken on pu
Date: Sat, 07 May 2016 19:21:32 -0700
Message-ID: <xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
	<878tzmrrfg.fsf@linux-m68k.org>
	<d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, newren@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun May 08 04:21:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azELn-0004M5-PK
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 04:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbcEHCVg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2016 22:21:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64590 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751141AbcEHCVg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2016 22:21:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94AA718629;
	Sat,  7 May 2016 22:21:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZQ2WEq6T+58Y
	QMftXhXeSGZELlw=; b=ZHf31gAkpmvswx/u0ggt+BXeSOZVSZIwUah9Qs/8Pehu
	Bjq6vS51zXcH2k93lwdpN9y6umfCJLtzDTEnTET1nLMz42yz6HRatWa94s7KvYsk
	Mm3QDS6DS6NPuivEgyeoZMxE9qc63rq1iyi0Fup9gjX3kfEFkzLFU6MSjik/Q3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jAQczD
	6UfD4DkMVeFfdplsfH1OGr8Z9k8ddci1I7SKpNy0OR2XAA8LylmiLndSEOBTN8lX
	yr+oteV0dyV7YMDHHroBE54n2upP6ArhFqVsTvLjx/+Hr8nYNtnpeHU3bCqAtFuX
	u7z01xqitU4uEUpLJPBkr892daAZfWmhofurE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D51418628;
	Sat,  7 May 2016 22:21:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 121BB18627;
	Sat,  7 May 2016 22:21:34 -0400 (EDT)
In-Reply-To: <d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sat, 7 May 2016 18:18:30
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 95819638-14C3-11E6-82AE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293907>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> That's true, but the test passes anyway.

You can also remove the body of the test and replace it with "true"
and say "the test passes anyway".  Changing the test to use a file
with only one line is irresponsible, if you do not know the nature
of expected future bug that requires 10 lines to be there to
manifest that the test wants to try.

test_seq was invented exactly for the purpose of accomodating
platforms that lack seq, so using it would probably be the best
first step.  Updating implementation of test_seq to avoid $PERL
would be a separate step, if desired (I personally do not think
that is worth it).
