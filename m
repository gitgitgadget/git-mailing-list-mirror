From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] test-lib: quote TRASH_DIRECTORY
Date: Fri, 4 Mar 2016 14:03:15 +0100
Message-ID: <56D98793.9000708@drmicha.warpmail.net>
References: <cover.1457088499.git.git@drmicha.warpmail.net>
 <a07529d116612bcd1c411a697f8f8e37d7c18d3f.1457088499.git.git@drmicha.warpmail.net>
 <20160304115127.GA8355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 14:03:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abpO7-0002yJ-Ct
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 14:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011AbcCDNDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 08:03:19 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58759 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751852AbcCDNDS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2016 08:03:18 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 247D121B18
	for <git@vger.kernel.org>; Fri,  4 Mar 2016 08:03:17 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 04 Mar 2016 08:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=AKkz5QE/lHlUXN3iWj3tTZX56A8=; b=J/+ZXG
	Wf4SElIWm0uBmudki6sk7/QZOJPjLB4LBAr/1u7AJBp8IQ520eFFTO9khxm1j8J3
	wYL9gC5AS4IHN8oZLHPsBeRb3QjcS0kjO3GXzFPAmHnpGXD6ZCar6aqVaz7C+ytt
	ktuDqlxX+kMvchYLnfxC+55VfrwcIyX3Oy7dU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=AKkz5QE/lHlUXN3
	iWj3tTZX56A8=; b=C5Yc1XUbxXszqwWskZbq9r6SrMim15+h01ERi8Ryp3TPvTq
	L7m8KKK8JbEIMBpySpOMuLcNpq6NF70daeiIYXm3GHubBRzTf18vPjduihtf4Anp
	nc3gV0CQdURup0E5Uv3QW1JYGBHibFSZqO0BWsNkyKtlUJPHMqXhbQiB1j5Y=
X-Sasl-enc: MH4edN8C+mLEGfp/hUdDwvospqAeBy9/BzKCjd1/LN49 1457096596
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5F6BAC00014;
	Fri,  4 Mar 2016 08:03:16 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160304115127.GA8355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288254>

Jeff King venit, vidit, dixit 04.03.2016 12:51:
> On Fri, Mar 04, 2016 at 11:53:49AM +0100, Michael J Gruber wrote:
> 
>> We always quote $TRASH_DIRECTORY to guard against funky path names. Do
>> so in one more spot
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  t/test-lib.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 0b47eb6..8957916 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -868,7 +868,7 @@ case "$TRASH_DIRECTORY" in
>>  /*) ;; # absolute path is good
>>   *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
>>  esac
>> -test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
>> +test ! -z "$debug" || remove_trash="$TRASH_DIRECTORY"
> 
> I don't think this does anything. The shell doesn't do whitespace
> splitting on the right-hand side of a variable assignment:
> 
>   $ foo='lots of spaces and "!'\'' funky chars'
>   $ bar=$foo
>   $ echo "$bar"
>   lots of spaces and "!' funky chars
> 
> Of course we _do_ need quotes when we refer to $remove_trash as an
> argument (as with "$bar" above), but it looks like we do so correctly
> everywhere.

I'm used to that behavior, yes, but:

- Is this true for every shell that we support?
- Having quotes there, too, is a good reminder to have it also where
necessary.

Michael
