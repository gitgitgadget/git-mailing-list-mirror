Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FB6C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 16:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJFQC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 12:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJFQCy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 12:02:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9735FAA3DE
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 09:02:53 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h13so1012166pfr.7
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 09:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=twmpwbW1Htny/JMdkHqziFnuKdhC0wTRWRw5yMphJWk=;
        b=jp6wTlVJ1xpdpqVAqmpv/YkRHHfJtxCv1enrWMRBWxKiAFclT9+gRi+t8OSbu7rP1V
         Y7nB6j2hUEJvCFTC0/MoVvy8p43Uys+Wq0yHhTcEWcQrRabQU/Ol9nO/PJPwKr6fRNTC
         +ViKRD0Al/DTPotmPaTJ5fCZYuYIqsDZpEQDGqxZ2P1HkTiY/A4MskvQqQg2FWA1p4Rv
         R6Ea4QOupqJ9IkdOFk/odoFVy57bvtfsW4dPdZDcO+tDBgr5DVf93hOqk7rro6tuhDMC
         GS31g1h6FL4wc/uhov/xuCwJ1UwBCMmq7nFEHFhynbE33HlFxVApPel2I5efTMfeEG0c
         5rYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twmpwbW1Htny/JMdkHqziFnuKdhC0wTRWRw5yMphJWk=;
        b=DUfG0k/9FAUmP+XIts9LHdmUp9siRsFN+cC1Th0xhbGQoln2QuWuvqWmGzO5yRkZRo
         5jlKtWJjHst62wXzfawZJOmhyJGHUqSFmp95hyyae2sFBe6u+wqMjAZvAVdbBesq/Zfy
         dszdVClm4QKQqm+KxbdzvFs+4eDQK/vPilxZLbtnTxSKzI3paHL8UHlejJ+TxODzOF3p
         LnjWP+uokjYCl4/XAZACtEQCI0OubsqPUs6Z8gYO2efkokYBF8U1ulildPBy6jOSJfLe
         05SbUMYuJix2TS968ko96H36yCx7udY2niydZCXoLhPn4Q9Yqjr8e2KXw7Fn4ZPICnJs
         d4sw==
X-Gm-Message-State: ACrzQf1DQs0pYYSTwndE49093Bxurst6xwUrQX4Q9bglV5OJN7lVWWOY
        eUyjRlhZ7OpUNZV9bIr+qXGF8B+bc128
X-Google-Smtp-Source: AMsMyM54Zq9Ah3Rh/xJtwYflID0tHaFpkLeMmM1fco/VUqpWNQasO5s9TwD4TNBIFNpGHY0T0AyJ+g==
X-Received: by 2002:a63:8349:0:b0:44f:7a9:84f4 with SMTP id h70-20020a638349000000b0044f07a984f4mr437099pge.389.1665072173008;
        Thu, 06 Oct 2022 09:02:53 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902c41200b0017e232b6724sm8234623plk.69.2022.10.06.09.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 09:02:52 -0700 (PDT)
Message-ID: <66d1bcaf-64c8-13c2-ba7a-98715de3617b@github.com>
Date:   Thu, 6 Oct 2022 09:02:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] python file more pytonic, adjust "if" and "for"
Content-Language: en-US
To:     dsal3389 via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     dsal3389 <dsal3389@gmail.com>
References: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
 <71da6f53a44cd3390d122ff2c0446824313e5101.1665056747.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <71da6f53a44cd3390d122ff2c0446824313e5101.1665056747.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dsal3389 via GitGitGadget wrote:
> From: dsal3389 <dsal3389@gmail.com>

re: the commit message title

s/pytonic/pythonic

Please prefix the title with the file/function being updated. Based on
precedent [1], that'd probably be:

    git-p4: <your message>

Also, I'm not sure the reference to "for" is helpful, since you're only
adjusting if-statements in this patch (although one of those conditionals
does include a for-loop, nothing about the loop itself changes).

Finally, please use the imperative mood in your commit messages [2];
something like:

    git-p4: adjust "if" statements to be more pythonic 

[1] https://lore.kernel.org/git/?q=dfn%3Agit-p4.py
[2] https://git-scm.com/docs/SubmittingPatches#describe-changes

> 
> L371
> redesign few lines to get rid of the "else" statement

What was your reason for making this change? I don't see anything in PEP8
[3] regarding this kind of conditional organization being preferred over
what's already there.

For what it's worth, I'm happy with the change itself; I'd just ask that
you include an explanation for why (because it's more concise, or makes the
assignment to 'out' clearer, etc.). The "Describe your changes well" section
of the "SubmittingPatches" document [2] should be a helpful guideline.

Also, as a matter of convention, it's not necessary to include line numbers.

[2] https://git-scm.com/docs/SubmittingPatches#describe-changes
[3] https://peps.python.org/pep-0008/

> 
> L404
> moved the if statement below another if statement that
> checks if it should exit the code, only if it doesnt need to,
> then we can iterate the for loop and decode the text

While the actual change below makes sense, I found this explanation very
difficult to parse. Maybe something like:

    Reorder if-statements in 'read_pipe_lines()' to raise an error with the 
    command before trying to decode its results in order to avoid 
    unnecessary computation.

> 
> Changes to be committed:
> 	modified:   git-p4.py

Please remove this text from the commit message.

> 
> Signed-off-by: Daniel Sonbolian <dsal3389@gmail.com>
> ---
>  git-p4.py | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

The rest of the implementation looks good, thanks!

> 
> diff --git a/git-p4.py b/git-p4.py
> index d26a980e5ac..0ba5115fa2e 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -368,10 +368,9 @@ def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
>         """
>      retcode, out, err = read_pipe_full(c, *k, **kw)
>      if retcode != 0:
> -        if ignore_error:
> -            out = ""
> -        else:
> +        if not ignore_error:
>              die('Command failed: {}\nError: {}'.format(' '.join(c), err))
> +        out = ""
>      if not raw:
>          out = decode_text_stream(out)
>      return out
> @@ -400,10 +399,10 @@ def read_pipe_lines(c, raw=False, *k, **kw):
>      p = subprocess.Popen(c, stdout=subprocess.PIPE, *k, **kw)
>      pipe = p.stdout
>      lines = pipe.readlines()
> -    if not raw:
> -        lines = [decode_text_stream(line) for line in lines]
>      if pipe.close() or p.wait():
>          die('Command failed: {}'.format(' '.join(c)))
> +    if not raw:
> +        lines = [decode_text_stream(line) for line in lines]
>      return lines
>  
>  

