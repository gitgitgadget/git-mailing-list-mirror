From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2] pull: merge into unborn by fast-forwarding from empty tree
Date: Thu, 20 Jun 2013 15:20:33 +0200
Message-ID: <87zjuk6hr2.fsf@linux-k42r.v.cablecom.net>
References: <20130620124758.GA2376@sigill.intra.peff.net>
	<aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
	<20130620131547.GA11073@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	<git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 20 15:20:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upen4-0008IP-N4
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 15:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232Ab3FTNUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 09:20:37 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:47054 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965039Ab3FTNUg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 09:20:36 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 20 Jun
 2013 15:20:26 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 20 Jun 2013 15:20:34 +0200
In-Reply-To: <20130620131547.GA11073@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 20 Jun 2013 09:15:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228500>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 20, 2013 at 03:06:01PM +0200, Thomas Rast wrote:
>
>> +test_expect_success 'pulling into void does not overwrite staged files' '
>> +	git init cloned-staged-colliding &&
>> +	(
>> +		cd cloned-staged-colliding &&
>> +		echo "alternate content" >file &&
>> +		git add file &&
>> +		test_must_fail git pull .. master &&
>> +		echo "alternate content" >expect &&
>> +		test_cmp expect file &&
>> +		git cat-file blob :file >file.index &&
>> +		test_cmp expect file.index
>> +	)
>> +'
>
> I naively would have expected this to leave us in a conflicted state
> over "file".  But I guess read-tree just rejects it, because we are not
> doing a real three-way merge.  I'm not sure it is that big a deal; this
> is more about safety than about creating a conflicted/resolvable state.

Note that the test_must_fail essentially tests that the merge is rejected.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
