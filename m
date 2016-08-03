Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8451F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758321AbcHCUUy (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:20:54 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33334 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758264AbcHCUUw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:20:52 -0400
Received: by mail-yw0-f196.google.com with SMTP id z8so17577618ywa.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:20:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e/qN4A1meqAWi2GotFkd+BLtXUsQmheWCYTUj+jCol8=;
        b=KAjEMfKxeqspQWkIisRW2qZn4/ZbbV0o3sfUcxGeDksLab5Nzq2uoZalbA0jEHzGZV
         QpHumTW0/qwNRe8+3uu188tO46tOBEALTnpnvPG8je4iU3ceTHBCDTLp59Lwr+mcpnjE
         jhvOP/vsYsEUaE7j5KZTLc396oQrLnxyberuHoSquEzvREff96SQ7l+emMnhVYBtSI9X
         WCRSSoHl55hGvHib3CHz4vKKW0QIgWNyotdn1nwgyyqnEQExuZxFGtplnDcPfVqszO37
         87Pev+TkDwIg3s+kF52s5jmb7YkKxxXXPU6S2LLC7mguHH5IEgNLcaUuCloK+f+S6vAW
         8wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e/qN4A1meqAWi2GotFkd+BLtXUsQmheWCYTUj+jCol8=;
        b=Y8aFAnx5H60N7WUW4NHEQJEzWYcamIjTBaRswGrqmBLpifID6DVB3Z+zR7jXPtCbDp
         ph6zphPn38fNiNqwRzBoHAFL47Xh7Rrykt+dyjn4Lwta8xw/NircmBtrTfALckr6Teco
         AVcjeA7zi+mukqOmMkdj1qiCJNaUEg7xL5ri352Nh7eHWjhosG5G9e0xsf/EUshk3AMi
         2vtmVuZvUpSLUjBWgg9GEyd6NntFu3zF4spVEW70Kumc80MGbqfpiJ19EVTkLH7J+Ylo
         IFpskA6TsWXBRwEWJYq24sJSqnYuQiVps76jcL9e38epFRU3ibnVUI7FSuNiHA7+AIf/
         TmVw==
X-Gm-Message-State: AEkoouudcKAv9havWv2uxGIIMp4vLGbzwMYyDzehGO3n9N+IPCY+R+b17CyMNQRIeLCu5j7wC3XgrDcg3AZfvQ==
X-Received: by 10.129.136.5 with SMTP id y5mr44864978ywf.30.1470255634897;
 Wed, 03 Aug 2016 13:20:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Wed, 3 Aug 2016 13:20:34 -0700 (PDT)
In-Reply-To: <xmqq7fbzf56s.fsf@gitster.mtv.corp.google.com>
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
 <0102015640423cc5-691952fa-3726-4132-bcc1-dfa55d4c0895-000000@eu-west-1.amazonses.com>
 <xmqq7fbzf56s.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Thu, 4 Aug 2016 01:50:34 +0530
Message-ID: <CAFZEwPMwen+5wrs3fEOiLUOyf3RrUTV2rftt1c0D4XCVm-UzHg@mail.gmail.com>
Subject: Re: [RFC/PATCH v11 02/13] bisect: rewrite `check_term_format` shell
 function in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Tue, Aug 2, 2016 at 11:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +/*
>> + * Check whether the string `term` belongs to the set of strings
>> + * included in the variable arguments.
>> + */
>> +static int one_of(const char *term, ...)
>> +{
>> +     int res = 0;
>> +     va_list matches;
>> +     const char *match;
>> +
>> +     va_start(matches, term);
>> +     while (!res && (match = va_arg(matches, const char *)))
>> +             res = !strcmp(term, match);
>> +     va_end(matches);
>> +
>> +     return res;
>> +}
>
> It might be safer to mark this function with LAST_ARG_MUST_BE_NULL,
> but because this is static to this function, it may not matter too
> much.  Just an observation, not a strong suggestion to change the
> patch.

Yes, I could do that.

>> +static int check_term_format(const char *term, const char *orig_term)
>> +{
>> +     int res;
>> +     char *new_term = xstrfmt("refs/bisect/%s", term);
>> +
>> +     res = check_refname_format(new_term, 0);
>> +     free(new_term);
>
> Yup, that looks much more straight-forward than using a one-time-use
> strbuf.

Thanks!

Regards,
Pranit Bauva
