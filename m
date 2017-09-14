Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34E0920A21
	for <e@80x24.org>; Thu, 14 Sep 2017 07:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbdINHSf (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 03:18:35 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:45716 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdINHSf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 03:18:35 -0400
Received: by mail-it0-f50.google.com with SMTP id v19so2903146ite.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 00:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nCiPrbVuwcui1m+So77BjYu1ukyvPxC/fezE460uqlA=;
        b=rvWA+DypwX/Xz7OAZGwuaUOeDMTIYAbXSv/1VpQ6ez2MdaBi6ymzEy8sPOtbYCuiGw
         N5ffgOHG8n1mQzHqzRUJxYwAktGpYZoD6WZBiqobyDQLay5VvTQ9dI2lslM7rDtynUKO
         nQoLsOokwpev/UUW1KXBNiL2VjiT4h7WDj1uCLWgggMFlKrr/joCjMZ8mnwVhhonKIMW
         CgOvsxtFIOWl5w6wghQLDau46TthcFq8tvbahxeAR+Qkufa1YZDVcXJWw6mXl60noS8O
         AmKfFFYriPWUu1VtCmcXWmVy1Jcic9adzlYfOyn5ibQG64W9tsbojzrXAd0zjMdkD5qO
         +THA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nCiPrbVuwcui1m+So77BjYu1ukyvPxC/fezE460uqlA=;
        b=nwu36n0pdQj7G6SI64Nre7l6NHt8NnyWjJ1aX2LUWvsX+E59cALFLmYU/P9DbzUeHw
         y+TkTdcBoayfyS91TB4CPr3q6Mc+lJHC9WMQKn8tp59VO8Bi0t7+3JTv9Zim4608jx0m
         f6tDW4OADICU6dMQTErKtZ6aF3Bfqo6ZJl/VmiOgUGFRWH1Bmhw8tByl1d7HLK/t9NIY
         XsythGVnhlabF+VbTFGa8yFLnK7QdNmUoN/LGHkE79A4V1nHKmoLL4tZMfEbmSQGu8JQ
         QfoGaxwKn5V9pSuEeE1ugrdPLcPsCXnqJf2hZWX7ZQ5UrIRr8xXZegH2Aj+JQDd1MM9z
         pW1Q==
X-Gm-Message-State: AHPjjUita18S1IvsJz736e6ORVTi97ZYTechaQiOV67/rQn0jVrd/LS8
        KdF/8s/rQZzEx88afiAuzJSGLFnohgoOu0wGf+HYhw==
X-Google-Smtp-Source: AOwi7QAmHVCXjX+9dM5FP3qwGuL1tnZ/wLdgN/ti3S/eQg69ZZPqnSwLjW1ZSNgYpJshcXVkCyijVt0xRyxXLAdDa6M=
X-Received: by 10.36.73.216 with SMTP id e85mr2003210itd.116.1505373514068;
 Thu, 14 Sep 2017 00:18:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Thu, 14 Sep 2017 00:18:33 -0700 (PDT)
In-Reply-To: <C327746B-3E57-4AA9-B29E-AA3C33722D3B@gmail.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-12-chriscool@tuxfamily.org> <C327746B-3E57-4AA9-B29E-AA3C33722D3B@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Sep 2017 09:18:33 +0200
Message-ID: <CAP8UFD0roTFSt4Q9-_2fxDb9r0a5LxQ5rKbbbz2ZfPcEZqdTuQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/40] odb-helper: add odb_helper_init() to send 'init' instruction
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>, Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2017 at 2:12 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 03 Aug 2017, at 10:18, Christian Couder <christian.couder@gmail.com> wrote:
>>
>> +static void parse_capabilities(char *cap_buf,
>> +                            unsigned int *supported_capabilities,
>> +                            const char *process_name)
>> +{
>> +     struct string_list cap_list = STRING_LIST_INIT_NODUP;
>> +
>> +     string_list_split_in_place(&cap_list, cap_buf, '=', 1);
>> +
>> +     if (cap_list.nr == 2 && !strcmp(cap_list.items[0].string, "capability")) {
>> +             const char *cap_name = cap_list.items[1].string;
>> +
>> +             if (!strcmp(cap_name, "get_git_obj")) {
>> +                     *supported_capabilities |= ODB_HELPER_CAP_GET_GIT_OBJ;
>> +             } else if (!strcmp(cap_name, "get_raw_obj")) {
>> +                     *supported_capabilities |= ODB_HELPER_CAP_GET_RAW_OBJ;
>> +             } else if (!strcmp(cap_name, "get_direct")) {
>> +                     *supported_capabilities |= ODB_HELPER_CAP_GET_DIRECT;
>> +             } else if (!strcmp(cap_name, "put_git_obj")) {
>> +                     *supported_capabilities |= ODB_HELPER_CAP_PUT_GIT_OBJ;
>> +             } else if (!strcmp(cap_name, "put_raw_obj")) {
>> +                     *supported_capabilities |= ODB_HELPER_CAP_PUT_RAW_OBJ;
>> +             } else if (!strcmp(cap_name, "put_direct")) {
>> +                     *supported_capabilities |= ODB_HELPER_CAP_PUT_DIRECT;
>> +             } else if (!strcmp(cap_name, "have")) {
>> +                     *supported_capabilities |= ODB_HELPER_CAP_HAVE;
>> +             } else {
>> +                     warning("external process '%s' requested unsupported read-object capability '%s'",
>> +                             process_name, cap_name);
>> +             }
>
> In 1514c8ed ("convert: refactor capabilities negotiation", 2017-06-30) I introduced
> a simpler version of the capabilities negotiation. Maybe useful for you here, too?

Yeah, actually there is also fa64a2fdbe (sub-process: refactor
handshake to common function, 2017-07-26) that Jonathan Tan wrote on
top of your changes and that adds subprocess_handshake(). So the
current code is using it like that:

static int start_object_process_fn(struct subprocess_entry *subprocess)
{
    static int versions[] = {1, 0};
    static struct subprocess_capability capabilities[] = {
        { "get_git_obj", ODB_HELPER_CAP_GET_GIT_OBJ },
        { "get_raw_obj", ODB_HELPER_CAP_GET_RAW_OBJ },
        { "get_direct",  ODB_HELPER_CAP_GET_DIRECT  },
        { "put_git_obj", ODB_HELPER_CAP_PUT_GIT_OBJ },
        { "put_raw_obj", ODB_HELPER_CAP_PUT_RAW_OBJ },
        { "put_direct",  ODB_HELPER_CAP_PUT_DIRECT  },
        { "have",        ODB_HELPER_CAP_HAVE },
        { NULL, 0 }
    };
    struct object_process *entry = (struct object_process *)subprocess;
    return subprocess_handshake(subprocess, "git-read-object", versions, NULL,
                    capabilities,
                    &entry->supported_capabilities);
}
