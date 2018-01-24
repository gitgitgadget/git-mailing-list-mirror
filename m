Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1A01F404
	for <e@80x24.org>; Wed, 24 Jan 2018 21:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932696AbeAXVgL (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:36:11 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33205 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932539AbeAXVgK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 16:36:10 -0500
Received: by mail-pg0-f67.google.com with SMTP id u1so3636733pgr.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 13:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UhxcZ/Pm3N4QntR4nH2nayjw+KG7B31SK/FoZO2hdRo=;
        b=WMDPyqnzjp0IB5Pg99sCBC9UuQFFPSvhjpoOclewCXfeCVPH+oFXpMvku+gxOFxcmf
         mwxFPh+c3Bx4XNK1iAfHu0v5ryLAvK+BP/0ImDXhAwdeikl/Mj6ZGKvTlPFCX0c1mCfd
         TWGzakqtqYW3fh23W7YQoTQA+o+h9jbDqyUzi4AZ0hXJzXAf/HzDOK5SuwsLv6wK9b9+
         emNa1Tt+7kS3SBM2hqqZjc/hNYNUbq48N/s2jQ0zULX1iW7ES3e5HS5w8HDyLOaNsJNb
         KLJsTseWzYKpqBx1D1brmAHj8ctJwfT7uF0osm1excKaggJXaaTqxOWmTPcCOtZ1Q/1i
         w8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UhxcZ/Pm3N4QntR4nH2nayjw+KG7B31SK/FoZO2hdRo=;
        b=ILKGF6W0t5o6Ifg84KTG/YpoFg5rkzqEiyBVX8oyGjLEyrxmTwY/AQm5qHinUJdAqb
         SvlcjQAmn0983sLyHALd8Bt5tyh9ZQA6A/M+XqZ8xAifQxxUtL5Z9TgtmboXrBOjOtQc
         PTzoaCABryCbpuR3OQZtho02AkeFxg6nsv6NgydL9D3d0bLvFknN8vtVN9h14e45HVP6
         zh9HhhUgABAHb3Bwta2ssik2RWQSBh63TrZL9fiuMlsA4GjZNja1vzh471S+NF5fNH+b
         zU6G1W4FBj4nBE/6nDqNUztqgNGmbwUHcEkkA57EZrPg9RL7jDJdT2MyHN+QFK7gxjBZ
         9I8Q==
X-Gm-Message-State: AKwxytfQYjeauYGWMaCbDrUUetgt1j/KCBMQSHztpAzd1OYz3a0wOpUb
        EJag2Np4uBAa4DsCDfo1TuiqLIiyp3U=
X-Google-Smtp-Source: AH8x224hxU8mQBtR4Qwd1NVWajdeaGBX3G8B7ZSDCi1FdA0VmDcMbEHpfOnDV3+KIPzsT+K5A9IfSA==
X-Received: by 10.101.67.65 with SMTP id k1mr11851894pgq.159.1516829769607;
        Wed, 24 Jan 2018 13:36:09 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id l188sm1716265pgl.72.2018.01.24.13.36.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 13:36:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 04/14] dir: convert struct sha1_stat to use object_id
References: <cover.1516617960.git.patryk.obara@gmail.com>
        <cover.1516790478.git.patryk.obara@gmail.com>
        <cover.1516790478.git.patryk.obara@gmail.com>
        <d7d2ff4d0d18ff381d023d0d2451d161d74a191c.1516790478.git.patryk.obara@gmail.com>
Date:   Wed, 24 Jan 2018 13:36:07 -0800
In-Reply-To: <d7d2ff4d0d18ff381d023d0d2451d161d74a191c.1516790478.git.patryk.obara@gmail.com>
        (Patryk Obara's message of "Wed, 24 Jan 2018 12:11:56 +0100")
Message-ID: <xmqqmv13aqig.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patryk Obara <patryk.obara@gmail.com> writes:

> Convert the declaration of struct sha1_stat. Adjust all usages of this
> struct and replace hash{clr,cmp,cpy} with oid{clr,cmp,cpy} wherever
> possible.  Rename it to struct oid_stat.

OK, but a hunk like this makes readers wonder...

> -static int do_read_blob(const struct object_id *oid,
> -			struct sha1_stat *sha1_stat,
> -			size_t *size_out,
> -			char **data_out)
> +static int do_read_blob(const struct object_id *oid, struct oid_stat *sha1_stat,
> +			size_t *size_out, char **data_out)

... why the variable is still called sha1_stat, not oid_stat.  Is it
because it makes the patch too noisy or something?

> Remove macro EMPTY_BLOB_SHA1_BIN, as it's no longer used.

Good.
