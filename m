Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941B81FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 16:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbdFMQVj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 12:21:39 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34391 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdFMQVi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 12:21:38 -0400
Received: by mail-pg0-f46.google.com with SMTP id v18so62848232pgb.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yDbYHGt7dWwxQOa8NxjqWqjNW5/HQTh7AZdQEbKtIqQ=;
        b=cCUDwRgZnjRLDBc+I4YYSmrim7bjFgK2RNGQySs7Zc1D7l0RacmorsP97iUdSrBVLe
         v3yCo9eGKQBOjjwboWI+vpIs3QsqOraFXw7sZXdBk9c9uWnmpQ0FM1TO1CCYFMrUVkJB
         gevpjj+Sj7bPRRfEjv46af/yBm/5j6wXalONz5gTQ12aRoDBTS7lX+ObivwxMXuGV4+g
         6+eKQQNAuhdPg1jGFdcwq4wNcw+XEIXaYcJAhsynsAi374mCaBdLad/PteRWTyW8+ZkE
         jRBsXwa57Kw8mTd+rhOvRGdVBRbvsNTLDMN3iLiLgi4D9y4Kh5AskE8NYD3KVraXOFa/
         EW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yDbYHGt7dWwxQOa8NxjqWqjNW5/HQTh7AZdQEbKtIqQ=;
        b=FqWiwcLefw1uF/t2v54dh/MPlwV+f6aZILbNhGWDnOK0hmrf3C0zSqWkbRDURSs5g/
         JLesN9R7oCgwyRW6se6ESVgE9h9mOLvoJ0FqPyfwYKfbkcsTgD0t5fI63Rq21Zkvv6vF
         CfzavZXaAeCDz5Ubtkh7f2Ce0Qeyjd8DGKpDU1SiVYjLYxSorf43i/5zombnlp45KkS4
         YbIwemQLoYziymHlzGEI+iFZ1jIpoGfXotwsaRBs941pW4I3+A5/50qzwauVuxvnwZ2v
         f6XVwcRV4RtrLlpJW90Rba4wBlNqKBQRzXV66CJDhZNi8sfRvD/8xLDlOIkYa5gPa9pY
         bGqw==
X-Gm-Message-State: AKS2vOxAUQTJ975a9t+Gb5kYbBL6nY2lL7ekDWDLDL5Fi52UtPM6Oe45
        jgCi4VnNxRRUIw==
X-Received: by 10.84.164.193 with SMTP id l1mr512598plg.243.1497370892574;
        Tue, 13 Jun 2017 09:21:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id q68sm31910886pfj.40.2017.06.13.09.21.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 09:21:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v3 6/6] Use the early config machinery to expand aliases
References: <cover.1497355444.git.johannes.schindelin@gmx.de>
        <822765b002488f03523bf440097492be3c14931a.1497355444.git.johannes.schindelin@gmx.de>
Date:   Tue, 13 Jun 2017 09:21:30 -0700
In-Reply-To: <822765b002488f03523bf440097492be3c14931a.1497355444.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Jun 2017 14:04:39 +0200
        (CEST)")
Message-ID: <xmqqk24f97ud.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Instead of discovering the .git/ directory, read the config and then
> trying to painstakingly reset all the global state if we did not find a
> matching alias, let's use the early config machinery instead.

s/read/&ing/, I think.  My reading hiccupped while trying to figure
out what two alternative approaches are being compared.

> It may look like unnecessary work to discover the .git/ directory in the
> early config machinery and then call setup_git_directory_gently() in the
> case of a shell alias, repeating the very same discovery *again*.
> However, we have to do this as the early config machinery takes pains
> *not* to touch any global state, while shell aliases expect a possibly
> changed working directory and at least the GIT_PREFIX and GIT_DIR
> variables to be set.

Makes sense.  Nicely explained.

> Also, one might be tempted to streamline the code in alias_lookup() to
> *not* use a strbuf for the key. However, if the config reports an error,
> it is far superior to tell the user that the `alias.xyz` key had a
> problem than to claim that it was the `xyz` key.

The mention of "streamline" is puzzling to me.  When we are trying
"git xyz", "alias.xyz" is the key we would look up, not "xyz"; it is
not clear to anybody who didn't read the discussion on v2 (which
includes the readers of "git log" in a few months) what kind of flawed
streamlining could look up "xyz" and result in a bad configuration
reported on it.

>  alias.c          | 31 ++++++++++++++++++++++++-------
>  git.c            | 55 ++++---------------------------------------------------
>  t/t7006-pager.sh |  2 +-
>  3 files changed, 29 insertions(+), 59 deletions(-)

Happy to see the deletion of all the save/restore-env stuff.

Except for the puzzlement in one paragraph in the log, looks very
good.  Thanks for a pleasant reading.

