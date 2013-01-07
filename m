From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Mon, 07 Jan 2013 18:43:04 +0100
Message-ID: <50EB0928.3090901@web.de>
References: <201301012240.10722.tboegi@web.de> <20130102094635.GD9328@sigill.intra.peff.net> <7vtxqzyw0g.fsf@alter.siamese.dyndns.org> <7vpq1nyvp1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 18:43:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsGjh-0004tr-2T
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 18:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145Ab3AGRnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 12:43:19 -0500
Received: from mout.web.de ([212.227.15.4]:59529 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754131Ab3AGRnR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 12:43:17 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MRl5x-1TPUOH23A1-00Tcex; Mon, 07 Jan 2013 18:43:05
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vpq1nyvp1.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:c3wPoyS7y9VAYSxgffPG8Q8QMNaiuzj3Ot9seOsJsmg
 2TmWsDTA9xFJJwUp5gJU0+xvElP9GiQJujMzf6qASk3xjyZsII
 s0QkDHVOKIC8kL5jvlPZkF4OZmpBfJV1ZekFBM+llFtvufNhKF
 RoerCmc+Mem2tysz77Nn9FEybeWso7GWsLyx4hr8jMd6X2r90d
 KW/qjKp/7irDUDIxcMAng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212906>

On 03.01.13 01:08, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I would actually not add this to TEST_LINT by default, especially
>> when "duplicates" and "executable" that are much simpler and less
>> likely to hit false positives are not on by default.
>>
>> At least, a change to add this to TEST_LINT by default must wait to
>> be merged to any integration branch until all the fix-up topics that
>> this test triggers in the current codebase graduate to the branch.
>>
>>>> +test-lint-shell-syntax:
>>>> +	$(PERL_PATH) check-non-portable-shell.pl $(T)
>>>
>>> This is wrong if $(PERL_PATH) contains spaces, no?
>>
>> You are correct; "harness" thing in the same Makefile gets this
>> wrong, too.  I think the right invocation is:
>>
>> 	@'$(PERL_PATH_SQ)' check-non-portable.shell.pl $(T)
>>
>> although I do not offhand know if that symbol is already exported by
>> the top-level Makefile.
> 
> I'll tentatively queue this instead.  The log message has also been
> cleaned up a bit.

Sorry for late answer, but there is a problem (both linux and Mac OS X) :-(
$ make test-lint does not do shel syntax check, neither
$ make test-lint-shell-syntax

In the Makefile the the line 
	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T)
doesn't seem to anything (?)

Replacing @'$(PERL_PATH_SQ)' with $(PERL_PATH) gives the following,
expected result: (a very long line starting like this:)

$ make test-lint-shell-syntax
/usr/bin/perl check-non-portable-shell.pl t0000-basic.sh ......

confused...
/Torsten
