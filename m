Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A386B1F406
	for <e@80x24.org>; Wed, 16 May 2018 14:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeEPOcS (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 10:32:18 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:38593 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeEPOcR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 10:32:17 -0400
Received: by mail-vk0-f67.google.com with SMTP id u8-v6so623822vku.5
        for <git@vger.kernel.org>; Wed, 16 May 2018 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bQvILwIH+wEYO+tjduSlun6jxTPg6MCfRBc7eBmZJG8=;
        b=s6gPvmmXtE6CvRQJLEjTSwHySgr7tzDTMyK/cSyvpkgR6DIO4kjEXK+eJOqu/yeAE3
         w8FNbjVIGnQX+AS3t8GO3GkGC/EM6Cu+yYdDSUJthGYYfx4aF8g/O2xCoQZ7aJwDh9KX
         TYJtxj5xJp7MaWh4EaBjcWpj2AvQgDU3/pAF+aGurs4O5VZXrlQcZz0iJMkB3QvfEnEK
         WdV8nVhVU9NQEG5mz4co39cjZysCnafq5BW99e+j2qIPLe4XvKdQMBlYUCuHOtEnolZB
         C/EBgDtQsvADDQ7h/BdJhqhI535jA8d9MapZ72EZ0R0Ubkz9R2KOB5xaJwCW9G1F5jJ3
         RQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bQvILwIH+wEYO+tjduSlun6jxTPg6MCfRBc7eBmZJG8=;
        b=T4rIs5smXboPDJU43fw5kHlwFoPZybx4wXBAzX1xXoMtHqtniIdt0TjQOjsd9kyPMN
         VTpKvHRADCgurAiVayR69RmMRTfSYaIe3vFBKKt1DvGlpE4TnJ6F01/31db3pZmgLgNT
         9uKgaDIQIDB5Qf+f6ESF1/ieymj9t5NXeg7GScP4OMeICeJfWsMea3MqkEQ7nLIZdORI
         Txmc8F0EUsIoMkmzRofRD7euy0ptEYZ72uo8VkK+Uf8Q3c4Ixwi3pdumlMHlSuMA4OJh
         40qxl7YKlHTOqtNU5Y6LfNPRJfwFzXCjOgY637ERt+W4SgFYbm4d6WV9Vk+JsZhQzRmt
         5hlA==
X-Gm-Message-State: ALKqPwcw+rxmGSfbDwzqDAnMIvtxHV/2qdvthlEXRuHKyvXuOlz1Fvdy
        CH83REsI+cdJW+vbBBUaQF9zd8fQQdFi2KuTtgE=
X-Google-Smtp-Source: AB8JxZr0AQmhmteYGRRiSRbhQCu8q4p/NPRrJfmCC+yWQIJg/rGS2YE7aXne6pQHXgpxXwidypq+G+iVVM37FZJ7eV4=
X-Received: by 2002:a1f:2cc6:: with SMTP id s189-v6mr999199vks.106.1526481135979;
 Wed, 16 May 2018 07:32:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Wed, 16 May 2018 07:32:15 -0700 (PDT)
In-Reply-To: <20180428113257.25425-1-martin.agren@gmail.com>
References: <20180424162939.20956-1-newren@gmail.com> <20180428113257.25425-1-martin.agren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 May 2018 07:32:15 -0700
Message-ID: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com>
Subject: Re: [PATCH 2/2] unpack_trees_options: free messages when done
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

On Sat, Apr 28, 2018 at 4:32 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> As you noted elsewhere [1], Ben is also working in this area. I'd be
> perfectly happy to sit on these patches until both of your contributions
> come through to master.
>
> [1] https://public-inbox.org/git/CABPp-BFh=3DgL6RnbST2bgtynkij1Z5TMgAr1Vi=
a5_VyteF5eBMg@mail.gmail.com/

Instead of waiting for these to come through to master, could you just
submit based on the top of bp/merge-rename-config?  I've got several
other merge-recursive changes, some about ready to send and others in
the works.  I don't think any conflict yet, but I would rather avoid
causing you any more waiting or conflicts and would rather just have
both your and Ben's changes in pu and then I can just build mine on
top of those.  Besides, I want to see that FIXME go away and have
fewer leaks.  :-)

Thanks,
Elijah
