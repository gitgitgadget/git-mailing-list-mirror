Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE0C81FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 11:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbcLELCD (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 06:02:03 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33384 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbcLELCC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 06:02:02 -0500
Received: by mail-qt0-f174.google.com with SMTP id p16so309088854qta.0
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 03:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C8ZcnZYWxZwi15EEFHdRl+/2B1N22rZ4hGf62V5e5kk=;
        b=eDrOn4rteKtEU91wlsw48KtKberZrGeasd+Rd3gyvLqTLrcWCK3QLRFUnet92D4MDK
         wytiuq9dpNYChljTxVjf9gsIobiH1vQX/5XLl4n7UuCVx69yff7qqxueanQcuVCfT4jY
         UroEqVz/sCxUnJu5zxrVcEsoSxDlmfHNPH3jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C8ZcnZYWxZwi15EEFHdRl+/2B1N22rZ4hGf62V5e5kk=;
        b=nB6KxmFtJgZhhq0Fmz3I+6C3y1gPT/BsYo9O8t08HrV14ASG5eWCeuq5LYT4O1/8F4
         IBqcHyYVGcZHOoMNpPW57wG3+cHPXC41bn9PIraTmeAmpGfHHMABQk90KFaqrpxw8SqA
         jcKM7UFVHT9IULEQgdhcCiGsfCA+fMlSGtTxNeW/rIUjPoSdZjucjmprkZiQdzs8QkTC
         jQgE91uSQ+qpH5a4ayEly5GIXgxT37w73p4+C/FuNeBcI2VGp2cDrd7lJzeonnX2fo+B
         B30DuoIcl0Pi3JseROi19v8kh7f3Z1+JbwcAy2GtVz1LZrDgRS1YJeJ5hGHKegJA8oht
         Dygg==
X-Gm-Message-State: AKaTC00hhD5FAYfnvdgVA8NlmzAHtr8AJDLXsvvAt1Qj4oj8FY2NwMGt5PoRQ+mN7qmxQS+u+ldvuKW0kkSNBA==
X-Received: by 10.200.54.4 with SMTP id m4mr48084840qtb.141.1480935721570;
 Mon, 05 Dec 2016 03:02:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.111 with HTTP; Mon, 5 Dec 2016 03:02:01 -0800 (PST)
In-Reply-To: <20161204140311.26269-1-larsxschneider@gmail.com>
References: <20161204140311.26269-1-larsxschneider@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 5 Dec 2016 11:02:01 +0000
Message-ID: <CAE5ih7-+TZVMhbF5b4TxhvZv3=eXFntN+MJqP6iDq0HyA6Ntfg@mail.gmail.com>
Subject: Re: [PATCH v1] git-p4: add config to retry p4 commands; retry 3 times
 by default
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Ori Rawlings <orirawlings@gmail.com>,
        Lars Schneider <lars.schneider@autodesk.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4 December 2016 at 14:03,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <lars.schneider@autodesk.com>
>
> P4 commands can fail due to random network issues. P4 users can counter
> these issues by using a retry flag supported by all p4 commands [1].
>
> Add an integer Git config value `git-p4.retries` to define the number of
> retries for all p4 invocations. If the config is not defined then set
> the default retry count to 3.

Looks good to me, ack.

>
> [1] https://www.perforce.com/perforce/doc.current/manuals/cmdref/global.options.html
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>
> Notes:
>     Base Commit: 454cb6b (v2.11.0)
>     Diff on Web: https://github.com/git/git/compare/454cb6b...larsxschneider:654c727
>     Checkout:    git fetch https://github.com/larsxschneider/git git-p4/retries-v1 && git checkout 654c727
>
>  Documentation/git-p4.txt | 4 ++++
>  git-p4.py                | 5 +++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index c83aaf39c3..656587248c 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -467,6 +467,10 @@ git-p4.client::
>         Client specified as an option to all p4 commands, with
>         '-c <client>', including the client spec.
>
> +git-p4.retries::
> +       Specifies the number of times to retry a p4 command (notably,
> +       'p4 sync') if the network times out. The default value is 3.
> +
>  Clone and sync variables
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>  git-p4.syncFromOrigin::
> diff --git a/git-p4.py b/git-p4.py
> index fd5ca52462..2422178210 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -78,6 +78,11 @@ def p4_build_cmd(cmd):
>      if len(client) > 0:
>          real_cmd += ["-c", client]
>
> +    retries = gitConfigInt("git-p4.retries")
> +    if retries is None:
> +        # Perform 3 retries by default
> +        retries = 3
> +    real_cmd += ["-r", str(retries)]
>
>      if isinstance(cmd,basestring):
>          real_cmd = ' '.join(real_cmd) + ' ' + cmd
> --
> 2.11.0
>
