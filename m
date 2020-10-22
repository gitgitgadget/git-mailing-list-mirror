Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB5EC388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 21:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C430A21D43
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 21:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt2uI5s/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506893AbgJVV1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 17:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442856AbgJVV1o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 17:27:44 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFFFC0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 14:27:43 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id b3so1725735vsc.5
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 14:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tqS3gPQnHbmC1tE6cFf53Pv/W0tYrRYlCy4A1hpIxaA=;
        b=Rt2uI5s/0Wn8hwX+stZ9Yc8P7Kg9OXn5BRisPdrGO7RW3zSCYGNuJOzLOOFfODncpV
         NHa+UkdjiCc0RzH9kS4DKGJ4mKn+JxL8f6JvYoPxPiYrhw1U5ffVM97xmJp01JCc25s5
         sxZ1mJyaEmI7lce+MTZe01J8G/E4azGxfmBZhm/OKAmEDxEX6NmQ9PuQsOWVMYtsY4d+
         94Jpr5Dzkt5afTDVWyjkjmQ1VPJOVX3WUwoEGl09QPrchGft2Ul6MKVmse04uuJn6oPP
         LdwzfUE5qSve/8Dnatz9TFW230NvR1pr8jBIiw7nNX21vB8vq2QEArEgmxZoSIGNOvuy
         V73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tqS3gPQnHbmC1tE6cFf53Pv/W0tYrRYlCy4A1hpIxaA=;
        b=UpTMqCUZ6YyoQuS+Xb9TpQErQXL2e1sUoNkvffQGVFoMie0+Lf0YL41zzPNahwYXg8
         XgfEBY+f6KTfhvlfV9xeQxLa+1joXVJjFop/k1vCNpAD6ja077bQcNqCnqHrRLqeC5bS
         21OzzcXWbI5wAeNQpYd9wYCsuKstS+JI3eP+mTyreOttVCTXvbYtpedmL+qpV9BO4kOn
         oXvFD7krAkWYzpZl357gqSGEA9WJTAs3i5QC+DCgtffqa0hMj0aOm6sGC87ChdMa0M2W
         8KPJRGv+1BQIxY/I0UvIN83VXGfdVPoj1VcYd8SFVjIt4xhz0pQg5WIdIaj8hfdNle3H
         3Y7w==
X-Gm-Message-State: AOAM531OtFInhWlh5Z3E7UzHb1fa40rNttQ9GiB0bZnqNshbxVN6On0m
        pE0sfNltQJM2hpcgtTFK556bzObegrK3MrOhsiJtyfF7SeFCLg==
X-Google-Smtp-Source: ABdhPJxKt40EdvuhDvg3g6sYzdvIPFO1KZpBxe5S4FJz0vJ5Z//0Ds4pFlxriTIS/0j4BP7BppMgaAD3M8Wn+B63F5o=
X-Received: by 2002:a67:f596:: with SMTP id i22mr1453336vso.16.1603402062775;
 Thu, 22 Oct 2020 14:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAKuTeyftpz8mQiiy2S56pxmW0fzCENAQ8=gmaTE5a-Ef5g216g@mail.gmail.com>
 <000601d6a883$66d8e180$348aa480$@nexbridge.com>
In-Reply-To: <000601d6a883$66d8e180$348aa480$@nexbridge.com>
From:   Adrien Berchet <adrien.berchet@gmail.com>
Date:   Thu, 22 Oct 2020 23:27:06 +0200
Message-ID: <CAKuTeyc6WhEguV2mi_eg8JYrhri0inBJE-xHL3ZbFRGuYsyaDw@mail.gmail.com>
Subject: Re: [bug] Cloning SSH repo into /tmp
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I encountered this behaviour on Linux Mint 20. But I just tried on
RedHatEnterpriseServer 7.6 and I could not reproduce this behaviour.


Le jeu. 22 oct. 2020 =C3=A0 16:55, Randall S. Becker
<rsbecker@nexbridge.com> a =C3=A9crit :

>
> On October 22, 2020 6:28 AM, Adrien Berchet wrote:
> > I encountered a quite weird bug when I tried to clone a repository into=
 the
> > /tmp folder (I just wanted to test something, so I was working in /tmp)=
.
> >
> > I run the following command in /tmp :
> >     git clone ssh://[user]@[host]/project/[project_name]
> > and I got the following error:
> >     fatal: the protocol '/tmp/ssh' is not supported
> >
> > I got the same result if a run the following command from /tmp director=
y:
> >     git clone ssh://[user]@[host]/project/[project_name] /tmp/project_n=
ame
> >
> > Nevertheless, the command works in other directories. Even the second
> > command works when run from another directory (this command: git clone
> > ssh://[user]@[host]/project/[project_name] /tmp/project_name).
> >
> > It is very specific and can easily be worked around so it is no big dea=
l but I
> > preferred reporting this in case it hides something else.
>
> What platform are you running on? I have experienced similar when /tmp is=
 linked to a separate file system with complex ACLs.
>
> Regards,
> Randall
>
> -- Brief whoami:
>  NonStop developer since approximately 211288444200000000
>  UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
>
>
>
