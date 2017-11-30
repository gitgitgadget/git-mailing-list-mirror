Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E41C20C11
	for <e@80x24.org>; Thu, 30 Nov 2017 18:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750849AbdK3Srb (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 13:47:31 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:37211 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdK3Sra (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 13:47:30 -0500
Received: by mail-it0-f49.google.com with SMTP id d137so9613957itc.2
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 10:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sUqtWuvXsZWoryVTpLQtuHiNJ9SOyYBONPbkI/gi28M=;
        b=ISPjur66FhbXXPZqln4Zw7bpvaAgVNaLnJw1NHWq+cXa8+dcyc0uakTIVHQ+5xRUDS
         coDyPr2gtu+BH77Qe1DXN5FRYJJGWdseGWQ4pUMt49N2b3EQyEZ/+1HpS98A9ZRIlRaj
         60ePDtHPGaRXKi1c32M36Fw8fXk6VOq2sXVFQQ3L/V3sX2VFMV/0A6T8yF8e0A6KstWd
         p0o7Bh7nR2hMsHqxDbUhdFn1a1/uRjEWdI2Ik4UuS5buvPT6u7vaTNXZWCDjSPZ00nPR
         XtiJvvbDKgDJACdklB8FkWWhSEfsvfRUmQpvCGnVUf6iPjSR7dYQBWoZ4QeK8khTjYsa
         6WGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sUqtWuvXsZWoryVTpLQtuHiNJ9SOyYBONPbkI/gi28M=;
        b=PP00pITapE0mRKvL8tduYAQ4xhPTDGHX5z4ibeM15zM293GOiMlTgsGmmXYJTON7TM
         0EmSlMYPDOss0WCRM//nM+d/J+GgyZ2JZh0g+RQedggNiV4B8KAv7YxRPS6slBE1A3Xg
         OvBxOhHsVd+dY2P6lK/8uWLWExuaPPZeu+N6Opa3Vp2OVfcg57XiLNF7SmugRnDtkhrz
         U26b+dIc+u+E8+NHtO/P6ADVWKGBm6f8kxGFskXWMt4RMPVJ3yx3CxmOodowWCzAVUzX
         dQwo7QUh91zv3bJS/NWwBmNNNJea4S1sY3qWjQceyfqvzN3AuMVilWpskBhFsiVOmu9r
         Pg3w==
X-Gm-Message-State: AJaThX6P4gQgrj7jpoa0ojnwXXiiu+Xg199DRWb1jX8gbxyeI5QymI/0
        s5HPqWY+jHQyrEIj42B4Nku8zgFksDCsjXjDJBkEXA==
X-Google-Smtp-Source: AGs4zMbxEjCwnDjydrhQI3nrDEJXBu4YY9HR9Ujv+hWf/rI21TRTftvFkhfxN7VksxAg4DklaLug7gNgvD9053l4cv0=
X-Received: by 10.36.16.208 with SMTP id 199mr4756524ity.0.1512067649519; Thu,
 30 Nov 2017 10:47:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.109.73 with HTTP; Thu, 30 Nov 2017 10:47:08 -0800 (PST)
From:   Daniel Knittl-Frank <knittl89@googlemail.com>
Date:   Thu, 30 Nov 2017 19:47:08 +0100
Message-ID: <CACx-yZ10GiDT=dDeF1EUtM_K4nGd414SDfxLRqGWyXt0ub02Gg@mail.gmail.com>
Subject: "git describe" documentation and behavior mismatch
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git list,

the help page/manpage of the git describe command has an example with
the --all flag which should prepend the ref namespace (tags/ or
heads/):

> With --all, the command can use branch heads as references, so the output shows the reference path as well:
>
>          [torvalds@g5 git]$ git describe --all --abbrev=4 v1.0.5^2
>          tags/v1.0.0-21-g975b
>
>          [torvalds@g5 git]$ git describe --all --abbrev=4 HEAD^
>          heads/lt/describe-7-g975b

Running the above commands in the git.git repository yields a different result:

>     $ git describe --all --abbrev=4 v1.0.5^2
>     v1.0.0-21-g975b3

No "reference path" to see. It is however shown, when the output is a
branch name:

>     $ git describe --all --abbrev=4 origin/next
>     heads/next

Is this expected behavior? IOW is the documentation outdated or is the
git describe command misbehaving?

Thanks,
Daniel

-- 
typed with http://neo-layout.org
