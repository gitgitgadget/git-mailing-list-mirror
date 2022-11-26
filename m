Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94549C43217
	for <git@archiver.kernel.org>; Sat, 26 Nov 2022 23:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKZXTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 18:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZXTv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 18:19:51 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849BD12D09
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 15:19:47 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r18so6759801pgr.12
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 15:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUNL0iHvaI8lBoW/AXLjYFlrCe+EASC+XwvyKqpj77M=;
        b=NK5H2Mj8VDREfHItByYo1F28+0fOm1mKWCPIrpF+tdnT4Azhx05vETMwLST8qpbbGo
         7nbBjdF6BHPTRn/UveOsxfFsdX3jK0FpBIDyypPsrqAJXsiq6jdC2wn1fwV/EPYMM/oe
         rDz7PDF6a/NAZNZSuKMsPnVQOK6I4shClg/ocZwsYrAlr4imRac6HawxqIGDCm5eBlZA
         cFZKiRJHAn0LJtYoZ2VKRX9ibC+m/tv5i2aGBBVKJhfukpbJobXHK4Mxvm1RYt9NuF3Q
         jmAVgHbqB9Od/L640TK0FAz9qjwzD6dK3KXNFvduGTkMKLgiocQdPQRO67/BUvUx1TVM
         dzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUNL0iHvaI8lBoW/AXLjYFlrCe+EASC+XwvyKqpj77M=;
        b=cBP8RNf6XzkrWRU9JDbvQ3HMhhaE0jCjIfHvvTgYj5R+R1PPFLe0NrK8XTj5NL+bu5
         4dy/VqyLjbP4cQ5W+h3tzNOS198+9ugVlORgF5lULswkyxpA7jd4RtQg67ZNoNDKUkS2
         /FrqpJAKGM66lknbl0Kj450JpR105YTJ64hhL1HQoy66Y8ycwKq1NyVD1TLfSbLR7+1M
         aiCI9VpzkxBUOMXxTPcCfCEFb8bAP44nMQBL3kmhbNODt1WWPhZNguUqT6utV2uIwGR7
         pU3rAtWF26CQ+8pK7FXg4+ACURa92uAlOOMdQ9Vj5hUwbce/xiWVEVlFFUtrMHlMKHrJ
         tFZQ==
X-Gm-Message-State: ANoB5pnibwi35CcfTCGQBzh0k3B6VtfVGrE8W1TRrS00xtcvYSPaMJfN
        Kb5zmI4g5T1N1PqrRXMU1TY=
X-Google-Smtp-Source: AA0mqf6cusVFiiGebji1hxZDh15lJxIIhKY39mV3VvUNWqt05pdHcTn9vHT93rzq0KRtcY/gvAB+wg==
X-Received: by 2002:a63:1f21:0:b0:46b:2bd4:f298 with SMTP id f33-20020a631f21000000b0046b2bd4f298mr24040303pgf.135.1669504786800;
        Sat, 26 Nov 2022 15:19:46 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b00189758e2babsm1971197ple.125.2022.11.26.15.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 15:19:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Subject: Re: [PATCH v4] pretty-formats: add hard truncation, without
 ellipsis, options
References: <20221102120853.2013-1-philipoakley@iee.email>
        <20221112143616.1429-1-philipoakley@iee.email>
        <xmqqfsedywli.fsf@gitster.g>
        <d80d1b97-b0c0-148b-afb7-f5210366e463@iee.email>
        <xmqqedtvu7py.fsf@gitster.g>
        <7a6c3d32-4494-e209-9877-e8784f0c3502@iee.email>
        <xmqq7czjecfr.fsf@gitster.g>
        <f0923db4-7bfe-86d2-7539-c9ebed62fa4f@iee.email>
Date:   Sun, 27 Nov 2022 08:19:45 +0900
In-Reply-To: <f0923db4-7bfe-86d2-7539-c9ebed62fa4f@iee.email> (Philip Oakley's
        message of "Sat, 26 Nov 2022 14:32:28 +0000")
Message-ID: <xmqq35a5cnhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>>  in that they may do "[][].." or "[][][]" when told to
>> "trunc" fill a string with four or more double-width letters into a
>> 5 display space.  But the point is at least for these with ellipsis
>> it is fairly clear what the desired behaviour is.
>
> That "is fairly clear" is probably the problem. In retrospect it's not
> clear in the docs that the "%<(N" format is (would appear to be) about
> defining the display width, in terminal character columns, that the
> selected parameter is to be displayed within.
>
> The code already pads the displayed parameter with spaces as required if
> the parameter is shorter than the display width - the else condition in
> pretty.c L1750
>
>>   For "trunc" in
>> the above example, I think the right thing for it to do would be to
>> do "[][].", i.e. consume exactly 5 display columns, and avoid
>> exceeding the given space by not giving two dots but just one.
>
> The existing choice is padding "[][]" with a single space to reach 5
> display chars.
> For the 6-char "[][][]" truncation it is "[][..", i.e. 3 chars from
> "[][][]", then the two ".." dots of the ellipsis.

Here, I realize that I did not explain the scenario well.  The
message you are responding to was meant to be a clarification of my
earlier message and it should have done a better job but apparently
I failed.  Sorry, and let me try again.

The single example I meant to use to illustrate the scenario I worry
about is this.  There is a string, in which there are four (or more)
letters, each of which occupies two display columns.  And '[]' in my
earlier messages stood for a SINGLE such letter (I just wanted to
stick to ASCII, instead of using East Asian script, for
illustration).  So "[][.." is not possible (you are chomping the
second such letter in half).

I could use East Asian 一二三四 (there are four letters, denoting
one, two, three, and four, each occupying two display spaces when
typeset in a fixed width font), but to make it easier to see in
ASCII only text, let's pretend "[1]", "[2]", "[3]", "[4]" are such
letters.  You cannot chomp them in the middle (and please pretend
each of them occupy two, not three, display spaces).

When the given display space is 6 columns, we can fit 2 such letters
plus ".." in the space.  If the original string were [1][2][3][4],
it is clear trunk and ltrunk can do "[1][2].." (remember [n] stands
for a single letter whose width is 2 columns, so that takes 6
columns) and "..[3][4]", respectively.  It also is clear that Trunk
and Ltrunk can do "[1][2][3]" and "[2][3][4]", respectively.  We
truncate the given string so that we fill the alloted display
columns fully.

If the given display space is 5 columns, the desirable behaviour for
trunk and ltrunk is still clear.  Instead of consuming two dots, we
could use a single dot as the filler.  As I said, I suspect that the
implementation of trunk and ltrunc does this correctly, though.

My worry is it is not clear what Trunk and Ltrunk should do in that
case.  There is no way to fit a substring of [1][2][3][4] into 5
columns without any filler.
