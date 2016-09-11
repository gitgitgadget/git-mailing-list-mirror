Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36EB51FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 16:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755982AbcIKQD6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 12:03:58 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36150 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755606AbcIKQD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 12:03:57 -0400
Received: by mail-oi0-f44.google.com with SMTP id q188so142599253oia.3
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PGW/qpPTHVa+NFWDUogkf/Ccc89yGGjUWc2DQTN01DU=;
        b=HuaylG4uyiEobf8h74Z5hxmHKrO/Z/tTUh7JQ3QcPr3v6eUWCtHibWA9n1TQCyRJGa
         1XilPctGczh3zs4QNiEovF8DyxudwbSBa8HVd7S7RZAI4yGQhG9T4N2B+Y8dFjvctP/c
         KLUdGX+h93g6rcoT4bGZvRpkPQTf/VKMB1d++FSQ74I0BAE5ZF+GKzWJxuGMFe8b600a
         XArkoX4icVD2esFYol5mdAbulPWGXxkLwr8lkKY/PcsT5U7N7EesLRDso04VTDgsx7XQ
         t5ZASqpKDNbYll3Cg7ryEkkilOouICYhsUuneKQZJQOOBhXzhV3PrEaLmCze7UHP9ysW
         tw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PGW/qpPTHVa+NFWDUogkf/Ccc89yGGjUWc2DQTN01DU=;
        b=bIVJpYmKANiSpQb3dD1o3CPrfOALPEYZ/e0VFMG7mfmWmzoPA1dPMzY3gyXiIcP2xI
         sXL53DmNQfNqr/80RH5lCu36rU7iYbDnLsW8AWw5cgGoE4qFzl0HYKgK1tNRGiVr+j6J
         mmh3//rB4NoCGrt5LbzOwR5y23eqaIuv21se7PEK/Fzs4sQsRE7ORd7593w1RMVEnT8Y
         vUICtDJlPbmjBGdbdkcy4Lby+p2mi1blSv/DZleUG2350APS1GpKFbvjqZzXcGF9Xp8v
         vS/uxuJhQGFGbyNJ1WqeNTfhmSFHjZBcXazRwYh2ILKOgHL+fPgVZGw+UCvjG2M83dsp
         y1Nw==
X-Gm-Message-State: AE9vXwMASA/fVXt5aCQxxsATPr7ZGV7paskgwkOhTTVWenkeufXCdyozDkQCl81J2rc9niOt8QYNw5jsIdg+xrvG
X-Received: by 10.202.108.21 with SMTP id h21mr812655oic.172.1473609836648;
 Sun, 11 Sep 2016 09:03:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Sun, 11 Sep 2016 09:03:56 -0700 (PDT)
In-Reply-To: <6CCFB3A0-2C3B-4142-8E62-47C3DD6AE7A3@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
 <20160908182132.50788-7-larsxschneider@gmail.com> <CAGZ79kYHX6-hhKW_6JEd1hBNi8R+sBY-RjZARfHDMnyLKFZnsQ@mail.gmail.com>
 <6CCFB3A0-2C3B-4142-8E62-47C3DD6AE7A3@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 11 Sep 2016 09:03:56 -0700
Message-ID: <CAGZ79kY4_ASUopbXg3AgtGu-hJ87thD46NgzggeB1635Yvk5dA@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] pkt-line: add functions to read/write flush
 terminated packet streams
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 11, 2016 at 5:33 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:

> Does this convince you to keep the proposed error handling? If yes, then
> I would add a comment to the function to document that behavior explicitly!

oops. I should read the docs more carefully.

Thanks for pointing out.
Then I'd be happy with the patch as is.

Thanks,
Stefan
