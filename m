From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 02/16] bisect: add test for the bisect algorithm
Date: Fri, 26 Feb 2016 22:38:40 +0100
Message-ID: <56D0C5E0.2020703@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
 <1456452282-10325-3-git-send-email-s-beyer@gmx.net>
 <CAP8UFD2szf46skWmgZi3kSkh3D0aeMPw4TagUQa7KZ-z6pHdAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 22:38:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZQ68-0007eq-HK
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 22:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933912AbcBZVir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 16:38:47 -0500
Received: from mout.gmx.net ([212.227.15.18]:61396 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176AbcBZVip (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 16:38:45 -0500
Received: from [192.168.178.43] ([188.108.247.176]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0Ln897-1ZzHP507Ib-00hJxm; Fri, 26 Feb 2016 22:38:42
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <CAP8UFD2szf46skWmgZi3kSkh3D0aeMPw4TagUQa7KZ-z6pHdAA@mail.gmail.com>
X-Provags-ID: V03:K0:s50OeGGiNiGLrEU+Hbzg7beqkdPK/ImaVHvhEPYrSTB0a8Q7tcv
 wby3KgsFou1KzevhYCqsJVfAuEZG4zLMqoBvDp6K4C0xZVe8tmYIaGhRl0nGiF97GvSezf6
 GHJl/i1t4EzYh0RFDQ3P94Ci18GvGojafv+tQSEQVHjQTIj27ECyaIrkS8HjTiKQ0PCbcsT
 6SF3MiLMUp1njlC5bSyqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xndS7CsrR9Q=:ocDJkChiP54JxRLlP2W4Wq
 xvUwDwSNdBMUh9Vf8ZXEMxF8boE5ccd0HeXn+eh8TpOIZBwAD6cMfsSF7NtVKIV+YiRtEtCah
 mU14EjYa/TOtiqKz6ihrymFsH0Ola5MjH+dIcyRDuEbaxefohHAxAcZQosBiySM6Wm4xb3SB3
 ralu//CY/TCJbczFp3s4/e6/XDUu4AbVlscNNyStE0jTL3h8gy9zEtuP0rGAKyB4C7vbPD4Jo
 frPJ7mGx4LnEYYyzU4wQ63+yi7Aem5m/u37Y5fXjhrtJobmqeQGljHq88uJ3c55bp5MgGTl2s
 3Rt7kLsLP2eoTfaPptmr1C9skWpduhRu+EtH1bMmxttJtxKN8RvOVoBX4+3sp2yAttQlKOR6y
 2NAEeLqrAHrODJVKK+6Nm36CdrCLdijramdmmpVo86Yx5l/G6UnF2a2POw3EwfLTh79kelTDT
 66SZGjRhIMhKqsEd9ufn1/MlGbwoUitxgcq+D1XOxXYH4ON8F5mzLGWIOFTMJHA5bOkMOo32C
 nX0379irjK7J6qXKHj2Adgx9tb1FxM0JV4SB1tNbd4ZnlyBB/SvQdZIFLaJl+Wt81vEV/EXWQ
 3TSjzRB8fvITLBgYNTVT9vQ4e0WO8KrOLQOuN/sqCCLS+GdcH5y4M4kzjHXmq77V0d4UP+BKn
 p9vgVCmMQZmKLVzmV0XWXp8cMyE9/KYxF6dE6u+B6sqbaBoo/79otzti5gp6C9zs0R987yjCo
 koMCg+kqZphY4HkEE41EnEXVornR4Kn82xoxugX7PJ9xEG9Ds6+hTGj3OHWkbff/kJa0pU/f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287624>

Hi Christian,

On 02/26/2016 07:53 AM, Christian Couder wrote:
>> +test_expect_success 'bisect algorithm works in linear history with an odd number of commits' '
>> +       git bisect start A7 &&
>> +       git bisect next &&
>> +       test "$(git rev-parse HEAD)" = "$(git rev-parse A3)" \
>> +         -o "$(git rev-parse HEAD)" = "$(git rev-parse A4)"
> 
> I thought that we should not use "-o" and "-a" but instead "|| test"
> and "&& test".

Why is this? I understand the && instead of -a thing (test atomicity),
however, for || this results in an ugly

+       git bisect next &&
+       ( test "$(git rev-parse HEAD)" = "$(git rev-parse A3)" ||
+         test "$(git rev-parse HEAD)" = "$(git rev-parse A4)" )

Right? (Otherwise a failure of e.g. "git bisect start A7" would run
the command after || (which may still be fine in some cases but is wrong
in most of the other cases).

However, what do you think about this?

diff --git a/t/t8010-bisect-algorithm.sh b/t/t8010-bisect-algorithm.sh
index bda59da..ae50e7c 100755
--- a/t/t8010-bisect-algorithm.sh
+++ b/t/t8010-bisect-algorithm.sh
@@ -8,6 +8,16 @@ exec </dev/null

 . ./test-lib.sh

+test_compare_rev () {
+       arg="$(git rev-parse "$1")"
+       shift
+       for rev
+       do
+               test "$arg" = "$(git rev-parse "$rev")" && return 0
+       done
+       return 1
+}
+
 test_expect_success 'set up a history for the test' '
        test_commit A1 A 1 &&
        test_commit A2 A 2 &&
@@ -48,27 +58,25 @@ test_expect_success 'set up a history for the test' '
 test_expect_success 'bisect algorithm works in linear history with an
odd number of commits' '
        git bisect start A7 &&
        git bisect next &&
-       test "$(git rev-parse HEAD)" = "$(git rev-parse A3)" \
-         -o "$(git rev-parse HEAD)" = "$(git rev-parse A4)"
+       test_compare_rev HEAD A3 A4
 '

and so on...
See
https://github.com/sbeyer/git/commit/2c224093ccee837a7f0f62f6af6a0a804d07c022

(test_compare_rev() could also go into test-lib.sh)

Cheers
Stephan
