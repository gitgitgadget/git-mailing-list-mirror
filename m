Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B4C20802
	for <e@80x24.org>; Thu, 22 Jun 2017 23:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753912AbdFVXhg (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 19:37:36 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34891 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753841AbdFVXhf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 19:37:35 -0400
Received: by mail-pf0-f175.google.com with SMTP id c73so15533015pfk.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TOk/gjb5HFqYGbS37ZFjYsARbQz4FLT4JcBBXRrpV2A=;
        b=oP6hL/kmscV59HNDlFAPglzBovqgaPh4cs4QUgrYrgQrvpwNbIAn8wPTgde9mT2flC
         WKWaP8mBm/baWvtE0rjFqQGlYGDkM3fjHM1hqAeouzaaWwjIIoxfUByv4jZcf1TYJ3Fm
         IOqLOWYrJX2WmEmRaKXPmBxLtA71DzyrCL+0a7cmK38Gp4lEliPXE/JkPiVuYjDzSkVi
         2eo4cFf1ybUrfRgFGq/yrxCjh1l7YEsI2GXU7HLUH1kA4Yu4B+OqeYj3T4Pj+ZwK2769
         vDzZaZcZdUlDBK1MF9/XoOjHCd5CYaJRGYtWte4IkJuMEfeQfbHOMxkzxekOToSeedol
         Lw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TOk/gjb5HFqYGbS37ZFjYsARbQz4FLT4JcBBXRrpV2A=;
        b=lsyrQSl8UHvTP7zbNp81GIo8g+YuBmIh8yzubfmVAL+KB9bCwTywTN5DtL9PqsnUmm
         960o0ImTqB3Bdd6apzebsVKh/H3tsbgcj0VcaCYpN78RQJc4QuiWoXWjdd650hddLs3P
         9/IGe4H0/N/H5I/D3ajSDD8hSyGw/zKbdkax4yjx1n/cqbr6/MO+4co9A30Ba524PmfC
         TXWD9Hv6RElxD1cXPUxPN300mMY42dmQtTfRJ2ZoSNEKDiw3Wi2ufJNBhvuUacwEzSII
         2bJsI48K1QXXZI29FRrj2XK7mQ3RLo9rzbR4P5rwtX/yT8bN28/I5CyXZRDQCJZVKrhy
         zTfw==
X-Gm-Message-State: AKS2vOwZVYW2AgUdItbY799s2V7LLXrxBz1XddJbMMqVcK9l3td00wqQ
        dRsqUNJC+aU79EPbgYIf5hUcJqiXMfcTYJtnMw==
X-Received: by 10.98.34.8 with SMTP id i8mr5160598pfi.194.1498174654495; Thu,
 22 Jun 2017 16:37:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Thu, 22 Jun 2017 16:37:33 -0700 (PDT)
In-Reply-To: <CAGZ79kY46UGwBt2A20bwX_CFNuVP8hy_inCqh6hqiA5VfcfSxA@mail.gmail.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com> <20170620024816.20021-9-sbeller@google.com>
 <xmqq37atp0ng.fsf@gitster.mtv.corp.google.com> <CAGZ79kY46UGwBt2A20bwX_CFNuVP8hy_inCqh6hqiA5VfcfSxA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Jun 2017 16:37:33 -0700
Message-ID: <CAGZ79kben16T9nUpOjsq5-Sv8q7z+C1Nrq++jn2aO17CzqToHw@mail.gmail.com>
Subject: Re: [PATCH 08/26] diff.c: migrate emit_line_checked to use emit_diff_symbol
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 4:30 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Jun 21, 2017 at 1:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>>  static void emit_add_line(const char *reset,
>>>                         struct emit_callback *ecbdata,
>>>                         const char *line, int len)
>>>  {
>>> -     emit_line_checked(reset, ecbdata, line, len,
>>> -                       DIFF_FILE_NEW, WSEH_NEW, '+');
>>> +     unsigned flags = WSEH_NEW | ecbdata->ws_rule;
>>> +     if (new_blank_line_at_eof(ecbdata, line, len))
>>> +             flags |= DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF;
>>> +
>>> +     emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_PLUS, line, len, flags);
>>>  }
>>
>> This is a bit unsatisfactory that the original code didn't even have
>> to make a call to new_blank_line_at_eof() at all when we know we are
>> not checking for / coloring whitespace errors, but the function is
>> called unconditionally in the new code.
>
> We could check if we do colored output here, I think'll just do that for now,
> but on the other hand this becomes a maintenance nightmare when we
> rely on these flags in the future e.g. for "machine parse-able coloring"
> and would markup according to the flags strictly. I guess we can fix it then.

Actually that function already has some quick return:

static int new_blank_line_at_eof(struct emit_callback *ecbdata, const
char *line, int len)
{
    if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
         ecbdata->blank_at_eof_in_preimage &&
         ecbdata->blank_at_eof_in_postimage &&
         ecbdata->blank_at_eof_in_preimage <= ecbdata->lno_in_preimage &&
         ecbdata->blank_at_eof_in_postimage <= ecbdata->lno_in_postimage))
                  return 0;
    return ws_blank_line(line, len, ecbdata->ws_rule);
}

so maybe we could 'inline' it, as there is no reasonable faster check
than what we
have in there.

I'll keep it 'a bit unsatisfactory' here and if it actually is a
performance issue, we
can fix it.
