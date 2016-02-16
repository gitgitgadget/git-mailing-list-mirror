From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the
 origin of a config value
Date: Tue, 16 Feb 2016 16:46:07 +0000
Message-ID: <56C3524F.3000504@ramsayjones.plus.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
 <1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
 <56C244D7.1030503@ramsayjones.plus.com>
 <20160215214049.GA10094@sigill.intra.peff.net>
 <56C253B8.1070702@ramsayjones.plus.com>
 <51832840-B879-4650-9DC5-E15EAA9919B9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	sschuberth@gmail.com, sunshine@sunshineco.com, hvoigt@hvoigt.net,
	sbeller@google.com, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 17:46:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVilc-0006sI-Am
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 17:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbcBPQqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 11:46:17 -0500
Received: from avasout07.plus.net ([84.93.230.235]:54751 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933112AbcBPQqP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 11:46:15 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id K4m91s0064mu3xa014mAnt; Tue, 16 Feb 2016 16:46:11 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=EBOSESyhAAAA:8 a=W5RpPGfKo7NaljfMNLsA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <51832840-B879-4650-9DC5-E15EAA9919B9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286407>



On 16/02/16 09:51, Lars Schneider wrote:
> 
> On 15 Feb 2016, at 23:39, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> 
>>
>>
>> On 15/02/16 21:40, Jeff King wrote:
>>> On Mon, Feb 15, 2016 at 09:36:23PM +0000, Ramsay Jones wrote:
>>>
>>>>> +test_expect_success '--show-origin stdin' '
>>>>> +	cat >expect <<-\EOF &&
>>>>> +		stdin:	user.custom=true
>>>>
>>>> So, as with the previous patch, I think this should be:
>>>> 		file:<stdin>	user.custom=true
>>>
>>> That's ambiguous with a file named "<stdin>", which was the point of
>>> having the two separate prefixes in the first place.
>>>
>>> I think in practice we _could_ get by with an ambiguous output (it's not
>>> like "<stdin>" is a common filename), but that was discussed earlier in
>>> the thread, and Lars decided to go for something unambiguous.
>>
>> sure, I just don't think it would cause a problem in practice.
>> How about using '-' for <stdin>? Hmm, you can actually create
>> such a file in the filesystem! Oh well, I guess its not a big deal.
>>
>>>
>>> That doesn't necessarily have to bleed over into the error messages,
>>> though (which could continue to use "<stdin>" if we want to put in a
>>> little extra code to covering the cases separately.
>>
>> Yep.

Sorry for not replying earlier - today has been hectic, so far.

> OK, I am happy to add the extra code. 

Unless I've missed something (quite possible), this patch does not
need to change. (you have (both) convinced me that your current
solution is the best).

The only change that I would suggest is the one-liner I already
suggested to the previous patch (plus the one-liner in the test,
of course. err ... so the two-liner!). Having said that, I didn't
try it out - I was just typing into my email client, so ...

>                                       However, out of curiosity, can
> you explain in what cases you actually use configs from stdin? I wasn't
> aware of this feature before working on this patch and I still wonder
> when I would use it.

Personally, I can't imagine ever using it. (I don't have a great
imagination. ;-)

Since I couldn't recall when this feature was added, I looked for
the commit that added it and found it was merged in commit 08f36302.
In particular, commit 3caec73b ("config: teach "git config --file -"
to read from the standard input", 19-02-2014) does not seem to
include any motivation for the change. The corresponding release
notes for v2.2.0 do not seem to add anything either.

So, I'm not much help here. :(

[Ah, looking at the date on the merge explains why I didn't
notice this.]

>                  If it is only a seldom used feature then I am not
> sure if adding the extra code to restore the existing error message
> is worth the effort?

ATB,
Ramsay Jones
