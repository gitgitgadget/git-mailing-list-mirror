Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0D21F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389504AbfAOTuV (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:50:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51884 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbfAOTuV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:50:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so4596614wmj.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 11:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+a2abX91OaigO94gyv+xU+ejwZO0BTVAlWcU3I6cAPM=;
        b=uCHNa5Pi9lfg1IS55SIL5EG4hcyM6YEUnnK5BHr7BTt5Dukapno7tU7ecp0BDjUya/
         mOZ0+mNKtZzsCyvscvE9OJ6ynIWXDZthuSe2L64o22tRIlq91XgM13LzBbrBc8Ntq9vR
         aWY6yLSssDv3gBb1jX/SrKpl9cWrl2o4fSMV/e2jA556s50f4uptfa0bH0LvySkrWwAW
         zGoZ9TC812AOB0IWczEiJx9qSLuxKiBFqhaYQm6SGkQA/cIC8b8AYhivWt/LPX8l8ADu
         1Ox9JpOcN6dimrJj+GIrcRFj/TNeKgiGpSmadVQfEzK5sPpD0J8pgWtGdP/45Xk2Rsjt
         OosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+a2abX91OaigO94gyv+xU+ejwZO0BTVAlWcU3I6cAPM=;
        b=YZgsfjuwl+SrVscPkNNDXmMaDYzv7QY9/LeZdm7YbRmSETvlOqsOy8ff6kqYctiSEV
         5f6KSNVrE6/A5cVifJiCNkc1woBGU/SbgYDjr9mw1xEdsHxDkOqf7IbehsWKoYx7aa4Z
         nWoWXAagfCiTUI7hSYX7xBTGDSR4hAIXEk9LR0xPdoLkLoNmL5CAk3KSrKFkcVbGLjyr
         eJr0+9GkSkzsroY8TE/Mh69BhRdA/l4kOFY6XEdLL0RrNn06Asgxh+ZvMZw0iu6MqyaA
         ea6iiUI6KByHPDgrDcl78OrhPgfNd7Rop4iA0Cd92l7U9OSD/cF8F4q6zIdOmgwmjtAL
         o5Eg==
X-Gm-Message-State: AJcUukcgKpRDhkEi90/r1uil0HL2hROGHtsSoX+l3pVhr8OjwGB9xwb8
        LERXu/FmG3tgpTFou2glMA0=
X-Google-Smtp-Source: ALg8bN5nHbrTvYnaJd43hy8A95qH+IkFQvRLqLwoxSf6uSRjvZlm8zAeNU4bu2P1BkxCFc9XXkEJxw==
X-Received: by 2002:a1c:8b09:: with SMTP id n9mr4648100wmd.38.1547581819203;
        Tue, 15 Jan 2019 11:50:19 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o16sm93523661wrn.11.2019.01.15.11.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 11:50:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Sideband the whole fetch v2 response
References: <cover.1547244620.git.jonathantanmy@google.com>
        <cover.1547581039.git.jonathantanmy@google.com>
Date:   Tue, 15 Jan 2019 11:50:18 -0800
In-Reply-To: <cover.1547581039.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 15 Jan 2019 11:40:26 -0800")
Message-ID: <xmqqtvi9r98l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> @@ -474,6 +474,7 @@ void packet_reader_init(struct packet_reader *reader, int fd,
>  	reader->buffer = packet_buffer;
>  	reader->buffer_size = sizeof(packet_buffer);
>  	reader->options = options;
> +	reader->me = "git";
>  }

This was somewhat unexpected.  I would have thought that an
interdiff would be more like

        +	reader.me = "fetch-pack";
                if (using sideband-all) {
                        reader.use_sideband = 1;
        -		reader.me = "fetch-pack";
                }

> +		case SIDEBAND_PRIMARY:
> +			if (reader->pktlen != 1)
> +				goto nonprogress_received;
> +			/*
> +			 * Since the packet contains nothing but the sideband
> +			 * designator, this is a keepalive packet. Wait for the
> +			 * next one.
> +			 */
> +			break;
> +		default: /* SIDEBAND_PROGRESS */
> +			;

OK.

Will replace.  Thanks.
