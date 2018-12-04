Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8097211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 12:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLDMBp (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 07:01:45 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51532 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeLDMBp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 07:01:45 -0500
Received: by mail-it1-f195.google.com with SMTP id x19so14935056itl.1
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 04:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sokDqmmi2RHPoA67xJgK31opXVMISQ4FA+bElgkLmzU=;
        b=ETm9GS87Kdq0NB1xJ6ZR5QVAyU6Rt+QwZ1I6oKxlmw/npVfjro1fAhJc46axdpbOpi
         HwCVQFp6dSKTuDxDF77q2VCdCaBWcZFuD4b17b1//t/TEefDM++39f6CFQt+CiUe2JCE
         w8PW+P/095S5fvghekSRx7h5HKLzwrckkpt/2An/rflNmXb34knUkbdiLM6M+UoBdO2z
         jrPKW7Hs7jdDyKHyXCEtW/bHB2PBGqy2ODt4PdGOitRZmrgi172yl4h6GSyMi2MPlsHi
         ePxZD8zAH2w5iUmvw5nbw8EBeX6SbdJwu3DkzdD8Px2X+rSYdqVasdoOCNobkQPk1SNJ
         eq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sokDqmmi2RHPoA67xJgK31opXVMISQ4FA+bElgkLmzU=;
        b=KLHRMx3BK9QgDEblgGoYzE1gesCilic38hRZCSO3gSfqeYUZIkBCijjoJHAoy5SsLe
         VUO2bl+tMeBvFVqHY6LVe0MAlgsBIjBfVoMfMxQ4S40B8GVX43jR/ionrW8lvmhyUWxl
         C/PFYJCMmlLRvtC+mUTDbAcZFLOaWYFAMlQQt192bmVaMgK1IkSnZgJvpSA8gBwp9Z31
         0f4linkUfzHlFvdm+7rz8/LdzNV0pNkUwUMLvSXwAC4vYNC9MugcLYJSxxbPbQa0zyjI
         Io/nhsyrIKh3iSM5QlRcUfyWZmu716lz+4l47LVXy0UyZzIdTCrl1P0WOMRnyPuxqhmp
         34rw==
X-Gm-Message-State: AA+aEWZ+dqH8OkcFrSjyVAZV+q1FojvhLagXGtvb5Bra2x+VwgLt/3iN
        NLzaY0t077Jjl7j1lFLk62yL0qYj07FBSbgcff8=
X-Google-Smtp-Source: AFSGD/XkDC3sLdyVdFHvocMODsi9+okHc5ATuSbDkSMX87N1EQKV9wbH9dSmwI8sCm5MRva+prL/8JgBdJQh5x+eUuM=
X-Received: by 2002:a02:3003:: with SMTP id q3mr18310711jaq.16.1543924904141;
 Tue, 04 Dec 2018 04:01:44 -0800 (PST)
MIME-Version: 1.0
References: <CA+YJQx72dMybGWyzNMUcNcVZnpDTHoaONcC-AQdqt=C_8aEdXg@mail.gmail.com>
 <CAP8UFD2xv6SK+qPXKr5hQ0ZctOR5K-BNg1wdBy5=fp2DVBZMHw@mail.gmail.com> <f9f644daa705c78ef348a4a808d88bc01e7bdbd4.camel@gmail.com>
In-Reply-To: <f9f644daa705c78ef348a4a808d88bc01e7bdbd4.camel@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 4 Dec 2018 13:01:32 +0100
Message-ID: <CAP8UFD3cD5KtvPJK5WkWGVUT6grbL=xL2MV1YWNJGpOjD3uRiQ@mail.gmail.com>
Subject: Re: [BUG REPORT] Git does not correctly replay bisect log
To:     lskrejci@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 4, 2018 at 12:20 PM Luk=C3=A1=C5=A1 Krej=C4=8D=C3=AD <lskrejci@=
gmail.com> wrote:
>
> On Tue, 2018-12-04 at 12:04 +0100, Christian Couder wrote:
> >
> > Could you try to check that? And first could you give us the output of:
> >
> > git merge-base 5b394b2ddf0347bef56e50c69a58773c94343ff3
> > 94710cac0ef4ee177a63b5227664b38c95bbf703
>
> $ git merge-base 5b394b2ddf0347bef56e50c69a58773c94343ff3 94710cac0ef4ee1=
77a63b5227664b38c95bbf703
> 94710cac0ef4ee177a63b5227664b38c95bbf703
> $ git log -1 --format=3Doneline 94710cac0ef4ee177a63b5227664b38c95bbf703
> 94710cac0ef4ee177a63b5227664b38c95bbf703 (tag: v4.18) Linux 4.18

94710cac0ef4ee177a63b5227664b38c95bbf703 is the good commit that was
initially given. This means that the good commit
94710cac0ef4ee177a63b5227664b38c95bbf703 is an ancestor of the bad
commit 5b394b2ddf0347bef56e50c69a58773c94343ff3 i and there should be
no reason to test a merge base when replaying.

After testing on my machine, it seems that the problem is not
happening at the beginning of the replay.

To debug I think it would be interesting to see the output of the
following commands just before we get different results:

git for-each-ref 'refs/bisect/*'

and

git log -1 --format=3Doneline

in the case we are using `git bisect replay` and in the case we are
running the commands from the bisect log manually.

(You might need to temporarily remove the last command from the bisect
log to do that.)
