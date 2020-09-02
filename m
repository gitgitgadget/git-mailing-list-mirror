Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE45EC433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88667207EA
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAXBaxTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgIBT2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgIBT2q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 15:28:46 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7046DC061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 12:28:46 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id l1so66887uai.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 12:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fYvAHeq/9as3X30FF7IRef4oxTKTUQ7b4SKsWZz8xDA=;
        b=FAXBaxTvtREpX65gs+L2F61I2GzIqRloP81t5oq10s4CvtivczQphUjXUPxArhnQ3R
         piMWp5TuIBW8doqDBcpl3XGGhg57w18A7HM1W/04rI7SG3RkNWSji1iSnZUaYSTTcUcf
         9PV+HAGq7n6c1bgGOJEFhJ2QmqxhdCMSiVBNJ4/PGy4nztCMP3XmZzfsPPMpgumag5WM
         pqJTxrXqGLoUoSc6t/goE7WPZTVxZkJxhniwRh+4kOnJym5JPHS62u7b6QZYYwMxek+9
         0sQ344m/hQg3vmFPti/mGAj1s++sm/Xnr9wzubbiviVsSfRHVYpm3P7Y6A2eTeR84kfe
         qnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fYvAHeq/9as3X30FF7IRef4oxTKTUQ7b4SKsWZz8xDA=;
        b=KZdpKDZkhK3X1bQtL/KGm1+Q7cjdzjflVcQBzJux+2Uie46SWHCzRrTd6was09ulbt
         HNwkn34N9ZomSssjSJcgU3nKoHQGJ4Vuh1ng/dhppzLfyCtDpfuUtTSj0LA4GJYzmlQf
         BV7rlqhlIGniPJ/kmEFRvokEnbZ9CjowyoowApgykkSlUQr1od2MWTD6xriAQm/1zEPC
         2zkymhpCJ5Wfjkk9kaiR+qiVEpqAS5ktgLa2uJ9+tO0FfcFY8+VonKroKL0DmCfc/h6r
         L7x622kPiSItubljZKaRgCVyoagIlbQaoz288V16gCouZopCqk2wfAh1pF3aVBv0bKDx
         UwRw==
X-Gm-Message-State: AOAM533CFa+DTsBYiNKEFT4sm5Fi7I4R/DQ3nTK9L3GK1Gn7dOuH6+Sw
        Ei/Pv9b8KGGGd2CdJza8uI9EHwZezWHq2aetLmaSZ+uwonk=
X-Google-Smtp-Source: ABdhPJwFzHk9/Lcjf9ZVNHW59A38lVvSmn+W1Dv5WUHseqJps7ngppic1rUBQk4xdyGq4/QqSoAP6X/CQ5ZoufgbVr4=
X-Received: by 2002:ab0:679a:: with SMTP id v26mr6397441uar.27.1599074925580;
 Wed, 02 Sep 2020 12:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAEbcw=3mOoYuJo2mQgqB2aJgn-D2i_7ZRmhfPvYNVHD1Kp8wuA@mail.gmail.com>
 <20200829044842.GA5732@dcvr>
In-Reply-To: <20200829044842.GA5732@dcvr>
From:   Ivan Baldo <ibaldo@gmail.com>
Date:   Wed, 2 Sep 2020 16:28:34 -0300
Message-ID: <CAEbcw=1S8CE-fnM91F0_KKCXqDzDy5B1Bycz2x2ymtZmi+miWw@mail.gmail.com>
Subject: Re: Fastest way to set files date and time to latest commit time of
 each one
To:     Eric Wong <e@yhbt.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  Hello everyone!
  I just now managed to get time to work again on this, sorry for
replying so late but wanted to do a single reply with the conclusion
if possible.
  Let me tell you that I feel very humbled by all your replies, thanks
a lot for your time and concern with my inquiry!
  Eric's script is not only in Debian but also in CentOS 7 (and I
guess Red Hat 7 too) in
/usr/share/doc/rsync-*/support/git-set-file-times.
  My use case is similar to his: a cluster of identically configured
web servers with autoscaling (tested up to 100 servers) which when
they boot (or there is a new version of any of the websites), rsync
the current version from another server.
  So currently if we build the system image of the web servers in
tandem with the central server everything works smoothly, the problem
is when we recreate from scratch any of the pre-saved images, in which
case we get the dates mismatch and unnecessary rsync checksumming when
put to production.
  Will use Eric's script from CentOS 7 as-is from now on, to avoid the
mismatch and mix pre-saved VM images without issues (slowness in
autoscaling).
  Thanks a lot to you all!
  Let me know if any of you comes to Uruguay, you got free beers here!
  Have a great day.


El s=C3=A1b., 29 de ago. de 2020 a la(s) 01:48, Eric Wong (e@yhbt.net) escr=
ibi=C3=B3:
>
> Ivan Baldo <ibaldo@gmail.com> wrote:
> >   Hello.
> >   I know this is not standard usage of git, but I need a way to have
> > more stable dates and times in the files in order to avoid rsync
> > checksumming.
> >   So I found this
> > https://stackoverflow.com/questions/2179722/checking-out-old-file-with-=
original-create-modified-timestamps/2179876#2179876
> > and modified it a bit to run in CentOS 7:
> >
> > IFS=3D"
> > "
> > for FILE in $(git ls-files -z | tr '\0' '\n')
> > do
> >     TIME=3D$(git log --pretty=3Dformat:%cd -n 1 --date=3Diso -- "$FILE"=
)
> >     touch -c -m -d "$TIME" "$FILE"
> > done
> >
> >   Unfortunately it takes ages for a 84k files repo.
> >   I see the CPU usage is dominated by the git log command.
>
> running git log for each file isn't necessary.
>
> On Debian, rsync actually ships the `git-set-file-times' script
> in /usr/share/doc/rsync/scripts/ which only runs `git log' once
> and parses it.
>
> You can also get my (original) version from:
> https://yhbt.net/git-set-file-times
>
> >   I know a way I could use to split the work for all the CPU threads
> > but anyway, I would like to know if you guys and girls know of a
> > faster way to do this.
>
> Much of your overhead is going to be from process spawning.
> My Perl version reduces that significantly.
>
> I haven't tried it with 84K files, but it'll have to keep all
> those filenames in memory.  I'm not sure if parallelizing
> utime() syscalls is worth it, either; maybe it helps on SSD
> more than HDD.



--=20
Ivan Baldo - ibaldo@gmail.com - http://ibaldo.codigolibre.net/
Freelance C++/PHP programmer and GNU/Linux systems administrator.
The sky isn't the limit!
