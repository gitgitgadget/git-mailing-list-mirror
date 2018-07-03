Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50F001F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 20:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeGCU3p (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 16:29:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37386 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbeGCU3o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 16:29:44 -0400
Received: by mail-wr0-f194.google.com with SMTP id q10-v6so3178565wrd.4
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 13:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qbSbNbWZslLsj/mPgetCPqL7R6sAhvHyabVSn0REQnA=;
        b=TthdaJL3vGC9WWL/1U/8A361BhPDjXrtG1h60sr7GS77aDbJ980MNSq3ZCfxHcb/4M
         z9XoXWZ/zZxnSG0I8LliBvEogSwjqwNd7A99cXrtX18VNPos5qZyHzvMi0bJ+W3H9IBu
         9gzYG/nHmzKVTUQmydIyp+6LZFGWm/t1QFzYQMDdimku2dM6tJOpRqx0mAWn8Ju18KWI
         y+nPwFS3ii5dcZthSW+WDTpL9DlWFXdbZp2w3EIYzWynvP6jg5Mg3HYCmsHAC31XGaJw
         cYXpNrqfv9CyhVpGSaT+rrTMW/b7jrbsbsUbN7QAQUzenTtWfecoJLFMErEkBU5CRa+O
         rgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qbSbNbWZslLsj/mPgetCPqL7R6sAhvHyabVSn0REQnA=;
        b=AB1A0sdNHWFCPIGzPVrOztDDKASqAnuitApiO19vuqFkiFY9UHN+ckDW+Ws38lelFP
         Bqou7rE+KHiJ7WpgAGoF4Bm3c1QlFoOPiCJ+IsSbiwheppvWBE+egOm5WP43s9gLKhC1
         vcw2fkgvbtZB8qvNrjRuQuJPc2nr0Vh24cqqiJVQ1Q90EqK65mCrrkAIZE29iYOwvAmL
         AGQDJshPKRyzlKxAcK9komr+H4v0dHcOt23ObwWfcAwuk9AVsjbrzZZOMKQOO6IyviOn
         6632vHng6Et4CnyE/kaJuqvet/1gm1lJiEgK7PWkblQ5OcADV45bCsEB7uRR+pbyKELj
         493Q==
X-Gm-Message-State: APt69E2uUbmxMBVLhJ4FVGKGlSEQQG7M6bMXrbTkIcurQtpkKQU0nttJ
        ba5sxg7tVOoqBDhQd/7HUeM=
X-Google-Smtp-Source: AAOMgpelZPFoNNjDrdBcm7npLaJYjAMaIf4vVEaGPef7rApST+Vy6xrqjUViiESfWogfzU8YIk1Hww==
X-Received: by 2002:adf:820a:: with SMTP id 10-v6mr12408872wrb.144.1530649783359;
        Tue, 03 Jul 2018 13:29:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r194-v6sm4287166wmd.36.2018.07.03.13.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 13:29:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2 2/7] rebase--interactive: rewrite append_todo_help() in C
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180702105717.26386-3-alban.gruin@gmail.com>
Date:   Tue, 03 Jul 2018 13:29:42 -0700
In-Reply-To: <20180702105717.26386-3-alban.gruin@gmail.com> (Alban Gruin's
        message of "Mon, 2 Jul 2018 12:57:12 +0200")
Message-ID: <xmqqlgasoyfd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> +	ret = fputs(buf.buf, todo);
> +	if (ret < 0)
> +		error_errno(_("Could not append help text to '%s'"), rebase_path_todo());

Error checking fputs() return is an improvement from the version
that has been queued on 'pu'.  I think messages given to error() and
friends begin with lowercase uncapitalized by convention, though.

> +	fclose(todo);
> +	strbuf_release(&buf);
> +
> +	return ret;
> +}
> diff --git a/rebase-interactive.h b/rebase-interactive.h
> new file mode 100644
> index 000000000..47372624e
> --- /dev/null
> +++ b/rebase-interactive.h
> @@ -0,0 +1,6 @@
> +#ifndef REBASE_INTERACTIVE_H
> +#define REBASE_INTERACTIVE_H
> +
> +int append_todo_help(unsigned edit_todo, unsigned keep_empty);
> +
> +#endif
