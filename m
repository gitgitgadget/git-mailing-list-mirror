Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418D5C3524E
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D8624670
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxjlnjsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBSUxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:53:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30571 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726703AbgBSUxo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 15:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582145623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4PTwg63XGKQxL07fIIQ6uL8k+xTYgDw3CdCgVsj0xw=;
        b=CxjlnjsFnMInZgdLRuqT2vsw6NdteYI736vfRDY5Omh9jxkmbxnGJB7NhbheMy2IlKtV9Z
        f5e3YRLn/BnAoBFqx0N5+PSHNkbq2tiPpAmfoD0Vdnw/fDzZg1BgyXcQPeFr7HxtP9Zv+G
        lKOcxbYcaTor2L20ajnDZDJYlDhJnTE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-gx6QrvXvMjy2fW6Z3qrDAQ-1; Wed, 19 Feb 2020 15:53:41 -0500
X-MC-Unique: gx6QrvXvMjy2fW6Z3qrDAQ-1
Received: by mail-wr1-f71.google.com with SMTP id d7so694881wrx.9
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 12:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n4PTwg63XGKQxL07fIIQ6uL8k+xTYgDw3CdCgVsj0xw=;
        b=fWjq9JzIpwwi0OhcWVDwIPXFil3yyuHDdS5L4F+e/e0AEGnXTmAe1VREosRLp6TpNA
         Y8Ilu7k6y4T8YhbHN2dL6zCsmBYlRqksXi6AvOdeoTcLKa3u3S5UR8jCQNjJSaY1xyIw
         RnpviklC+9FeDyvGZbquD9vmUkF2YLy34rHfwR+lfQX0vmZ3X8vVoHvnYZw8o/CTO3Uj
         RtGCqK3buIcUGeTrwvjmGvP0x4Ez9ao7E4aJN3/yrJCMD6alhAGBcCsXKlf1CWxOlqfm
         XLcCrYVa8pxdBxfqCe7PJ8W30nhuAUlmAuRpSodwvGEzuqcPzFkDPLRFjQIqapVLsl1A
         i4Fg==
X-Gm-Message-State: APjAAAVrBX/KuqtYR+WT16C+Y1m/WHVMks0ymSVqOtJmku8CnmPp0qOS
        FQU0SDYPTmS7p6CUXhh35lontm2NGadSeXbLJHDI4suuWtFU8jWDm26tXKOC9rx+SZYVWW+1w9U
        cx95nHsk19Q6Q
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr40584021wrw.158.1582145619881;
        Wed, 19 Feb 2020 12:53:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8zx3zF7kjD/zqBK6zXPyVw4pVlJbsyf/HkVulg6f8l2WShTHCmj36Zg5yvqkZ/mV6boz9IQ==
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr40584002wrw.158.1582145619560;
        Wed, 19 Feb 2020 12:53:39 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ec41:5e57:ff4d:8e51? ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
        by smtp.gmail.com with ESMTPSA id x132sm884173wmg.0.2020.02.19.12.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 12:53:39 -0800 (PST)
Subject: Re: [PATCH 3/4] am: support --show-current-patch=raw as a synonym
 for--show-current-patch
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, bfields@redhat.com
References: <20200219161352.13562-1-pbonzini@redhat.com>
 <20200219161352.13562-4-pbonzini@redhat.com>
 <CAPig+cQOZwA3aAzBko-RL8UnW77DuBY-s_-J2D+35Ofn=fFfsg@mail.gmail.com>
 <xmqqmu9ee3hc.fsf@gitster-ct.c.googlers.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <217229b8-3a72-55fb-71c6-8ba8ae3ceb0b@redhat.com>
Date:   Wed, 19 Feb 2020 21:53:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqmu9ee3hc.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/02/20 21:17, Junio C Hamano wrote:
>>> +       if (resume->mode == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
>>> +               return error(_("--show-current-patch=%s is incompatible with "
>>> +                              "--show-current-patch=%s"),
>>> +                            arg, valid_modes[resume->sub_mode]);
>>
>> So, this allows --show-current-patch=<foo> to be specified multiple
>> times but only as long as <foo> is the same each time, and errors out
>> otherwise. That's rather harsh and makes it difficult for someone to
>> override a value specified earlier on the command line (say, coming
>> from a Git alias). The typical way this is handled is "last wins"
>> rather than making it an error.
> 
> Yup, the last one wins is something I would have expected.  And if
> we follow that (which is the usual pattern), I suspect that we won't
> even need the first two steps of this series?

We would need them anyway, in order to add a callback to the "command
mode" option --show-current-patch.

The fact that --show-current-patch is a command mode option is also why
I decided against "last one wins".  I think it would be counterintuitive
that

	git am --abort --show-current-patch

fails, but

	git am --show-current-patch=diff --show-current-patch=raw

succeeds.

Another possibility is to have separate options --show-current-message
(for .git/rebase-apply/NNNN) and --show-current-diff (for
.git/rebase-apply/patch), possibly deprecating --show-current-patch.
That would have naturally rejected a command line like

	git am --show-current-message --show-current-diff

(and this one _would_ have removed the need for the first two patches in
the series).  However, the long common prefix would have prevented using
an abbreviated option such as "--show", so I went instead for the
optional string argument.

I realize now that I should have placed all this in the commit message,
sorry about that.

Paolo

