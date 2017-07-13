Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 244DB20365
	for <e@80x24.org>; Thu, 13 Jul 2017 21:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbdGMVA1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 17:00:27 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34231 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdGMVA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 17:00:26 -0400
Received: by mail-pg0-f44.google.com with SMTP id t186so35322901pgb.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 14:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Epbhz5RYQTRi2boei+V41UERspOfZqA8WB9UyzHpXZA=;
        b=IhhtREsniYKtNbikXVSwwp0Lpd45pQWCDhK0qnWy/mkNmBv2ZmWbIRyDzqC+MUI9OS
         m+pHZF4AB/B3dUElNw4QpykgCQ58XfOV7gfW+kx1lKh9CCIakghXUQbyZGpKA0Sqj4DD
         ftts46nvYx7BzuDIzO86RxV/OI357fqzcWIYbpWIs/122tYT/mYOlRpDfHsHEddo50lW
         wwoR875e3mCbUbcD2m5QXFN665zGHX844w0EZIKykmhKNzd3efUWfcu4/zP4RIhXhJvj
         mgIMvYY7N2byGTZ/GKLnU26+fDhadAI5QB2Mq5WE2bo1ZTL+g8bPZZhau/psClj7v1MT
         mSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Epbhz5RYQTRi2boei+V41UERspOfZqA8WB9UyzHpXZA=;
        b=VA/Ou61E2VwEq29CW49/nHYLCEjOA6yiRptZiI3geXnBVkTg8h0YNTPl5Kk6ftu6JP
         Wvq8z59r1Bh9QqfYOWjh586wq0GmMR8ys61IysuH2kRCK/GrBtHCCzbqxTUZ6LQhgpzl
         6NHMjMmbsbpxvqgLUBD1NzgxsFzpBjPJT1IuUCiLp8MYXBa5eNO9Gbi/ebHmX5nm6II7
         1twd17/tL1bpG9JP6syKXWGMlDF8FAF+Hoyats+qrqpKLC3JmAXLEBgEhoEmeIeH1hKy
         4FsyAEpbmtUgl7Dz1081hkOY2R4Hu5RAaQBwTDY/tiYy8moEBBq7f3/OmdHNp20Q78yD
         1qJQ==
X-Gm-Message-State: AIVw113HDmGVmWgJmOSAzeAoXe081N7xjUICRID62rb0pIamKRUq2YPi
        DFHJXxRrp/2e6+yobczeDRwhBSfHzgu0
X-Received: by 10.99.54.73 with SMTP id d70mr11403473pga.195.1499979625273;
 Thu, 13 Jul 2017 14:00:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 13 Jul 2017 14:00:24 -0700 (PDT)
In-Reply-To: <xmqq4lugukju.fsf@gitster.mtv.corp.google.com>
References: <20170713004415.5051-1-sbeller@google.com> <20170713004415.5051-2-sbeller@google.com>
 <xmqq4lugukju.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Jul 2017 14:00:24 -0700
Message-ID: <CAGZ79kb3_K8NxpHuzAdHhSLWUcbw_X3qVVspPeuSNA4sAeT-Kw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tag: convert gpg_verify_tag to use struct object_id
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 1:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
>> index f9a5f7535a..ed8329340f 100644
>> --- a/builtin/verify-tag.c
>> +++ b/builtin/verify-tag.c
>> @@ -56,20 +56,21 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>>       }
>>
>>       while (i < argc) {
>> -             unsigned char sha1[20];
>> +             struct object_id oid;
>>               const char *name = argv[i++];
>> -             if (get_sha1(name, sha1)) {
>> +
>> +             if (get_oid(name, &oid)) {
>>                       had_error = !!error("tag '%s' not found.", name);
>>                       continue;
>>               }
>
> This part is already done, it seems, in bc/object-id topic, even
> though other parts are not yet done?

Oops. I assumed the latest bc/object-id would have been in master
already, but after checking it is not. 967635dc3c2
(builtin/verify-tag: convert to struct object_id)
converts this part, although there are 2 differences:
* I added a stray newline before get_oid
* The argument to gpg_verify_tag is a sha1 or oid

So yes, this produces a merge conflict. :/

There rest (tag.{c,h}, builtin/tag.c) is not found in brians series.
