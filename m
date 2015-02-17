From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 06/12] commit: add tests of commit races
Date: Tue, 17 Feb 2015 16:06:37 +0100
Message-ID: <54E358FD.1090304@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>	<1423739543-1025-7-git-send-email-mhagger@alum.mit.edu> <xmqqoaoysz0o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 16:13:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNjqW-0005Ti-Tr
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 16:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbbBQPNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 10:13:52 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60920 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752760AbbBQPNw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 10:13:52 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Feb 2015 10:13:51 EST
X-AuditID: 1207440f-f792a6d000001284-45-54e359009024
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 5E.B9.04740.00953E45; Tue, 17 Feb 2015 10:06:40 -0500 (EST)
Received: from [192.168.69.130] (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HF6bad027231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 10:06:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <xmqqoaoysz0o.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqMsQ+TjE4MkvLouuK91MFg29V5gt
	3t5cwmjRPeUto0Vv3ydWi82b21kc2Dx2zrrL7rFgU6nHxUvKHp83yQWwRHHbJCWWlAVnpufp
	2yVwZ1zY9Zep4KlQReP1LcwNjH/5uhg5OSQETCS6v3SxQdhiEhfurQeyuTiEBC4zSlxb1cYO
	4Zxjkjiwaw0LSBWvgLbE7a7vTCA2i4CqxO+m7ewgNpuArsSinmawuKhAkMSh04+h6gUlTs58
	AmaLCKhJTGw7xAIylFmgjUni5L+dYKuFBewljj55zAhiCwmsYpRomVkNYnMKWEvcn/8bqIYD
	qEFdYv08IZAws4C8RPPW2cwTGAVmIVkxC6FqFpKqBYzMqxjlEnNKc3VzEzNzilOTdYuTE/Py
	Uot0TfRyM0v0UlNKNzFCApx/B2PXeplDjAIcjEo8vBYTHoUIsSaWFVfmHmKU5GBSEuUNCH4c
	IsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEt84PKMebklhZlVqUD5OS5mBREudVX6LuJySQnliS
	mp2aWpBaBJOV4eBQkuC9Hg7UKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K1Phi
	YKyCpHiA9t4HaectLkjMBYpCtJ5iVJQS570BkhAASWSU5sGNhaWtV4ziQF8K8zJGAFXxAFMe
	XPcroMFMQIPn/3kEMrgkESEl1cDIFXt3clDNii+zLsqWljzXLtrRmvdilnp6ttaa13fN9M0f
	fKl58v7MBS+z1zVhq04sXfnt8I5ahQc+eS96zwuwbe0MPVX1oizmEOu+ia/332pb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263947>

On 02/12/2015 08:36 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
>> new file mode 100755
>> index 0000000..08e6a6c
>> --- /dev/null
>> +++ b/t/t7516-commit-races.sh
>> @@ -0,0 +1,33 @@
>> +#!/bin/sh
>> +
>> +test_description='git commit races'
>> +. ./test-lib.sh
>> +
>> +test_tick
>> +
>> +test_expect_success 'set up editor' '
>> +	write_script editor <<-\EOF
>> +	git commit --allow-empty -m hare
>> +	echo tortoise >"$1"
>> +	EOF
>> +'
>> +
>> +test_expect_failure 'race to create orphan commit' '
>> +	test_must_fail env EDITOR=./editor git commit --allow-empty &&
>> +	git show -s --pretty=format:%s >subject &&
>> +	grep -q hare subject &&
> 
> Why "grep -q" in the test?  Normal invocation of the tests will hide
> the output anyway, no?
> 
> Wouldn't letting "sh tDDDD-name-of-test.sh -v" show the output
> better for those who are hunting for breakages to see at which step
> of the &&-chain things break?

Good point. I will remove the "-q" from the two grep invocations in this
file.

>> +	test -z "$(git show -s --pretty=format:%P)"
>> +'
> 
>> +test_expect_success 'race to create non-orphan commit' '
>> +	git checkout --orphan branch &&
>> +	git commit --allow-empty -m base &&
>> +	git rev-parse HEAD >base &&
>> +	test_must_fail env EDITOR=./editor git commit --allow-empty &&
>> +	git show -s --pretty=format:%s >subject &&
>> +	grep -q hare subject &&
> 
> Can we use a token different from hare and tortoise here?  If the
> previous one worked correctly, the main "commit" process would have
> failed to add 'tortoise' on top of 'hare' that raced from sideways
> (which is simulated by making 'hare' from the editor), so the tip of
> the history would be 'hare' when this test starts.  Expecting 'hare'
> here makes it unclear if you are expecting _both_ of the competing
> processes to fail (i.e. the main 'commit' fails to add 'tortoise'
> and the racing 'commit' fails to do 'hare'), leaving the 'hare' the
> previous test left at the tip of the history, or if you are expecting
> that the competing one that tries to create the second 'hare' on top
> of the existing 'hare' to win.

Yes, you're right. I will change the second test to use different tokens.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
