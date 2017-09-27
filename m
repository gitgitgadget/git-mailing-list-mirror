Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F08C20281
	for <e@80x24.org>; Wed, 27 Sep 2017 05:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbdI0FXe (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 01:23:34 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38831 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbdI0FXb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 01:23:31 -0400
Received: by mail-pf0-f194.google.com with SMTP id a7so5941570pfj.5
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 22:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=egE+igZNyKzvaVnmfyO7SffR8QGhgxvAy5DzZe7JM4c=;
        b=SSQhlP+fnKb0ypetFHHROsHMxdcz0Lp2XxkJxgx3Go5+R9jcGPmJMX+RBX7NlAizAK
         OcClP14asuuv8t7pkI1IQxFlwwEONzithxua0AAlbgEy4jIaNDcND/ffxteHXqCfdSKI
         IDzpZYAlDhRwe4Du2MQLOcZao6tg2RVXabcUbVBeQfdN3sydgObvEUMkC37DCM5yXKqT
         RqW2T4uAccij4mRnbJDl+WX5APzlmO0qM0JCYZ01h1gj2qZU4DSqYPatdwmxHvlXnp1Q
         9+0jxsbdIky2oV/saLY6l8/k3g97UFu8NwklB3Z2D7sv5eDDKhfLiIbtYeA5pjIODZEl
         Uoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=egE+igZNyKzvaVnmfyO7SffR8QGhgxvAy5DzZe7JM4c=;
        b=mFst+T8R5De/ZDYPlKMqfZzV7KqfWAF1Xux7j7qe3rriUTKaA1HOjxnT06UQz+iMH9
         irGpCmyzk7XL2QqJEEZLIB6WM1X2MLRH5axnW7PtrDv5ozjiBpT+ElyCK3Tcoc/3Nprc
         jYfMi80nQvkjdW1GGvcPTZYbpDbtfhYHVOZcYh30/DaT+TyS0EioZ+PtgnnyweUoLerW
         TSAhLaTwWMDJtqV6Do60cibFzzziGkuYHy+C7Cde8UTtKlKKmtcGja8X9Fi1yDBu1R4o
         UVhef1cI5NbZyS+OYfuUVvEw7i10vkWaaAY7T/v/An+UvTX4JUDffnxegXpn5KMRHKOP
         ImZg==
X-Gm-Message-State: AHPjjUh1xUZ6lPZps13KqFzS3bIe+rF2oqlk2A4LOOfRqGBjTIX4APyv
        FBkNu4ItDKjgXrZbFw+kBZA=
X-Google-Smtp-Source: AOwi7QD8nIjbip73mBXC0h4zU1DAsXW+UpIG3JEAvno9qUTmdbOiqY+eO5w6sX/LWFyGr9aldnystg==
X-Received: by 10.101.71.193 with SMTP id f1mr239855pgs.251.1506489811089;
        Tue, 26 Sep 2017 22:23:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id 207sm18841981pfu.0.2017.09.26.22.23.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 22:23:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 5/9] upload-pack, receive-pack: introduce protocol version 1
References: <20170913215448.84674-1-bmwill@google.com>
        <20170926235627.79606-1-bmwill@google.com>
        <20170926235627.79606-6-bmwill@google.com>
Date:   Wed, 27 Sep 2017 14:23:29 +0900
In-Reply-To: <20170926235627.79606-6-bmwill@google.com> (Brandon Williams's
        message of "Tue, 26 Sep 2017 16:56:23 -0700")
Message-ID: <xmqqvak467fy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> @@ -1963,6 +1964,19 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  	else if (0 <= receive_unpack_limit)
>  		unpack_limit = receive_unpack_limit;
>  
> +	switch (determine_protocol_version_server()) {
> +	case protocol_v1:
> +		if (advertise_refs || !stateless_rpc)
> +			packet_write_fmt(1, "version 1\n");
> +		/*
> +		 * v1 is just the original protocol with a version string,
> +		 * so just fall through after writing the version string.
> +		 */
> +	case protocol_v0:
> +	default:
> +		break;

When protocol_v2 is introduced in the other part of the codebase
(i.e. in protocol.[ch]), until these lines are updated accordingly
to take care of the new protocol, we'd pretend that client asked
(and the server accepted) v0, even though the client and the daemon
agreed to talk v2.

Shouldn't the "default:" die instead?  The same for upload-pack.c
