Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DBEF1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 17:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeFIR30 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 13:29:26 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38978 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbeFIR3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 13:29:25 -0400
Received: by mail-ot0-f196.google.com with SMTP id l15-v6so18278976oth.6
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBOlsA9V/4h62UZPCSmMWU6z4RD4Wb/bCCXYrnMLjyk=;
        b=RXDtkhFa8CC6MphotV8fPnb92xssGYBzbe7VEOT7KqqOkFScs3CGVsLKwPK/UUwb7f
         tEGimIZfLzMMrtLUiB2Ep64FoOm7Mljln5QKqlmUspMdQMI31Hk4ijXbvlGloyQSP3W/
         ScQqcL3G433NVb6RwLw3on0oj7J4sArDS8G9wPzGDmPas38jbpfcawZ6fMfabYUTjyUa
         xZ+5NGIZgCrD36wgW5VEFerYYcrlHroY+aO+PoX1HUjg/9lD6EfE5AXRD0w6WzY+pOxv
         tkoMPe6VpGO8NcARuYpgQtT5N7vdiyGshQ1iuX+LfgFq+KQ5TIakRVwBCKrw1Rsfatjs
         rOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBOlsA9V/4h62UZPCSmMWU6z4RD4Wb/bCCXYrnMLjyk=;
        b=PN+puF4ad2+mTtDLQsHnCOa0+LY4vxSdBtsuHq1rHnYJ8lcrDYOQpfBmwsL8JDSsMh
         xbsWa94cbHklMccxbdOehsJkjhVEhnNoY6ZgI3OSD5sivCJSL9OD75T/FDAQMSjIGBLl
         PPXgTAmcQ4OOCv8lQ2cs/QAzaAAss2mtHA7TOQJAWjyVPRvb+5bY+PMUYUexIbqXwoC0
         GXJUG+G+EuLMC45muFySSKPu8d+10WKxnSiZ6/o9Bk2EPP3nojT+nsKCQcbsyv3B66A3
         1dNVNoKzUZi9cDtZMraJbhZ5DxpmZKYBl5mdTi+DPH8NUZiOnZvB+FffEgBw9BKYiN3F
         espg==
X-Gm-Message-State: APt69E0l/nKuVT9TwSOozajqfJl3je+X2R20FublpFQIFdykYcT4C80O
        +4W9R0bGHuhUXmcibD4hIwqRV/LgDJbiIuMC5no=
X-Google-Smtp-Source: ADUXVKLbFU/6M6ghl3RFziAQceN2K4OFUMDtKP5pW0KeeaRioNVw0F1jTh+l8NmI7ZK3e4/nKnUS3Xf60+Jd1qGvTho=
X-Received: by 2002:a9d:55a8:: with SMTP id m37-v6mr6758376oth.75.1528565363702;
 Sat, 09 Jun 2018 10:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-14-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-14-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 19:28:57 +0200
Message-ID: <CACsJy8DW8foQ8+KDdjf4g_3UNi5oSqJyHYo5d9j4cth_yBXDCA@mail.gmail.com>
Subject: Re: [PATCH 13/23] midx: write object id fanout chunk
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 4:06 PM Derrick Stolee <stolee@gmail.com> wrote:
> @@ -117,9 +123,13 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>                 die("MIDX missing required pack lookup chunk");
>         if (!m->chunk_pack_names)
>                 die("MIDX missing required pack-name chunk");
> +       if (!m->chunk_oid_fanout)
> +               die("MIDX missing required OID fanout chunk");

_()

> @@ -501,9 +540,13 @@ int write_midx_file(const char *object_dir)
>         chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_packs * sizeof(uint32_t);
>
>         cur_chunk++;
> -       chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
> +       chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDFANOUT;

Err.. mistake?

>         chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
>
> +       cur_chunk++;
> +       chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;

Same here.

> +       chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + MIDX_CHUNK_FANOUT_SIZE;
> +
>         cur_chunk++;
>         chunk_ids[cur_chunk] = 0;
>         chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * MIDX_HASH_LEN;
>
-- 
Duy
