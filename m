Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93808202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 15:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbdJCPzT (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 11:55:19 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:44210 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbdJCPzS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 11:55:18 -0400
Received: by mail-qk0-f180.google.com with SMTP id r64so8440529qkc.1
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sm64j9zRQxnlh9DkrIeuZroNUKXDjAtYn8jltYeseMQ=;
        b=bqDv4Lg0HDZJ7NDW4D8MhqZ+ORybqzFdcklZJIcTLQ0OaGSN5bK5MetyBoxbcINQjM
         QJmT4HdookURubKt8FGhWwtygbUqKgMke5lJ9kjr9YtMunl7K36pYPRpf1MSgLVVlicK
         tgXfRcD9FXYeNS3DuX0orH/ddOWOU61Vm58luJ0xIXbnjRSLQW9moWu9K5YhRj3+vEbv
         7TnsbZOOlGpJQxkKz6GdTtEH5i0+m25867gOX0ThwwqmSlnlKF5WC3HZgP8pr1Y0RO5y
         Yeo29bB5YbbSP8KLO3nQzvZrfv/A0lOonBRIZ1h+coN/0Hd26vQv0oei2D7mp/8HWhG+
         Vh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sm64j9zRQxnlh9DkrIeuZroNUKXDjAtYn8jltYeseMQ=;
        b=DurmSogFq+oMJ8I4Xd9enuVAx9pS/f+vgFUeuQLWVdIlJKiDi89WDICT9vsdnbRmv5
         Mq9o+E72Ywfv8H1sk4BnJu2Sv1leJsl+MUhetuMvkO4s20ZL63NyvzukEGO4rPlJldwt
         zuvgzKA77uLTtY2V9R9/6BFg2v7JeO6zl2agmhAbvR9BtTnhdrMpi6dorrmUw7rGFTlH
         MJOC+uRSKuhtf6QzFEsRsqyjBEQfZ29rCVesVoZxTttTxkUJAEtPA1QycL0w/woKoDMn
         iE5nGAqBdc692FR6If/HhcJtetRTPo9rzn3kgFp1zJeYhMUBPPb9bLqim4EGT4f0NIBL
         Kz+Q==
X-Gm-Message-State: AMCzsaUmesuqEBemS9ofNxO51PRABURagPjNHr7E5tC+j5GdngGmoSo8
        0ZvwpXsDSYlVJWHVCE4JcMBsMCZ/GTRgHlg3Q9thYg==
X-Google-Smtp-Source: AOwi7QCCExfyPG1WNrM/H6kaEn52y5Wv7HFPlq7rYhIgxoXVcIIOWFcIlMm4qCwXOplAunoNGXrYOJEJTv5RgcLkcRQ=
X-Received: by 10.55.45.199 with SMTP id t190mr21419356qkh.230.1507046117422;
 Tue, 03 Oct 2017 08:55:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Tue, 3 Oct 2017 08:55:16 -0700 (PDT)
In-Reply-To: <20171002145651.204984-6-dstolee@microsoft.com>
References: <20170925095452.66833-1-dstolee@microsoft.com> <20171002145651.204984-6-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Oct 2017 08:55:16 -0700
Message-ID: <CAGZ79kZz0EPUo=FpndxQMztQ=x-_c_CbvRB2NDmTLQXWapDBqQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] sha1_name: Minimize OID comparisons during disambiguation
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -505,6 +506,65 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
>         return 0;
>  }
>
> +static void find_abbrev_len_for_pack(struct packed_git *p,
> +                                    struct min_abbrev_data *mad)
> +{
> +       int match = 0;
> +       uint32_t num, last, first = 0;
> +       struct object_id oid;
> +
> +       open_pack_index(p);

coverity complained here with
    Calling "open_pack_index" without checking return value
    (as is done elsewhere 13 out of 15 times).

I think the easiest way out is just a

    if (open_pack_index(p))
        die(_("Cannot open existing pack idx file for '%s'"), p);

or is there another good approach?
