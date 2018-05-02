Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2DA21847
	for <e@80x24.org>; Wed,  2 May 2018 17:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeEBRSM (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 13:18:12 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37427 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeEBRSL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 13:18:11 -0400
Received: by mail-oi0-f66.google.com with SMTP id w123-v6so4656738oia.4
        for <git@vger.kernel.org>; Wed, 02 May 2018 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yW9xWV5rj8VFa+AURED5OOLDPnHB9qycaXjeRDhvQJA=;
        b=Sf0CC4MpcO3Rr7w+SqpaFzAlNHAf/Z9mVWiCEZjJZjpXDkFlNareJdjJiPb6dMqR4Y
         C6TYtlabFk4I+Ywy0Yf/m25eIbjL/jAkwFgOvLXuUr6/OyBiU27r5W1JOJcyZPHRyi2c
         mlP7wrEKbpyuedSShnmnLSMo3XO34l41xJLKmK3nKEbuWMRjerJ1zvZHUMcAlT0tuAkv
         hSKx052cB4MhK+o7oBNg2XcmcSGUj3F/ZJRYCJtWNCQHUjqKCMdpedxLPx7Vr5z8i5Zv
         0mOfJV/FyNmHWmjyELyLF1ShmvziFp4QxKc24xMEHuWQV2JYEl/1h4sLu/OqMBqR3I2a
         El/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yW9xWV5rj8VFa+AURED5OOLDPnHB9qycaXjeRDhvQJA=;
        b=J2QAl9qZ92I0MeEo3D7KCe/RowB8uVPHfNpl3B9sMTGBjwkGgV6zKxT/kyZ/Nbje7x
         23jGpf2Kl+/Ox/V8fmjLr7xrXQEjizwxNOy2CZbbpon+gKP5OdpasGZN6Y/yVre4pEZI
         M8BSCQ2e1q/v5wa3DI20ANq1aC02bm85UCSZQIuR+26+KghTKX/sCA91MR72mxBMOQ9G
         +jmNbI/azrBnrlSUMdzPaPTcgq0vQTR+7mC03CaT8ghhWLhf7r8RK0dsCWqctffSmHAM
         LWBjYB1sOSq1tNmcq0gZnIeyL7BNrojNWwCw4MUbZFa0Yvy1N9V1YW+3jyzHdI2GMWtG
         JJRg==
X-Gm-Message-State: ALQs6tB0FbR9uX+lZt+MujnNw6p8U0YGNOeISkNLqWE35XLV2N505tWb
        qA42AroZUzMWE8rSoh5YqjWDNRJdecocbm7RqcY=
X-Google-Smtp-Source: AB8JxZq1YCk+a7vBPME6ci4om6DVsco4Rs6BgSP0KcpsW3vaxCHtOb6aOE1dq4aHz+FBY9rlNvdMyqjVrIEluZuIJgU=
X-Received: by 2002:aca:2813:: with SMTP id 19-v6mr13193978oix.281.1525281491238;
 Wed, 02 May 2018 10:18:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 2 May 2018 10:17:40 -0700 (PDT)
In-Reply-To: <20180501213403.14643-2-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com> <20180501213403.14643-2-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 2 May 2018 19:17:40 +0200
Message-ID: <CACsJy8CgX6BME=EhiDBfMRzBOYDBNHE6Ouxv4fZC-GW7Rsi81Q@mail.gmail.com>
Subject: Re: [PATCH 01/13] repository: introduce object parser field
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, jamill@microsoft.com,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 11:33 PM, Stefan Beller <sbeller@google.com> wrote:
>         /*
> -        * Holds any information related to accessing the raw object content.
> +        * Holds any information needed to retrieve the raw content
> +        * of objects. The object_parser uses this to get object
> +        * content which it then parses.
>          */
>         struct raw_object_store *objects;
>
> +       /*
> +        * State for the object parser. This owns all parsed objects
> +        * (struct object) so callers do not have to manage their
> +        * lifetime.
> +        */
> +       struct object_parser *parsed_objects;

I like this name 'parsed_objects'. Should we rename the struct after
it (e.g. parsed_object_store as opposed to raw_object_store above)?

Another suggestion is object_pool, if we keep 'struct object' instead
of 'struct parsed_object' and also want to keep current allocation
behavior: no individual deallocation. If you free, you free the whole
pool (e.g. you could run rev-list --all --objects in a separate pool,
once you're done, you delete the whole pool).
-- 
Duy
