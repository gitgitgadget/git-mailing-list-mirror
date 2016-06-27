Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BDD71FF40
	for <e@80x24.org>; Mon, 27 Jun 2016 05:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbcF0Fml (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 01:42:41 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37640 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbcF0Fmk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 01:42:40 -0400
Received: by mail-it0-f49.google.com with SMTP id f6so54260297ith.0
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 22:42:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qs+0LE6RB1JDMzogVlCK7OW/997izlh7tN7lj+otzCs=;
        b=qCkv+MAaDVhhnzWRM5d/o0Jj5QaADVxejpjLKbXV6QdfrRghZobhUFH7mprNsNODJK
         1mOdf3JhdScJdt8iT6dCC0DH3ug6NxIBvEbE1mpZjcz3oJ4xR6k5NOvRFzfMd7bptX36
         UEHIFfC/GmYmuQPDAuTLFEND5ZdoZSiEuWApG1tyKL1ZmpdRmkgwcFyqh928BiUDi9q4
         +cMX+yzi5ZCwdba89vzNOqzu24MA3W5a54bE/Ek1BfAE7qtvYECThdtBEWEzipsyu6KZ
         aNlNRxn/f2bf7fYF7Fqq5nZeXX3R9QqyjzT53qr/418NtmLHv2vv01isIbsKhO8p8QR1
         asGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qs+0LE6RB1JDMzogVlCK7OW/997izlh7tN7lj+otzCs=;
        b=jv2ADFIujCCzLux36npZ3CJj3it753RRUGoo3RULethNB2EL4nDgq2PcxZMlUTnunD
         8/bwZOx5K8JvqWz4ZSyim1F5i5dE3Q9lAy1kX865shpnPz9JFDSKeRZr3pJds+ab4e2j
         lgp8hFf5L3FPEFM+G+8MO8eEFmwVvgVrysobLA0WAJGmWAxPPGlw4LNDJ75T2OWNjFj/
         81K7A9sXlGiimkFEWu731qzjtUTnMZ8+4UFgL+GYvtl1GmIU7bWm9U6dJcnysvi/tYXl
         tozxxUoFW7pKJqy4RUOuEHDmGpc5Y+0ZkgcZyGGHFVQED4TJOmbx0Vocs9cB/JNIjEDZ
         xN/A==
X-Gm-Message-State: ALyK8tIMBYH0V6uJYFFt3wrKtcFlBruxNLEvu7EsSBzusHQN38vk76C4GefuwcQDhCr8o0dDVGRtDFbfSVcNcA==
X-Received: by 10.36.123.199 with SMTP id q190mr7476165itc.42.1467006155003;
 Sun, 26 Jun 2016 22:42:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sun, 26 Jun 2016 22:42:05 -0700 (PDT)
In-Reply-To: <CAPig+cT=BAuAbEmS5G1v2yGNczA+-WvW0bBZz_hrLcYi0bpO4g@mail.gmail.com>
References: <20160605031141.23513-1-pclouds@gmail.com> <20160626055810.26960-1-pclouds@gmail.com>
 <20160626055810.26960-6-pclouds@gmail.com> <CAPig+cT=BAuAbEmS5G1v2yGNczA+-WvW0bBZz_hrLcYi0bpO4g@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 27 Jun 2016 07:42:05 +0200
Message-ID: <CACsJy8Cq8Jp1yNWS-oBoZNTKqqsSZMM==Y3y1feXdutWSizo9w@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] fetch: reduce duplicate in ref update status lines
 with placeholder
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 6:33 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Jun 26, 2016 at 1:58 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>> In the "remote -> local" line, if either ref is a substring of the
>> other, the common part in the other string is replaced with "$". For
>> example
>>
>>     abc                -> origin/abc
>>     refs/pull/123/head -> pull/123
>>
>> become
>>
>>     abc         -> origin/$
>>     refs/$/head -> pull/123
>
> Bikeshedding...
>
> I think I recall in an earlier iteration that you asked for opinions
> about '$', but don't recall if there were responses. Have you
> considered '*' rather than '$'?

I did. But I remembered that * is used as wildcard in refspec, which
is specified on both sides, e.g. refs/heads/*:refs/remotes/foo/* and
wondered if it could cause a little confusion when the user sees '*'
only on one side here. But I have no strong opinion on '$' or '*' or
any other character. So if nobody says anything else, the next re-roll
will go with '*'.

> In my brain, at least, '$' is associated so strongly with regex that
> "origin/$" is interpreted automatically as anchoring "origin/" at the
> end of string, and "refs/$/head" just feels weird.

On the other hand, '$' has been used as the variable expansion symbol
in shell, tcl, perl and php (which are probably the same thing since I
have a feeling all of them borrow '$' from one source, probably
shell). But yeah, '$' at the end could remind people of regexp too.

> On the other hand, given the familiarity of shell globbing, "origin/*"
> and "refs/*/head" feel quite natural and intuitive.
-- 
Duy
