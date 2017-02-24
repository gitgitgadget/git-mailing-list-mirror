Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4968201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 21:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdBXVSw (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 16:18:52 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32934 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbdBXVSv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 16:18:51 -0500
Received: by mail-pf0-f194.google.com with SMTP id p185so1415405pfb.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 13:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1oeCxT4BNO1koGtApvJoS30+8zPRA54YjJbPyYRyCCc=;
        b=n/BQ0jZLP2L1H523y7tgUp1y8MGyuOha7ceqcWMXOiMdxcmAL1KCpaYj46eoYAebT9
         ZNgaCN6sBxEPWfr8fwq11srjZ2SmVuzMDLfMIiUxGy0KOU9SA/OzJ6GOW+ncAFsGIJPd
         dSd39ylxrdBlSscjuNt4zfDwxe1OKehHAumi2uFgbWG0OhOGCkmpcrKbgqYl8qTicBny
         jzHY3OvL4JqMbs00xLRjrzLMWZto9R/ntOiHFv2cb/qhUb+EyWbyH1BlYnPOmHQZusBM
         MdGmP9UCrXGMBrYOw411YRTj+S0pO03qJg3yKI8Gj7cgg/233e/HeOEsG+cqYGB6JuBg
         9hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1oeCxT4BNO1koGtApvJoS30+8zPRA54YjJbPyYRyCCc=;
        b=eka4qx49gx/aVAtPAiSrzG7ti6yBo5kx836wKLFuIMHEHSarR2f++8jCGVQCJtx14s
         46nU1CjA6tCjeQk/HAF6i6I2p+qhdLbNORuzQYwaxUxUdBRLvssir96PpxytnbeYVgAG
         cGNeAprcI+T4bUwB6fU8mb+C+US09JWIQ4IZ4r10+Jli2naJ09MjAvmmW840aOZkWWAa
         uy8+S6Rvk7Oxm8fzi6z/f5ROUmt6NGiZBM1QkkmVVx+vM7LzokIZ6h58Yi1DyKgWybmt
         94A+MswMxTnYMfTI98ZqRQ7j0Ub78Q79C2nUZyxvjQdFgNVEue3zWySrhqkTX5nwHS6J
         vMuA==
X-Gm-Message-State: AMke39nULyZCCvJBvkfp7Evxne8+5ZVYuQTzXmMhpKZxLO0iuF5EjJLP2rG4ikEyoR2DRw==
X-Received: by 10.98.196.12 with SMTP id y12mr6128956pff.49.1487971130219;
        Fri, 24 Feb 2017 13:18:50 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id a24sm16749181pfh.33.2017.02.24.13.18.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 13:18:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] refs: parse_hide_refs_config to use parse_config_key
References: <20170224203335.3762-1-sbeller@google.com>
        <20170224203940.hbmfsouw5k67l3h3@sigill.intra.peff.net>
        <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net>
Date:   Fri, 24 Feb 2017 13:18:48 -0800
In-Reply-To: <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 24 Feb 2017 16:06:44 -0500")
Message-ID: <xmqq4lzj1e4n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Feb 24, 2017 at 03:39:40PM -0500, Jeff King wrote:
>
>> This will start parsing "receive.foobar.hiderefs", which we don't want.
>> I think you need:
>> 
>>   !parse_config_key(var, section, &subsection, &subsection_len, &key) &&
>>   !subsection &&
>>   !strcmp(key, "hiderefs")
>> 
>> Perhaps passing NULL for the subsection variable should cause
>> parse_config_key to return failure when there is a non-empty subsection.
>> 
>> -Peff
>> 
>> PS Outside of parse_config_key, this code would be nicer if it used
>>    skip_prefix() instead of starts_with(). Since it's going away, I
>>    don't think it matters, but I note that parse_config_key could
>>    probably benefit from the same.
>
> While I'm thinking about it, here are patches to do that. The third one
> I'd probably squash into yours (after ordering it to the end).
>
>   [1/3]: parse_config_key: use skip_prefix instead of starts_with
>   [2/3]: parse_config_key: allow matching single-level config
>   [3/3]: parse_hide_refs_config: tell parse_config_key we don't want a subsection

While you were doing that, I was grepping the call sites for
parse_config_key() and made sure that all of them are OK when fed
two level names.  Most of them follow this pattern:

	if (parse_config_key(k, "diff", &name, &namelen, &type) || !name)
		return -1;

and ones that do not immediately check !name does either eventually
do so or have separate codepaths for handlihng two- and three-level
names.
