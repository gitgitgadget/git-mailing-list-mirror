Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629B0C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 06:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0DF613AE
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 06:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhDTGKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 02:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhDTGKo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 02:10:44 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9862DC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 23:10:13 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id c195so41643440ybf.9
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 23:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=gGzwJxo+Km4P+rsBpp8TLReSH3dROPddFPxDgjRdgr0=;
        b=ciXIYMEwbR9Xe2obahC/iSX8tmhDyW9ajt2HgCEDWFOJ6Ko0uejZPb83dULivp3DIT
         86wR27e5Z323JdtTsw/2QO1NY77RB+PEsm6U85tk79dR742fxu4Cq9yjHHqeqfScOhxy
         fT9vBLBIzeuSyaIWjoFDMPylaEHVH1Ioj6xECKu4LSwjdionlT7hpaK1md+Ss5e/h0vt
         dZvBShwOY20tvMshYsOM+c/YoDOsZynlWP2cp9Bne136m70yb1oLx2y+KYOA163GHQro
         WYzSesrLt06+qcbTd7jZHohhz0s/RzLT8nFpytyg3wYr7kXnsRH2i0Sj+HmkRxBDNl/b
         UT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=gGzwJxo+Km4P+rsBpp8TLReSH3dROPddFPxDgjRdgr0=;
        b=fNfJJ8MPUfdi2CJ1Ex4598aJzznBvI5Ucy3gWnx+tl5HZ6C9KBSkvWZBSeyGrt/Ean
         6Y6GnZ6AxaLZ3W8w+xPpQ8/cEyS1E5ZBKOljkeMEkYX3zEbOauVYbb50HqenwCpgLyVw
         Qp6thKNB6MB0ixlnmRWMN55LoGyw4OX/QX7Opm2WwGILWRIc4QVXoOC4V+lehsf3Rmcs
         LYX7Pvd4zKZBGwvKCquZf0Ht1oAAd9Xp82dlEBDUti3rQu4J2Rh7CqS5+LBoZ1r+F26o
         zEMOcGLVU7CujC4jE3aHDNyQKlCxyngJ1YCBZVWS2EaTIr4hoDfzgel+NdC515hihp+0
         SKXQ==
X-Gm-Message-State: AOAM532dnoE/n2LEoM1NSqkupEvR42MXPS6oJfVMzoj5J/mYgqu7mBMJ
        G6BydZ9YTCVH/2Kdn/YH2LibzIMwMd3CUsjZVhACGA26mnc62w==
X-Google-Smtp-Source: ABdhPJwZ9IkrdQOyXWcRIgdZo9gYhQVGj+8Xw9Z2zHeCGHzh5Q0SF86bCuVxLjqrVwayN+OoYKmhukviKpwUDi1Ekuo=
X-Received: by 2002:a25:e74a:: with SMTP id e71mr23538382ybh.408.1618899012836;
 Mon, 19 Apr 2021 23:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAOWQn3Qesh0+CkaD95q78Rq_vN5tjWKDe7HTk0Ynk-NY8XUKzg@mail.gmail.com>
 <YH42xGwjTX4Axcpp@camp.crustytoothpaste.net>
In-Reply-To: <YH42xGwjTX4Axcpp@camp.crustytoothpaste.net>
From:   Cristian Morales Vega <christian.morales.vega@gmail.com>
Date:   Tue, 20 Apr 2021 07:10:01 +0100
Message-ID: <CAOWQn3Rr7qsTTjY1CYj1SAXk6_fhEc8mFn1o4Dep5N0c9yeK1A@mail.gmail.com>
Subject: Re: git checkout behaviour when only ctime of file changes
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Cristian Morales Vega <christian.morales.vega@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Apr 2021 at 03:05, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2021-04-19 at 09:11:12, Cristian Morales Vega wrote:
> > I thought you may want to take a look at
> > https://issues.jenkins.io/browse/JENKINS-65395.
> >
> > Basically after something updates the ctime of a file, a
> > "git checkout" can behave differently depending on whether a
> > "git update-index --refresh" has been run before or not.
> > _Maybe_ it could make sense for "git checkout" to always behave as if
> > "git update-index --refresh" had been run before? No idea really.
>
> I believe the situation you're seeing is that git checkout usually
> doesn't rewrite files in the working tree that are already up to date.
> This makes checkout much faster in large working trees.
>
> By default, Git does include the ctime in its computation of whether a
> file is up to date.  If the ctime changes, then the file is considered
> to be stale.  git checkout, without an intervening command, will
> overwrite it, since it's dirty and just overwriting it is cheaper than
> determining whether it is in fact up to date.

Yes, this is basically it. The "just overwriting it is cheaper than
determining whether it is in fact up to date" is the main thing. I was
thinking that maybe, if ctime has changed but mtime hasn't, it could
be faster to not overwrite the files since I _think_ it means the file
contents don't need to be checked, only the basic file permissions (I
don't think git stores any extended attributes, does it?). But I could
be completely wrong here. Otherwise "core.trustctime" seems like the
perfect option for the problem.
