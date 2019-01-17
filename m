Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3441A1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 19:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfAQTnU (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 14:43:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38642 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfAQTnU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 14:43:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so12377409wrw.5
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 11:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=15O63urNQNHAdQN8cQb1yjv0vro13Csz/ouHIT6yGwI=;
        b=fM/VbX2GM23nOIAN8zCetk6VVuU80SVpDIZCPt9MgjwD6Fqd2RWXKH+s1H7Sh+P5kW
         XJp7835NIZfxpZk8ERtWZt6rxYJ0GUXIlm3eCE2ZTbl5XbXE86Q1W54x2GxZzuNX0KyZ
         XhJEJiOojwP2K6HlJJaxdtv8PXwo5q3J7swn+7rmrEwscKhT+4nPlSip47529QM/ILga
         3Zrk08vmqRjKNnThEtw1fIlutdUIPZpdExDZkgfxdTJXU9hZ7+N4YxjAo8Ia2y2hgPp2
         gtfDVHeydJHfHqwedpFEMf9uJjPRzbOW2LKWy3fQiB0v6zPeDo9UxaJmyC+D3Zm200PY
         Depg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=15O63urNQNHAdQN8cQb1yjv0vro13Csz/ouHIT6yGwI=;
        b=AeBUAZN2metUOIIxTeEAEX55jm2DcOxyD9KQ8rApRJn/9kBZHdoeNhNH5os9WGPSQ9
         3hdKuGg6UgVujo8TOKVnBU/XpR1FES9sNZ8EwlypKw/nIox5OATysbYniwxjy3Rh59FA
         N0v8HfflXjEsQ5UF6GElw0FjogXJc/Y9J5nMLPLC3WydlEtDOGNH/L8zFhRXpRWLMOB2
         Ksjr495P9jL/zaFq8FPqgfIIPYdyVB1zx3IYOXL2CGDs0sTox/AM3igRVRTfZdFG4Cf0
         +YtDaRNUAYPcR6+7T5IyakJvyxeR6ajPSzf20KfvOMIPPCF5G+eUql2LGB/PQszFVdUi
         QZRg==
X-Gm-Message-State: AJcUukdJMcLqmRXBPZYiq+IBqU729lZcPFK3BlGv4oy6hnjN62jk4v0k
        j3EqrK/lugqozCGiiGq6Hm8=
X-Google-Smtp-Source: ALg8bN54A9kVCEPViA6Gk9LShfOQfXgf2xttTS1WrphSs7gX8SnjbPGrxm/5wurHpNU89xDF1MKWcw==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr13197712wro.29.1547754197865;
        Thu, 17 Jan 2019 11:43:17 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a132sm48873235wmh.5.2019.01.17.11.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 11:43:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com
Subject: Re: [PATCH v3 0/4] Sideband the whole fetch v2 response
References: <cover.1547244620.git.jonathantanmy@google.com>
        <cover.1547666330.git.jonathantanmy@google.com>
Date:   Thu, 17 Jan 2019 11:43:16 -0800
In-Reply-To: <cover.1547666330.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 16 Jan 2019 11:28:11 -0800")
Message-ID: <xmqq5zunnk8b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>  /*
> + * Inspects a multiplexed packet read from the remote. If this packet is a
> + * progress packet and thus should not be processed by the caller, returns 0.
> + * Otherwise, returns 1, releases scratch, and sets sideband_type.
>   *
> + * If this packet is SIDEBAND_PROTOCOL_ERROR, SIDEBAND_REMOTE_ERROR, or a
> + * progress packet, also prints a message to stderr.
> + *
> + * scratch must be a struct strbuf allocated by the caller. It is used to store
> + * progress messages split across multiple packets.
>   */
> +int demultiplex_sideband(const char *me, char *buf, int len,
> +			 int die_on_error,
> +			 struct strbuf *scratch,
> +			 enum sideband_type *sideband_type);

OK.  That sounds like a sensible way to keep the leftover across
calls.

Will queue.
