Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97AE71F597
	for <e@80x24.org>; Mon, 16 Jul 2018 17:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeGPSZG (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 14:25:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43295 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeGPSZG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 14:25:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so32833477wrv.10
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6mMDCkY+kE65iL6huYICQ1sAgWrassx5DFXvfDr0Kyk=;
        b=brmFgMBKxxSe04WS9pIruTGn7QBQdXMTbJ6AkY2+bn+EwGIqErbiZ08Y+mixbgcW5T
         UO1+xiIuvk8k2rM3zWjfzaxw1ffvC5ww9Kgp0IBFOCxgMuktsh/DlI4FnvVYHlGTnmbo
         f3sATWOZ8e1lwR+aAbsZVE3rzsWWDVrDvnCb+8eyWa6rQ4sbtN1FCBFAl0AY+e3+1b4v
         hPhOHP9d8DA3T2rMrgQb/65Koi2Oif/zeCPhAYZQdVsjrHSfqImXDxhd/+TUwF6siktt
         quE2DCilgp4CenBrFDJw2zQyhOekQqSIwKGgW5kb5IPJJTyEAG947fkJ9/xHYOhhahpB
         zpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6mMDCkY+kE65iL6huYICQ1sAgWrassx5DFXvfDr0Kyk=;
        b=iI2d7HfJ+79aXeU7/sbQa9oQjl4YXK/dNJzJSgt0W/36y9vpR9wwp2sfm8n0j5p6V9
         IkiGB54CaB2StuFQEjkAEvcofz5a4A687Z45PyicVCKVvEb7++KHMTvmPO0NM7/h4i/0
         +LYSAz+U/aDD8XpZJHem9ih2pSqeFS0U83ERxDFtTUr083+NyXwklbS+l1fRh/mKM+zF
         /LcWRAALq/97rYrlFCrAJgn2UFn8IVypUoTuqmiXXOSpwOKxL+LuF/KSodySecCyl0Fp
         d5RG7Uk0+aoBWxo4Xk01TFukl3n6cAEB1Td8JMGvVTaGiq9N7G6KZHjYi4QX9g7GD2a7
         U1bg==
X-Gm-Message-State: AOUpUlGwCMGhusWihMrEwhW9d7GkK7kAxPAqRUKSDZvhmzw3KV1veQ4P
        G+steXfyNMZY/xAfbiPnDg0=
X-Google-Smtp-Source: AAOMgpcU20h32Dxo0stp4Af+UX2ZtdYgUUm2IppWyuOAgh/2WaYO1owyhovedg2rPYTKwaCpk4oXaQ==
X-Received: by 2002:adf:ec04:: with SMTP id x4-v6mr12079377wrn.245.1531763795179;
        Mon, 16 Jul 2018 10:56:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 64-v6sm24871761wrj.50.2018.07.16.10.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 10:56:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] rebase -r: support octopus merges
References: <pull.8.git.gitgitgadget@gmail.com>
        <xmqqbmbd3cc3.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kaYpw9t3kCvPnDiLc5z7cLFsVQv4XJDAff_T-bShEjPoQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.1807121450100.75@tvgsbejvaqbjf.bet>
        <xmqqlgagzah1.fsf@gitster-ct.c.googlers.com>
        <8dbaefe4-778e-1e83-4beb-0261699cc483@kdbg.org>
Date:   Mon, 16 Jul 2018 10:56:33 -0700
In-Reply-To: <8dbaefe4-778e-1e83-4beb-0261699cc483@kdbg.org> (Johannes Sixt's
        message of "Fri, 13 Jul 2018 18:42:07 +0200")
Message-ID: <xmqq1sc3ukry.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 12.07.2018 um 18:26 schrieb Junio C Hamano:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>> A much more meaningful measure would be: how many octopus merge commits
>>> have been pushed to GitHub in the past two weeks. I don't think I have the
>>> technical means to answer that question, though.
>>
>> It does not mean that misusing a feature is a good thing and should
>> be encouraged if many misguided people do so.
>
> Just recently I had to rebuild the version of git-gui that comes with
> Git 2.18.0 before it was released:
>
> https://github.com/j6t/git-gui-ng/commit/f07ae1d7f07b036d78a3d4706e6cb4102e623fb3
>
> I think that an octopus merge is the right tool for the task. Am I
> misguided?

It could be used and it is the right tool are two different things,
I would think.

