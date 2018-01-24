Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818CE1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 21:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbeAXVPJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:15:09 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37571 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbeAXVPH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 16:15:07 -0500
Received: by mail-pf0-f193.google.com with SMTP id p1so4110942pfh.4
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 13:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1vTEMWYlhg5TDMLSpkWl5infSbaGSsWdguVtSOwPbMw=;
        b=W4Y/DgtEaE+dAngoONfC1PwrCY8dsGlJaiVo1Q4QayxzmrVdsg74sSnyjPJqH+WTjt
         d4JXePTyIrhqH8p3RxfIqMU2SCuQU30sltRlrm88ehAPmZSt8UeaxXK9ipaB7N4nlRVW
         e0igqCOPjciboE9UE1OzwHb1U5jugPYwl4D9oH4TMlcNb5FS7DLKNjMYTxiEgwuOf/Ps
         cgmYe0lu5RT4uPI+q+fnYrTb3KXjPdaW0OfjMyMyIuIuybdA0I1KuGGLMnZ9OK6otaBm
         JEC52UJGqjIcjq24F2pUtJolXPFM5ndkvp1mWAoRJ34MmsRWj18d5T4Xwos/aHcf+8l8
         ZEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1vTEMWYlhg5TDMLSpkWl5infSbaGSsWdguVtSOwPbMw=;
        b=aGAUSYhO+PIjSHEKzw4M2De6A6+y4FaJLgECH1ud3N3dV4qfN1/930p/qD7AHlivqL
         sIc6G0yqc+18WO6K5z7VYwMddJyeexQSDbBxImETRSvEYTiiBmOYpwArQ7pW+3UrrgMS
         97maOZcC6K47kNodqJrV4dJUVYroD/kkkDzRY5cnQIvXXoYtVYiGtJ4OgTznjgFG2+2s
         02thMfnjOrPrra+tDtF3hO54zBywfc8JMwPSER0e61bZwrD7LjI1mPG6DZhfMXypE8tz
         k9OysACRgIFkoUjK9i3QvXpCh/IicbE4Iu9qZbvD6oAAuHxMS3cbUrNAZnRpfzEk9Xkz
         51IQ==
X-Gm-Message-State: AKwxyte9nh67r8Evqj+vFtktX2x8jN7WV1AVIuAI//bKxmxiPkv8vEOW
        PT9tCQZ81GXzJxIyx9AC6fU=
X-Google-Smtp-Source: AH8x2253XctqkFD1dWjCCxgAjQZzAGBRU6kwuQp0dSyQcBHVD0qxAQy0uWOSOcXf29GG+NRMSD2ijQ==
X-Received: by 2002:a17:902:622:: with SMTP id 31-v6mr9157147plg.448.1516828506171;
        Wed, 24 Jan 2018 13:15:06 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id i14sm1744273pgv.40.2018.01.24.13.15.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 13:15:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 11/11] fetch: add a --fetch-prune option and fetch.pruneTags config
References: <20180123221326.28495-1-avarab@gmail.com>
        <20180121000304.32323-1-avarab@gmail.com>
        <20180123221326.28495-12-avarab@gmail.com>
        <xmqqo9ljc73n.fsf@gitster.mtv.corp.google.com>
        <878tcnklzc.fsf@evledraar.gmail.com>
Date:   Wed, 24 Jan 2018 13:15:04 -0800
In-Reply-To: <878tcnklzc.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 24 Jan 2018 22:03:51 +0100")
Message-ID: <xmqq4lnbc61z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, Jan 24 2018, Junio C. Hamano jotted:
>
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>>  git -C {} config --replace-all remote.origin.fetch "+refs/tags/*:refs/tags/*" "^\+*refs/tags/\*:refs/tags/\*$"
>>
>> Shouldn't the last arg be
>>
>>  '^+\*refs/tags/\*:refs/tags/\*$'
>>
>> instead?
>
> ^+\* isn't a valid pattern.

Yikes, sorry for the noise.  You did mean "there might be a plus
sign at the beginning, but there may not be".

