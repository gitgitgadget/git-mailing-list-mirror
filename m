Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E841F406
	for <e@80x24.org>; Mon, 14 May 2018 13:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbeENNbd (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 09:31:33 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:37133 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbeENNbb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 09:31:31 -0400
Received: by mail-qt0-f174.google.com with SMTP id q13-v6so16052409qtp.4
        for <git@vger.kernel.org>; Mon, 14 May 2018 06:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JfYQWJYGTpYiXEH9W8wGVlUlyJV2u3LIwbhLE1NisVI=;
        b=J99Hh9yK+6Nab4Qk7Me4ybCTTI1OpE+FmNprTKnBw2L8vW8+jy93CSBvFoi9MhfEDb
         G3wzXEhiKCbpXDGP7P65l9RrPEW53NlfEEah2/Sc1ztucutHOHpCjZpSrEnZKxSpNQjU
         W2b7TpGipwt1tS0EJzvZ72fn5TSs0DpDCz5p8UO4f+sLcOQDBKS2YJZ6/kd5LK+PyFBE
         VP6bNVY0qFJPovvrs21pczp1DlmytG80Ve0ww0XRiEZmDUZ4QIo/Ifm3XxLyhun/knCJ
         iqHzHg98neKNkfWT+YQ7mK15pBJOjwyHnbwYNeHRBu+b5YXoo/xVxZxF+W7xwOqi67Y0
         fDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JfYQWJYGTpYiXEH9W8wGVlUlyJV2u3LIwbhLE1NisVI=;
        b=BjNzf7i3h6d52iHTEBtqJNF6ocvk8E4gRCoTKbuLxR+4t6DidiCQHfGg+fFv/wEpDo
         7i9Geag2a3uniuyzbFRn//ls91ygAJx2Qldhfce10Q5AiJjkLWqheDXSsC8TINdDtZPJ
         HV82Zx3C3ErMjHuMcxH+4lnAcOBjm8yBihXlLDH2unvXasbfaYdhyiffhIHzRvEwg1G9
         N4oTa5Qymxjc2fcnvHko6bK2Iqw8hFKxMVEpMTBI38tDqKQfZ25uC6MOdhoeikuxFMcl
         8eTjZYAAJORgs8+wzC+C7XP9Jk8fMKRDhVhFHlAY0ZDGPmTb3Q8ulLNdHZA0Zbwbm61P
         vWPA==
X-Gm-Message-State: ALKqPwcM9+F/fHUNraGKmW0OGn9PsE0Ewf3MQQakT4ESTpd81fnhbMsA
        kg3+Nqyf82uTsXOakVBtft8=
X-Google-Smtp-Source: AB8JxZqmo1w3h1g399ABLX8uhIbcxB9xM567KM/8hTre6JcKuiOuI7YcfsC/ov2d/mLs5SMiedIuiA==
X-Received: by 2002:a0c:9375:: with SMTP id e50-v6mr8554420qve.166.1526304690734;
        Mon, 14 May 2018 06:31:30 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id w70-v6sm8090406qkg.13.2018.05.14.06.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 06:31:29 -0700 (PDT)
Subject: Re: [PATCH v2 02/12] commit-graph: verify file header information
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180510173345.40577-1-dstolee@microsoft.com>
 <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-3-dstolee@microsoft.com>
 <CAN0heSrKFJbgwXXzUKaJQn24pY43S2bsn9Zx6Yyy6M2X2wDJ7w@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0964380e-1ec9-46c4-ea59-f8890d9ed711@gmail.com>
Date:   Mon, 14 May 2018 09:31:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSrKFJbgwXXzUKaJQn24pY43S2bsn9Zx6Yyy6M2X2wDJ7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/12/2018 9:35 AM, Martin Ågren wrote:
> +static int verify_commit_graph_error;
> +
> +static void graph_report(const char *fmt, ...)
> +{
> +       va_list ap;
> +       struct strbuf sb = STRBUF_INIT;
> +       verify_commit_graph_error = 1;
> +
> +       va_start(ap, fmt);
> +       strbuf_vaddf(&sb, fmt, ap);
> +
> +       fprintf(stderr, "%s\n", sb.buf);
> +       strbuf_release(&sb);
> +       va_end(ap);
> +}

That's a good idea. Makes that patch a bit less trivial and this one a 
bit less difficult.
