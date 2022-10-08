Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B77C433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 08:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJHIyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 04:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJHIyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 04:54:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D956E537EF
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 01:54:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a10so10271507wrm.12
        for <git@vger.kernel.org>; Sat, 08 Oct 2022 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssMUfA/f6kUNgwCDryygaCLqFM6e2mGzZ+8PDW8/WiA=;
        b=hRoUTMAd0Ox5lLfuadoILUOKn/BlEgTtzuSlw6SjKl33d3J2sB3FRDca1et4szi/M8
         7GM9qsBUbREG+xWGtwj6pfu5jrTC5OClfUxFx54amcrWB0mJG8LE3f8Tsyib+dtO/pVJ
         XUoa9AXY+ztaUizq3Ju3h+iuhhaINJVbwckq89RlA8MaSIFPE/DeHSvYY4wHnfuD9tao
         2h3b4RQnsGcJMmREi6+t4FHqUnJ6CBwgjMkTCrQ+ImQa5/6mWU8HS7IwsUIRtXpK0mCJ
         8jgA64H/+tMppHBgZ3Vtx+3Gpb0n2UqYnO+faJXa2N9opiXfGYhDj/rOm8wglwrbIOH0
         iIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssMUfA/f6kUNgwCDryygaCLqFM6e2mGzZ+8PDW8/WiA=;
        b=G30/pWc68PuPV/Cu7IdXlsj4DFveQ28JfXzBqCV8OzvlCcRBDp9zpNCmT9BXqGVTxs
         6LBh7mHUeKsLgviGI2JAGn0MYPkYMiBRJX2g/8ZeMMghJxsmBXY+B3nYthcI+3hROAKY
         D7j9o8c2SPlgnbW+T4bypynCAV8peBszrFiGFS3bACKIlAm4Q0BtG/4BZQY2p5kdpVKh
         2Di6D4QLMzZEJfQhHcvEs+A15SyQfbrgxMZPvkmkt4L/f+hygz50NRDkcYvZpXhtN6Hg
         QZvUnaD0/1fmwk60CjAzxCWkrTkUfLP3XOwlHQGFtKm8On/gndYZjlZk/c+++s1+JZbV
         yRFw==
X-Gm-Message-State: ACrzQf2mzmY1sbiUP6RT3lhkANJ4l6lldMiJWW9fbs5z2pzh7T8+trd5
        tLfmQjiFKl7gjhDzQnB73nk=
X-Google-Smtp-Source: AMsMyM7fVQEvtuNmst524eZXI46/BBz2hRt3psrfO8ioJXdTbGMJ73Pdrpi2lNfbApUvawWVK+Gwtg==
X-Received: by 2002:a5d:52d0:0:b0:21e:4923:fa09 with SMTP id r16-20020a5d52d0000000b0021e4923fa09mr5731816wrv.244.1665219254392;
        Sat, 08 Oct 2022 01:54:14 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id n3-20020a1ca403000000b003b49bd61b19sm9750518wme.15.2022.10.08.01.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 01:54:13 -0700 (PDT)
Subject: Re: [PATCH v3] branch: description for non-existent branch errors
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
 <930ff836-a5c4-0e85-517d-39645f00cd31@gmail.com>
 <8d627a2c-923f-181f-a03b-15f370c4dd0f@gmail.com>
 <CAPig+cT+Yeh95p-2PgMDYz+_AxeEA72i-zLuQu11QEyWAt8kiA@mail.gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <7a332503-d267-6d2c-c2bd-d072411ca408@gmail.com>
Date:   Sat, 8 Oct 2022 10:54:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cT+Yeh95p-2PgMDYz+_AxeEA72i-zLuQu11QEyWAt8kiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 8/10/22 5:27, Eric Sunshine wrote:
> On Fri, Oct 7, 2022 at 8:49 PM Rubén Justo <rjusto@gmail.com> wrote:
>> [...]
>> Make the error descriptions for those branch operations with unborn or
>> non-existent branches, more informative.
>> [...]
>> Signed-off-by: Rubén Justo <rjusto@gmail.com>
>> ---
>> diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
>> @@ -7,6 +7,28 @@ test_description='test show-branch'
>> +test_expect_success 'error descriptions on empty repository' '
>> +       current=$(git branch --show-current) &&
>> +       cat >expect <<-EOF &&
>> +       error: No commit on branch '\''$current'\'' yet.
>> +       EOF
> 
> It's a matter of taste, but leaving and re-entering the single-quoted
> context, along with escaping, can make for a difficult read. You could
> instead take advantage of the SQ variable already defined by the test
> scripts:
> 
>     echo "error: No commit on branch $SQ$current$SQ yet." >expect &&
> 
> Not worth a re-roll, of course.
> 
>> +test_expect_success 'fatal descriptions on empty repository' '
>> +       current=$(git branch --show-current) &&
>> +       cat >expect <<-EOF &&
>> +       fatal: No commit on branch '\''$current'\'' yet.
>> +       EOF
> 
> Ditto.

Thanks, I didn't know about $SQ.

	'\''$current'\'' vs $SQ$current$SQ vs ${SQ}$current${SQ}

I also find ugly that escaping, but I think is harder to read and
error prone to use $SQ here.. :-/

