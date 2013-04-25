From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/3] remote: add a test for extra arguments, according to docs
Date: Thu, 25 Apr 2013 09:23:34 +0200
Message-ID: <87obd3cbux.fsf@linux-k42r.v.cablecom.net>
References: <cover.1366811347.git.trast@inf.ethz.ch>
	<372aa93e4a7a3583730c02543583ce93e095ec64.1366811347.git.trast@inf.ethz.ch>
	<7vhaiva9u5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 09:23:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVGWu-00044Q-9o
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 09:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200Ab3DYHXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 03:23:40 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:25818 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754032Ab3DYHXj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 03:23:39 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 25 Apr
 2013 09:23:33 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 25 Apr 2013 09:23:35 +0200
In-Reply-To: <7vhaiva9u5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 24 Apr 2013 14:37:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222350>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> +test_extra_arg () {
>> +	expect="success"
>> +	if test "z$1" = "z-f"; then
>> +		expect=failure
>> +		shift
>> +	fi
>> +	test_expect_$expect "extra args: $*" "
>> +		test_must_fail git remote $* bogus_extra_arg 2>actual &&
>> +		grep '^usage:' actual
>> +	"
>> +}
>> +
>> +test_extra_arg -f add nick url
>> +test_extra_arg rename origin newname
>
> Perhaps just a taste in readability thing, but I would prefer to see
> them more like
>
> 	test_extra_arg_expect failure add nick url
> 	test_extra_arg_expect success rename origin newname
>
> than misunderstanding-inviting "-f" that often stands for "--force".

Hmm.  I had that at first, but then the final cleanup would have had to
touch all tests to remove the optional argument, making it noisy.

Anyway, it's probably all a bit over-engineered for only one effective
code change ;-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
