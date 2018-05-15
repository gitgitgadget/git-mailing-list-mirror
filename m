Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08EC31F406
	for <e@80x24.org>; Tue, 15 May 2018 01:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeEOBFW (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 21:05:22 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:43016 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeEOBFV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 21:05:21 -0400
Received: by mail-yw0-f194.google.com with SMTP id r202-v6so4170997ywg.10
        for <git@vger.kernel.org>; Mon, 14 May 2018 18:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PqvrEE+0qtUj2UMz2ZSznN+FaCPV6hm22FKyhTKks/Q=;
        b=ZIILOfrgOiJ2oj3wOs2Rc148rL6t8UFph6eXRXuDjjBIB7hv7K1V+CxSnraBN/pOdR
         j3acC5iFI/X8NRY3MMecVzY+52wEWsrBM6VJEOk+q2mrdU/IO64j93/sVyu7il0tJK/q
         HDnp/Et5YIJqu6Js0+++xbQBy2rjWRPUP4YQ8xXG8vKzCiQOLKIVYgbnwsZpR3qzVlVe
         MFPrSkSeQgKVSpx4G5CZ3O01W7zr869AsVDWgFPixC9hxoXRtLwtMBPe2jrlC8pZ4uIS
         qTa8NLge+TN0WobKgTKGRRuQDH5wDmw6eBb/ps6EZBYmJDq0aKVOXbTMXXodNNd0UKuN
         2Q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PqvrEE+0qtUj2UMz2ZSznN+FaCPV6hm22FKyhTKks/Q=;
        b=VeY2DfqwOuqHbdvpKGNbwCg6DiCitWClAfCbotF8YQkPz597bYPitPRxrBMjeq1WaG
         naLx1+6r/8LYhhF6uZNPUmgYpP4URzf0OpVeaatV6KlQZGC6Eq+V4vosbcnFJ5m3lo64
         xu1vWb81tJerLoX8ornLVRSSkfzs9nhR37tZig77BzhD+HUvBQT0Jrbxd0ViGtkXpX8u
         LGQ0WgjUZhYsqA/Lcs49+CSLBFroKzZ0FXKHfr3DRmWBbsxRTp/X9wZDdtmmlotSgqbF
         Jt6cnW9JgOatRm1Z6Xv/TkJZGCv3yCSOG6X6u3HnVW4F1Zs8QpvmUx2gqvow0o1hC/Cs
         j48w==
X-Gm-Message-State: ALKqPwfL5cOXbPFR1xA2tUgNDaXQhEo27CwpFRAdY1w30ITw7EGLd2vz
        QZ0ctI7LPpKVKWf/zP2QzRF5RNE9xTpviNbiVhpdIL15wjI=
X-Google-Smtp-Source: AB8JxZrf+vasqFQ5PPgrWVO91HhAQCnoLBAHxnnKB0P0ZVu585C2G2u9B9WkmSFkGC9pe5V0+aBx2t9OQc4mHG/3i9c=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr5515644ywf.238.1526346320332;
 Mon, 14 May 2018 18:05:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Mon, 14 May 2018 18:05:19
 -0700 (PDT)
In-Reply-To: <20180514105823.8378-2-ao2@ao2.it>
References: <20180514105823.8378-1-ao2@ao2.it> <20180514105823.8378-2-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 May 2018 18:05:19 -0700
Message-ID: <CAGZ79kag=1h506FGg72_F9Rmz4nqPN19kaywfTtD3WnNWnxD9w@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] config: make config_from_gitmodules generally useful
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 3:58 AM, Antonio Ospite <ao2@ao2.it> wrote:
> The config_from_gitmodules() function is a good candidate for
> a centralized point where to read the gitmodules configuration file.

It is very tempting to use that function. However it was introduced
specifically to not do that. ;)

See the series that was merged at 5aa0b6c506c (Merge branch
'bw/grep-recurse-submodules', 2017-08-22), specifically
f20e7c1ea24 (submodule: remove submodule.fetchjobs from
submodule-config parsing, 2017-08-02), where both
builtin/fetch as well as the submodule helper use the pattern to
read from the .gitmodules file va this function and then overlay it
with the read from config.

> Add a repo argument to it to make the function more general, and adjust
> the current callers in cmd_fetch and update-clone.

This could be a preparatory patch, but including it here is fine, too.

> As a proof of the utility of the change, start using the function also
> in repo_read_gitmodules which was basically doing the same operations.

I think they were separated for the reason outlined above, or what Brandon
said in his reply.

I think extending 'repo_read_gitmodules' makes sense, as that is
used everywhere for the loading of submodule configuration.
