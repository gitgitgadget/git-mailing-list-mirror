Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B95101F462
	for <e@80x24.org>; Sat, 15 Jun 2019 08:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfFOIl6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 04:41:58 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:35439 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFOIl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 04:41:58 -0400
Received: by mail-ed1-f51.google.com with SMTP id p26so7213709edr.2
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 01:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6mhKycMoTkDnfpCB3kGrJDmNE8lYsiICHnxrdN7wqQ=;
        b=F9aaBjKHw+IULKX0D5cJ0NVUJkqm/j41BfSv7zvMwBpFBO2cvX630Dxz02Ic18gG68
         HGuBJc1ad7B05JfiWSlTukvtGGU/Jpcu4KWy8FJjjsyhp6GWOkv8icbqzlWPDWWZA9VL
         Ok1204N5ZEMYlSAXVD3ZqkULdVmu7P3P/8yXgWKAfAd48+ZDmZDRBoJMD0QqldTeaPdK
         Gz4e2bwI2JbeGBDH8N7gQ1ksZXYopANdczOQe+uQXBkjaH35zaUVk8PjKc4lhS+FDXqw
         c6tmp+1h9LgHHWHboEkh70ELhBM5fs/G+Xhm2cTg/loLNtxHjgx29+UI7LPObdxqAkSf
         Om0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6mhKycMoTkDnfpCB3kGrJDmNE8lYsiICHnxrdN7wqQ=;
        b=jNsCs/3S5wXlZjGPBneYLy535p8JEH+iTZ8kZXwVhVtJZKbZscarQOKszAEKzQnYfG
         n6RenfwLzsXZ5GDmY50IG5+MmxyqQWdem/P0wACys1NLa0ce/TLLrmQ0bW/ElfZPeQPb
         55McSjWNQECNjhAkzjjhYkZ7+x1JE5F5w5b8QPpUzF2hVPYYwnk4QPFo8hODv2oIiWU8
         oLREiVCRBSeF+O2vXkt1Vdnui30ySRCfPE5anXpuiTPmsfI3WCxgk7hSOwHbRTvoLHia
         WAxsapomWhrhSsRGu1r4pF5eN2PnQ/opZu6sFi2hJeyv3XctfVkLA+64oo4xXbzmrYmI
         QMig==
X-Gm-Message-State: APjAAAUet9IxkF3RFiHPsG4LPqgKfMbq4IjARLUmbhGfrBILGGbRNQ+M
        wn+Mim6ArxeqDJKWNJQ4J7tcdhEoWyme71tCMN0=
X-Google-Smtp-Source: APXvYqwoz1GdsGl/tp/7/XxrgKWAXSV1paGKktYg8RpDoGSOfxdl/TJvXfUUBt9DQdC9m/TlQKyfbCYl6fim5dOAXdU=
X-Received: by 2002:a50:9107:: with SMTP id e7mr20982700eda.280.1560588116660;
 Sat, 15 Jun 2019 01:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
 <20190614150758.GA22984@sigill.intra.peff.net>
In-Reply-To: <20190614150758.GA22984@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 15 Jun 2019 10:41:44 +0200
Message-ID: <CAP8UFD2dhGqOxXJMTZhNSM5G4sp6PvKF+0R5KVk6YjAQi3Sccw@mail.gmail.com>
Subject: Re: 'git interpret-trailers' is tripped by comment characters other
 than '#'
To:     Jeff King <peff@peff.net>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        git <git@vger.kernel.org>, masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 5:10 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jun 14, 2019 at 08:35:04PM +0900, Masahiro Yamada wrote:
>
> > Perhaps, 'git interpret-trailers' should be changed
> > to recognize core.commentChar ?
>
> It looks like the trailer code does respect it, but the
> interpret-trailers program never loads the config. Does the patch below
> make your problem go away?

It seems to me to be the right analysis and the right fix too.

> I do wonder if the trailer code is correct to always respect it, though.
> For example, in "git log" output we'd expect to see commit messages from
> people with all sorts of config. I suppose the point is that their
> comment characters wouldn't make it into the commit object at all, so
> the right answer there is probably not to look for comment characters at
> all.

Would you suggest an option, maybe called `--ignore-comments` to ignore them?

Thanks,
Christian.
