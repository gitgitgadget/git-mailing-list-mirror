From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 1/2] t/perf: time rev-list with UNINTERESTING commits
Date: Mon, 20 Jan 2014 23:32:12 +0100
Message-ID: <87ppnmb7yr.fsf@thomasrast.ch>
References: <20140120212845.GA11451@sigill.intra.peff.net>
	<20140120213101.GA16095@sigill.intra.peff.net>
	<20140120221142.GA24320@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 20 23:32:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5NOQ-0001Bv-QT
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 23:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbaATWc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 17:32:27 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:55228 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbaATWc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 17:32:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 9B65B4D657D;
	Mon, 20 Jan 2014 23:32:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id F6U2vPuROvog; Mon, 20 Jan 2014 23:32:13 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id AF5154D64BD;
	Mon, 20 Jan 2014 23:32:12 +0100 (CET)
In-Reply-To: <20140120221142.GA24320@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 20 Jan 2014 17:11:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240733>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 20, 2014 at 04:31:01PM -0500, Jeff King wrote:
>
>> diff --git a/t/perf/p0001-rev-list.sh b/t/perf/p0001-rev-list.sh
>> index 4f71a63..b7258a7 100755
>> --- a/t/perf/p0001-rev-list.sh
>> +++ b/t/perf/p0001-rev-list.sh
>> @@ -14,4 +14,21 @@ test_perf 'rev-list --all --objects' '
>>  	git rev-list --all --objects >/dev/null
>>  '
>>  
>> +test_expect_success 'create new unreferenced commit' '
>> +	git checkout --detach HEAD &&
>> +	echo content >>file &&
>> +	git add file &&
>> +	git commit -m detached &&
>> +	commit=$(git rev-parse --verify HEAD) &&
>> +	git checkout -
>> +'
>
> This is bad to be touching the repo and assuming it is non-bare. For
> some reason I assumed that the perf suite made a copy of the repo, but
> it doesn't. If you point to a bare repo via GIT_PERF_REPO, this part of
> the test fails.

It does make a copy, but with cp -Rl.  I haven't actually ever tried
what happens if you point it at a bare though.  It *should* fail because
it tries to cd $repo/.git, but if that was itself bare...

-- 
Thomas Rast
tr@thomasrast.ch
