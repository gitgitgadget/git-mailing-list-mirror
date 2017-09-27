Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213AA20281
	for <e@80x24.org>; Wed, 27 Sep 2017 05:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbdI0FRn (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 01:17:43 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:52846 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdI0FRh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 01:17:37 -0400
Received: by mail-pg0-f42.google.com with SMTP id i195so7155725pgd.9
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 22:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TlKJ/+DbU3jDcts3UoeA2ErvXTL4dwWEmNQ8FvGiDTk=;
        b=sVcP3395aWGr/7jay9ALiGrIDyqcYPsl6XRT4dfso+w40aZZ8rPq9e6bB1uTfLB8zt
         O1+nXlIS7q3QPKEKydmBTepRAUOovdg11FeSDX5O8j+HIKTW4QJK0tzalG1HTSo6WcLs
         6JlXIkoMvmD9LueqVmO7uSCWD4NqTxXbDkvbTxcxlvQQya1hsFnvgwzxaFAwvvtjEQ+3
         QqwQTa8aR9nnbgaxCdadOnDYUnmxKX+gEK23tm/0S7zHlwqHVFMJ8ThMXooUm5wYJ7ex
         SRYKtmczSPk668+XyPNFWUeFNZLk/J9vHjmYLyBpbfyuu2IPZg16rTVNql9PkLdSceX5
         NOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TlKJ/+DbU3jDcts3UoeA2ErvXTL4dwWEmNQ8FvGiDTk=;
        b=rpvBVNpzmGRbQZo2u/mwceFDTVluET01Vo0jrarAUsUooKzwVJQHL7qp50JYvGLI45
         GrdfggdR+ReJQT57Ag4C/23OT83mZAmaO5WD9VucGEf73epJOuy7Z1ShFiaKrXKP56ho
         FPFFvlQ5BmoLjp22ZErlKJVU+pzGaEoE+NC44t2QXJF1wUmFaciEdh7HpphBUHmGflQX
         ZzufZ4fdGYiu8Hn47PY9KIClxAgWcH4tEj+tOQbF1ZF78LIzhq0/a3dsEsZJEYzZc2t7
         O5DUFXVd+eKarWOh7oNqyHSp/HSTlgUruYJu3MoB4k/LzDZPFr9AFSd+b0aVn3+QaY+c
         5AYw==
X-Gm-Message-State: AHPjjUh0J+br0oa2i2bn9RZkIZZ2mU1dUGHLsBVOftBNoubRo8XrJ6xy
        pcmN2GHRuicuWP1hl2XyOU0=
X-Google-Smtp-Source: AOwi7QCOADGa3IrxiQn8wxguR66NDoixrHeiR9alR9xGmRsRVNd8wnItjnd3YG8raInJQNjbaduYzQ==
X-Received: by 10.98.130.205 with SMTP id w196mr215302pfd.189.1506489456768;
        Tue, 26 Sep 2017 22:17:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id o186sm17527860pfg.144.2017.09.26.22.17.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 22:17:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 3/9] protocol: introduce protocol extention mechanisms
References: <20170913215448.84674-1-bmwill@google.com>
        <20170926235627.79606-1-bmwill@google.com>
        <20170926235627.79606-4-bmwill@google.com>
Date:   Wed, 27 Sep 2017 14:17:32 +0900
In-Reply-To: <20170926235627.79606-4-bmwill@google.com> (Brandon Williams's
        message of "Tue, 26 Sep 2017 16:56:21 -0700")
Message-ID: <xmqq4lro7mab.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +`GIT_PROTOCOL`::
> +	For internal use only.  Used in handshaking the wire protocol.
> +	Contains a colon ':' separated list of keys with optional values
> +	'key[=value]'.  Presence of unknown keys must be tolerated.

Is this meant to be used only on the "server" end?  Am I correct to
interpret "handshaking" to mean the initial connection acceptor
(e.g. "git daemon") uses it to pass what it decided to the programs
that implement the service (e.g. "git receive-pack")?

> +/*
> + * Environment variable used in handshaking the wire protocol.
> + * Contains a colon ':' separated list of keys with optional values
> + * 'key[=value]'.  Presence of unknown keys must be tolerated.
> + */
> +#define GIT_PROTOCOL_ENVIRONMENT "GIT_PROTOCOL"

"Must be tolerated" feels a bit strange.  When somebody asks you to
use "version 3" or "version 1 variant 2", when you only know
"version 0" or "version 1" and you are not yet even aware of the
concept of "variant", we simply ignore "variant=2" as if it wasn't
there, even though "version=3" will be rejected (because we know of
"version"; it's just that we don't know "version=3").

> +enum protocol_version determine_protocol_version_server(void)
> +{
> +	const char *git_protocol = getenv(GIT_PROTOCOL_ENVIRONMENT);
> +	enum protocol_version version = protocol_v0;
> +
> +	if (git_protocol) {
> +		struct string_list list = STRING_LIST_INIT_DUP;
> +		const struct string_list_item *item;
> +		string_list_split(&list, git_protocol, ':', -1);
> +
> +		for_each_string_list_item(item, &list) {
> +			const char *value;
> +			enum protocol_version v;
> +
> +			if (skip_prefix(item->string, "version=", &value)) {
> +				v = parse_protocol_version(value);
> +				if (v > version)
> +					version = v;
> +			}
> +		}
> +
> +		string_list_clear(&list, 0);
> +	}
> +
> +	return version;
> +}

This implements "the largest one wins", not "the last one wins".  Is
there a particular reason why the former is chosen?

