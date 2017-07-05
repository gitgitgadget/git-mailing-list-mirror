Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA96B202AB
	for <e@80x24.org>; Wed,  5 Jul 2017 06:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbdGEGfC (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 02:35:02 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35377 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdGEGfB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 02:35:01 -0400
Received: by mail-qk0-f177.google.com with SMTP id 16so182295381qkg.2
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 23:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mazzo-li.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WfmPaKsyi51YxbbBfp42TF+rE12M2lju/RnlhEosmLM=;
        b=bW3Qrr0PpTSNyv07hO9WpQKyT/amAZtAMP3P6qJYJ60w+WNC/HyFFeVc0ofo73nTNi
         LJGxT2QNFs4PlQQ0xCD/8cy8rKftSnPeywwqk93IJDjcp0kdLO4l1xVwKjDSvI4ZgZjr
         tSuPmel8KcM3lSD/9xH9yPSzO6jrRpfvqFsmYLnj1NOyqSwErr7uM7HF4oPdUDZdNpuK
         3TNseLR6vEExkLsO4Zg7lBv+MrivTpZQ9qXSWNtMgG8PVGC9GJBCps786Q3AWnX3Hz3P
         BWgf68odNNJfeVmugf8MfGXXn3zqsPqTQLCPwVTzGVwZk5muIn37j+K+RdhDrVBM4D7y
         qHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WfmPaKsyi51YxbbBfp42TF+rE12M2lju/RnlhEosmLM=;
        b=XtzEGamiVLwr/+xdOruQtUzDQxSof+q+xRIpJBfSTsE23brgy+B5MbLQS1t0Qx+Vy2
         RGMstvd57zJYWLhxQJkCDkEw3ezNsDHM7gmtzkJhE99tfmP2Dh7m62+XkHV0A5/bwmSP
         Sbx/Ide59UlLYDHCwo7dHVwgzzv/qKirl39dUjsjwSUU3suOCvCHQxuZdiY/CDIi5O/l
         BoJc2026JT/Oje9fV9CI4PnApQ5xDBDqCkvSiQcwr2rNGAhVUuIrraDpsuJlmQ4oJlwa
         Tkn7SpWeMVziT5yp1Er1jjrmEQjSiCBZQAf5th/bP0U/8NZio53P6q+28ZWm6JfUvEtc
         GiGg==
X-Gm-Message-State: AKS2vOzlwUhx4HW2qnou9e/agEstkXrbbi3yBLHSgtTGJakDUtPJx+8i
        byUXY3/8Zy4rPvGqPKfvhKiD8V1Gnh9j
X-Received: by 10.55.146.133 with SMTP id u127mr53001871qkd.17.1499236500370;
 Tue, 04 Jul 2017 23:35:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.140.67 with HTTP; Tue, 4 Jul 2017 23:34:19 -0700 (PDT)
In-Reply-To: <xmqqvan8jdje.fsf@gitster.mtv.corp.google.com>
References: <1499116727-757-1-git-send-email-f@mazzo.li> <xmqqvan8jdje.fsf@gitster.mtv.corp.google.com>
From:   Francesco Mazzoli <f@mazzo.li>
Date:   Wed, 5 Jul 2017 08:34:19 +0200
Message-ID: <CAPB=P5xsssm=RiAkEuAtpxe52+-sNAPVP2qnQGctLjNZFYznkg@mail.gmail.com>
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4 July 2017 at 19:51, Junio C Hamano <gitster@pobox.com> wrote:
> People have been burned by the lazy "--force-with-lease" that does
> not say what object to expect there and forces the command to DWIM
> incorrectly what the remote's ref ought to be pointing at.  This
> change encourages its use without the user being painfully aware of
> that danger.  Whenever you say "push --force", you'd be using the
> dangerous "--force-with-lease" that does not specify what the
> expected current state of the remote is.  The end result gives an
> illusion of being safer than a simple "--force", without being
> not really safer.

Could you clarify the danger you're referring to? E.g. give an example
of surprising --force-with-lease behavior that we do not want to
encourage?

Thanks,
Francesco
