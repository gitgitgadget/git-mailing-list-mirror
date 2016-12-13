Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8189B209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 21:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753507AbcLMVIz (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 16:08:55 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:36202 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbcLMVIy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 16:08:54 -0500
Received: by mail-io0-f194.google.com with SMTP id b194so658672ioa.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 13:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=B9S6u85h9fpJgBjaMWGaXjfg6nWkGUFOOq+ELAa3GUc=;
        b=H/+i/dLuSj6yVUWmXe8RANROS/jedqZU1tgEwsBwoZ5gHlT2iDlQ4DbPbBwj6l6fic
         gT6/TPwQeesdUiP/2G8GOeSPwPolcSTRb3GM/MDtSb3jNndMaFyxso1ybRy4Hb+JUkrx
         J7znUTgmWgJXACwuq7VoajxJCgsRElMKBKkOWJ4VQwPL6FbPT9pf0wRFivCMKy4k5aUI
         MOnJGfFsxhH1wV19/UZ45oGHqU1R9fVkpxvdDsvoYhcua9t2NPrw897gzrz4VGGHT+OP
         xThk04F+LR6KOBrrdVau73yGaHxUuI4sLJYWwIn27T8lUblLILaXXBMgNP3K2t+aOSt7
         Fh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=B9S6u85h9fpJgBjaMWGaXjfg6nWkGUFOOq+ELAa3GUc=;
        b=bJaMZFkcfVmciy/lpvAFnXyVWXYQCHk1UjPMTbFu74/thwTBdPtyRk18k0TlNqBcoy
         OoHwCeHtdDcCa02LZPOpgVn/VpcjnYe8YO+uBXSDusow6XrajriPZyOC/CcOM30ZX++E
         uJxcMkAW7NvxVbUPjebKvlkQyeLijSBELCnHn7wlx5dZzlocNQ5BocqCjrgPmFelMron
         3mnwsQTCWLCcEjwHXWT7tOIRpftHswraZ+qLWbVHsn5nu3N+t8KppfwLTDaAHOszX4i8
         +6xaCmCz2faxu4JV0B/TZXVMex24V8YZ/ThHLBLXG+4b7zw23oeEyShSHvihL14nfPw8
         xoNQ==
X-Gm-Message-State: AKaTC01lKOBbcRJrE/ZpmlmZUK3KgVeLxNh6tSYvHnDUhHPER9zyKnMPVumBHjHJ0mbcuH6W2qZFDEXmE1H0GA==
X-Received: by 10.36.139.4 with SMTP id g4mr4422263ite.35.1481662111515; Tue,
 13 Dec 2016 12:48:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.65 with HTTP; Tue, 13 Dec 2016 12:48:31 -0800 (PST)
In-Reply-To: <xmqqfulr1s5z.fsf@gitster.mtv.corp.google.com>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <cover.1481642927.git.johannes.schindelin@gmx.de> <934c8e420cc4a75b1f3e4489fa4a4135c48f78ae.1481642927.git.johannes.schindelin@gmx.de>
 <xmqqfulr1s5z.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Dec 2016 12:48:31 -0800
X-Google-Sender-Auth: EJhDsJ8wdha-pDpq6TXzUAE3kKs
Message-ID: <CA+55aFzxFFNY+dL6s7dLZeVXBsBKD0aeof5Bj2wcD1CpefVSAA@mail.gmail.com>
Subject: Re: [PATCH v2 02/34] sequencer (rebase -i): implement the 'noop' command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 12:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> +/*
>> + * Note that ordering matters in this enum. Not only must it match the mapping
>> + * below, it is also divided into several sections that matter.  When adding
>> + * new commands, make sure you add it in the right section.
>> + */
>
> Good thinking.  Makes me wish C were a better language, though ;-)

Do this:

  static const char *todo_command_strings[] = {
      [TODO_PICK] = "pick",
      [TODO_REVERT] = "revert",
      [TODO_NOOP] = "noop:,
  };

which makes the array be order-independent. You still need to make
sure you fill in all the entries, of course, but it tends to avoid at
least one gotcha, and it makes it more obvious how the two are tied
together.

              Linus
