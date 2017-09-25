Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF4CD202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 23:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966579AbdIYXmG (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 19:42:06 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:49835 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966545AbdIYXmE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 19:42:04 -0400
Received: by mail-qk0-f175.google.com with SMTP id u67so8429626qkg.6
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 16:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eHDZanS57F2QmPKk8UalRQ3Ac318lYf9UYODNJ77UiQ=;
        b=iXpUA0q2ZWVWJPWc2SIS0z0odlCDVmGheOIbMu/qLcYkuEOhyyPmR8PipU2Vwme0KY
         oEPk4gFugHhhWEwjh35IeQKjb8NeM0SgJI9dKKHenyXAzgOlgN7MQlBNmGUsads2L8V0
         eJw1hoB7xtr5Ur4eeLscbIf7LnVY6TDlwk0iVwJjzZID+q4ZxFbTXdaEUbKLStqa9lF+
         jh01xYCZACaeV7lkJWRN2niLV9C/MfbFRlEVfwduMsyETMLyfi8oU/umTCFIpfutInWf
         M0wo1jM+gEu+luixLEnIOiJ6SuDdc0CtWZx5dlF0iGPhjlRNV8sbKSpGzOVDyN+cQSUW
         Y1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eHDZanS57F2QmPKk8UalRQ3Ac318lYf9UYODNJ77UiQ=;
        b=FYyPUE5uqZccaRxelPgAnOVdYnuljmutc7hpVXSDjMVmfyPrAsM7XZDB12xG48uhF+
         QBC/YCjeTsUXbw3riEHojwz/DO4mUz8wfIf29j2nCu6aBphDc/lilJgpGUkThuglJ80/
         0SFDn3FlaaFsuhbDh3xQgqg58hK+FlHLODKd7pMKiP0Rjyl0hYsetz4UAuYB3npVTki+
         FB2D1U0KVKk6UpCuY/N1ovz774bYuLOG2Vq83mzj80L1VdP9AXo39Oth0iIEeBCTuYNu
         Cbaej1wftjAnMvli5iYcNABN2UmPnbTzlubjMsUIfIuS2oQj0GriMDfEmrpGt0cRw7z4
         PIEw==
X-Gm-Message-State: AHPjjUh/ezTbI+4vNJrcDZNH/MdF3Z6pf+a6dSKjOs/jxtDKihKLGwJE
        GfzlIsfAFcHjFVlrb2ZUehqTCpvM4dnIBX1gQVpcswADC74=
X-Google-Smtp-Source: AOwi7QDKsFEOT/NJQLxUPg6x+M2LK9eaKsGWmypJgC4sQk7+ak+JkEziklP8PuvWve/KbKxEkr9Rh4S/1hcbZOxFLbc=
X-Received: by 10.55.52.135 with SMTP id b129mr12897059qka.308.1506382923668;
 Mon, 25 Sep 2017 16:42:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Mon, 25 Sep 2017 16:42:03 -0700 (PDT)
In-Reply-To: <20170925095452.66833-5-dstolee@microsoft.com>
References: <20170925095452.66833-1-dstolee@microsoft.com> <20170925095452.66833-5-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 25 Sep 2017 16:42:03 -0700
Message-ID: <CAGZ79kaBGtgBv2OryCO+oc-0nvSyi0vXA2jsLS2=5Xweea1SNg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] sha1_name: Parse less while finding common prefix
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, stolee@gmail.com,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 2:54 AM, Derrick Stolee <dstolee@microsoft.com> wrote:
> Create get_hex_char_from_oid() to parse oids one hex character at a
> time. This prevents unnecessary copying of hex characters in
> extend_abbrev_len() when finding the length of a common prefix.
>
> p0008.1: find_unique_abbrev() for existing objects
> --------------------------------------------------
>
> For 10 repeated tests, each checking 100,000 known objects, we find the
> following results when running in a Linux VM:
>
> |       | Pack  | Packed  | Loose  | Base   | New    |        |
> | Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
> |-------|-------|---------|--------|--------|--------|--------|
> | Git   |     1 |  230078 |      0 | 0.08 s | 0.08 s |   0.0% |
> | Git   |     5 |  230162 |      0 | 0.17 s | 0.16 s | - 5.9% |
> | Git   |     4 |  154310 |  75852 | 0.14 s | 0.12 s | -14.3% |
> | Linux |     1 | 5606645 |      0 | 0.50 s | 0.25 s | -50.0% |
> | Linux |    24 | 5606645 |      0 | 2.41 s | 2.08 s | -13.7% |
> | Linux |    23 | 5283204 | 323441 | 1.99 s | 1.69 s | -15.1% |
> | VSTS  |     1 | 4355923 |      0 | 0.40 s | 0.22 s | -45.0% |
> | VSTS  |    32 | 4355923 |      0 | 2.09 s | 1.99 s | - 4.8% |
> | VSTS  |    31 | 4276829 |  79094 | 3.60 s | 3.20 s | -11.1% |
>
> For the Windows repo running in Windows Subsystem for Linux:
>
>     Pack Files: 50
> Packed Objects: 22,385,898
>  Loose Objects: 492
>      Base Time: 4.61 s
>       New Time: 4.61 s
>          Rel %: 0.0%
>
> p0008.2: find_unique_abbrev() for missing objects
> -------------------------------------------------
>
> For 10 repeated tests, each checking 100,000 missing objects, we find
> the following results when running in a Linux VM:
>
> |       | Pack  | Packed  | Loose  | Base   | New    |        |
> | Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
> |-------|-------|---------|--------|--------|--------|--------|
> | Git   |     1 |  230078 |      0 | 0.06 s | 0.05 s | -16.7% |
> | Git   |     5 |  230162 |      0 | 0.14 s | 0.15 s | + 7.1% |
> | Git   |     4 |  154310 |  75852 | 0.12 s | 0.12 s |   0.0% |
> | Linux |     1 | 5606645 |      0 | 0.40 s | 0.17 s | -57.5% |
> | Linux |    24 | 5606645 |      0 | 1.59 s | 1.30 s | -18.2% |
> | Linux |    23 | 5283204 | 323441 | 1.23 s | 1.10 s | -10.6% |
> | VSTS  |     1 | 4355923 |      0 | 0.25 s | 0.12 s | -52.0% |
> | VSTS  |    32 | 4355923 |      0 | 1.45 s | 1.34 s | - 7.6% |
> | VSTS  |    31 | 4276829 |  79094 | 1.59 s | 1.34 s | -15.7% |
>
> For the Windows repo running in Windows Subsystem for Linux:
>
>     Pack Files: 50
> Packed Objects: 22,385,898
>  Loose Objects: 492
>      Base Time: 3.91 s
>       New Time: 3.08 s
>          Rel %: -21.1%
>

These number look pretty cool!

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

double signoff?

> ---
>  sha1_name.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index f2a1ebe49..bb47b6702 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -480,13 +480,22 @@ struct min_abbrev_data {
>         char *hex;
>  };
>
> +static inline char get_hex_char_from_oid(const struct object_id *oid, int i)

'i' is not very descriptive, maybe add a comment?
(I realize it is just walking through the char*s one by one)

Maybe this function (together with the change in the while below)
could go into hex.c as "int progressively_cmp_oids" that returns
the position at which the given oids differ?

> +{
> +       static const char hex[] = "0123456789abcdef";
> +
> +       if ((i & 1) == 0)
> +               return hex[oid->hash[i >> 1] >> 4];
> +       else
> +               return hex[oid->hash[i >> 1] & 0xf];
> +}

sha1_to_hex_r has very similar code, though it iterates less
and covers both cases in the loop body.

That is the actual reason I propose moving this function
(or a variant thereof) to hex.c as there we can share code.
