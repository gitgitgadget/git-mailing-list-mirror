Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9194820196
	for <e@80x24.org>; Thu, 14 Jul 2016 19:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbcGNTAv (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 15:00:51 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:34429 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbcGNTAu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 15:00:50 -0400
Received: by mail-it0-f49.google.com with SMTP id j8so4993792itb.1
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 12:00:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qf3Vn/GvrCR1rxc+wy5/THh6KQU9xlAmdlJS0zYbDC4=;
        b=h1bPip0s/wyrokO1YR+dLAMVDIKuGdmdalmYlfi0IU9xhI5x4N05n/7wZ79D2S98G6
         i2XTodAeGyZJVyTPIRFjuRznjwTnGzcgz2i+7/IlF7aackRYaFKFvUPwO/qGzqZYzVZJ
         OyDq9XC3ZFVURR3s5wGaogq/bIn4QKQVHHkZIlJrqamMXpmSoHW5JQqZer6WkRsMQsFF
         btF89EaRLehjj2PvnKyYW7JYRr/R+yciv5DvMBM0dDiNqkrbzdHrkivAjckHziF7qw/t
         okav0JOzV+Ms3g52/eRPxgLkEA+VlEnabIDDRRA3M/pZCUHzHmdHLsDqNsLKaw0C4KEc
         dH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qf3Vn/GvrCR1rxc+wy5/THh6KQU9xlAmdlJS0zYbDC4=;
        b=LuJ52Cr0wBEyYWvp09+FE23jiySvUiGEZ50o81NrHYoQctMC9xt4Su+PnOXPmT8vEj
         qzN8ImP96fjzAlJSwVsSPwDIkqgUyg/GME8JYe8SBq/nhIT7Pt8OyUv80/08OADhRtDk
         0VD1GFzCpKjvOqmuF/pnoqfajf4ZZeArMPbMAAz5tDUbrb8M4pTpYsZ12bgyu+FLOMDY
         Ta3sBop8rBHmpm9/gTLHtKplyvr5jgxuonWo6KPSQfchBZF/qeyRLuNpTnGkJ9jbGytg
         qPEGlllZdL+b3kYgNTJYJXQ3lU9CSNaVpK4OB8SFU8yRe6CvafJI88ytlxlkpb7wq5YP
         SiCQ==
X-Gm-Message-State: ALyK8tJJh3YxJy7zzbbJPzsRG+14WQCbK6f3Ndc8v82CvmgrmL4ddBZ66DnHLJ5F64r6Ih+L+jdiW054dX8KjBXb
X-Received: by 10.36.250.132 with SMTP id v126mr2438825ith.46.1468522849007;
 Thu, 14 Jul 2016 12:00:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 14 Jul 2016 12:00:48 -0700 (PDT)
In-Reply-To: <xmqqk2goqd4l.fsf@gitster.mtv.corp.google.com>
References: <20160714173920.22001-1-sbeller@google.com> <20160714173920.22001-3-sbeller@google.com>
 <xmqqk2goqd4l.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 14 Jul 2016 12:00:48 -0700
Message-ID: <CAGZ79kZgJ_6fxZ19Hx6zd6KoTAd_+oMjb4fj1twY2ZGUHP7wHA@mail.gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>, Eric Wong <e@80x24.org>,
	Jeff King <peff@peff.net>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> packet_read_line() calls packet_read_line_generic() that calls
> packet_read() with the fixed packet_buffer[] that is sized to be
> LARGE_PACKET_MAX.

>
> Can this check even trigger?

I thought when len == LARGE_PACKET_MAX,
this could trigger. Though on inspection of packet_read,
we already reject packets that have size LARGE_PACKET_MAX,
and the largest size allowed is LARGE_PACKET_MAX - 1.

I guess we can remove it altogether and still be future proof.
If we ever want to allow larger push options we either need to
have larger (variable sized) packets or a capability push-options-v2,
so I'll rip this check out.

>
>> +             lf = strchr(line, '\n');
>> +             if (lf)
>> +                     *lf = '\0';
>
> packet_read_line() -> packet_read_line_generic() calls packet_read()
> with PACKET_READ_CHOMP_NEWLINE flag bit; do we need this check?

This check was not about "option with lf at end\n", but rather we want to chop
off "option\nover\nmultiple\nlines" ?

Although as you remarked in another email, this would not pose a problem for
the shell variable, so we could also drop it to allow multi line
options. will do.

>
>> +
>> +             string_list_append(ret, line);
>> +     }
>> +
>> +     return ret;
>> +}
>
> Other than that, looks good to me.
>
> Thanks.
