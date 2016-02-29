From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv19 00/11] Expose submodule parallelism to the user
Date: Mon, 29 Feb 2016 13:55:45 -0800
Message-ID: <CAGZ79kbA5M26MVHymKRo9RTO7uXzN5YR9bKOBpFCM=qW8rDUnA@mail.gmail.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
	<1456444119-6934-1-git-send-email-sbeller@google.com>
	<56D4AE8A.2050403@kdbg.org>
	<xmqq1t7v9qou.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY5nxDQ_o0L_MOYFOx4FPH1apW-TuB88UypuwDaLuKGNQ@mail.gmail.com>
	<xmqqwppn8ba4.fsf@gitster.mtv.corp.google.com>
	<56D4B805.7090702@kdbg.org>
	<xmqqsi0b89tb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:55:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVnD-0003fz-Et
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbcB2Vzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:55:47 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:34070 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbcB2Vzq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:55:46 -0500
Received: by mail-io0-f171.google.com with SMTP id 9so198508149iom.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 13:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=1XlTKkdLLiPRYlSaEZrsL3iDMVYvvWBscWtAf82EVEs=;
        b=WrD83Wi6291bdpAV6vBw31UN7JWzSqK7KrSgIERkU4LyP03F/K9rKTH8zXi/ZRFcUO
         6d6ov6KAxjXuy2l2ibVfx+sSqwLUDGQhW7y6/vxTFVS3SeNXJDCb/Sz1ERW4JK/9Esww
         l71HJY0g2dWsbdJCdiLS67nIEkY1J9RU5LdRS5CzEs/OppINivTrzIeSK7xmaxyCmVzm
         nfjOIGHiaELF/QkRCVaI5BNum+f6OQmfz4zY9bPIkeufqjrnxEefoTFqwfIpzx6nNB4G
         xj835Tkph6BPrM6YW9Vn+s8qKZ0QXUdugFHtYGyPk2tiaR182WZf4H/Szf5lWUr+h3Gy
         4Ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=1XlTKkdLLiPRYlSaEZrsL3iDMVYvvWBscWtAf82EVEs=;
        b=b7k8kgzcYxRpqABb5/YX8G0QHT/IwapeRzmRXVbw/9vco5cZM7PzQRJK/0PMmLRsmC
         JdsZ2VbAMc9ceN6F9IjrpvgxBigUBPuL486TMRTS4DToZoMF1uzINGBdiPqtmlkhBsJg
         vVcDbP+7cmwkEJRBZDrABGWKm2Um/AGr1boPOKtaqGnJ97afE+itH99MqoMeITmQ2rql
         /G5OBEiaNAt4dHCMsyp4nr0V6LSbd9sDvZbz3/TLlppGr7/MmIQx4ckpqOLqbltah9um
         axI/3GpfzZKlCrwrXggjcYs3IcnaCuRBIKKDa/vtlhrgCGn/4Mq/4RMhxkeshnfPgUBz
         1E7w==
X-Gm-Message-State: AG10YOSpX9cTKH4DOFj3WbbtJPDM1iMvoRYdlpu86yIwjeQAGbAVrltIJoXcm4IEx2+qY8hyMueCFAUBcavVciJ7
X-Received: by 10.107.167.80 with SMTP id q77mr25103237ioe.110.1456782945731;
 Mon, 29 Feb 2016 13:55:45 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Mon, 29 Feb 2016 13:55:45 -0800 (PST)
In-Reply-To: <xmqqsi0b89tb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287914>

On Mon, Feb 29, 2016 at 1:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Am 29.02.2016 um 22:19 schrieb Junio C Hamano:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> Maybe we want to remove the struct child_process from the
>>>> function signature of the callbacks and callbacks need to rely on
>>>> the data provided solely thru the pointer as passed around for
>>>> callback purposes, which the user is free to use for any kind
>>>> of data.
>>>
>>> I think that is the most sensible.
>>
>> I also think that is the better approach. Dumping out the argv array
>> is not the best end-user experience. It is just a debugging aid, and
>> for that we have (or should extend if necessary) GIT_TRACE
>> infrastructure. Moreover, a command that failed should have printed
>> error messages, and it is not necessary to follow it up with another
>> "A child process exited with code N" message.
>
> Exactly.  Stefan, please do not go in the route of butchering the
> start_command(), finish_command(), etc. API set with the "uncleaned"
> variants.
>
> Thanks.

After rereading your emails just after I had the patches ready to send,
I realized it's a bad way to go. Thanks for confirming that. :)
