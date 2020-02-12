Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1FEC2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9867D20714
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 16:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgBLQqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:46:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38310 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgBLQqp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 11:46:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so3219971wrh.5
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 08:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfuSHzn4upzswx+du6hLf7yScQR2bc4uUt9C/Tjzz7o=;
        b=imcLEYR5MqIzfvmT1eq9EY5Ciys0iGTYwyYE/polemRvZ8eVoB2enJEVVfBLk3EQXc
         dcZVsQnOPwq4cmfmQ2FgpjiXuy4hvCIw37Pq8ThxND/Jgw9+/cmCHZIVlX1Uc+OrkhDB
         RZLImeClidLU23iCMeSvF98yjgY4W0JP9S6kXb1hDe0T2YG8M45HL09DFQ830co6sZf6
         mgOC6dqIY8V9ajzXTAX3MMKg72Ou+wEWnOdPQWEGpZJnmxNNTsUM0ZdzqHBe6KUYBNoG
         lRPS68G7YXuXOiPV1eDHPuw74uJNA4FtnXROIkkL3WPBJC1RHNI4LvOWdRtZb3kOJtD1
         0KxQ==
X-Gm-Message-State: APjAAAV/LM8gADeloMdPk+h/EeH7oRTFoxWQeemirUqcjWgdMPmic2+W
        88kCkib4F+buvrKrepAe4Mm5JSv1JOUlR1PpR1wToGlV
X-Google-Smtp-Source: APXvYqy+D5M7dhLSVjKvx2cN8J4q6pQss5NSJpq0FmKjb3nvtR3FwXOoXO5nIneYvYRJMN+Qbf45i8ksObLUY1rmzOM=
X-Received: by 2002:adf:fd87:: with SMTP id d7mr16953712wrr.226.1581526003283;
 Wed, 12 Feb 2020 08:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20200212085646.hgq3nv2lf4brbb3j@glandium.org>
In-Reply-To: <20200212085646.hgq3nv2lf4brbb3j@glandium.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 Feb 2020 11:46:31 -0500
Message-ID: <CAPig+cTfMx_kwUAxBRHp6kNSOtXsdsv=odUQSRYVpV21DnRuvA@mail.gmail.com>
Subject: Re: SHA1dc on mac
To:     Mike Hommey <mh@glandium.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 12, 2020 at 3:57 AM Mike Hommey <mh@glandium.org> wrote:
> If I'm not mistaken in my reading of the various files involved, it
> looks like for some reason, building git on mac leads to using Apple
> Common Crypto for SHA1, rather than SHA1dc, which seems unfortunate.
> Is that really expected?

There was a discussion on this topic a while back[1], and it does seem
that the behavior you describe is intentional[2].

> More generally, at this point, should anything
> other than SHA1dc be supported as a build option at all?

The conclusion [2,3] was that it likely would make sense to drop
support for Apple's CommonCrypto altogether, although nobody has yet
stepped up to do the work.

[1]: https://lore.kernel.org/git/CAMYxyaVQyVRQb-b0nVv412tMZ3rEnOfUPRakg2dEREg5_Ba5Ag@mail.gmail.com/T/
[2]: https://lore.kernel.org/git/20160102234923.GA14424@gmail.com/
[3]: https://lore.kernel.org/git/CAPig+cQ5kKAt2_RQnqT7Rn=uGmHV9VvxpQ+UgDPOj=D=pq6arg@mail.gmail.com/
