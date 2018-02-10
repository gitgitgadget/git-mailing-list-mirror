Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F020F1F404
	for <e@80x24.org>; Sat, 10 Feb 2018 20:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbeBJUIb (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 15:08:31 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:37041 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbeBJUIa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 15:08:30 -0500
Received: by mail-wr0-f172.google.com with SMTP id k32so4964241wrk.4
        for <git@vger.kernel.org>; Sat, 10 Feb 2018 12:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gZGOceW0nRk4P6Am8QeJSJiHlVhET+sSVvRcClOGAKw=;
        b=l3NDvrVH7NIyJRhoptcKQKuqfoF52m6XYCx4Mtyv+5upN7iuXFEbN1ehDiccYCW/dO
         JOH2gYYepIbC6ZeOBCuSneZWOFFK8ICEBiwazx1fXvAIT4T/RAWjbzt5g1DQcxTwiiZK
         BNGr6vbib9/e6z/xhFZ5kqCLUrXkZM9akNrPzPMrnWTcXt/fZnP3DapENvVZNJlSqBr6
         V8yJLapIcWWer6EfCtJvFBXs5Zf1g/FpPW2L76D4i5IcoKwvzEY6xRlLiG+N4w83clov
         Oze+bK6ygU38FMZS0kSkbmqLGBqVP2s3TxsayK0lb4u2lFDg9lezK85alE+a4ODFijVp
         nt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gZGOceW0nRk4P6Am8QeJSJiHlVhET+sSVvRcClOGAKw=;
        b=WR3KrlnM006t2kXUyABLHamb2p66TB6EnI/rFzeUNUpyWKjkWZD9oPRrY1kMP9YwlN
         SkKyEaCCL0hKThdZE8X92+D35V+2qJwVZOHc+nnPUrMVT2xw3AVN2lYEs43d1xv2SnfY
         tB7pxJLSEuT3jplE2jTFGbFaap6/f1jVTpbRPe2GY1uA/ASE3TSE3hU4gX5fCSsr8QDd
         T9M/b749ncBdZYuni9BOY0At70/okcN3ac7Tv//iJ1R33oLQAsgsjmSRDmfKCmI0bZXi
         JwhdswYSTd1MKrpOSpDMxikfxCck1TwvhgstZ/ZjmABs+XJHLa/7VOuY2r/b1KLJN7fk
         2H8g==
X-Gm-Message-State: APf1xPDON+uTYJuZiX1/aB9PKZ90m3/7QdY0TLGM3B1/LJY83JxrUwjG
        igVSc5RG0+SvpggqO9+JLPE=
X-Google-Smtp-Source: AH8x2256g6fxzEvsvHCRU1bxHZJ8ff9ZkhHspSp2BkvaqNMLcnpXZdn7+9OF2T+npicXVlPiFf9gZw==
X-Received: by 10.223.178.87 with SMTP id y23mr6063317wra.249.1518293308876;
        Sat, 10 Feb 2018 12:08:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t14sm1943264wmc.23.2018.02.10.12.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Feb 2018 12:08:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] diff: add --stat-with-summary (was --compact-summary)
References: <20180201130221.15563-1-pclouds@gmail.com>
        <xmqqefm3cgd7.fsf@gitster-ct.c.googlers.com>
        <CACsJy8B5DYpSQnJiLK8r4naaBh0YWLGwn9FuvM6EhP74E4E_CA@mail.gmail.com>
        <xmqq8tc7b6yt.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CQLnzX6vijE+WHE3_nwqVfFiNWFb_rcA-Lw_fvGf=aFw@mail.gmail.com>
        <CAPig+cR9RycfLz0C6tXA4iPXdqoyczfij8CBaU4MmRGRmuRhSQ@mail.gmail.com>
        <CACsJy8AiBq__c0UET5ywMbTTz_MJNo-bZ-qAaoGZXdMNnECcaQ@mail.gmail.com>
        <xmqqy3k47jdg.fsf@gitster-ct.c.googlers.com>
        <CACsJy8ByZzR4GqVus=__RUg7W390e2ABoCb1ANewb5KRmBuV4Q@mail.gmail.com>
Date:   Sat, 10 Feb 2018 12:08:27 -0800
In-Reply-To: <CACsJy8ByZzR4GqVus=__RUg7W390e2ABoCb1ANewb5KRmBuV4Q@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 10 Feb 2018 17:24:31 +0700")
Message-ID: <xmqqr2pstxok.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> Yup, this is about giving summary in a compact way, not about giving
>> a compact stat information.  I agree with all the above reasoning,
>> and that is why I said that your "compact-summary" was a good way to
>> refer to the feature.
>
> OK I'll wait for a few days. If there's no comment, I'll go with
> --stat=compact-summary.

Sorry, but that is not what I agreed with you on ;-) I meant to say
that your earlier --compact-summary made sense.  I do not think
"compact summary" as a value of "--stat" makes any sense.  It's not
like this new one is one of the ways we offer to present "stat"
differently and compared to other existing ways this is to give the
stat in a compactly summarized fashion.  If this were a value to
"--summary", then "--summary=in-stat" might make sense, in that this
is not about how we show the "stat" information but about how/where
"summary" information is shown.

