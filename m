Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB17200B9
	for <e@80x24.org>; Sun,  6 May 2018 15:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeEFP4d (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 11:56:33 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34699 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeEFP4c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 11:56:32 -0400
Received: by mail-pg0-f50.google.com with SMTP id g20-v6so11851592pgv.1
        for <git@vger.kernel.org>; Sun, 06 May 2018 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I9I6GCWX9ouq+BImjafl7mT9GJF4wgUN5ilG2vodWHQ=;
        b=csDICNxvFjSU+V2KiSwNgYTfYUV/sffEiYeEPXQdmV9xJlGDi/zcS6SEt4scaRCBOV
         c41IX9mgFtDLP0oYsmHoE4pj8oCRDYbg6PN+rzxO85nmRHzDyy159Dm7Evrr5TotaHRi
         7+DgCdrRYsbshvDobdlpgiWoxW2tWhNO2vrR/VC+bStyTpfMlcR7DL1Xd6KOGjdOE9kW
         Y/w3P2xYKsPhXV6K/40OkqdVvZBe0IayOJAccmJ91D3VZmNuySeOlUoZC0GNqo8w2Brm
         giybyJR98zscja5hVfnmuqDsGO6NqwXQkISf4dlyMVWN5nOjN/+kVj0Yzi/Zwfq4cIRO
         BM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I9I6GCWX9ouq+BImjafl7mT9GJF4wgUN5ilG2vodWHQ=;
        b=CVspK27dpkKi/GSuabnqrBLXaT5L0X9thdMNw5SIIJC59YN0ljAaadtqcWF83Pyf9/
         YfRIPFZzECTxvaJTOiaecyy9tWXJYNtsvv+U/+Z+kIP/F64Zj96FOHYZZg0e69KAMijL
         GygVuZB0bdjuSTr+HbV+7tPTO5JcUgHezPAZzttQKRRtPWmhRtuig6hItxyoFj9qibj+
         wx1bSIBBFlJur+EiUg4lL49LosMI7Rt9dti/18F51rKU+brV0l99aNw+tzsk7I1q3onH
         /b3tgqjRMU9xLq4weQ0sKl9MxNoEW8lKd+wgF6R8M9j5flkDL+Y3ZzNNz8Bens+2Mo1j
         v5lw==
X-Gm-Message-State: ALQs6tC0grBlHMd1TMlqKscZ0QiiBTTHoWWToJt5IKPLBMGHbuiFmtjS
        IFTLxxG1xeoLYzpSvdOiovAvR1HPzxWcdHnCRDcovWGm6jM=
X-Google-Smtp-Source: AB8JxZr2u9kzLxyOMnQ23AKn57R/9tswoLN+P9fg6dwMils8bECHLPNxuTpBdNaP8o37fWFeiv260xyxfV6Ew+Y+mXY=
X-Received: by 10.98.11.3 with SMTP id t3mr33922107pfi.32.1525622192322; Sun,
 06 May 2018 08:56:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sun, 6 May 2018 08:56:31 -0700 (PDT)
In-Reply-To: <1525621731.16035.11.camel@novalis.org>
References: <20180506141031.30204-3-martin.agren@gmail.com> <1525621731.16035.11.camel@novalis.org>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 6 May 2018 17:56:31 +0200
Message-ID: <CAN0heSpfu+070fxhjjccXQpfFnr13O4tvSaj44YWkFWVJL_4mA@mail.gmail.com>
Subject: Re: [PATCH 2/5] refs.c: do not die if locking fails in `write_pseudoref()`
To:     David Turner <novalis@novalis.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 May 2018 at 17:48, David Turner <novalis@novalis.org> wrote:
> On Sun, 2018-05-06 at 16:10 +0200, Martin =C3=85gren wrote:
>> While at it, make the lock non-static.

> Re making the lock static, I wonder about the following case:
>
>       if (read_ref(pseudoref, &actual_old_oid))
>
> die("could not read ref '%s'", pseudoref);
>
> I think this calls exit(), and then atexit tries to clean up the lock
> files.  But since lock is no longer static, the stack may have been
> destroyed (I don't actually know whether this is true, so maybe someone
> else does).

Right. After commit 076aa2cbda (tempfile: auto-allocate tempfiles on
heap, 2017-09-05) this is safe though. Quite a few locks have already
been moved to the stack, e.g., in 14bca6c63c (sequencer: make lockfiles
non-static, 2018-02-27) and 02ae242fdd (checkout-index: simplify locking
logic, 2017-10-05).  I could add a note to the commit message to make
this clear, like "After 076aa2cbda, locks no longer need to be static."

Martin
