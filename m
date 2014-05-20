From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] t6006-*.sh: Fix truncation tests
Date: Tue, 20 May 2014 17:43:31 +0100
Message-ID: <537B8633.602@ramsay1.demon.co.uk>
References: <537B5E8C.3070803@ramsay1.demon.co.uk> <20140520141936.GA30187@ashu.dyn1.rarus.ru> <537B6E42.8040308@ramsay1.demon.co.uk> <20140520160213.GA2947@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 18:45:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmnAW-0003YE-Jy
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 18:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbaETQnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 12:43:37 -0400
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:45639 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750745AbaETQng (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 12:43:36 -0400
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id EFA18AC4093;
	Tue, 20 May 2014 17:43:38 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id B909AAC407F;
	Tue, 20 May 2014 17:43:38 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Tue, 20 May 2014 17:43:38 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140520160213.GA2947@ashu.dyn1.rarus.ru>
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249698>

On 20/05/14 17:02, Alexey Shumkin wrote:
> On Tue, May 20, 2014 at 04:01:22PM +0100, Ramsay Jones wrote:
>> On 20/05/14 15:19, Alexey Shumkin wrote:
>>> On Tue, May 20, 2014 at 02:54:20PM +0100, Ramsay Jones wrote:
>>>>
>>>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>>> ---
>>>>
>>>> Hi Alexey,
>>>>
>>>> If you need to re-roll your 'as/pretty-truncate' branch, could
>>>> you please squash the relevant parts of this patch into the
>>>> corresponding patches of your patch series. (ie this is a patch
>>>> against the head of the current pu branch ...).
>>>>
>>>> Without this patch I get:
>>>>
>>>>   $ ./t6006-rev-list-format.sh
>>>>   ok 1 - setup
>>>>   ok 2 - format percent
>>>>   ok 3 - format hash
>>>>   ok 4 - format tree
>>>>   ok 5 - format parents
>>>>   ok 6 - format author
>>>>   ok 7 - format committer
>>>>   ok 8 - format encoding
>>>>   ok 9 - format subject
>>>>   ./t6006-rev-list-format.sh: 152: ./t6006-rev-list-format.sh: Syntax error: "(" unexpected
>>>>   FATAL: Unexpected exit with code 2
>>>>   $ 
>>> Ooops, my fault.
>>>>
>>>> (if you have bash as /bin/sh you get different but related errors).
>>>> The additional quoting suppresses the 'command redirection' errors, etc...
>>> It's strange but I do have Bash as /bin/sh and unfortunately I have no
>>> this error
>>
>> Hmm, I see this:
>>
>>   $ bash t6006-rev-list-format.sh -i
> AFAIK, this is not "running Bash as /bin/sh" :)
> Maybe I'm wrong but Bash as /bin/sh is:
>   $ ls -l /bin/sh
>   lrwxrwxrwx 1 root root 4 May 12 18:35 /bin/sh -> bash

Ah yes, I keep forgetting that bash behaves differently when invoked as 'sh'.
(i.e. it enters 'posix mode' in this case).

Indeed, this is (roughly) equivalent to:

  $ bash --posix t6006-rev-list-format.sh
  ok 1 - setup
  ok 2 - format percent
  ok 3 - format hash
  ...
  ok 52 - oneline with empty message
  ok 53 - single-character name is parsed correctly
  # passed all 53 test(s)
  1..53
  $ 

... which works.

Thanks again.

ATB
Ramsay Jones
