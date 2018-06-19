Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC0AA1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966784AbeFSQVn (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:21:43 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:42163 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966993AbeFSQVn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:21:43 -0400
Received: by mail-wr0-f178.google.com with SMTP id w10-v6so263039wrk.9
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 09:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1yYmzclksAijndCBpCuPpPDkLF9owU1jmAPy/P6593k=;
        b=Yo/czT4PSrsxCqHAWzyvOy52RVAfVSvaRD+DEHwbxYw13MFfIBc2yVvPMBs//d3CO/
         7btUWjOyB0vMJal4Ri2ZlpK+IM6OaJpF0dDDINaJtFzlY/SRK/GUnN9S2LFCTKFRX5+f
         5PFi96sGMGe1Uau64NnKrqVbt4nrhDJcGANQ70q5RLtHF4TZRH5sD/BktSPYFwfCoJfZ
         cFmMEEpAg6DCSBS0bXK8l6vid9EFFXIylDuX44a4LPFi/NSWyabzakdM9eeXmT3kuRkz
         dAzVDi5OV55340hAGs1f1YNYXudFRUYsCq+85oUugwsQfodyFkDcOJTQR9eE2gC3ejQ4
         ddng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1yYmzclksAijndCBpCuPpPDkLF9owU1jmAPy/P6593k=;
        b=sMcd82pD+fl/aIFWGRTc7mx5M15B1YJK6E3cey3Ue3rE8nl9EfZUkhIseRWaU2iFrS
         iC2QYPf+bqeU4lyrfRcr+01LwYECF5PDrRXn3jEHExhy5npP/tJrmWoUGFtrotCzsgEu
         8Z6Ab7oLDqF5yN3ycxgnuNv9gamNCVTZ9E4Pv6+TvXq8rbAC25lSyHxQLvBN+a924Ah/
         nWAhIaD/dVUBWN1v4UH+EEKloRoxCNYwaWfycGtP2zflOo5Y7DR0YdqSCLqEjXV3Rxwg
         qfz4WpbuNbahsbDq3gLM/F8P6LjanSKPpUeFkB9ryem5szetwR1YZSJuEVsy6yQh9kBM
         n7HQ==
X-Gm-Message-State: APt69E1B35xrQBSrBrb0GVJ/QPyAIi9ROEBfpOW2fPyrJzEb1bOxM+SS
        VzXTNL2/qcI9EWByO4ceBwI=
X-Google-Smtp-Source: ADUXVKIVz8dmEYHTwZgahewzccRiN0qXPLha1hTt03bTbk2BmX/NmRGOcQ56egvMpyGr/aklDUzC7A==
X-Received: by 2002:adf:ad4c:: with SMTP id p70-v6mr13559537wrc.44.1529425301572;
        Tue, 19 Jun 2018 09:21:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g205-v6sm532916wmg.43.2018.06.19.09.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 09:21:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>, git@vger.kernel.org
Subject: Re: [PATCH] t3404: check root commit in 'rebase -i --root reword root commit'
References: <pull.3.git.gitgitgadget@gmail.com>
        <d59805a43ddaf4bbd4528a2b7afa9809eca9b86b.1529177176.git.gitgitgadget@gmail.com>
        <484fe825-0726-a027-1187-de00df6406d5@talktalk.net>
        <20180618164958.GO11827@zaya.teonanacatl.net>
        <nycvar.QRO.7.76.6.1806182343421.77@tvgsbejvaqbjf.bet>
        <20180618221942.GQ11827@zaya.teonanacatl.net>
Date:   Tue, 19 Jun 2018 09:21:40 -0700
In-Reply-To: <20180618221942.GQ11827@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Mon, 18 Jun 2018 18:19:42 -0400")
Message-ID: <xmqqa7rqwxuz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> index e500d7c320..352a52e59d 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -977,7 +977,8 @@ test_expect_success 'rebase -i --root reword root commit' '
>  	set_fake_editor &&
>  	FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" \
>  	git rebase -i --root &&
> -	git show HEAD^ | grep "A changed"
> +	git show HEAD^ | grep "A changed" &&
> +	test -z "$(git show -s --format=%p HEAD^)"
>  '

The additional test probably will pass when HEAD is a root commit by
failing to refer to HEAD^, resulting an empty output from show.  The
previous step would also give an error and won't emit anything that
would match "A changed", so it probably is OK, though.
