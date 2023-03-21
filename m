Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633DDC6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 18:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCUSKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCUSKP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 14:10:15 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B421F903
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:10:14 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r4so8555144ilt.8
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679422213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=soqFlysk0izVcjuEIjDaUoagYgpVqLRoVXr72K4ZQag=;
        b=E1FMxlCmKopMVKwfyanVFYzD4zmYFu+h0R5dk8c0eaWdFc/kdkqQ76cruDmldub+e0
         FhVvP92meZKhAPG1FLOVBR6kKp0QJ9bLEHfSrYD4B1wPBVquEQ8iDpCkfrXX1h9RDcNe
         578fUDDW7kWP7VG22N+a87gIOmQRiQqbulKTvmJyge4ZMaoPAgPgNT0R3n8mS3c+5V1m
         Yx/94K2n6O9T0HO9g6WS+Ig36sOX+/868pJ4DaCUwJHcD9s4fgUzIc4j//arTlgFRh5B
         ObdUKAlDYa30KmLV/nxZHCuZNct2fxmkYwbhw7zzLex+TYBFASCZJaDClZE2VcG58j1H
         pQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679422213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soqFlysk0izVcjuEIjDaUoagYgpVqLRoVXr72K4ZQag=;
        b=l9Ctd9i/uf0hnfnI90dpZSAAX3fjgDcME+qZYICDFy3pkBYithmI6QoHezcHeC4oGt
         2+r3X5gk8J0dWgeNERrQjyOKwX91Kug1q0RolLFao0/XA6x286Mh0m6Di6D93WbIaOkH
         scCpjornFwtXzUd40mCQrHA43YLOvvPtSJGFZZ2oKDfrh33KjU93FqOA4a+s1ggSleif
         o8zV75WOfHwuOqFw9nlnzz5md6s6a54D8YcUj34FacbpoZ2impktGJZpiJ0CxI/rT1lR
         KOjZV3S51lIEr/6hwpy2wTZKN7eV//HFQ156sfjq+NWanqk8cslSZ8rvjuqh80609J8H
         xGDg==
X-Gm-Message-State: AO0yUKUrL3Xb+SjXQKcc5VPp/SgrBzw66M+5rBByLHqJqBPN1hFucSCh
        fKACJoRAEkZ2JRfoZTlNFmKDAg==
X-Google-Smtp-Source: AK7set+3h3bFW/OEl2vcKYZB45Mp0EatS+1WYJ0eCzbApRSXcqz+CbsSNMOpkkZbZq9oZUsFHhdROQ==
X-Received: by 2002:a92:d8cf:0:b0:323:29e2:a19 with SMTP id l15-20020a92d8cf000000b0032329e20a19mr2530723ilo.19.1679422213724;
        Tue, 21 Mar 2023 11:10:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i42-20020a056638382a00b0040653d9e194sm3197173jav.161.2023.03.21.11.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:10:13 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:10:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Edwin Fernando <edwinfernando734@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC] Intro and Micro-project
Message-ID: <ZBnzBEqViueKIXHx@nand.local>
References: <CAPNJDgcauhz_NraSPTQfiDM61gyghSJShZLPUtt5HOr2xKysZg@mail.gmail.com>
 <ZBnmsoRmQGKkQt+S@nand.local>
 <xmqqo7omhuia.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7omhuia.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2023 at 10:41:33AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > That sounds great! I assume that you meant avoiding pipelines where the
> > 'git' executable is in a non-terminal position of the pipe, e.g.:
> >
> >     $ git blah | <something else>
> >
> > Since if "git blah" exited with a non-zero code or crashed, etc., then
> > we wouldn't see the failure since the pipeline would suppress it.
> >
> > That has been a long-standing goal within the test suite, and I think
> > that it's a great project to get you started. It'll ensure that you have
> > all of the bits in the right place to get Git running on your machine
> > and that you're able to run the tests.
>
> Yes, but can somebody rewrite the micro-project idea page to clarify
> what the "pipe" thing is about a bit more, so that you do not have
> to repeat the above explanation the next time ;-)?

Good suggestion. I did so in the following pull request:

  https://github.com/git/git.github.io/pull/633

Thanks,
Taylor
