From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] mergetool: reorder vim/gvim buffers in three-way diffs
Date: Wed, 10 Feb 2016 15:40:31 +0100
Message-ID: <56BB4BDF.3010407@drmicha.warpmail.net>
References: <1454033894-49954-1-git-send-email-dicksonwong@gmail.com>
 <xmqq1t90jkcr.fsf@gitster.mtv.corp.google.com>
 <xmqqr3gl1pyw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>,
	Dickson Wong <dicksonwong@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 15:40:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTVwc-0005Bx-Ho
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 15:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbcBJOke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 09:40:34 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55478 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750713AbcBJOkd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2016 09:40:33 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 3DC182233D
	for <git@vger.kernel.org>; Wed, 10 Feb 2016 09:40:33 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 10 Feb 2016 09:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=oJrW5gmXQdXrZ9yf3mMJVxGSDNM=; b=ars/sB
	linIDKDMEA5EvVZ/Vxl5W83LKNNoGzHJTzEJenqlytwScdBMJ5wrfVXcqF4lefFR
	k4boTkSumtYOm4eDvVgoNImF1Y2i+JRATwaZS2ebuRrzp1UO0C1vakVDAJqMxWb6
	TACXFJXi7TyK4hIhPFJA4er5nn8CPWEcsTWsk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=oJrW5gmXQdXrZ9y
	f3mMJVxGSDNM=; b=CoueB4YhJM7Bjjlw3cKk4J9vOippngC+65RUHMsphx5cyqV
	wvXI6xckqPQ5YRgYPUpc/dip9EVL7aeyZ+CigtltGMw7iyEuGmAjtOfatDAVsKSW
	4hL8M94mFLh+mO4KbZ4s0Ch7qLlPJa96yILRLb6M5wfnfWFYuOBgXixr4GRE=
X-Sasl-enc: P6x99n+kJUKqL9KJi4q8dm+LpaVJ7VmazwMtS8dTGE7r 1455115232
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8B97F680107;
	Wed, 10 Feb 2016 09:40:32 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqqr3gl1pyw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285901>

Junio C Hamano venit, vidit, dixit 09.02.2016 23:25:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Dickson Wong <dicksonwong@gmail.com> writes:
>>
>>> When invoking default (g)vimdiff three-way merge, the merged file is
>>> loaded as the first buffer but moved to the bottom as the fourth window.
>>> This causes a disconnect between vim commands that operate on window
>>> positions (e.g. CTRL-W_w) and those that operate on buffer index (e.g.
>>> do/dp).
>>>
>>> This change reorders the buffers to have the same index as windows while
>>> keeping the cursor default to the merged result as the bottom window.
>>>
>>> Signed-off-by: Dickson Wong <dicksonwong@gmail.com>
>>> ---
>>
>> David, I unfortunately do not use 'mergetools' myself and certainly
>> not vimdiff.
>>
>> Opinions?
> 
> Second call for help.  Any comments on this from anybody other than
> the author that I missed to support this change?
> 

OK, applied it (on top of next), looks sane and improves the situation
for the majority of people who read left to right, then top down and
assign buffers 1 2 3 4 "mentally" to local base remote merge windows
based on that. Their expectation is met now. Thanks!

(Also, the other vim variants don't need a corresponding change.)

Michael

>>
>>>  mergetools/vimdiff | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
>>> index 1ddfbfc..74ea6d5 100644
>>> --- a/mergetools/vimdiff
>>> +++ b/mergetools/vimdiff
>>> @@ -2,22 +2,22 @@ diff_cmd () {
>>>  	"$merge_tool_path" -R -f -d \
>>>  		-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
>>>  }
>>>  
>>>  merge_cmd () {
>>>  	touch "$BACKUP"
>>>  	case "$1" in
>>>  	gvimdiff|vimdiff)
>>>  		if $base_present
>>>  		then
>>> -			"$merge_tool_path" -f -d -c 'wincmd J' \
>>> -				"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
>>> +			"$merge_tool_path" -f -d -c '4wincmd w | wincmd J' \
>>> +				"$LOCAL" "$BASE" "$REMOTE" "$MERGED"
>>>  		else
>>>  			"$merge_tool_path" -f -d -c 'wincmd l' \
>>>  				"$LOCAL" "$MERGED" "$REMOTE"
>>>  		fi
>>>  		;;
>>>  	gvimdiff2|vimdiff2)
>>>  		"$merge_tool_path" -f -d -c 'wincmd l' \
>>>  			"$LOCAL" "$MERGED" "$REMOTE"
>>>  		;;
>>>  	gvimdiff3|vimdiff3)
