Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AAE29AAFA
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422482; cv=none; b=al1jV/UAuTB/YNcgFlKr3mNddb9HdHR7Hzd3xu7CS2c/+vEy/Hz9i2lcgElqglM9uZJZkQyyPQL1lRO4nYyHIozT9Qdu78/E9mY7mItmvZZcV8OXzOJZU9QcLOS/RqJczn7gGGRbA+ovpVpjj6ZyiOmjmm9RR7n5g2C+OELQf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422482; c=relaxed/simple;
	bh=zIW/4SMKOvo/R/aSIZslNTH1x9ZMCFhJWvjtvQR/u/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uCGXXseUklapipRCtqUOAEBxqNHQTNaDruAJ3vEhpfemee1HDkrI3yIckwci0nTp1jbLgK0mmNKibXuBRRTPwkepUrtYVV/PtM63UtaTmftGR6k2LSEpFLbLnfApeygunL1WitoJ+zD2zftgEUHED1VMRfFmcpn5Pj5uPeyqOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RBwiZ2mH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CbWzJrNf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RBwiZ2mH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CbWzJrNf"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 393CA13801CE;
	Wed, 23 Apr 2025 11:34:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 23 Apr 2025 11:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1745422478;
	 x=1745508878; bh=hb2FWfoJCUMjbYPxVCq/zboNSar3hGwyvSt8fcY1Rx0=; b=
	RBwiZ2mHZPSGDEvC0SpP5JAQ6buVP97opEIeXm7GJWNScYGc5nFoBD7f9Auz1YeE
	rtts1oQh//IuFDEsHfplkx/aWWiqPBCi0mBLXe3nJF2ezACqSQXE9fTwDCuY6kVv
	IdWIAbX7uh2RvYan8IScVStZsuvwox4jiFtsUZkMX1n920A0xRmGgakL5FAylm6O
	Gmqr0B/nFLmQ4nvXT9iI8kLbQqLElzuQ4TztVAF26wODfqjqazHkUf0yuaf5XZcq
	EGBIgpLNH/Kl53bx7KHlr2J8+l2Ze+1OOLzIo3btidth9fgZU6A9AYCsXfg25TcX
	wGtu+ROmolFmvA868Pbr0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745422478; x=
	1745508878; bh=hb2FWfoJCUMjbYPxVCq/zboNSar3hGwyvSt8fcY1Rx0=; b=C
	bWzJrNfYRPjo/cGFqtSgIolGA4U0NIp6kpaVmMKAyPMsabURzS+IRdjvKUiqZWk9
	Ahwl2t0tPQ/+AUfFGNngCW6LigU3SVsuvAh9Ed0rHMM5h11w6oZG7/dE0XTJMvSP
	d+w3U2h0mIkVudxm0CMIKxUoWpMTP2nM8lYSeXbN5ZecQFfusMNbzBQspri4mUa8
	b/nApy5EpSeekx520x/kL3kwxftGTltWza+g2wwrKvapMkHVViHPRLiEa+5rGr/k
	RrK6ZQFRonVEX42ZR6+Y7A3RCK0AYtivoi3Nnv8vCPk+aFTvJ2dzmZvUpAfRwo3A
	mxCtADV52VAllubhZSndQ==
X-ME-Sender: <xms:jQgJaDe8cANbhONJReJ3_8dVW-Bl0pnDrhvVeZ26Y_R36jUFocdzAA>
    <xme:jQgJaJOpwzzs2Ltw78LUnNeS2qbDix1tlVJHX7Ftx7v8fQl4n-ZDesN0ZkZG-aReT
    bVyb7E5DLLPUaTUGw>
X-ME-Received: <xmr:jQgJaMidjW5FUiQVdsd_KIDO7O1XEWNl62TAvTYyLcB8JukfUn3mDER0_LY0FYF5YXJu-NonVRdO259W5Hx1XM0xK1Nlde0OyybS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeileejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrug
    hithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepjhhulhhirghnsehsfigrghgv
    mhgrkhgvrhhsrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopeifihgrghhnvdeffeesohhuthhlohhokhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jQgJaE9KUXecZHN8FyMG7l0ynpwjxA76VfzuZ9FUAlGNdZEmjkBWKA>
    <xmx:jQgJaPthdxUG_tXOMW9U8hePK-yLPR5bq2q4sGKUdkG9m7WxzgTdYg>
    <xmx:jQgJaDHWJuQ8Qz8jpAnlSpDV6h71dNG06iQ1oiozB1aeP_4JNjm9lw>
    <xmx:jQgJaGPKwm55SDnO3vX8MI6WYFhNVFEdxOXjhPQfuoqiPZWnFMGcfQ>
    <xmx:jggJaN4nh4Pt6KPNCBpEWedO5BoYdBIzV7dGybXyXYFgyW-eg3lLNcPN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 11:34:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  M Hickford <mirth.hickford@gmail.com>,
  "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,  Shengyu
 Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v3 2/3] send-email: retrieve Message-ID from outlook
 SMTP server
In-Reply-To: <PN3PR01MB9597D275C6E76AD7938230F9B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Wed, 23 Apr 2025 03:22:07 +0000")
References: <PN3PR01MB95975C7925B6395DEC46F9EAB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597D68A4E7A570949672832B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqmsc73l8g.fsf@gitster.g>
	<PN3PR01MB9597D275C6E76AD7938230F9B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 23 Apr 2025 08:34:35 -0700
Message-ID: <xmqqo6wm28ok.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Aditya Garg <gargaditya08@live.com> writes:

>> On 23 Apr 2025, at 3:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> ﻿Aditya Garg <gargaditya08@live.com> writes:
>> 
>>> Outlook does not accept the Message-ID header in the email body. Instead
>>> it saves it in its own proprietary X-Microsoft-Original-Message-ID
>>> header and a random Message-ID is set my the server. As a result,
>>> replying to threads does not work.
>>> 
>>> The $smtp->message variable in this script for outlook is something like
>>> this:
>>> 
>>> 2.0.0 OK <Message-ID> [Hostname=Some-hostname]
>>> 
>>> This contains the Message-ID set by Microsoft in the first <>.
>>> 
>>> This patch retrieves the Message-ID from this server response
>>> and sets it in the email headers instead of using the self generated one.
>> 
>> Hmph.
>> 
>> send_message calls gen_header as the first thing.  This prepares the
>> usual From:/To:/Subject:/Date:/Message-ID: lines and returns the
>> header text as well as recipient addresses broken out into different
>> classes, among other things.
>> 
>>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
>>> ---
>>> git-send-email.perl | 11 +++++++++++
>>> 1 file changed, 11 insertions(+)
>>> 
>>> diff --git a/git-send-email.perl b/git-send-email.perl
>>> index a6cafda29c..216b23caa5 100755
>>> --- a/git-send-email.perl
>>> +++ b/git-send-email.perl
>>> @@ -1799,6 +1799,17 @@ sub send_message {
>> 
>> And before these pre-context lines, the composed $header that
>> contains the message_id has already been sent by calling datasend()
>> method on the smtp object.  After that, we are ...
>> 
>>>            $smtp->datasend("$line") or die $smtp->message;
>>>        }
>> 
>> ... sending the body of the e-mail here.
>> 
>> So it is not clear to me how ovewriting the $message_id variable
>> after the message with $header with "Message-ID:" line that
>> contained the ID we generated has already given to the SMTP server.
>> What the code is doing certainly contradicts with what the proposed
>> log message explains it does, i.e.
>> 
>>    ... sets it in the email headers instead of using ...
>> 
>> It would affect the message-ID that is used by subsequent messages
>> when they are sent as replies to this message.  I do not think we
>> computed the header (the In-Reply-To: field) for the next message
>> at this point of the code, and I can well believe that mucking with
>> the $message variable at this point would make the next message
>> correctly a response to this one.
>> 
>> Perhaps you meant that Outlook DISCARDS the Message-ID: field in the
>> message it was instructed to send out, and INSERTS its own?  Then I
>> can see how this patch would improve the situation, but the last
>> paragraph in the proposed log message needs to be rewritten.
>
> Exactly. We don't care what message id the script is sending here. We just
> send the first mail, and then retrieve the message ID that was set by outlook.
>
>
> Then we change the variable so that In-reply-to and References work properly.
>
>>    After sending a message, retrieve the message-ID the Outlook
>>    server assigned to the message and store it in $message_id
>>    variable; this value will be used when next and subsequent
>>    message are sent as replies to the message, preserving the
>>    threading of the messages.
>> 
>> or something.
>> 
>
> I'll change the log message, although it seemed clear to me.

Sounds good.  What confused me was "and sets it in the email
headers" in the proposed log message looked as if it was referring
to the Message-ID: field of the message we retrieved the ID Outlook
would assign to it, i.e. as if the order of events were (0) we grab
an ID from Outlook, (1) we compose the header, embedding the ID in
its Message-ID: field, (2) we send the result out.  What happens in
reality, if I understand you correctly, is that (0) we compose the
header, with our message-ID in its Message-ID: field, (1) Outlook
discard our Message-ID: field, replaces it with its own, (2) we can
learn the ID Outlook used, and (3) we'll pretend as if that ID is
what we gave the message we just sent in the first place, which
would be used in In-Reply-To: field of the messages sent as replies
to it, but it was unclear from the description which one you meant.

Thanks.
