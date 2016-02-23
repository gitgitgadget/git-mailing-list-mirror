From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv14 0/7] Expose submodule parallelism to the user
Date: Tue, 23 Feb 2016 15:42:45 -0800
Message-ID: <CAGZ79kZucTS8ESLOEAJ2rJPrBEtQWHOow-a5G11vm4GOKEARqg@mail.gmail.com>
References: <1455905833-7449-1-git-send-email-sbeller@google.com>
	<xmqqtwl4bedt.fsf@gitster.mtv.corp.google.com>
	<xmqq8u2bngsi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 00:42:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYMbS-00043P-84
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 00:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbcBWXmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 18:42:47 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:33418 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbcBWXmq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 18:42:46 -0500
Received: by mail-io0-f169.google.com with SMTP id z135so8304390iof.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 15:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=viBKLq81XSp++7UfuobaxppIcwCXj27/IPcnQcR5HfY=;
        b=dCWjTmzTskdDTT11C7qREfSHHZ2GWa1lzs8Rc7M+PKopPap1t0INpszyTPn4Uqizij
         UDgiNESK8Zd6Rlxb5hqu3XlB/lXhRjNMZyXkg7riH8yNu+dXKmKcPRv2pmW8joLdmNR1
         lfj9VBaPJDr8G0WwmZ4U7gXyxqwXGhlL0Tmn9opp7uKqw/3zztu7KfMqef3xgZVOdo7m
         U5pz1fIFznatCAk8NiPrhSytbMyzwiNAWRoHezZVRpL22F4csxGF09eY1hPw2AEIo1u7
         mBVUhSnQIIEZ+G6BT643GA9MX70WgfEkDBxuTm/lMKSFvh41AMCr6QxRw/8vIqysA8TB
         ye9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=viBKLq81XSp++7UfuobaxppIcwCXj27/IPcnQcR5HfY=;
        b=M9P8Yox1Sipg7H8/l1AU+tS4NUCzORRwoJKS04OQLJaoP/lkmlq/5bdjQk8JDsF8vn
         gQr9s+rzQluY/nOdI19YCiytsBYRYeOHHpHl8SrC5YcVXggHEFklQu4otMfJmuLsrI48
         GbZinQ3fs4p/kT55KhQMMfFis7qOBNoQamv3IuGc51JoDpS3DybX3lqCT36drhVc1dX0
         jX1X9g+vNr997vD/WjpH0p82+sBqpM9wlcheyG+Im0TTCwRtb6rvUxGBxOg5ohoaM7td
         ErRSaH1f0pTrEyYRpz2aZIuQz/V+5QNwg8tmOM7ExA9oaBhzCcnCzycKPprLE57U6mjv
         JSeA==
X-Gm-Message-State: AG10YOTiPKQg+v1/7ahENc3SiB9c7GygTQAH/7MwRB/J29DIHxvKwvsH71G2em0yQ/mcDlBZnoHjapk2SB+2sDmK
X-Received: by 10.50.180.35 with SMTP id dl3mr8544148igc.94.1456270965359;
 Tue, 23 Feb 2016 15:42:45 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Tue, 23 Feb 2016 15:42:45 -0800 (PST)
In-Reply-To: <xmqq8u2bngsi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287144>

On Tue, Feb 23, 2016 at 3:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Looks good.  I didn't notice these unnecessary blank lines while
>> reading the previous rounds, and it is good to see them go.
>>
>> Let's wait for a few days and merge them to 'next'.  David's ref
>> backend topic textually depends on this, and we'd better give it a
>> solid foundation to build on soon.
>
> So... it seems that you and Jonathan had a few rounds of back and
> forth on 5/7 that didn't sound like it saw a satisfactory end.  Will
> we see a reroll to address the issues raised?

Yes, I was about to send one out, but then I wanted to fix the last
of Jonathans small nits, which resulted in some heavy refactoring.

I'll reroll, but I suspect it won't make it out today in time for integration.

Thanks,
Stefan

>
> Thanks.
>
