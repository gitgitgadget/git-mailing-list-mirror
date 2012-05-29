From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v7 0/9] submodule: improve robustness of path handling
Date: Tue, 29 May 2012 21:21:18 +0200
Message-ID: <4FC521AE.1010707@web.de>
References: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com> <4FC3DAEF.1070508@web.de> <CAH3AnroT1vs-s==ykNyogq6gbVncY0pt5U1=fMp+b6B0jwG19Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, phil.hord@gmail.com,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Johannes Sixt <j6t@kdbg.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 21:22:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZRzV-00011k-VA
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 21:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174Ab2E2TV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 15:21:58 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:59397 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168Ab2E2TV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 15:21:57 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate03.web.de (Postfix) with ESMTP id 8CB8E1B53C234
	for <git@vger.kernel.org>; Tue, 29 May 2012 21:21:25 +0200 (CEST)
Received: from [192.168.178.48] ([79.193.81.60]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0McFgl-1SH6Jf2TSR-00JdID; Tue, 29 May 2012 21:21:25
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAH3AnroT1vs-s==ykNyogq6gbVncY0pt5U1=fMp+b6B0jwG19Q@mail.gmail.com>
X-Provags-ID: V02:K0:ZY9fz5CeOknflNHCZqg2EjstGeOSpwsRh8jD7arXpFi
 77cVYwTezaujSqAq2G9Y66wKvZaeqYEp9UZm1rKKl5k18yTAFj
 1iQYlqJ/wOUqr90JscTGsnccYxVbuxm3AUIwOT08S2FPJ45nk/
 a3PXkzhcNynYWC8GipRaqe1dWAwD/AHmr+3cmALEQ3B1j111HU
 Z4OmhGUAVFURDCdr2Hh7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198753>

Am 29.05.2012 00:01, schrieb Jon Seymour:
> On Tue, May 29, 2012 at 6:07 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> So I'd vote for just fixing the relative submodule path issues and to
>> not care about the possible issues with URLs. Opinions?
> 
> I'll write a minimal patch to solve my relative path problem without
> fixing the invalid/"greedy" submodule url or url normalization issues.

I'd really appreciate that.

> Do you have any comments about whether the failures documented in 2/9
> and 4/9 are worth noting, at least, as weaknesses?

Sure, they document known problems. Me thinks they all should be
squashed into a single patch and submitted separately. The following
three tests from 2/9 are redundant and can be dropped (they are
already handled by the '../../subrepo' case):

    '../../../subrepo fails with URL - ssh://hostname/repo' "
    '../../../../subrepo fails with with URL - ssh://hostname/repo' "
    '../../../../../subrepo fails with URL - ssh://hostname/repo' "

>> (And patches 6-8 contain changes to test cases other than just changing
>> test_expect_failure to test_expect_success which makes reviewing this
>> series unnecessarily hard)
> 
> Agree absolutely about patch 8 - I will re-roll with separate tests to
> document the test setup issue I fixed in 8.
> 
> The only other changes to tests in 6 and 7 were the removal of
> comments about the actual bad behaviour. Would your preference be that
> I removed these #actual comments completely or that I moved
> documentation of the actual behaviour to the header of the test?

I'd prefer just to see the failure => success changes, so the comments
look superfluous to me and should be dropped from the failure case.
