From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 2/5] t1500: test_rev_parse: facilitate future test
 enhancements
Date: Wed, 18 May 2016 18:38:27 +0200
Message-ID: <20160518183827.Horde.e7PY7wuh3iXKFZgoQ0oLR3D@webmail.informatik.kit.edu>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
 <20160517193630.10379-3-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 18 18:38:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b34Uk-0003Md-Jx
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 18:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbcERQiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 12:38:46 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:44108 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753453AbcERQiq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2016 12:38:46 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1b34Uc-0008Ud-10; Wed, 18 May 2016 18:38:42 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1b34UN-0002LT-BY; Wed, 18 May 2016 18:38:27 +0200
Received: from x590c0b33.dyn.telefonica.de (x590c0b33.dyn.telefonica.de
 [89.12.11.51]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 18 May 2016 18:38:27 +0200
In-Reply-To: <20160517193630.10379-3-sunshine@sunshineco.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1463589522.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294971>


Quoting Eric Sunshine <sunshine@sunshineco.com>:

> Tests run by test_rev_parse() are nearly identical; each invokes
> git-rev-parse with a single option and compares the result against an
> expected value. Such duplication makes it onerous to extend the tests
> since any change needs to be repeated in each test. Avoid the
> duplication by parameterizing the test and driving it via a for-loop.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t1500-rev-parse.sh | 44 +++++++++++++++++---------------------------
>  1 file changed, 17 insertions(+), 27 deletions(-)
>
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index 0194f54..c84f5c3 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh

> +	for o in is-bare-repository \
> +		 is-inside-git-dir \
> +		 is-inside-work-tree \
> +		 show-prefix \
> +		 git-dir
> +	do
> +		test $# -eq 0 && break
> +		expect="$1"
> +		test_expect_success "$name: $o" '
> +			echo "$expect" >expect &&
> +			git rev-parse --$o >actual &&

I think that "--$o" looks really weird, but that's subjective, of course.

However, the idea popped up in an other thread[1] that we might want
something like 'git rev-parse --absolute-path --git-dir', which wouldn't
really work with '--$o'.

Even if we don't go that route, perhaps it would be better to list the
options to be tested including their doubledash prefix.


[1] -  
http://thread.gmane.org/gmane.comp.version-control.git/287449/focus=292585
