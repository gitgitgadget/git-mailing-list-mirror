From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git-subtree Ready #2
Date: Tue, 21 Feb 2012 10:07:44 +0100
Message-ID: <87sji4k10f.fsf@thomas.inf.ethz.ch>
References: <877gztmfwy.fsf@smith.obbligato.org>
	<8739acra5j.fsf@smith.obbligato.org>
	<20120215050855.GB29902@sigill.intra.peff.net>
	<87sjicpsr1.fsf@smith.obbligato.org>
	<87ty2ro1zf.fsf@smith.obbligato.org>
	<20120220205346.GA6335@sigill.intra.peff.net>
	<7vd399jdwc.fsf@alter.siamese.dyndns.org>
	<87ehtowxu7.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>, Avery Pennarun <apenwarr@gmail.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Feb 21 10:08:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzli1-0006bO-9Y
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 10:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab2BUJHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 04:07:51 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:25046 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086Ab2BUJHt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 04:07:49 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 21 Feb
 2012 10:07:45 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 21 Feb
 2012 10:07:45 +0100
In-Reply-To: <87ehtowxu7.fsf@smith.obbligato.org> (David A. Greene's message
	of "Mon, 20 Feb 2012 23:37:52 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191144>

greened@obbligato.org (David A. Greene) writes:

>> -GIT_BUILD_DIR="$TEST_DIRECTORY"/..
>> +
>> +if test -z "$GIT_BUILD_DIR"
>> +then
>> +    echo Here
>> +	# We allow tests to override this, in case they want to run tests
>> +	# outside of t/, e.g. for running tests on the test library
>> +	# itself.
>> +        GIT_BUILD_DIR="$TEST_DIRECTORY"/..
>> +fi
>
> I'll put a patch together with a more extensive explanation.  Basically,
> tests run outside of the top-level t/ directory don't work because there
> are all sort of assumptions in test-lib.sh about where they live.  There
> are comments in test-lib.sh indicating that it should support tests in
> other directories but I could not make it work out of the box.

Note that this will conflict with tr/perftest, which is already in next.
It had a similar override, but then made do with the existing
GIT_TEST_INSTALLED facility.  I think you do need the above here,
because you are not sourcing test-lib from the directory where the test
lives.  It may then be cleaner to again use GIT_BUILD_DIR in
t/perf/perf-lib.sh since it does not require knowledge (outside of
test-lib) that $GIT_BUILD_DIR/bin-wrappers/ holds the binaries.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
