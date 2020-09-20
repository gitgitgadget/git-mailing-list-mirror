Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF9BC43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 16:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE68214F1
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 16:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBbYV6zZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgITQRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 12:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgITQRg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 12:17:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05604C061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 09:17:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t7so5936932pjd.3
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n5R9+Q6/xl8wAI2vmRCv8/Vqx37zPnPLoc6ImTD6L0o=;
        b=pBbYV6zZCSW6W6gyxSb8NijP99UNucsO9wbRKmR7+vW/pSa8TPl5a5Hvne0CCFHfx2
         xLdMPLVc0fiq1AyYcMpNi+8IJQDFGUYRAkEDTi1kLMFT/Rf+znG7UfHHatNyAXbjjNIu
         UIUTrwd0u8gEj951ObZV9BgV+QdG36JXg0J8jY7Te8dDn4XzKbYP17HgcTAbbGIBnzjE
         AuFD2CbPCDen1bWWCyz+w7YKeiU4Qq79Wdp4BxV1mmKoQY86Dz8DJ/aCQ+Etdi7oSmJf
         GOFH6FI8BW9Ugxe7g/Xq9Lmbi1bzQOWC9yhr9EYt+tE/JGk7A4wLF8jlFeDHD9dJVoZ8
         XjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n5R9+Q6/xl8wAI2vmRCv8/Vqx37zPnPLoc6ImTD6L0o=;
        b=nvLcxDdz1iTIFzHc7W2IALb/ZnSO/4wnW2niasNbkkd67c885/0a2lEsZqwQHrJ0Q3
         o6P4bGGK3Di43kIw6Y9ly2rkW1PoBz0Ehc4ZA4i2Q/IoNz/OWqtGczJP5KtyhlGJqMo3
         6bziu7OMv8TwVAlMQ6ANod7+/hJwQ9s2BSOR/Dgj42bikkv4yvtikwA4hH57rXmfS5Eh
         7FG1QfsgrbEiNO0Xuq63I+rY5ix1/d/4S60I9JQFe/LOIaZW369RknIKYz7dnMwkUGrt
         LPqQCbMMRyC4y4jIb5mWKMvrMeueWE6m4g1Fz5H2IMqrxlmVT5UGbsAKxOrJjfdN+zAx
         kCzQ==
X-Gm-Message-State: AOAM5333R99y7sQ2QG5hV1vR8yDBPWDwXvoJuS/GDBkKLE2td6ZnJFsI
        5UYJFZGEKDEE5UkfdVHDHC4E+Q==
X-Google-Smtp-Source: ABdhPJyq7RRMe4GrlIs1/Gmpw6m0xP9/niwD4bPuIxyMJsKlJf4BXh0tqRmIX6klfCi58uDGHxz06Q==
X-Received: by 2002:a17:902:c393:b029:d1:e5e7:bde9 with SMTP id g19-20020a170902c393b02900d1e5e7bde9mr23148382plg.73.1600618655281;
        Sun, 20 Sep 2020 09:17:35 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id v26sm8940220pgo.83.2020.09.20.09.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 09:17:34 -0700 (PDT)
Date:   Sun, 20 Sep 2020 09:17:30 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>, git@vger.kernel.org
Subject: Re: Joint project with Git for outreachy
Message-ID: <20200920161652.GF331156@google.com>
References: <20200918222103.GA3352870@google.com>
 <CAN05THSUN4YToYRqWUxZ0r2=wVxJU0V2iWumx1jjx=eTQ7rAYw@mail.gmail.com>
 <20200919195545.GH67496@camp.crustytoothpaste.net>
 <xmqqtuvtiec8.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtuvtiec8.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 19, 2020 at 03:36:23PM -0700, Junio C Hamano wrote:
> 
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > On 2020-09-19 at 09:12:53, ronnie sahlberg wrote:
> >> Hi Jonathan,
> >> Hi Emily
> >> 
> >> Emily, you want to contribute to wireshark? That is awesome. I think I
> >> speak for everyone to send a HUGE welcome
> >> your way and hope your experience working on and with wireshark be excellent!
> >
> > I think there's been a misunderstanding.  I think the proposal was to
> > have Emily and Jonathan, who are both significant contributors to Git,
> > doing the mentoring from the Git side, along with someone from the
> > Wireshark side.  I don't think we know yet if anyone will be interested
> > in working on it, but it seems from the response to be a proposal that
> > has interest in both projects.
> >
> > Feel free to correct me if I've misunderstood.
> 
> That matches my understanding.

Right - brian and Junio are correct, I'm hoping to co-mentor with
Jonathan. Ronnie, I'm really pleased to see this warm welcome, which
makes me optimistic about the kind of experience an intern would have on
this project. It would be really great if we could get a volunteer to
serve as point-of-contact if the mentee is not sure about something
they want to send to the Wireshark list, and possibly to come to an
introductory real-time chat (video/voice/IM) to provide a little
overview and nudge in the right direction.

It sounds to me like we have enough enthusiasm to put this project on
the list, though - if I understood my conversation with Jonathan last
week he's planning to add that. Feel free to correct me :)

Thanks, Ronnie and Richard!

> > > (
> > > Jonathan, remember that smb2 client I was working on, libamb2?  I got
> > > it to run on PlayStation2 now. It is totally awesome being able to use
> > > SMB3.1.1 and full encryption to copy file between the PS2 memory card
> > > and Azure cloud file server :-)
> > > )

(This actually sounds awesome. Got a repo or blog post up somewhere?)

 - Emily
