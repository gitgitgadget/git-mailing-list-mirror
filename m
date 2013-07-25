From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/5] range-set and line-log bug fixes
Date: Thu, 25 Jul 2013 11:12:21 +0200
Message-ID: <51F0EBF5.80105@viscovery.net>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com> <CAPig+cRWaKv6UN5pZLwonXBpHnFE7+4ELXTnE+2nLr8h83bX6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 25 11:12:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2HbM-00073g-G7
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 11:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465Ab3GYJMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 05:12:44 -0400
Received: from so.liwest.at ([212.33.55.13]:52155 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754948Ab3GYJM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 05:12:28 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1V2Hav-0006s3-N3; Thu, 25 Jul 2013 11:12:21 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6C6BB1660F;
	Thu, 25 Jul 2013 11:12:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <CAPig+cRWaKv6UN5pZLwonXBpHnFE7+4ELXTnE+2nLr8h83bX6Q@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231128>

Am 7/25/2013 10:03, schrieb Eric Sunshine:
> The tests in this series identify real bugs in dealing with empty
> ranges, which the subsequent patches fix. The test are possible
> because one can specify an empty range via blame/log -L, however, I
> now realize that the ability for -L to create empty ranges was never
> intended or part of the design, but is in fact itself a bug.
...
> * Should we drop these new t4211 tests which guard against real potential bugs?
> 
> * Should we add custom C code to the test suite to make the
> empty-range testing possible?
> 
> * Should we introduce another (undocumented) loophole just for the
> sake of the tests?

IIUC, the tests you added are protecting the *implementation* of range-set
functions. For tests of the implementation, we usually write test-foo
programs that call the functions directly.

Tests invoking git should test the observable behavior. Therefore, if
calling a git utility with "-Lfoo,+0" should be an error, then the test
suite should mark such a call with test_must_fail. I guess this rules out
the loophole approach.

-- Hannes
