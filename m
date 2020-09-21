Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24455C43465
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 11:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1ED420EDD
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 11:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXst7fv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgIULdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 07:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgIULdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 07:33:16 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602ABC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 04:33:16 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r25so15000821ioj.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 04:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fq5zTg7mkWjX4/+pq1bT03tYVHkLRNcY1pjo9gbEtdA=;
        b=dXst7fv+IJNysDFH7DlD1l4Puh/7ctQ2BLNQyrxnRwUXTHQelyhpkqxWxOvQ1t/hnC
         rQftC0G/5MsMAUzvJZ/MXiQ2wYQRsh7IdzXh1uH71Tp+0xg5DSUTYKNzFj6AIlnuRZlY
         EIdfmg2WEQ1MJyMNvB4RYyh39dO4cpW3x9iXSULOX4KFMZZIYE1tbowOW0AaYs8+VVmi
         QZ3Zan3nvROsjV0qlDtBmum0S0c2zVl3Fhbr8mGHOPYQAkmBcXVKaQb3+bqFiuH/F/k7
         fq8tW/eXGavk8L6REivt2edhoQVvz674zeMnozYhKqxr5Lj1YfCzUS9Yb3vfFwelmqGP
         QRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fq5zTg7mkWjX4/+pq1bT03tYVHkLRNcY1pjo9gbEtdA=;
        b=SlXPyo9PR5+9nyp1VcV0SQ28jp2rMzKYdm136MtlVxpBQqHdU0F1wLK9Y0pk8o3ZVo
         RLAE/1vOItayArGmAzVAZk4Ai1vIa3E7B7LGk1JDop3e5FNUJEhR4jmzmO3QYTekYJcL
         ltFp136Osmw7jtg1y8h2LU0pv33gCFWuOlZwuCuSHUBaMlEAkFgp1gwT91HAwNUyDDkO
         Kcb6AizFQmHQ/b98DuVXB04lQ8DYvwIMM3dUNxfF4LXYHOwgZF8Oglw+2qcWJc5QK7Uu
         NdItZ3AiWzdSiQHdbdJPNpjWl4NgQOgJBHRUFJesrv0AabEQrPN+lK6YIrk3V/OO2yDy
         qW8Q==
X-Gm-Message-State: AOAM530CRzPU3ZEgjIR3+3ZOq9XKHiNp4WIBuswCDCTphPt9m2jIxoWR
        b8gGLN4/ehNAu/pHzAmlpY18WQ/n39n+KOYqJWI=
X-Google-Smtp-Source: ABdhPJx4vi3iVkWPdCm2LXmcMjyn4hSKt1TPubQSQXwtzwWGLXDCA/V1kkFIWRP9P0ajMMTrTZfFjDU0CfAK1Qd4ELE=
X-Received: by 2002:a02:9a0e:: with SMTP id b14mr40401490jal.22.1600687995664;
 Mon, 21 Sep 2020 04:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200918222103.GA3352870@google.com> <CAN05THSUN4YToYRqWUxZ0r2=wVxJU0V2iWumx1jjx=eTQ7rAYw@mail.gmail.com>
 <20200919195545.GH67496@camp.crustytoothpaste.net> <xmqqtuvtiec8.fsf@gitster.c.googlers.com>
 <20200920161652.GF331156@google.com>
In-Reply-To: <20200920161652.GF331156@google.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Mon, 21 Sep 2020 21:33:04 +1000
Message-ID: <CAN05THSYBmy_1gPvzRB1qOffrg-YcL_YnHA-Th2scJ0nzB2U_g@mail.gmail.com>
Subject: Re: Joint project with Git for outreachy
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily

I got confused. I worked in Jonathans team about 5-6 years ago and
since I am old fart I couldn't realize that maybe they had other
people join since I left.
Hence I assumed you were the intern.

Just me being senile. No harm meant.

Regardless, a git dissectors will be totally awesome so whomever ends
up being the intern or whatever doing it, I will be happy to help
them get it going and have a successfull project that they can
remember with joy and be proud of.

regards
ronnie sahlberg

On Mon, Sep 21, 2020 at 2:17 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Sat, Sep 19, 2020 at 03:36:23PM -0700, Junio C Hamano wrote:
> >
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> > > On 2020-09-19 at 09:12:53, ronnie sahlberg wrote:
> > >> Hi Jonathan,
> > >> Hi Emily
> > >>
> > >> Emily, you want to contribute to wireshark? That is awesome. I think I
> > >> speak for everyone to send a HUGE welcome
> > >> your way and hope your experience working on and with wireshark be excellent!
> > >
> > > I think there's been a misunderstanding.  I think the proposal was to
> > > have Emily and Jonathan, who are both significant contributors to Git,
> > > doing the mentoring from the Git side, along with someone from the
> > > Wireshark side.  I don't think we know yet if anyone will be interested
> > > in working on it, but it seems from the response to be a proposal that
> > > has interest in both projects.
> > >
> > > Feel free to correct me if I've misunderstood.
> >
> > That matches my understanding.
>
> Right - brian and Junio are correct, I'm hoping to co-mentor with
> Jonathan. Ronnie, I'm really pleased to see this warm welcome, which
> makes me optimistic about the kind of experience an intern would have on
> this project. It would be really great if we could get a volunteer to
> serve as point-of-contact if the mentee is not sure about something
> they want to send to the Wireshark list, and possibly to come to an
> introductory real-time chat (video/voice/IM) to provide a little
> overview and nudge in the right direction.
>
> It sounds to me like we have enough enthusiasm to put this project on
> the list, though - if I understood my conversation with Jonathan last
> week he's planning to add that. Feel free to correct me :)
>
> Thanks, Ronnie and Richard!
>
> > > > (
> > > > Jonathan, remember that smb2 client I was working on, libamb2?  I got
> > > > it to run on PlayStation2 now. It is totally awesome being able to use
> > > > SMB3.1.1 and full encryption to copy file between the PS2 memory card
> > > > and Azure cloud file server :-)
> > > > )
>
> (This actually sounds awesome. Got a repo or blog post up somewhere?)
>
>  - Emily
