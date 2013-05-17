From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/6] test-lib: refactor $GIT_SKIP_TESTS matching
Date: Fri, 17 May 2013 10:04:22 +0200
Message-ID: <87y5beav7d.fsf@linux-k42r.v.cablecom.net>
References: <cover.1368736093.git.trast@inf.ethz.ch>
	<9b7e6a882a21b7e1734ec6fd90d3cf0208bb68f1.1368736093.git.trast@inf.ethz.ch>
	<5195C4B1.3010201@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 17 10:04:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdFeU-0002do-GW
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 10:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab3EQIE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 04:04:29 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:9009 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123Ab3EQIEY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 04:04:24 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 17 May
 2013 10:04:19 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 17 May 2013 10:04:22 +0200
In-Reply-To: <5195C4B1.3010201@viscovery.net> (Johannes Sixt's message of
	"Fri, 17 May 2013 07:48:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224656>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 5/16/2013 22:50, schrieb Thomas Rast:
>> +match_pattern_list () {
>> +	arg="$1"
>> +	shift
>> +	test -z "$*" && return 1
>> +	for pat in $@
>
> You should have double-quotes around $@ here, but then you can just as
> well abbreviate to
>
> 	for pat
>
> and you don't need the 'test -z "$*' check anymore.

Hmm, actually the quotes wouldn't help, because it currently reads

-	for skp in $GIT_SKIP_TESTS
-	do
-		case $this_test.$test_count in
-		$skp)
-			to_skip=t
-			break
-		esac
-	done

so the splitting already happens, and in fact needs to, so that one can
pass multiple patterns.  Or am I missing something?

But the 'for pat' with implicit $@ sounds nice regardless, thanks.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
