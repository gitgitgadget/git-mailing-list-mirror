Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EC35208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 20:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbdHOUaY (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 16:30:24 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:32893 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbdHOUaW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 16:30:22 -0400
Received: by mail-qt0-f193.google.com with SMTP id u19so1779590qtc.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 13:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bxXphA6t6LIrnIyE0zzZX+Hc79lbll1wmmS6LuKfh+k=;
        b=FbWFIvtzPBH8Txk0OnIfISaNm5DmdizMto3P7GP90TufQ5AhaCtLlT6LPS2QQwwxJX
         +M8yOuvkNoXsfEovtz7YRIPIFBiL3etZlaCxAhkRh1Y6r1DBuETO3vlOQz3Q/ThvHEPk
         K5OCvgypnUUsdjJUuhC8ISxqD3SCHdYTNUTSsgM6aC8d4fuDdVdQRYlEDI1pWKlZ9S0I
         BWjRkfIyW8L1br+gqNH594NuuZXoAWxv51PSuR9TO07dKlv1MNS5YZ0NU2ZWV8FenbNn
         oUUzOKXu6TGu6gJarmcs+gpI6Dj5YmTo4swyPnPfF3WPM21kmJh+oPGURfB8QW/G99m8
         Xxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bxXphA6t6LIrnIyE0zzZX+Hc79lbll1wmmS6LuKfh+k=;
        b=DuS34o2kVbwjHMq4oCv7WwG2xBukmSaCOPmdvWyJeNcLFVr9YEo5RDpqM4Mh2xW0O4
         oB7jOXbVp3a+set7yU18UktRkK0igN4Ijs82p0rYa1DSYj3kJFGMgqOYdkyYfOvpsDTb
         BbtPk2fYgd7fSZrj03tRjIQn3NVMSVTqbydqPrg6I0/J7/zbYiIx/5gP+8GAyNJjw/cE
         4cnSWn6DTW5FiuRBjeHgfz+cbYeFWIJxwwWV6lIyX5NE5+94yG49ZD0AULhjuonht896
         Y4cy/sk6BkPDbuP26wH6WyT1kiSDrF9lvRYyT37rKqahbGpzjqLTQW+6ITfMI9EMx4pK
         5qgw==
X-Gm-Message-State: AHYfb5iaAPKIDUUskfw4Pyomg+JZz2EvV1wbftW35p5XUITVdC3A4bbY
        hyF6/kTEjt983CQ1MjAxG1CueMvoaktg
X-Received: by 10.200.41.247 with SMTP id 52mr37924416qtt.0.1502829021190;
 Tue, 15 Aug 2017 13:30:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.77.16 with HTTP; Tue, 15 Aug 2017 13:30:20 -0700 (PDT)
In-Reply-To: <FC865401-2FE6-45ED-BBA5-524C3E29477E@gmail.com>
References: <20170815173611.2267-1-chriscool@tuxfamily.org>
 <836F754B-C78C-4D19-8365-875D96B3F115@gmail.com> <CAP8UFD2KBEVwZE8obaDxf+0AyU4zH0+5bWJzzHazFywgWT9QjQ@mail.gmail.com>
 <FC865401-2FE6-45ED-BBA5-524C3E29477E@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 15 Aug 2017 22:30:20 +0200
Message-ID: <CAP8UFD0OUKUu0bqf6BxHBf+51CgFjjmtOk06J_D-=8maa41G7w@mail.gmail.com>
Subject: Re: [PATCH] sub-process: print the cmd when a capability is unsupported
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 9:35 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 15 Aug 2017, at 21:29, Christian Couder <christian.couder@gmail.com> wrote:
>>
>> On Tue, Aug 15, 2017 at 9:00 PM, Lars Schneider
>> <larsxschneider@gmail.com> wrote:
>>>
>>> Wouldn't it be possible to use "process->argv[0]"?
>>> Shouldn't that be the same as "cmd"?
>>
>> Well in sub-process.h there is:
>>
>> /* Members should not be accessed directly. */
>> struct subprocess_entry {
>>    struct hashmap_entry ent; /* must be the first member! */
>>    const char *cmd;
>>    struct child_process process;
>> };
>>
>> so if cmd is always the same as process->argv[0], maybe there is no
>> need for the cmd member in the first place?
>
> The struct is a hash map entry. `cmd` is the key for a `process`.
> Therefore, I think this is still necessary.
>
> Does this make sense?

Not sure it makes sense. A quick try to remove the cmd member, failed
t0021 with:

Initialized empty Git repository in /home/christian/git/git/t/trash
directory.t0021-conversion/repo/.git/
[master (root-commit) 56d459b] test commit 1
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 .gitattributes
--- expected.log.tmp    2017-08-15 20:27:51.658818467 +0000
+++ debug.log.tmp       2017-08-15 20:27:51.662818526 +0000
@@ -2,6 +2,6 @@
 x IN: clean test2.r 14 [OK] -- OUT: 14 . [OK]
 x IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
 x IN: clean testsubdir/test3 'sq',$x=.r 49 [OK] -- OUT: 49 . [OK]
-      1 START
-      1 STOP
-      1 init handshake complete
+      4 START
+      4 STOP
+      4 init handshake complete
not ok 15 - required process filter should filter data

and it is not clear to me why, so I guess you are right and I will
just use process->argv[0].
