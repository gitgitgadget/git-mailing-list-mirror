Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F322C1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 23:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeDIXhc (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 19:37:32 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:39349 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751652AbeDIXhb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 19:37:31 -0400
Received: by mail-yb0-f170.google.com with SMTP id g197-v6so3660352ybf.6
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 16:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8dmp0fUjmt1udYLz5C+LDUo7o6HK4JG6WA6z9Jlim84=;
        b=iuD0GUp/8w//ElN2mV++8SZF9luHLIGncMBU/t+0jOACqngLHB4LufybbZE0w4hcry
         PxYOqSGF324gEAlCRyZwJmsIuf74LQpY7ipV2KymoOyjULZ2m67n6nOc9gyjN5nLH0pN
         wHAezdX1LTfOfO5+uM+XrrzCTnU6OAE5g9/R6+wIicgtRT/QaQogCWPpTZ/Z3q46R6ZB
         jj0j8GRkxdOM05MBvTUWdsrhUhg8N0prVv36v1wJFBRY2ptEWS1Et3+hMLo5UC35Y6Cx
         PY3Y0XxVFd4J1WK5GHpQQkVJVTUu9rWkdjIMaByIThdivFW4sjmm3Q4QQGL/bhm7TaHD
         /LBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8dmp0fUjmt1udYLz5C+LDUo7o6HK4JG6WA6z9Jlim84=;
        b=RD263YUu4gGjVRx/X1tL8rEtNQdUE47OPihWVHYbXaICMSNKncQ7nbyoeH2VKUG9WA
         1o7rMcIPSSiLMaJ6+skwoZnpYsJeb5sd6akRY9QAzC9R9S8QibsT06UuqD0M/Oh/JT8H
         qGQEkPIFwkptme7DhqMPmBQw8iErfAqy9hvU1IsglpkVZESY4fOZoLaErWwmeQ5J/uVZ
         fmh9uSi/FkLVrysq9r6/abe4lcEd2HBJnrTpp6tAun0dVIJLX9ONBB9PFVlfA78SJs4t
         xpg7clGm6WQINX9K5/r7+Ipp2/VgbtYa2NIBGWg4AaHPKWZtP5eQNxJa5QMC4hAH1SP+
         Qfcg==
X-Gm-Message-State: ALQs6tBDGHvimp9EX8ZNI8f+h43UBqos4iTUl1HDE3rqCG00LS1TPecd
        nndGAJ1ETgvJGpMgRvv4hF0A5wz07IZ9ebMz+86dNA==
X-Google-Smtp-Source: AIpwx48AgyNFZKVaf5+Tr/t9pdqQu0R1uavcqJWlPz9OHzFPCpUZdqvJAEIsJBVLs/oh4ahzF9aGQUlq1WcRa6kEvFI=
X-Received: by 2002:a25:8e0e:: with SMTP id p14-v6mr3375345ybl.352.1523316709132;
 Mon, 09 Apr 2018 16:31:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 9 Apr 2018 16:31:48 -0700 (PDT)
In-Reply-To: <20180409232536.GB102627@google.com>
References: <20180406232136.253950-1-sbeller@google.com> <20180409224533.17764-1-sbeller@google.com>
 <20180409232536.GB102627@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Apr 2018 16:31:48 -0700
Message-ID: <CAGZ79kaNXb0rZVrbbRstX9uKU-rmkC6PTj9gw7MrzWGEDL9ogw@mail.gmail.com>
Subject: Re: [PATCHv2 00/16] object-store refactoring 3 (replace objects, main
 ref store)
To:     Brandon Williams <bmwill@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 4:25 PM, Brandon Williams <bmwill@google.com> wrote:
> On 04/09, Stefan Beller wrote:
>
> I've looked through the series and it looks good.  My only concern is
> making sure that the ref-store is in a good place to be embedded into
> the repository struct.
>

Michael knows more about the ref store.

Could you have a look at (the preparatory)
https://public-inbox.org/git/20180409224533.17764-8-sbeller@google.com/
and
https://public-inbox.org/git/20180409224533.17764-13-sbeller@google.com/

Thanks,
Stefan
