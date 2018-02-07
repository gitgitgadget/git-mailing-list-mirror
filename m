Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ECEC1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 19:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754695AbeBGTuh (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 14:50:37 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38722 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754157AbeBGTuf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 14:50:35 -0500
Received: by mail-qk0-f196.google.com with SMTP id w128so2700383qkb.5
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 11:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zdjECoXdqk8qGkykru153/Qmv3BqIYbxGH8JQaaD/xI=;
        b=ZylukewV2noDsgvrtJvlComWa+fy0rsSSJ1VzSsViagg84DfDb6WfEbpa2fp4rn48V
         000lkGjY7tMfs0wVuyZ43ACFGWKy+PnjPcHrMwT8v/osKppna+zp1UwoBmzRINijl5Xp
         tfBT4Er7sk4JxcvzBuSaPde6lq0ikuYyN7MyNtJKAJTFFpsSIdyE/5REdSVzoNBzoe0N
         i6UkkVgccdBECuZvt30Jq4VS8UQJoniDnPvUitbcedY0Pe99SjoNpKMf7fITPUPOanmY
         cP6xytq8BOYyLbNXyyiZp9o85pKwARCdXjtekMREdueLobp8EGt6FPaor5YPmSu9J0Ls
         zy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zdjECoXdqk8qGkykru153/Qmv3BqIYbxGH8JQaaD/xI=;
        b=C4mHQ7prZ3QjWVaT1dzxGvXrgyrbrvSejflu839t72CkA4y17YqZrh3tJungu7jofW
         DS0woUYbuweH9J0TP0nAM+s7g1DYcqC1ykm4jDiSLoSVZDnSyqNVHVQcUVnQr6QApQn4
         PNOWEj/Eo4ZIzK4nh9GUKmY4L9kzqNmB2y7Qpih62WMgCvpFoIFAjZyVfk0cx6uSrfSa
         puS7nd7gNuMKdnSS+U5hRmSE1gAg6z0jEpUI85+exuFBP//CVO7Yq/zEWNQPeLxnTHi1
         aIb6n4AdduDC6wUJaLu4AIYBO6ponv0S/Yl6bjRJRkAAR60+0m+U0S8+FRtARvegzJNn
         9zlA==
X-Gm-Message-State: APf1xPBS5gfl6/sbwE9jHBTEaqg3PQaLh14cFcUJOODMQi5Ow6ajF2LE
        N8osSus+JEkB0IR/JykuKQKWMeQ2yuexd0R9zSg=
X-Google-Smtp-Source: AH8x226xNa6FiVH6DNQxeEJyeYAKd5vcTtVcq+JOtHmktHW+UizYeweFOKI7/C55Ty4qpifdM4dOLmqatuO6pQe78Qw=
X-Received: by 10.55.177.135 with SMTP id a129mr11109502qkf.112.1518033034399;
 Wed, 07 Feb 2018 11:50:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Wed, 7 Feb 2018 11:50:33 -0800 (PST)
In-Reply-To: <20180207194547.1412-1-sbeller@google.com>
References: <xmqqlgpppri7.fsf@gitster.mtv.corp.google.com> <20180207194547.1412-1-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 7 Feb 2018 14:50:33 -0500
X-Google-Sender-Auth: uDHQ2Oe1zYUrUU-fgwnTKpWApZA
Message-ID: <CAPig+cQZr=UN3KC3LnaKy=oUYd1inbtDgi_pDuhPXf9HgFOdNw@mail.gmail.com>
Subject: Re: [PATCH] send-email: have default batch size when relogin delay is given
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, mina86@mina86.com,
        mst@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jan Viktorin <viktorin@rehivetech.com>, zxq_yx_007@163.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 2:45 PM, Stefan Beller <sbeller@google.com> wrote:
> When the batch size is neither configured nor given on the command
> line, but the relogin delay is given, then the user is not using the
> the feature as intended. But as the user gave a relogin delay, there is
> clearly the intention to delay sending out emails. Assume a batch size
> of 1 instead of silently ignoring the given relogin delay.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> @@ -379,6 +379,12 @@ unless ($rc) {
> +if (defined $relogin_delay) {
> +       if (not defined $batch_size) {
> +               $batch_size = 1;
> +       }
> +}

Maybe also print a message that this batch size has been used as
default lest the user wonder why it's sending "slowly" without
apparently batching anything.

Alternately, complain and die if both options are not specified.
