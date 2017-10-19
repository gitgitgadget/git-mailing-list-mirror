Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844A5202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 19:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbdJSTuR (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 15:50:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43554 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbdJSTuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 15:50:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id a8so7496990pfc.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7AApQZVpVTowv/tcI80gWTXpEWfGljqfyQnKy05n8NI=;
        b=OdItH7yX3qtZCDAgjNF7SOnGq8qI1vJO/iLlnbcEiNaAqDHz3fwHZc4ymMEKRhUFSR
         SvwT1edXLYnIYhruvep42rYzpKIoXjEgYZXhjW44zCqThWG/Zs4GPjKsX3FNoygd3fuu
         cOwail5oUkn77uRm4S4eip88yabK8DExbtgiCNPwuVu0dQM+/BmJQjMQEcs7RJfxYAJl
         8hFESP8DsuWU+2gDKGNqnJk17JvJQ2oNttpiL9Me3cSorY0XTlWHw9Kd2Cvw6F/iTO5V
         lnn0/CxOMBRaxK5I/7TP48ySZ2n3qabjxop/EeE7bfvpa68MtbNzjpHFSMr1jHvz+mov
         6mGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7AApQZVpVTowv/tcI80gWTXpEWfGljqfyQnKy05n8NI=;
        b=oIXI/A6Y/SzdGBPzz3QEUXpTZyIqIXcvjJtbkeNSQB3LyuB3hhwnUrg6EStX2JEMWE
         sH1f1vg3ut3uCjHhRoEDzwe/lbAs2oZPQBes9qHdga63qfAaKA8YW34nl1/yAAHgka9R
         93WJXVyAmTHk8VbtoMjG2zntX0pX5MolEvINRZo13M+8d5PY9BeaSOmYY7LNMPWjepsz
         UG1kmkR4FPX0iHWAqKVXV8YfhQsNgtWV/G+5biMV7CkTfnrOWkYUm6EUhrMgsRxgpa7z
         t5TEw3KY7JlkO0dWSpmYlWasoKMnCccXXJ0frcJfmUGsZicn26ulTBxH5i9WgAjbepYp
         /8Nw==
X-Gm-Message-State: AMCzsaW0nBevPk53AQYQtuCxBxjVXmY9sMC+7qiARTcibyiUpz/jHWyd
        eQoo3qX6v1ZRC6nqOqY4jTjKdph0oeEZY25JxDo=
X-Google-Smtp-Source: ABhQp+QPMJ+xdV+6AFcMGooR2XglRIrwJu5b9cAWHa9XQ0vS7MbL5HpbMuB8+XuJoSIcivL0Wgr3DEB+VKEC7tA/IUg=
X-Received: by 10.101.73.79 with SMTP id q15mr2374638pgs.236.1508442616179;
 Thu, 19 Oct 2017 12:50:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.177.141 with HTTP; Thu, 19 Oct 2017 12:50:15 -0700 (PDT)
In-Reply-To: <20171019193413.prx5pkmwaxk6mpdt@sigill.intra.peff.net>
References: <20171019190703.1534-1-martin.agren@gmail.com> <20171019192618.GB84767@google.com>
 <20171019193413.prx5pkmwaxk6mpdt@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 19 Oct 2017 21:50:15 +0200
Message-ID: <CAN0heSpxJDxmSXu=P0stq+CsKVqjsvOnjDpOoMT9GdWxeZU2Pw@mail.gmail.com>
Subject: Re: [PATCH/RFC] grep: turn off threading when recursing submodules
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19 October 2017 at 21:34, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 19, 2017 at 12:26:18PM -0700, Brandon Williams wrote:
>
>> One alternative to turning off threading would be to employ proper
>> locking (like I failed to do) by wrapping the call the
>> 'add_to_alternates_memory()' in calls to grep_read_lock/unlock:
>>
>>   +       grep_read_lock();
>>           add_to_alternates_memory(submodule.objectdir);
>>   +       grep_read_unlock();
>>
>> That way adding the submodule to the object database won't happen at the
>> same time another thread is trying to read from the object store.
>
> Yeah, I think that is the right approach. Many of Git's APIs aren't
> thread-safe, so we need a big mutex around "I am doing anything except
> actually looking at the already-read blob contents". We just missed this
> spot.

That's a big glaring lock I missed, right in front of me. Looks like the
right solution!
