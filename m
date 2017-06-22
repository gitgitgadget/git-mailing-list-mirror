Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0568620282
	for <e@80x24.org>; Thu, 22 Jun 2017 06:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdFVGu1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 02:50:27 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:32789 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdFVGu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 02:50:26 -0400
Received: by mail-it0-f66.google.com with SMTP id x12so2351278itb.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 23:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oslFLsRnZFnJD8k9rvcfko+GOn+rn28GjbblbZyfvl0=;
        b=TiZO5IJwppYLRfu1qz/U2/BsvW+U2bOsASQ+zKVWmBZ9HIqeJ43hcXduWK2A49aXwb
         wYsvC5PBwtTRRqQzFXfE4HThVGwtvV+8D6EpyUtNayYWUjJ+1zQ9yt9wi3EHm1OQZcRt
         qSswlVBCLdP8Kqw0GBUXqVi+qqnSzL8P/jJweRNrON8qCiXS4RGEurikzeRR1T4ZjJGp
         aCtddSQhoG064m8qPRR8p+qgR3BImLabSnLQuAoJqILU5ci40+e500AJ6mhkUsgzl5FO
         zG+V4wLtaM+VK9D/bQirkrwqHiPThXhrlUjehBLvu7J7KqSEiJmFGty1E+XDhXnuj9yo
         DICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oslFLsRnZFnJD8k9rvcfko+GOn+rn28GjbblbZyfvl0=;
        b=RpuAtsuyFTMQbK3UIx59g9T4koWoG8EvhUhDlwx4pXWStB0i3DsLjwfxL71f0EFM4a
         wLro8a0JQQOj2Gpm17wL7btQIISfY2aT11AbYTsBXCnBMUbXJgLI7dchKSktv4xLBJCK
         YNKmiy4sUHDk0yGlN+rcIZMOKgFDZKavT8m645PgedYB+qbxkRp5+sheztAAxIBgr8cD
         JTebasrcmreqcIfzlokoXHGwdIVCuUTnjRjtlo39KavfleH4kBDbMoXiZjmMpAsxbcE8
         JqMP8d2cHxGyc+Lhcyz3HjoEZEtvfrNL6W++gNnPaLukgckVPjkIgcsv1sBEtx5xhZNn
         EKqw==
X-Gm-Message-State: AKS2vOwECNXdMGtBpQRPirdgwML2yLIEEecjVg3gOzubS29Nuol8s/Wz
        e6yen+l/9+HVxt2fIAHvgeHKK8FBRg==
X-Received: by 10.36.8.195 with SMTP id 186mr532398itc.76.1498114225821; Wed,
 21 Jun 2017 23:50:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Wed, 21 Jun 2017 23:50:25 -0700 (PDT)
In-Reply-To: <20170619215025.10086-5-pc44800@gmail.com>
References: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
 <20170619215025.10086-1-pc44800@gmail.com> <20170619215025.10086-5-pc44800@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 22 Jun 2017 08:50:25 +0200
Message-ID: <CAP8UFD3_toXcKzMmikkwaiGi7oHJ0BcT4s1fYe6hW4mYjUdmGA@mail.gmail.com>
Subject: Re: [GSoC][PATCH 5/6] submodule: port submodule subcommand sync from
 shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 11:50 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:

> +static char *get_up_path(const char *path)
> +{
> +       int i = count_slashes(path);
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       while (i--)
> +               strbuf_addstr(&sb, "../");
> +
> +       /*
> +        *Check if 'path' ends with slash or not
> +        *for having the same output for dir/sub_dir
> +        *and dir/sub_dir/
> +        */
> +       if (!is_dir_sep(path[i - 1]))

i is always 0 here, as we decrease it until it gets to 0 above.

> +               strbuf_addstr(&sb, "../");
> +
> +       return strbuf_detach(&sb, NULL);
> +}
