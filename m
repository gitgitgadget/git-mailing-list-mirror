Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C86EECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 16:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiIAQnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiIAQnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 12:43:16 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895BB89CF5
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 09:43:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so2949587pjq.3
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=rOUbQM/HQYQdRKKTAFreUUXoLXZYFjHwuaAvB18Wv4c=;
        b=qIP9GVoxAXRKXK+nrwrju3aUeXgklQWyhSFmXo/CNBFXUYCibuQ043KkHGyuDoiXr5
         /iTt0tzGotM7x1+ov54j7N8OwdixDdV2vtGnfR6lHYnITtaSIUAIfG4dYmGM0OJ69KyP
         gqWKZEk+jHLXBU+D0J2RYaH5rH+Zp5m42dBlBAErZW2+jV3+DPXHgyT5Js+MusfQs/fK
         3PS5DIv/NTVYgCZgvKezJWU2l/P9AvMuKJzUSXFAnfln4P3ZduScJJQtiKFhKhiWZg3d
         1IlsX2MqvNRFzXCvPdmMT/SsM4IBXQExOGw6kL+F2kNMR/+rgOcTuAYGlzd+PLPmmfIW
         n/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=rOUbQM/HQYQdRKKTAFreUUXoLXZYFjHwuaAvB18Wv4c=;
        b=CQjLRCYto3nS88YrGH/PcRFyR8CEINxaOl5OcqxEZjHxmsoV0rAXyGMhlYmHK5543J
         hRMeJ+QA28DCs6Z8WPNpzFJh++z32ULKqcNpRwLx9JNKib8eNjuorLDcSNo62ojPJ+az
         9DejSVX+//yeHOqDqDEgFJCg3Hb3c826LMHkc8u4QQNPJBnNkdWOI0X1uEKglMh5+wv5
         rK9HvH+j7bJiqZd+uFyOrB70gBLG59Tgp6DXkoo+WZd9D54SUVJTOD+x1WmDrvULR4G/
         Ea2IlTtnUZU9xZONoEoXcXUGdL4T212qrbvoHbL9QgJUpVNeWsarEMQBcIhXm4vpRLjW
         doEg==
X-Gm-Message-State: ACgBeo2L5yxwyxUOCAF1wS6jelcIAAL37NY+mPyRgkpdBF6GdTpRqj98
        q4wb1hkCslooloj4r89unh9ZQXUxD7E=
X-Google-Smtp-Source: AA6agR6AxmksmLevdI0VoDyCCdSuSyzz2fLXfBb5cAI8sBn8RzSQ5z16tPOPjiq5AhpFLVk2TWZVfg==
X-Received: by 2002:a17:90a:d149:b0:1fb:6dfb:1fb8 with SMTP id t9-20020a17090ad14900b001fb6dfb1fb8mr11286pjw.25.1662050594019;
        Thu, 01 Sep 2022 09:43:14 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n1-20020a17090a670100b001fe483eaf48sm1903859pjj.30.2022.09.01.09.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 09:43:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 6/8] t/perf: add Scalar performance tests
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
        <42ab39f21212d3da1af3546d3425aa790637056f.1661961746.git.gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 09:43:12 -0700
In-Reply-To: <42ab39f21212d3da1af3546d3425aa790637056f.1661961746.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Wed, 31 Aug 2022 16:02:23
        +0000")
Message-ID: <xmqq7d2navvj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_compare_perf () {
> +	command="$@"
> +	test_perf "$command (scalar)" "
> +		(
> +			cd scalar-clone/src &&
> +			$command
> +		)
> +	"

Our preference is to avoid using "$@" when you are not taking
advantage of the fact that it protects individual parameters from
getting split at $IFS whitespaces.  Use "$*" is preferred here [*].

For example, this is good:

    mytest () {
        for arg in one two "$@" three
        do
            do_something_to "$arg"
        done
    }

    mytest 'a b c' 'd'

Thanks to the use of "$@", 'a b c' stays together and are kept
distinct from 'd'.

The above is not.  command="$@" is used as a misleading synonym for
command="$*" that flattens the arguments to test_compare_perf
function.  If you called it with 'a b c' and 'd' like we called
mytest with, you cannot tell that 'a b c' were together and 'd' was
distinct from the other three.  The only thing test_perf sees would
be that $command without double quotes have four separate tokens.


[Footnote]

* Of course, it is tolerated only in tests and perfs where we are in
  total control of the arguments so that we can declare that no args
  to the shell function have whitespace in them.  In scripts used by
  end-users, we may not be able to get away with "$*".
