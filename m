From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 0/3] add test to demonstrate that shallow recursive
 clones fail
Date: Mon, 11 Jan 2016 08:29:18 -0800
Message-ID: <CAGZ79kZz+U3FvYwsJ+v6BQP=z-Z-Y4-=6KxeiqzjTKxQXiFtDg@mail.gmail.com>
References: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
	<79770C7D-B6A1-4239-A1EF-0A986CCD24AA@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 17:29:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIfLQ-0006xZ-0O
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 17:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933840AbcAKQ3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 11:29:20 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:32834 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933700AbcAKQ3T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 11:29:19 -0500
Received: by mail-io0-f175.google.com with SMTP id q21so353801234iod.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 08:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yjzeP3UuzKRtS+59vi5N8ex+jSmR+IX52XlFOUovILc=;
        b=ORKdhccP6Iv7x3X6ggyz/4j3s9Rr4gyndN1YvSdqqWU3GoYYlApSkOHfmwIuYPvNsl
         HtEpoAndNzS2+NIkThplVSDxtNyJk73J3d312qD8ynKBHPXst1CcpYBC1GvVeldliviR
         nMKPrIHeXm+z3KshA72L/b1Nrpagn1O8ata/HV/IPbT6wVqXHVpPIjz49ivEsfV9HI6+
         M0Mx+OIXF02YV3K5vDWEFAIU8QZge8pmP+Gq9c94j83gz/kz9dGC2yypIUQGbc6u/hmk
         tQH0z6PVBCs3GGzwf2/haKGeO3tURP+TLwGbo24f303kYE8O/RG9Fsd6IKuKAdDgvArg
         OPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yjzeP3UuzKRtS+59vi5N8ex+jSmR+IX52XlFOUovILc=;
        b=cuF0ZUNKfIGS03hhM8YHcRybHQiU354txEjG3klAEHoGrwxOWYpIPmYJAEnA/InJMG
         pysS/eu3YdRtIJNLbTvPYYgny33Fq+KwbyR2gFSTRn9nX1nJzLhzHxlp6iJzkPZFY7l6
         dT9ltJD1rtPrTHfDpVWfJ0oyD8/j3Tixx4guqgRQVgDFL1azomDZW+8dTVjf21t4+r1p
         igBWRBeG8vWYTuSXwo5gsIOet39AH7YwJXf1eEpC8kFwrOURDjflu5X4emN667JlOBW7
         rW11/Q5nQxQedgd+EMFmGQkDF63Qa/BClvgHA2pwMCFYYMWuMW/CZhhxCh8Ujn6H/d17
         QwtA==
X-Gm-Message-State: ALoCoQl+ebXE96e3mieTwET+LgTq1t7fkHslIGo5fMvy1Z00uu/oZVwhKz8+p/LZRh54XpxnfTHHtwTLv7AhO9MQ6Doi1ddptJ4fLIBQ15bGHRl67oQnYmk=
X-Received: by 10.107.30.65 with SMTP id e62mr116110959ioe.110.1452529758799;
 Mon, 11 Jan 2016 08:29:18 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Mon, 11 Jan 2016 08:29:18 -0800 (PST)
In-Reply-To: <79770C7D-B6A1-4239-A1EF-0A986CCD24AA@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283666>

On Thu, Jan 7, 2016 at 1:50 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
> Hi,
>
> does anyone have a few free cycles to take a look at this patch series?
> I wonder if you deem it as not interesting or if it got lost.

Patch 1&2 look good to me.

>
> Thank you,
> Lars
>
>
> On 21 Dec 2015, at 00:19, larsxschneider@gmail.com wrote:
>
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> diff to v2:
>> * remove workaround tests as suggested by Peff [1]
>> * fix chain breakage introduced in 275cd18
>> * add hints to the user if a submodule checkout fails while using the
>>  depth argument [2]
>>
>> Thanks,
>> Lars
>>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/281237
>> [2] http://article.gmane.org/gmane.comp.version-control.git/281420
>>
>> Lars Schneider (3):
>>  submodule: add test to demonstrate that shallow recursive clones fail
>>  submodule: fix &&-chain breakage
>>  submodule: extend die message on failed checkout with depth argument
>>
>> git-submodule.sh               |  4 ++++
>> t/t7406-submodule-update.sh    | 35 +++++++++++++++++++++++++---
>> t/t7412-submodule-recursive.sh | 52 ++++++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 88 insertions(+), 3 deletions(-)
>> create mode 100755 t/t7412-submodule-recursive.sh
>>
>> --
>> 2.5.1
>>
>
