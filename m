Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3501C47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 13:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D28205C9
	for <git@archiver.kernel.org>; Fri,  1 May 2020 13:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLw0w1Ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgEANfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 09:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730772AbgEANfl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 09:35:41 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B3EC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 06:35:41 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id c3so2545810otp.8
        for <git@vger.kernel.org>; Fri, 01 May 2020 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zjqekg6x+ocRJ1sL9n2tM0Bf2X9kWvl7D8OYbRdaSN0=;
        b=ZLw0w1UxwBv+ifBCYRqdGPMYPdULYfXTI2s5bPv2wnP+XcqSuLNRpE89asPh2Gumra
         nKEFpV0JcP1A4m8KY7L8e0tUj8kkBpfmLYDeKyS+uvW0NMyhm6TctIYW8DlsamCt3Eyw
         FIqXEKf1zjAP0/JxHbkXZDeqy+QptQg8TG907W0tkL9Jhk/5vkm9Y7IbNrspxhrzvO0d
         E7Gv5c6bjWfaPMnJErhxdAC0kS0W5LXRle9+FHl42Li7X7E+aUM9ts9vnKXoMIQrpxRg
         l46ikoftmwBaxmiakJzIrTl+9sBQS5flur66ahdy1OS+WC5qNVg4+Fsp7P/v8JftD0XB
         gveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zjqekg6x+ocRJ1sL9n2tM0Bf2X9kWvl7D8OYbRdaSN0=;
        b=XLJUSQsQtgoYDRLHiDcEiuRbZYT+wSH/3qBhJNS5fdWutrf6K+EAX+XkdfCbXTLqco
         1JE5orAREMDu1XsmUVNAjdZDx2AHHlX/G2AlabD+HA/nTS5UxBnqPWtd6WuJIc/BV7UF
         DmhAtjuJ4oS+rcxiPUzHwd9USi/O+Nm8Dk+63sQTy4S8qcTpeQPu1AcjU1Z7r9sWN1TJ
         NNM7SUOMFnDUKqZrA5X6kNWONO5+xIrVD+hsNmYNZpyXsCKr6xZBoMZ7SY8HwnuswIVr
         z0hvmT1uHvp2z3T5myBkKFzHq9UAu91cqvos8BYcqD7+qxD022TdvgvxxN/CgawbGQY9
         58tQ==
X-Gm-Message-State: AGi0PuawYoYfFKyv1hy/OCYnxfIFSNiEyCRyeRFffjR4nMDFMLV2UAy1
        aPo1AcTB8OfLKW2rzdUJ09WG7v4MiaER73oxPBCP5Vsc
X-Google-Smtp-Source: APiQypINWUnY/+tke8z2XTVHHXXJRoqSGkvMnJVPTcIzm3dHc8DG9E6s1dSma4BCTWluNFPaw1KzUTdpK55LV2tA1hU=
X-Received: by 2002:a05:6830:403c:: with SMTP id i28mr3735172ots.346.1588340140450;
 Fri, 01 May 2020 06:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHTRwmjXXYAU_LTBF_9sX1CXFnGyHsu5_KHuCp1rB76-4zn=Gg@mail.gmail.com>
 <20200429184909.GE83442@syl.local>
In-Reply-To: <20200429184909.GE83442@syl.local>
From:   Doug Glidden <41mortimer@gmail.com>
Date:   Fri, 1 May 2020 09:35:28 -0400
Message-ID: <CAHTRwmhhQCs4i04atAK66REiFJP_9e910MoYMt9iyu2v6S2jVw@mail.gmail.com>
Subject: Re: git fast-export not preserving executable permissions?
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor,

Thanks for your response! It looks like git does not actually
recognize the file as executable:

    $ git ls-tree HEAD
    100644 blob 7d2f57b2381766924e1e4ffcc62615c637bbd784    executable_script.sh
    100644 blob d1d7cf309e091f54f268503b31653d8eba42fe88
non_executable_file.txt

Now you have me wondering if the real problem here is that I'm working
in git-bash on a Windows machine, which means the file permissions
aren't completely native. I'm going to run a similar experiment in a
native Linux environment and see if I get the same results. I'll let
you know what I find.

Thanks,
Doug



On Wed, Apr 29, 2020 at 2:49 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Doug,
>
> On Wed, Apr 29, 2020 at 09:36:31AM -0400, Doug Glidden wrote:
> > Hello Git world!
> >
> > I have run into an issue that I cannot seem to resolve with git
> > fast-export. When running a fast-export on a repo that contains
> > scripts with executable permissions (e.g. a gradlew script), the
> > resulting export does not properly reflect the executable permissions
> > on the script files.
>
> Interesting. fast-import and fast-export both understand executable
> modes (although Git only understands the modes 644 and 755 for blobs),
> so this should be working.
>
> I can not reproduce the issue as-is. Round-tripping a fast-import and
> fast-export preserves executable bits for me:
>
>   #!/bin/bash
>
>   set -e
>
>   rm -rf repo client
>
>   git init -q repo
>   git init -q client
>
>   (
>     cd repo
>     printf "x" >x
>     printf "y" >y
>     chmod +x x
>     git add x y
>     git commit -q -m "initial commit"
>   )
>
>   git -C repo fast-export HEAD | git -C client fast-import
>
>   diff -u <(git -C repo ls-tree HEAD) <(git -C client ls-tree HEAD)
>
> > To illustrate this issue, I created a small sample repo, with one
> > executable file and one non-executable file. From the output below,
> > you can see that the mode in the output from fast-export is the same
> > for both files; according to the documentation for fast-import, the
> > mode for the executable file should be 100755 instead of 100644.
> >
> >     $ ls -gG
> >     total 2
> >     -rwxr-xr-x 1 106 Apr 29 09:13 executable_script.sh*
> >     -rw-r--r-- 1  63 Apr 29 09:12 non_executable_file.txt
> >
> >     $ git fast-export --all
> >     blob
> >     mark :1
> >     data 106
> >     #!/bin/bash
> >
> >     # This is a shell script that should be executable.
> >     echo 'The script executed successfully!'
> >
> >     blob
> >     mark :2
> >     data 63
> >     This file is a simple text file that should not be executable.
> >
> >     reset refs/heads/dev
> >     commit refs/heads/dev
> >     mark :3
> >     author Doug <41mortimer@gmail.com> 1588167102 -0400
> >     committer Doug <41mortimer@gmail.com> 1588167102 -0400
> >     data 25
> >     Adding some sample files
> >     M 100644 :1 executable_script.sh
> >     M 100644 :2 non_executable_file.txt
> >
> > Please let me know if there is any further information I can provide
> > about this issue.
>
> Does Git think that the file is executable? Please run 'git ls-tree
> HEAD' to find out.
>
> > Thank you,
> > Doug
>
> Thanks,
> Taylor
