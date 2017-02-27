Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D211F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 19:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbdB0TsG (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 14:48:06 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35139 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbdB0TsF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 14:48:05 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so1977969pgz.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 11:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4pr23gbUDvFb9ooyaVMOT4JRcSD3gydsnmSyzA7wm24=;
        b=fwU0RgM8PSizdp6cpnZIS1ICAV1V3y0piTEUMkbhUAtV9FxBFTvWLIW0cUkeHnLdkD
         QZoc/MokeLm2Lq/8SHNg856kGzBtUbbMJbwLZ4rlM8TOJEjBcMrfsKmIL0i1aUjO3mc+
         LSchrL1UYo9ykFVWYjduH+GU/tfPoJiSLqmoqllVBEsNogvas60jmDR34eBaDZEwzDJE
         FjxOT01r8NC2ohG0D6G10KmP5vhEQm6i23K6krbPuMjlFwXudYQai8sP2FseI90sFs1Y
         yzCImiMgAXJBl9Ip/TtvsK1o1KqbkFKkqoFoAhPaCNhTtnh8CrNKG2/jC1TfEZcc3d5I
         t8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4pr23gbUDvFb9ooyaVMOT4JRcSD3gydsnmSyzA7wm24=;
        b=pw+HQ2yxmi76lLSQ/ANQKMahMQA2h0zfj+cqBJ4KkknOjxl304qLKjrji65XEsFuWV
         IpTZsHyc+VzTJkCyahmDyjRx2OynNm5OTMCnnEE26c1jqmdd8gLAwnwh/er0dnU7Jg8o
         zGyIcMvab//wuRQTxQMxqndIA8f5d1ZexTuwolAzSQJf5RlNFCy76p6zl9F+V2NCgikB
         kMVA26O1nMd/YkcRsUnITdkH1+vAM+cj1qDj1YJAP15J7VinaS9/qlfXFqQS3bk0S1xF
         i8zuaMz5Gb2+bnpa4uivJTh61YSO3RBxRyV3q2Ji9o5/7W+ayO6rE0J24N677Q+hfPpU
         PTVg==
X-Gm-Message-State: AMke39lLa+wDCdFsXbAkn/jhN0jTQwuGR6bfl4+g5JedVKPH+80wkqfZqVqDDSN3wUxzcg==
X-Received: by 10.84.193.101 with SMTP id e92mr26435609pld.4.1488223112017;
        Mon, 27 Feb 2017 11:18:32 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id q73sm18523401pfa.129.2017.02.27.11.18.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 11:18:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] commit: be more precise when searching for headers
References: <23989e76-24ba-90a4-91a9-9f66bfccb7c9@web.de>
Date:   Mon, 27 Feb 2017 11:18:30 -0800
In-Reply-To: <23989e76-24ba-90a4-91a9-9f66bfccb7c9@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 25 Feb 2017 20:21:52 +0100")
Message-ID: <xmqq8torxx15.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Search for a space character only within the current line in
> read_commit_extra_header_lines() instead of searching in the whole
> buffer (and possibly beyond, if it's not NUL-terminated) and then
> discarding any results after the end of the current line.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  commit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Makes sense.

> diff --git a/commit.c b/commit.c
> index 2cf85158b4..173c6d3818 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1354,8 +1354,8 @@ static struct commit_extra_header *read_commit_extra_header_lines(
>  		strbuf_reset(&buf);
>  		it = NULL;
>  
> -		eof = strchr(line, ' ');
> -		if (next <= eof)
> +		eof = memchr(line, ' ', next - line);
> +		if (!eof)
>  			eof = next;
>  
>  		if (standard_header_field(line, eof - line) ||
