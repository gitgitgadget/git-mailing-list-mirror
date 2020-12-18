Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC2EC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF382151B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbgLRClk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 21:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730778AbgLRClj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 21:41:39 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FAEC0617A7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 18:40:59 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id j20so654618otq.5
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 18:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=uxcuBg0VVZin32+iVq8mzhBzQqy3xAJ9OiAnYfGNxVM=;
        b=fHLxmejWAhoArCgJVP2qkSLbLgsBj9IL5FBBpNd0RezIW5B8OoOSPqGbMTbRafn+bR
         fl0qwc6CAzl4Qg2AZKkO7qubmo6PWOdt3g6mCrhXGv2MqZRHKVQJ7yRQNGjIgaThJF94
         yEr3wZ3wwZUtgWQy1FgZKtpijEenZ9Ag2QMioZFwLNBprvfTYn/G2SDLrG9hKv2q4EvG
         nCu+JQ8xyBs+9HptXxytp1OLrVnWil0/VTqHfHDLxYYNKOoVEhlmsizTxW+HUeiIMDLp
         637jtlsrb1LbRsYe6HmRwuqP662nmcNzLKOF5IuF+Qe+LvOD/7hS4oGD0YEy7QUrc7mg
         EIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=uxcuBg0VVZin32+iVq8mzhBzQqy3xAJ9OiAnYfGNxVM=;
        b=cPjIiQemSFWi3oQn9GfastArB35KWDY0dqqvYOpJUKkp4GgH9ur9hPLca6+Qx/Pzda
         F1jH583f7om07hcrSWil1KH+ADXVYZSksNrvs3072IO65G6i4miQxnFWpuGVVB+9+tol
         65USSExvG09RYTOWYba32kgaE2yZ/O8dboQAWUEn4pB08SFTaQGM1KW3uN7YN0o8TaDI
         wkgPQL9hw/I8ghPFFUkKhtkfhnXxNWM0yznDI+ZyzQKgcOnU8sLwb2mdy2ADFZ/IzEbx
         hFnXUctnDGmuVc1gseqddBAPDs5YBeqkUtdNWxMvdmyhcWy0ttlvNSKO59rwaLjYLC00
         1tHw==
X-Gm-Message-State: AOAM530k1h7qJC0iDY64QTSEmz4P0gb+Drjq4lG23rDFlUrOqPqTP7RV
        jsB6PBICsQbb7niVnbw7EMQ=
X-Google-Smtp-Source: ABdhPJzpkWbffy9MfNqNIzdyl8+IAOPkuq7jzEk1NwwpZERjBs6G5wYXfgNb4YB9qAE8YOa/S8+HDQ==
X-Received: by 2002:a05:6830:1d66:: with SMTP id l6mr1419265oti.23.1608259259197;
        Thu, 17 Dec 2020 18:40:59 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 94sm1652505otw.41.2020.12.17.18.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 18:40:58 -0800 (PST)
Date:   Thu, 17 Dec 2020 20:40:56 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Message-ID: <5fdc16b8de8c1_f2faf208ad@natae.notmuch>
In-Reply-To: <xmqqk0tgx7ms.fsf@gitster.c.googlers.com>
References: <20201217054524.856258-1-felipe.contreras@gmail.com>
 <xmqqk0tgx7ms.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v3] mergetool: add automerge configuration
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > It doesn't make sense to display easily-solvable conflicts in the
> > different views of all mergetools.
> >
> > Only the chunks that warrant conflict markers should be displayed.
> >
> > In order to unobtrusively do this, add a new configuration:
> > mergetool.autoMerge.
> 
> As pointed out by others, I think it makes more sense to have
> mergetool.$tool.autoMerge, with optionally mergetool.autoMerge
> that can be used as a fallback, and enable it by default.  If
> we can make the default of enabling/disabling per tool, that
> would be ideal (see my other reply on how to do these).

I don't think that's the case. There is no tool the user wouldn't want
this enabled on.

> > +		git merge-file --diff3 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
> 
> Adding "--marker-size 7" to the command line would make the sed
> scripts below more robust.

Right, althought the user can't configure otherwise, and the default 7,
it can't hurt to add it.

> > +		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
> > +		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
> > +		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
> > +		rm -- "$DIFF3"
> > +	fi
> > +
> >  	if test -z "$local_mode" || test -z "$remote_mode"
> >  	then
> >  		echo "Deleted merge conflict for '$MERGED':"
> > diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> > index 70afdd06fa..b75c91199b 100755
> > --- a/t/t7610-mergetool.sh
> > +++ b/t/t7610-mergetool.sh
> > @@ -828,4 +828,22 @@ test_expect_success 'mergetool -Oorder-file is honored' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success 'mergetool automerge' '
> > +	test_config mergetool.automerge true &&
> > +	test_when_finished "git reset --hard" &&
> > +	git checkout -b test${test_count}_b master &&
> > +	echo -e "base\n\na" >file1 &&
> 
> I think test-lint-shell-syntax should have complained about the use
> of "echo -e" here (that's the reason why I queued the patch in 'seen'
> initially but it does not appear in what finally got pushed out).
> 
> You can either use the plain-vanilla
> 
> 	cat >file1 <<-\EOF &&
> 	...
> 	EOF
> 
> because there is nothing gained by saving number of lines with
> reduced readability, or can use
> 
> 	test_write_lines >file1 base "" "" a &&
> 	...
> 	test_write_lines >file1 base "" "" c &&
> 	...
> 	test_write_lines >file1 local "" "" b &&
> 	...
> 	test_write_lines >file1 local "" "" c &&
> 	...

It's only one "", but OK.

> which would both save number of lines while making it a bit clearer
> which 'line' corresponds to which other 'line' in different
> preparation of the same "file1".
> 
> Will expect a reroll.  Thanks.

I have the next version ready, I'll wait for feedback from Seth
regarding tools that might want this turned off (which in my opinion are
zero).

Cheers.

-- 
Felipe Contreras
