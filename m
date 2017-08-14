Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 562C220899
	for <e@80x24.org>; Mon, 14 Aug 2017 17:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbdHNRHG (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 13:07:06 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36023 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbdHNRHF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 13:07:05 -0400
Received: by mail-yw0-f170.google.com with SMTP id u207so58532608ywc.3
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0q7Wsw9GnOVehkaOimSjUJubHDneDSLmf0X5F3hQKdQ=;
        b=MNr0QqEMzyqhlyifTTy/UbzzbOgHIc0ryvPw57XODKashxU8X/OowM1Wp99BFvU+tc
         Gor/aoSnIjikARs57bpk1I31fWly5vSKejmYXTOXbvn82hOyGXn53jS0mRM0ls6V0Wbh
         KMYQDwGCwZa2bgHCOfj3T0W7X8BpJHy/74roRZ8drIU0HX1haQpwRpqZVr+pJljmP4I2
         7cfqbvi2uWFAOE2+JibMLFUiwLpm+urODO9lm0yogvb/9XtpIr6C//1o0SRPIDBOft+c
         55ypE8pUS2y85zDt4zHPo2h6kgYzA7yuEbc6v3vtAfZJdu3RbtwafRX+44bUr0xLXKCa
         5Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0q7Wsw9GnOVehkaOimSjUJubHDneDSLmf0X5F3hQKdQ=;
        b=FUxs5m7rz4e303hpzXpilTzAYHuinCs1zHheg4mWR0BtXalFI0pXDfLkTy2okHIcLJ
         HHWKVsnw+bEdkdgCHFNOFBhKfHz6DT3NEC7Zi7qCX1jfvmFv0QQCaegd71dwu1Ecb7PH
         3y+NffxZQ02bcjWz3ieqVg7oL2IkbMRoiLZsHDfALwdP9O6O32ELg3yg7nxoXIY+Pe1N
         nbpE1giuW2HoQAWtFejcHpw8U2CHk0ZBHijti/1XbKaOhNmstfEzPUqoDh+mOLJQGHSE
         r53z+uJ1zU4kS35s4cq4qh+zr4y1IJVAqmXQ2IEA568rdQ7jZgO9p1Aak76GqfFGGovL
         Qx0Q==
X-Gm-Message-State: AHYfb5jkgrUaSENHHc3hMFNWF2PhSZun1ruZOnmJIvG8xMFrLqkZiLBq
        EMjW4YlPNgKRPiEGbNcNXv8s1YJhjfpD
X-Received: by 10.129.120.4 with SMTP id t4mr20632227ywc.422.1502730424500;
 Mon, 14 Aug 2017 10:07:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.75.3 with HTTP; Mon, 14 Aug 2017 10:07:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1708141802510.19382@virtualbox>
References: <1232852793.287524.1502435085656.JavaMail.zimbra@absint.com> <alpine.DEB.2.21.1.1708141802510.19382@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 10:07:04 -0700
Message-ID: <CAGZ79kaYi=mqw615ZHiNAbDdnnKLawzZDy3ecLYDVV=e7e5qbQ@mail.gmail.com>
Subject: Re: Bug with corruption on clone/fsck/... with large packs + 64-bit
 Windows, problem with usage of "long" datatype for sizes/offsets?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        martin.koegler@chello.at
Cc:     "Dr.-Ing. Christoph Cullmann" <cullmann@absint.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 9:05 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Christoph,
>
> On Fri, 11 Aug 2017, Dr.-Ing. Christoph Cullmann wrote:
>
>> on Windows 64-bit, for a repository having a .pack file > 4GB I get
>> during cloning:
>
> The reason is Git's source code that over-uses the `unsigned long`
> datatype.
>
> In a nearby-thread, an underappreciated effort by Martin Koegler is
> underway to get the ball rolling in getting it fixed. Maybe you can help
> making Martin a lot more welcome on the Git mailing list, and maybe even
> help getting his patches reviewed and integrated?

'nearby' as in [1] ;-)

[1] https://public-inbox.org/git/1502527643-21944-1-git-send-email-martin@mail.zuhause/

I had the impression the review is going well there?

>
> Ciao,
> Johannes
