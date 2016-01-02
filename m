From: Beat Bolli <dev+git@drbeat.li>
Subject: Re: t6023 broken under Mac OS
Date: Sat, 2 Jan 2016 21:06:55 +0100
Message-ID: <56882DDF.2030701@drbeat.li>
References: <56869D10.9090105@web.de> <5686B400.7000800@ramsayjones.plus.com>
 <xmqqr3hzpyf5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 21:16:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aFSbY-0006ys-Kr
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jan 2016 21:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbcABUQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2016 15:16:45 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:49468 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbcABUQo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2016 15:16:44 -0500
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Jan 2016 15:16:43 EST
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id 43687C3445;
	Sat,  2 Jan 2016 21:06:56 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from mcmini.bolli (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 1710BC343D;
	Sat,  2 Jan 2016 21:06:56 +0100 (CET)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.0
In-Reply-To: <xmqqr3hzpyf5.fsf@gitster.mtv.corp.google.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283267>

On 02.01.16 20:35, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Hmm, I have never used a Mac, so I'm just guessing here, but
>> you could try something like (obviously untested!):
>>
>> diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
>> index 245359a..68b306f 100755
>> --- a/t/t6023-merge-file.sh
>> +++ b/t/t6023-merge-file.sh
>> @@ -350,7 +350,7 @@ test_expect_success 'conflict at EOF without LF resolved by --union' \
>>  test_expect_success 'conflict markers contain CRLF when core.eol=crlf' '
>>  	test_must_fail git -c core.eol=crlf merge-file -p \
>>  		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
>> -	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 3
>> +	test $(tr "\015" Q <output.txt | sed -n "/\.txtQ$/p" | wc -l) -eq 3
>>  '
>>  
>>  test_done
>>
>> [The 'wc -l' portability should only be a problem if you rely on the
>> exact textual form of the output, rather than the integer count.
>> 'wc -l' is used in many many tests ...]
> 
> Looks OK, thanks.
> 
> The use of the unportable '\r' with sed exists only in a stale topic
> parked on 'pu', so I won't worry about it myself at this point, but
> when the topic is rerolled, reviewers please be careful to spot it
> and stop it from introducing this bug to our tree.

I'll amend this topic once I find some time again...

Thanks.
