Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7E391F453
	for <e@80x24.org>; Wed,  3 Oct 2018 15:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJCWlx (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 18:41:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33527 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWlx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 18:41:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id g26-v6so5845900edp.0
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u9FdIPFQ4GFYTRF8ED4hcKd8jgsDGNKVJlstR78h4b4=;
        b=WVFjGFBh1HqHf+Wa0BX3TDcZoEOew4a39/FR3rU1w+2XWVPAqQNXh474MaF6VfULca
         ikcWk+fJeq05AMpumdGZc1uS69XfAJna1xjqxIxRK38ijTYPNiafV3ACwsDWLbLdRmon
         UBrbeMkM6lmPQFzagdeXf84IsS/dXkQWWNS7v6OjBZwzSvm4T45DXOJBDJoG2AB07Wkf
         ZAchhcINt28nRDtXRgg3Z5sTlDlL3Bib6hC1C7wUN+cMn0aREUkRx0ncNsGYrEA5PRlE
         JtTqh/c3muUvGjFlORT7JVMA6aSUjlYL+UU1RoJ0f4V3D3N4xwfXmdu2H300t8ABFz7h
         WkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u9FdIPFQ4GFYTRF8ED4hcKd8jgsDGNKVJlstR78h4b4=;
        b=HBCERfaxOqZmnpfqHCPidAb+nlGwWaIHyq7R6CENfiNlFBJUC64evcJWFPVlXKpG6M
         5l4U+s3LX+C1MMeyJSt6NjkWqQCRiVlS9J1brRHW0yq2X5r+umUjVG62FxFvPFA7nTLV
         reElh/G21D4NVedRCd9PS+lBR3vZ9USiLP5oqvEUrf61+4+efKY0slA/h3/V2oNsC2CS
         KuGfcd/c5TD9uYYWuHJAeewrA/wVmeW6G9sbXARx5OzSQpwqP08vy3Bnd6RfBqtYCly8
         l/oRAPKrh2lpYzqWJKS0ZSs4ZzZU2kBu8MMIIGE2Jy8Dwb0QnOyZizZiV0zGzH8eRnNP
         No6Q==
X-Gm-Message-State: ABuFfohnQzpaieCw6HgZq8g4TUxK77PuaH2e++kooENdXbqvExcUt683
        HRAhBlVkzv4+oGRsfEalQSc5JiZ5wUg+DZ9DMTM=
X-Google-Smtp-Source: ACcGV60pU0M+B3+j6nw9L67eY3JAEUFFh5elWJEK/LEgyjEPAmUqE0lliMCbtepGZnb3gwdFxKj9czU9b7E4vN5w3xI=
X-Received: by 2002:a50:8878:: with SMTP id c53-v6mr3118903edc.146.1538581974737;
 Wed, 03 Oct 2018 08:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181002191642.21504-1-jacob.e.keller@intel.com>
 <20181002195519.GB2014@sigill.intra.peff.net> <20181003101658.GM23446@localhost>
 <20181003150522.GQ23446@localhost>
In-Reply-To: <20181003150522.GQ23446@localhost>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 3 Oct 2018 08:52:43 -0700
Message-ID: <CA+P7+xpB5Pqj7Kp5HiUDqtNMiX8+kGt5QfwLaZ+ROY9jj+Xnrg@mail.gmail.com>
Subject: Re: [PATCH] coccicheck: process every source file at once
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 3, 2018 at 8:05 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
> In fact, it works finer than ever, because running 1.0.0 with this
> patch on Travis CI notices a possible memmove() -> MOVE_ARRAY()
> conversion:
>
>   https://travis-ci.org/szeder/git/jobs/436542684#L576
>
> Surprisingly, running 1.0.0 without this patch, or running 1.0.4
> locally either with or without this patch doesn't notice that
> memmove() call.  Presumably that's why Jonathan could kind-of "revert"
> my conversion from f919ffebed (Use MOVE_ARRAY, 2018-01-22) in his
> 6a1a79fd14 (object: move grafts to object parser, 2018-05-15) without
> anyone noticing.
>

That seems very odd...

Thanks,
Jake
