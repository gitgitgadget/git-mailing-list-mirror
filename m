From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] perf-lib: fix start/stop of perf tests
Date: Sat, 29 Jun 2013 09:51:50 -0700
Message-ID: <87ppv4hnbt.fsf@linux-k42r.v.cablecom.net>
References: <1372513119-27384-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 29 18:52:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsyNf-0008Nb-MU
	for gcvg-git-2@plane.gmane.org; Sat, 29 Jun 2013 18:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020Ab3F2Qv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jun 2013 12:51:58 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:8669 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab3F2Qv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jun 2013 12:51:57 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 29 Jun
 2013 18:51:43 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.211.119) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Sat, 29 Jun 2013 18:51:53 +0200
In-Reply-To: <1372513119-27384-1-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Sat, 29 Jun 2013 15:38:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.211.119]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229253>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> ae75342 test-lib: rearrange start/end of test_expect_* and test_skip
> changed the way tests are started/stopped, but did not update the perf
> tests.  They were therefore giving the wrong output, because of the
> wrong test count.  Fix this by starting and stopping the tests
> correctly.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>

Doh!  Thanks for catching this.

>  t/perf/perf-lib.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index a816fbc..c61d535 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -150,6 +150,7 @@ exit $ret' >&3 2>&4
>  
>  
>  test_perf () {
> +	test_start_
>  	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
>  	test "$#" = 2 ||
>  	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
> @@ -187,7 +188,7 @@ test_perf () {
>  		base="$perf_results_dir"/"$perf_results_prefix$(basename "$0" .sh)"."$test_count"
>  		"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".times
>  	fi
> -	echo >&3 ""
> +	test_finish_
>  }
>  
>  # We extend test_done to print timings at the end (./run disables this

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
