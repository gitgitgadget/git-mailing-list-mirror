Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 511991F404
	for <e@80x24.org>; Thu, 19 Apr 2018 20:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbeDSUy1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 16:54:27 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38004 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeDSUy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 16:54:26 -0400
Received: by mail-ua0-f195.google.com with SMTP id q38so4356264uad.5
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 13:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P119ynbsgUuVJopw0Yn4u+c6+QDN8fC0VbVdK9ulPBw=;
        b=bGVraqJyzenI/I2pTNNMAoylZ/+BUT7OZlmWRUygDQ7Mg2GhVrul1De1RqqMCXnzfc
         kPQV7ZPk4X89MUyWc5nETWiCq4Cr0lPatIR3BV35MBcLjlX3JFFvTlM++dJKbBqe9oPt
         GhMG7ybN3SNzFllustB9OeJ6P79KLrkf/OFMHnvHDeWfxlongRgByDihKyhuIgBblcbD
         b4VF/8juqzdTgjv4du0GRsgyx676bltETQrFXSeYT87qi9LW3kqcasbuEz9gbG1ZRhSh
         SxznIt4ZRKL8FANhYXlRLnmQlTrATpkTs+6uSkCl0wjwxkhWwLl0225B3j6pm6hNCzHa
         CD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P119ynbsgUuVJopw0Yn4u+c6+QDN8fC0VbVdK9ulPBw=;
        b=Abe0poYbhFGMkf8cc1qGM+6Wq2gbpUyUVR68NZXT2w1U3GcR864bohD22VnyHjuFXY
         qQ8/v339/BdgxVPs0Qc840/I3IRNDEXQ4tmDPmW7VSvI3Ksih+6yRozJjZIAM9R6CnHD
         3WWyiU/4A0cA/YuKYaEmIuFD6aoQe8Wvzqu1fJkLACSr7rFhtXTCz4xe5eWNRiHejW8H
         gPcT2FbmR/PVZSBRKFdWoANCJU9axYwDlFLApphIobElChldBlhr+wZRvIdaxuDLJArv
         9Xj8Ch0KBjFg1lGEao09EuN9TbxQXCgofYwIJhJaK1zXIR0xlhQ+sx4+4IrnFWyRAJSr
         OmCQ==
X-Gm-Message-State: ALQs6tCg8i9ts+d3wxZSRxgv7spDzrLtJxvhO4V1vMtNBSMVHgqAA5Tk
        ROgIAk8wW7fTGH+IZgN7AvYYVFSxNB/06LrIKJc=
X-Google-Smtp-Source: AIpwx4/ld060v5YUL1hUvsAtAOMYj2hCTrxG92EGRbDxl9991YHahNa+VDK9MgjUE2ZxWWzMck+yST0HgSoEHoYZTaA=
X-Received: by 10.176.19.226 with SMTP id n31mr5754018uae.199.1524171265705;
 Thu, 19 Apr 2018 13:54:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 19 Apr 2018 13:54:24 -0700 (PDT)
In-Reply-To: <CAN0heSquJboMMgay+5XomqXCGoHtXxf1mJBmY_L7y+AA4eG0KA@mail.gmail.com>
References: <20180419175823.7946-1-newren@gmail.com> <20180419175823.7946-34-newren@gmail.com>
 <CAN0heSquJboMMgay+5XomqXCGoHtXxf1mJBmY_L7y+AA4eG0KA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Apr 2018 13:54:24 -0700
Message-ID: <CABPp-BF9gjC-Jw=NZQygxwQ7d_dbZEUB2OoQ-ieSG6bNUWs5BA@mail.gmail.com>
Subject: Re: [PATCH v10 33/36] merge-recursive: fix was_tracked() to quit
 lying with some renamed paths
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 1:39 PM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> On 19 April 2018 at 19:58, Elijah Newren <newren@gmail.com> wrote:
>> +       /* Free the extra index left from git_merge_trees() */
>> +       /*
>> +        * FIXME: Need to also data allocated by setup_unpack_trees_porc=
elain()
>> +        * tucked away in o->unpack_opts.msgs, but the problem is that o=
nly
>> +        * half of it refers to dynamically allocated data, while the ot=
her
>> +        * half points at static strings.
>> +        */
>
> Timing. I've been preparing a patch that provides
> `clear_unpack_trees_porcelain()` and fixes all such leaks. (About 10% of
> all the leaks that are reported when I run the test-suite!) My patch

Nice!

> conflicts with this series for obvious reasons. Figuring out the
> conflict resolution might be non-trivial, and I suspect it would even be
> an evil merge. I'll be holding off on that patch until this has landed.
>
> BTW: s/also data/also free data/. But since I'm promising to get rid of
> this TODO quite soon after this is merged... ;-)

Oops, good catch.  I can fix it up since I need to fix the issues
SZEDER found, but yeah if you're just going to implement the fix and
rip this comment out then it's not that critical.
