From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Tue, 21 May 2013 08:36:18 -0700
Message-ID: <7vppwkqr9p.fsf@alter.siamese.dyndns.org>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
	<87hahwajgl.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 21 17:36:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueoc0-0001SA-Sm
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 17:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685Ab3EUPgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 11:36:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754677Ab3EUPgU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 11:36:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 522462076C;
	Tue, 21 May 2013 15:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mTmD4Ze3X+cVoGqRktT/yiGbZfc=; b=hgT/hI
	FU/A9TH+MwK7HLdrakPO9LD0OcMx2glvQBWo7+js8uvcY8Az2lAS3NCjIGBEjfr1
	8eDBuRKI7hMxTTx2Rhpo7nQpgsuRPQ5bioFNFyfzXKUvrAQb3KADxKKoGwVLzi/q
	QxYMv8vEkzx/4uVUTARlxH+uBVZqx7yPeuK3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lJyjDYaOTWPRU2oCIzxMi21CYeqTecyW
	GWBY+tDpyE2KVKCpUAYaNl1cdcREi6lDeItRXeYpIIgrA3mMH6xOq/f/SCwWVvG+
	Z0LUOzhqkuKGHjzd4CEYmPZ1dkPnIZwoegnvgwXTt4Ody7isL89GvjUR7bj/iztK
	8xDnCQubhFE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 465342076A;
	Tue, 21 May 2013 15:36:20 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4A7520767;
	Tue, 21 May 2013 15:36:19 +0000 (UTC)
In-Reply-To: <87hahwajgl.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Tue, 21 May 2013 09:19:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2EF6D64A-C22C-11E2-B0E8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225034>

Thomas Rast <trast@inf.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * tr/test-v-and-v-subtest-only (2013-05-16) 6 commits
>>  - test-lib: support running tests under valgrind in parallel
>>  - test-lib: allow prefixing a custom string before "ok N" etc.
>>  - test-lib: valgrind for only tests matching a pattern
>>  - test-lib: verbose mode for only tests matching a pattern
>>  - test-lib: refactor $GIT_SKIP_TESTS matching
>>  - test-lib: enable MALLOC_* for the actual tests
>>
>>  Allows N instances of tests run in parallel, each running 1/N parts
>>  of the test suite under Valgrind, to speed things up.
>>
>>  The tip one may be useful in practice but is a tad ugly ;-)
>
> I was hoping for some success stories ;-)
>
> I think Peff (who I stupidly managed to not Cc in the series, there's
> another git-send-email usability issue there) asked for the third from
> the tip, which lets you run valgrind only on a certain test.  (For

Yes, I think that that change is a very good thing to do.

> example, if you've already had two coffees while your computer found out
> which test it was, this is a much faster way of seeing if the failure
> disappeared.)
>
> So one obvious way of going forward is cooking this for a while and
> seeing whether people find the one-test-only or the massively-parallel
> feature useful (or maybe both).
>
> [To anyone who just reads this, but did not see the original series, I
> should also point out that this only applies within a tNNNN-foo.sh test
> file.  You can already parallelize a full valgrind test run much better
> than the above.]
