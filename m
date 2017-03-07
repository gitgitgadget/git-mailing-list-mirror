Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FFF91FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 21:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755194AbdCGVRo (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 16:17:44 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36327 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbdCGVRo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 16:17:44 -0500
Received: by mail-pf0-f180.google.com with SMTP id o126so5304087pfb.3
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 13:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/V4Z3ulMu5HtrASY74Zev4gMDHpuHqV6WpgDVTtJ4x4=;
        b=Rcu5vjbP0YnNKT5EUqyR4KnGMhqwUi8Fvyb4Q7iYS4au6+1WchRqdepK0x0JH0QHWI
         z5uAi2z3+EcyS3k+BTov97GcvHfhaDAL7DonO+uicmjchIk1TWRXg2JDedbZeaJPaNMm
         yklMR+P3e1DQbWxOFfXnoHOZr5Oz3PPQE6hGPVPg0sHQgpmDNgj0bo4+U39KPPaxjtc1
         AIqJwp/4cCr0PA6R9ILeb46bNJ9OtGVk7qVKV6syhHv/tPzTgqfFJRXuift80SamEsUn
         9KtaHaWDF/fAynF7cvsZFpJHiBQeQhVIZZ7Uh7xc53A9Gw4u+OIzxIrz/IMMVezFD0uk
         K8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/V4Z3ulMu5HtrASY74Zev4gMDHpuHqV6WpgDVTtJ4x4=;
        b=stWxy9ZqipRLDmyLjjs7FJduByrfl+S3IA82+vgsksJ7UDbXkCqo9/XXVz0fN/HS6M
         jRd1CXFjZKDdpI3LyzuDs5gxmT38THM/w8jgNWqZhdx8LinFg8iluoeMTmdeMIxFvRZU
         ZA4ZUO21Le/75o/ETYZ1tOjkl6YSLSxtrbNrE7buQ+5jp71MsBugEnCP1j8Gouq3rswV
         aHzGeEwuFNfcz+ovsgCd/UsU8gjwqLTjZPSJNkLv6qH+k8bOppHLuq61bDpbbfhZ0kaG
         bhc3ZYydcOkwMhlSR33obPN1nWFuq95ku9+u37PrPChyw/cdOPNL5viRfUTaQJ/yrr1L
         C/cw==
X-Gm-Message-State: AMke39mtz64d9H/KOGxKddhq24Xc7cxKVbpHp0Y1EnUxvGdyVYy8NNYGn2n4oKVC8qHv8F3R3NNusULVjzjkO9OS
X-Received: by 10.84.239.8 with SMTP id w8mr3180109plk.73.1488919969458; Tue,
 07 Mar 2017 12:52:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 7 Mar 2017 12:52:49 -0800 (PST)
In-Reply-To: <3026648b-a26c-bc67-62dc-170217d6c2ca@kdbg.org>
References: <CAME+mvUe7itzg7JLu9_131smzHHE0JsN-z7q8_dTY1qEdugYWw@mail.gmail.com>
 <CAGZ79kaYi1OLuOKvbCmDrMCq0fZnO2Ry7JML=Puwmx6TTtEYog@mail.gmail.com> <3026648b-a26c-bc67-62dc-170217d6c2ca@kdbg.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Mar 2017 12:52:49 -0800
Message-ID: <CAGZ79kZhfRiUQndEGB=b34WMCPv0KDjpDix0Ly85aFeyOQAwWA@mail.gmail.com>
Subject: Re: [PATCH] t*: avoid using pipes
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2017 at 12:39 PM, Johannes Sixt <j6t@kdbg.org> wrote:

> Welcome to the Git community!

>
> Actually, being a *micro* project, it should stay so. Not doing all of the
> changes would leave some tasks for other apprentices to get warm with our
> review process.

right, so just pick one file.


> Thank you, Stefan, for digging out one particularly interesting case.
>
>> When looking at the content, the conversion seems a bit mechanical
>> (which is fine for a micro project), such as:
>> ...
>> - test "$(git show --pretty=format:%s | head -n 1)" = "one"
>> + test "$(git show --pretty=format:%s >out && head -n 1 <out)" = "one"
>> ...
>>
>> specifically for the "head" command I don't think it makes a
>> difference in correctness whether you pipe the file into the tool
>> or give the filename, i.e.  "head -n 1 out" would work just as fine.
>
>
> True, but!
>
> The intent of removing git invocations from the upstream of a pipe is that a
> failure exit code is able to stop a && chain.

Doh! I was so fixated over discussing whether to use "<" or not,
to miss looking for the actual goal.

Thanks for spotting!
Stefan
