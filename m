Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD73E20209
	for <e@80x24.org>; Wed, 28 Jun 2017 04:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbdF1EI0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 00:08:26 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35713 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdF1EIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 00:08:25 -0400
Received: by mail-pg0-f67.google.com with SMTP id f127so6631029pgc.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 21:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7+fUwminjCKAVFDGsu50e7dH2Sr6dQ6e21olGggI47c=;
        b=EDg9PsBxVa7NTlHkTfh6R/gvxIyiTbAU6VPcqxTqQc1PfJckAtlHWpwDfjU0DlHwYa
         2CipA1vyf94u6p3c3rp2PdlUcggXyhq4fk0OYildJN9DjfcGZeafSVJOfIi/dH0gNLtQ
         kfZhJjHORFoJ1MDvLkBkRQeklI9My8pvnQFzI2xJrt4e4MQo0SETrGwjQR6Kvuw0OGz2
         2U+J8Ca5rjJqmUABDXmyq9bV3vodtwLgh1iWEFpZArZtOCh7zJlphOgEikYpkQAz2v1q
         7z82fBnWBIekDuWo1k3sLkwNVQ1K6j4R36FV0Pa66cUdRFrSIr6ax/cPd0ZaIskXItqS
         U34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7+fUwminjCKAVFDGsu50e7dH2Sr6dQ6e21olGggI47c=;
        b=YKZ9xwVpe5NNh+m++luidPRHZX1HRFpoWu09Z0wml57hq6r0nO7CCulmkrA4+Yw9SL
         +R+ldWAn5zrZPMgHYZgLww8tsSIWFbtzelYXG70h47UVSRI1dEA249LTm1grBhjKoj3H
         ToPMyiEsDpRpq+dBDJYLs0l/3mkwEfI2jaLF2KDb4VdfiQx7PWvI1VAWpru6woamABOq
         2eYEuY7ZfesfGvYjaCjV4xsXYvnsrTFRv+aJGmqKdAXvHr2Tk0kP7uTlXQYvkBjdT04m
         m8MkSPAwLoV1TfOXOqZAJdKzFbMVYB4oVszE56qe+XT2pLArDWgsGBMXT1jqPEOcAgKS
         oXUQ==
X-Gm-Message-State: AKS2vOxJAj5YmT9dbNWdqtE6YL4j7a551PflAmLB9a4VZdjYmflBcr50
        N0fPRMcdDDtzFoJpAV0=
X-Received: by 10.98.9.19 with SMTP id e19mr8725465pfd.177.1498622905050;
        Tue, 27 Jun 2017 21:08:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id y192sm733434pgd.38.2017.06.27.21.08.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 21:08:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miguel Torroja <miguel.torroja@gmail.com>
Cc:     larsxschneider@gmail.com, luke@diamand.org, git@vger.kernel.org
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
References: <CAKYtbVY_=aMjcS=r2YyhcxKiUAaJUJA=OELTvXfau4GGz7Lz4Q@mail.gmail.com>
        <20170627191704.4446-1-miguel.torroja@gmail.com>
Date:   Tue, 27 Jun 2017 21:08:23 -0700
In-Reply-To: <20170627191704.4446-1-miguel.torroja@gmail.com> (Miguel
        Torroja's message of "Tue, 27 Jun 2017 21:17:04 +0200")
Message-ID: <xmqqk23wycso.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miguel Torroja <miguel.torroja@gmail.com> writes:

> The option -G of p4 (python marshal output) gives more context about the
> data being output. That's useful when using the command "change -o" as
> we can distinguish between warning/error line and real change description.
>
> Some p4 triggers in the server side generate some warnings when
> executed. Unfortunately those messages are mixed with the output of
> "p4 change -o". Those extra warning lines are reported as {'code':'info'}
> in python marshal output (-G). The real change output is reported as
> {'code':'stat'}
>
> A new test has been created to t9807-git-p4-submit.sh adding a p4 trigger
> that outputs extra lines with "p4 change -o" and "p4 changes"
>
> Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
> ---

It appears that https://travis-ci.org/git/git/builds/247724639
does not like this change.  For example:

    https://travis-ci.org/git/git/jobs/247724642#L1848

indicates that not just 9807 (new tests added by this patch) but
also 9800 starts to fail.

I'd wait for git-p4 experts to comment and help guiding this change
forward.

Thanks.
