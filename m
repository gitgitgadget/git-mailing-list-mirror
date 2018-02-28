Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7C9A1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeB1BLH (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:11:07 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40388 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeB1BLG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:11:06 -0500
Received: by mail-ot0-f196.google.com with SMTP id l12so746337otj.7
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BSBffkQ1LknSVg53hoDyzdfwMne8MDDBRKtnwpWw5V4=;
        b=V2R4TW5/ZBq1ZbnAQrTkMQDRGoFsGzHj+UsQTZiRMA01lKkY5CwlGXpQ83Pb8twNkT
         lYXP0wP2+F5scYpUtRZKzmnIAzkpDUf9N9hcLM1Jo8fuxIm5LbnGYl4QWvWkC+nRH3Qh
         GxxwL3bl3YM/dw18Nfkj9ZuAgZgKADtAk/U/UZQL+N9cj5JXWtUPr9gATxy4D24W1lV7
         Bhu3c4q9EoOqt0MGzPymZzHt4TntMx0WUDoFKz4MX08wBzFkc0HN89rFEBsv3G/2Yzj0
         SJnchZx2iKDvaxpm5uWWgREirCnS5hMW4bBxfZunUS56zYznQyQtlHkmYglfwyfAClOK
         V2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BSBffkQ1LknSVg53hoDyzdfwMne8MDDBRKtnwpWw5V4=;
        b=os7Mtib5x4hSfaJW/ic/YGtZvuANGuOF/OxNNbv2fUhD3L/XIhj2tA+c+PJcMXQBUO
         KgKIMH1rR2fT8wWpuC6ou4ZwJWgpWWNfAb/g85iOR42rXh415HtCZPQctO/slDL/IcGR
         U4Z9a0ECQVnN9EI/LyUFVQMG1hvXjFwmfsN/VRsr3cX14H3NgsLGhE72AO3+qaF7L4kw
         a2rZWf3ygWDa1BlgYHELL4YfmdKPGMKW7XwKzY3TLsmNg1Qj/Vnbifm/jniShrBI4mdu
         YaJz8WxRMZ9ArD2QC5M2WF676bst2qDPVD4MjpiaIWz95lGFFYhqTWylS0K3BTX26gt8
         v/yQ==
X-Gm-Message-State: APf1xPBqKXqxOaFoWwOynnWRd7WP5GQqgrr9vFgiSlmOi8yrR+bOvE5v
        /ddp0IOeKiimYFOAGN9ru45XjaDb53/zXK5/Iu8=
X-Google-Smtp-Source: AG47ELtCQQAVuXISt/xrTu0B8yTqDaKAqHZkyC6r/UgIAQ2/uaA4oXG1X+CdyMoFOOToDE4hhiPgpMA8RaL7AgQBCgc=
X-Received: by 10.157.85.214 with SMTP id z22mr12285429oti.75.1519780266275;
 Tue, 27 Feb 2018 17:11:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Tue, 27 Feb 2018 17:10:35 -0800 (PST)
In-Reply-To: <20180228010233.GA45342@google.com>
References: <20180228005059.GA251290@aiede.svl.corp.google.com> <20180228010233.GA45342@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Feb 2018 08:10:35 +0700
Message-ID: <CACsJy8Cn2hcodoR8ksRBY9qf7MmJaP+KAzYqv6seeR9s-Be8Hw@mail.gmail.com>
Subject: Re: [PATCH] protocol: treat unrecognized protocol.version setting as 0
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 8:02 AM, Brandon Williams <bmwill@google.com> wrote:
> On 02/27, Jonathan Nieder wrote:
>> If I share my .gitconfig or .git/config file between multiple machines
>> (or between multiple Git versions on a single machine) and set
>>
>>       [protocol]
>>               version = 2
>>
>> then running "git fetch" with a Git version that does not support
>> protocol v2 errors out with
>>
>>       fatal: unknown value for config 'protocol.version': 2
>>
>> In the spirit of v1.7.6-rc0~77^2~1 (Improve error handling when
>> parsing dirstat parameters, 2011-04-29), it is better to (perhaps
>> after warning the user) ignore the unrecognized protocol version.
>> After all, future Git versions might add even more protocol versions,
>> and using two different Git versions with the same Git repo, machine,
>> or home directory should not cripple the older Git version just
>> because of a parameter that is only understood by a more recent Git
>> version.

I wonder if it's better to specify multiple versions. If v2 is not
recognized by this git but v0 is, then it can pick that up. But if you
explicitly tell it to choose between v2 and v3 only and it does not
understand either, then it dies. Not sure if this is a good idea
though.
-- 
Duy
