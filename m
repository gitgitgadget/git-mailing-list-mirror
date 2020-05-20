Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63102C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 23:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A2220708
	for <git@archiver.kernel.org>; Wed, 20 May 2020 23:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tf4DEWEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgETX7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 19:59:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63594 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgETX7e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 19:59:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E9B21DD068;
        Wed, 20 May 2020 19:59:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YHS+iFQFK/FAXroUtSqvuzqZanc=; b=Tf4DEW
        EzW9ap9R3qvUMubbCmKY8Mui3qdGLdtnbZ9HuC1j+OwW8W9guXUIePHzCkmp7GwO
        fZWMJEWhnB6u1r7vCXR30Yn8gWZ2Ub/Yb6QfMcvnfu+fCrtYwPnHss8WnBXTiN7d
        /rLXAiCaG6sBOG00tt+r+UunmZbTADyt7Ewu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iBK8/ykHtqRbZkrBBF+pktq5lYmJUQqv
        jUlktxdFGakVDFwDX35I0k9y0HYrgBPeOhjIPrUCw/OzTUmBbcEioGDCOnZ2cDyK
        ldttzi+YnR1oJHWXonh9izFp+VqfFsW3ConBuPn+p8Oa+CSRuQ6zE10PQkV1a5xe
        AXRcq4Tn6A4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E1C46DD067;
        Wed, 20 May 2020 19:59:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3163EDD065;
        Wed, 20 May 2020 19:59:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Protocol v2 in v2.27 (Re: Re* [ANNOUNCE] Git v2.27.0-rc1)
References: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
        <20200520193156.GA4700@coredump.intra.peff.net>
        <xmqq5zcquz4t.fsf_-_@gitster.c.googlers.com>
        <20200520220023.GB3648@google.com>
Date:   Wed, 20 May 2020 16:59:29 -0700
In-Reply-To: <20200520220023.GB3648@google.com> (Jonathan Nieder's message of
        "Wed, 20 May 2020 15:00:23 -0700")
Message-ID: <xmqqlflmtaxq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F25EE182-9AF5-11EA-81A4-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Speaking of which, should we enable protocol v2 by default for people
> with feature.experimental enabled, like this?

It is an excellent idea, but is something that had to have been
proposed before -rc0 to be in the upcoming release, no?

The patch looks good; do we have the master list of things that are
under control of feature.experimental knob in the documentation, or
is it a feature that we do not have to have a centralized control?

> diff --git c/Documentation/config/protocol.txt i/Documentation/config/protocol.txt
> index 0b40141613e..c46e9b3d00a 100644
> --- c/Documentation/config/protocol.txt
> +++ i/Documentation/config/protocol.txt
> @@ -48,7 +48,8 @@ protocol.version::
>  	If set, clients will attempt to communicate with a server
>  	using the specified protocol version.  If the server does
>  	not support it, communication falls back to version 0.
> -	If unset, the default is `0`.
> +	If unset, the default is `0`, unless `feature.experimental`
> +	is enabled, in which case the default is `2`.
>  	Supported versions:
>  +
>  --
> diff --git c/protocol.c i/protocol.c
> index d390391ebac..d1dd3424bba 100644
> --- c/protocol.c
> +++ i/protocol.c
> @@ -17,6 +17,7 @@ static enum protocol_version parse_protocol_version(const char *value)
>  enum protocol_version get_protocol_version_config(void)
>  {
>  	const char *value;
> +	int val;
>  	const char *git_test_k = "GIT_TEST_PROTOCOL_VERSION";
>  	const char *git_test_v;
>  
> @@ -30,6 +31,9 @@ enum protocol_version get_protocol_version_config(void)
>  		return version;
>  	}
>  
> +	if (!git_config_get_bool("feature.experimental", &val) && val)
> +		return protocol_v2;
> +
>  	git_test_v = getenv(git_test_k);
>  	if (git_test_v && *git_test_v) {
>  		enum protocol_version env = parse_protocol_version(git_test_v);
