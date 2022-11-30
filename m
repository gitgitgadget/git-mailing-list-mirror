Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE6AC433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 10:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbiK3K6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 05:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiK3K63 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 05:58:29 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6187323E90
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 02:58:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z92so13067544ede.1
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 02:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XCLZYN6AZiVvgZF6cRLeTqKapZhKd6kzfZ3Ji3TM2L8=;
        b=ZAq7yIYBO+dnOcY1cqZjmlcVMn0QOKVWX+mIfz4rlt+l5n7xD/r6RUEt0PP19pZiR1
         NWm80jjxJZAwjqBC6AEW08IBYOrdy4hh6dDUgmorJDEB6Bh0s5NFdjtn9V0Mz8V9X08L
         KUBkMCpSspz8xbuddppHXlG7r2wu2o4RZBbXe/aB8zSBUuas32yLX1X+SMb4FTp1gosq
         wAoJa41iho28BgYxCEaagJ2jDdbaP82QXHdPgHgPnAor7V7QScSGag6Zx69lLr5Bipgy
         XYAK4KznHLyUgkXzRH4rWxPf2iWVIKjGuec26iYRpuetJ7tmHgZ1tvZ21WN+nFGX2aQA
         view==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCLZYN6AZiVvgZF6cRLeTqKapZhKd6kzfZ3Ji3TM2L8=;
        b=Osz7c/boSIoILFGHI8S4lwNCNYlNYpF72rykLm7mZAfcrz1VaTcBp5sEuLKtmJ4C+c
         dPltU22pIcSbG6R2yD2TDYmrNIaPVhfDqGzXEM6kkzisrbXd3QNgM5vT6UM/5CmBB4JE
         6M3sQK7yNgro3odGFW5b+Xq8L+wb6hbWzRzJ2a3mqMuBnuQbNoq6WTeMrS2uHVmQok93
         wBEt0vd+6hQwpbWauTNH6Ymdd5OkZ+AjQrJVFpzGzf56NTu67FSBO8WobZvz4xFmZDiI
         H5nZZOmH+UoEM+ZAeViWLzKbj0WyZIFkNO3803+iTIjY/+Bq8Mx6wXZDkYxZFRC/wHKO
         p3yA==
X-Gm-Message-State: ANoB5pn8ts3H978B5NMmWhfmRfYEXwl+ldzHwlN4ViKsnwBQs5nev8ZH
        GZ3ekNI9DMmWDwNzlmmz+pU0Ce4/YumSBA==
X-Google-Smtp-Source: AA0mqf50DRsvMhvuSt2k15JSvw1WMCWerrM+lfIjaqUKdEXlIA1s8EEuUqO27UB5S6Q7jIpL5Bak/g==
X-Received: by 2002:a05:6402:3c1:b0:46b:2d74:d970 with SMTP id t1-20020a05640203c100b0046b2d74d970mr12863395edw.138.1669805906797;
        Wed, 30 Nov 2022 02:58:26 -0800 (PST)
Received: from gmgdl ([109.38.157.167])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906300e00b00780982d77d1sm504298ejz.154.2022.11.30.02.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:58:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p0KnJ-001zq5-0h;
        Wed, 30 Nov 2022 11:58:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        phillip.wood123@gmail.com, myriamanis@google.com
Subject: Re: [PATCH v4 1/5] run-command: add duplicate_output_fn to
 run_processes_parallel_opts
Date:   Wed, 30 Nov 2022 11:57:38 +0100
References: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
 <221130.86lensiwy0.gmgdl@evledraar.gmail.com>
 <5f6f0181-c251-0a98-a39f-a910b93f8c1a@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <5f6f0181-c251-0a98-a39f-a910b93f8c1a@dunelm.org.uk>
Message-ID: <221130.86cz94iu9a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 30 2022, Phillip Wood wrote:

> On 30/11/2022 09:53, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Nov 29 2022, Glen Choo wrote:
>>=20
>>> Calvin Wan <calvinwan@google.com> writes:
>>> So this might be more idiomatically written as:
>>>
>>>          int n =3D strbuf_read_once(&pp->children[i].err,
>>>          			 pp->children[i].process.err, 0);
>>>   +      if (opts->duplicate_output) {
>>>   +          struct strbuf buf =3D STRBUF_INIT;
>>>   +          strbuf_addbuf(&buf, &pp->children[i].err);
>>>   +        	opts->duplicate_output(&buf, &pp->children[i].err,
>>>   +        		  opts->data,
>>>   +        		  pp->children[i].data);
>>>   +          strbuf_release(&buf);
>>>   +      }
>>>
>>> which also has the nice benefit of not touching the strbuf_read_once()
>>> line.
>> We should also use "size_t n" there, not "int n", which is what it
>> returns.
>
> It returns an ssize_t not size_t, lower down we test `n < 0` so we
> certainly should not be using an unsigned type.

Good catch, I just skimmed it and missed the extra "s". In any case:
let's use the type it's returning, so ssize_t, not int.

(DEVOPTS=3Dextra-all etc. will also catch this, depending on your compiler
etc.)
