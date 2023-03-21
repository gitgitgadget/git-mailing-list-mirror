Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E3FC6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 17:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCURlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCURln (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 13:41:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3077735AC
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:41:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id fd25so9530406pfb.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679420494;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DusbhdxK3VkRfUDXe49Cjw8NsArWvQbZx74A4QpDbL8=;
        b=fvZlYhR2x1yADIt0Uy94R20xfd37Ga+kLOhpY8J9vX0dLOLnedi7Akne2CFAEc+MJ3
         W425Wv3uwaJO7aTOciHGU2YzqSWydyYqPJUK8NUiI1ROZDuYxW1TQdUPSVGIVvx0QLVo
         UvK2+ZEjr6GxeGWEh548lrTU0wt+/O8TRIPp85ldIKcF+ZM6ANXnj9hSbTAbht2AMoZf
         XifIjtzfaCvrUpvW/oeMSYQzh09NO2O6/I3m8NGvmVYnXOqEKmpYkMl5ucTot76ZeQu1
         o/2B+dpuDgPEFNQUFhdBNxDKtxWoiPXuaiDo8Mo9ZRlA2aVzpGLIK7bSUhaLGGTmHzgg
         OLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679420494;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DusbhdxK3VkRfUDXe49Cjw8NsArWvQbZx74A4QpDbL8=;
        b=F6KEnxnb6SUUwEI0JsgKRuNHYDB6XAw1vUYTxGAai6XCQ/CLyNSkgoNK/sIeqCc+iE
         sYEae6i9XF1CJ4IyAV4pZ6NHyzkhBOZ2Rsbf32oymWUuCLssyhRdg1KJrc6zRU/G6XqW
         mC1pOvp+jDwXLD8Gy6rRRehUOWlJ5xDc0dOFMNnjHlV3N2EIHtvgqLoGvTizAK8GN9JT
         X5oirHtplQPxM03Zp65k2dbt+/dG0b9IO/1P27tssSuDCcPHL+V54ZqaYLVJl56ZZpcs
         7RObk4Wa9aTytTXOGGCj1xI5cpOjR9fgTBEx7mxu5rJlUKiXG8YdALRKPhMDXj1yhHxE
         Pi+Q==
X-Gm-Message-State: AO0yUKXcyLfBVy26KGgKs6OoQZWamA4lqlGDM5cSTgb1RDllqbVNroVh
        V1G7ThyOeVRfr9IJKTUMZ3E=
X-Google-Smtp-Source: AK7set/QZYQ6u3QGFRC145khP6Ka4Pv8CSXdpdOIBGlWHpXoJWu9IezdgDg3fMKpxKrFLC2mhT1UyQ==
X-Received: by 2002:aa7:9619:0:b0:627:eb0a:56e9 with SMTP id q25-20020aa79619000000b00627eb0a56e9mr523527pfg.29.1679420494106;
        Tue, 21 Mar 2023 10:41:34 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id d16-20020aa78690000000b005a90f2cce30sm8469599pfo.49.2023.03.21.10.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 10:41:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Edwin Fernando <edwinfernando734@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC] Intro and Micro-project
References: <CAPNJDgcauhz_NraSPTQfiDM61gyghSJShZLPUtt5HOr2xKysZg@mail.gmail.com>
        <ZBnmsoRmQGKkQt+S@nand.local>
Date:   Tue, 21 Mar 2023 10:41:33 -0700
In-Reply-To: <ZBnmsoRmQGKkQt+S@nand.local> (Taylor Blau's message of "Tue, 21
        Mar 2023 13:17:38 -0400")
Message-ID: <xmqqo7omhuia.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> That sounds great! I assume that you meant avoiding pipelines where the
> 'git' executable is in a non-terminal position of the pipe, e.g.:
>
>     $ git blah | <something else>
>
> Since if "git blah" exited with a non-zero code or crashed, etc., then
> we wouldn't see the failure since the pipeline would suppress it.
>
> That has been a long-standing goal within the test suite, and I think
> that it's a great project to get you started. It'll ensure that you have
> all of the bits in the right place to get Git running on your machine
> and that you're able to run the tests.

Yes, but can somebody rewrite the micro-project idea page to clarify
what the "pipe" thing is about a bit more, so that you do not have
to repeat the above explanation the next time ;-)?

It is not "we do not want pipe", but it is about "we do not want to
ignore exit status of git".  So just like 

	$ git <subcommand> | <some other command>

sequence is bad, we want to avoid 

	$ <some command> $(git <subcommand>)

that feeds output of Git as an argument to some other command.  And

	<some command> <<EOF
	... some text ...
	$(git <subcommand)
	EOF

is bad too.  But

	var=$(git <subcommand>)

is OK ;-).
