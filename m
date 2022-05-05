Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C748C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 16:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbiEEQTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 12:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381989AbiEEQTY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 12:19:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C381DA51
        for <git@vger.kernel.org>; Thu,  5 May 2022 09:15:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dk23so9677755ejb.8
        for <git@vger.kernel.org>; Thu, 05 May 2022 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfAVTX4xXIswk5Gn2VqMSZnsHJk3fYxd+19OJ8pXTEs=;
        b=AtyZACB5baJstM0Ygbs/iZQQ62Dvzg8IBH3bA9h/XC4URGWZ2DSnMXnpFBoW3UWLec
         1BAL/If/gmNDDL4k+7OJL2jW+n+33eOfXGbXGp4VmciApRBSs7sUY0gHbuK3XonzXbuF
         mLLeKQFwcMEea5EUH3594Ihd2bEtybNf1UV4jcgTb+L94mPmbptAdZk26lQqHhioHFLS
         swj5Ndu3InSp3zkVQHK+F1UUF2ky6VVINylHpBJ7HnzU4EoqMY0789+F/0d/HoHXHjtA
         YKK4Hdkn+h/PgmQRX/l/aqp1VPgEAVyISF7kiBZqNx5/BywA877Qhk28ORuszZHCoKcu
         a9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfAVTX4xXIswk5Gn2VqMSZnsHJk3fYxd+19OJ8pXTEs=;
        b=ekYre1BNNFDsR7AtMyq2dHJESEk+K1BLJo4V7S0UwmStkSOHJhCVPGkZhjqe57bcm0
         3nVmvozGSua8RNfJ65rD6yXAaHfKeublCHnMNp6XdBEwyz56OFsCQ0rpk8AiujBhqKks
         DIoNK1XVuiVeFipHYWgT0MnWry8FsaGiWdCR+3rzqwAKxfIONcjqaGnrCMcJErQ9R49Z
         P5QNMeRCCosF0Ob4kSJ8aJmMhwt3gf0bJslnhPh5CdXEZD0qqYx6mUGsmeLOwdetoxkC
         2MeW/EfXkOWAktUJtWnppO06eDsdCYpaCJZmYbzfwyWMBNDpaEG4LzxEK+4qNOTi+IkY
         fujg==
X-Gm-Message-State: AOAM530S3a4sUy7c1uzAuEy4jxZtxHHGfYD9N1aGst+nElBJkFgO5KSL
        6ZQQPDHKtsK0ZsCazVtqevDS+pKWcGXd2PR7m8o=
X-Google-Smtp-Source: ABdhPJx05V+VQVy1su7tLb+A3Pgp5imtkxCOud5eEPKY2mP1n/TXvMUR45d3m8+Kvmb2/X/WvKBkdPFMEmaWLfx9JtQ=
X-Received: by 2002:a17:906:a05a:b0:6ef:a44d:2f46 with SMTP id
 bg26-20020a170906a05a00b006efa44d2f46mr26759693ejb.192.1651767342703; Thu, 05
 May 2022 09:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqilqnvacd.fsf@gitster.g> <0facc01f-ee36-333a-eb25-9c98d616700e@github.com>
 <xmqqy1zhmftk.fsf@gitster.g> <CABPp-BHDKRX4sW_Jjqw5j7Voas0X_xkFZgg5Jqk0TkNZOd7k1g@mail.gmail.com>
 <xmqqmtfwezx5.fsf@gitster.g>
In-Reply-To: <xmqqmtfwezx5.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 5 May 2022 09:15:31 -0700
Message-ID: <CABPp-BH8VsH+Y3UxAvZM2kua8XGRE1RyenrESeYwofcq-=kjbQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2022, #01; Mon, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 5, 2022 at 8:56 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On v2 you said, "There are a few things that I found questionable, but
> > they were mostly documentation issues".  You brought up several points
> > in v2 where my wording in the Documentation was admittedly suboptimal,
> > though I think I addressed all of those in v3.
>
> Correct.  The above is all assuming that "cone is the future" is
> what is shared by the population that depends on sparse-checkout.  I
> do not have strong opinions to declare that, but to help the topic
> move forward, I was giving reviews under the condition, i.e. "If
> there is such a concensus, here are the things in your current
> iteration that would need to be addressed".

Thanks for the clarification.

> I vaguely recall there were folks who didn't like the change of
> default the last time you brought this topic up.  Convincing them is
> not my job---it is yours.  Mine has been to help prepare the code
> ready for public consumption when that happens.

That's a surprise to me; I don't remember anyone bringing that up,
ever.  Did I somehow miss it??  I'd be happy to talk to anyone and
hear their concerns if they do hold such an opinion.  Over the last
year or so both Stolee and Victoria have suggested such a change or
said they wondered why I didn't include such a change with other
sparse-checkout changes we were making, and I mentioned a few times I
thought it'd be a good future plan and finally submitted it.  To the
best of my memory, no one ever offered a counter opinion.

Are you perhaps mixing this up with the case where people brought up
concerns with suggested tab-completion changes?  That's the only other
related series recently where folks brought up concerns with suggested
changes.
