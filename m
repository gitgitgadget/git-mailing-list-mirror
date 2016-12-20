Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA2A1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 19:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965120AbcLTTYT (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 14:24:19 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:35546 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965253AbcLTTXc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 14:23:32 -0500
Received: by mail-qt0-f180.google.com with SMTP id c47so186209156qtc.2
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 11:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tu7wvBgW74nwoQrxzyCTBTt9DcmcnDdlH+OTb1Le6tU=;
        b=abxnh0VuTbMagoaaWERuPLWss6lUg3ywdb5ay3TOPiTjQ/mKNZ7ekD8eUow/1KHhZX
         asYJH5Ks5HIvueqpZZ6C5bag4mx1WxdkiSycC0Vi3pOOgjfYaByeuBynKQHPIO6WmGp4
         f4GAW1sZ/srLuoS+jjlkXwFkY9yJTq4veSTxlPRd8mKvUGe8BU7JFOttNXHdBuEm9qA4
         0PKlannAKrWiIoVXO+THwpWyptJlnix+u/la178YrzvZc3pmnEM+29rkyrfX/bmN2h3i
         IFhO3By9u+8nxLVHwCyLCW/AEm13HC5kz+rMvgsdHk0UoekE38GsZABpsv5Ah5PIoO0b
         msiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tu7wvBgW74nwoQrxzyCTBTt9DcmcnDdlH+OTb1Le6tU=;
        b=KTEc1KApKjFX0uusWp0lLVkJPm6A8rvY7z4GAcspaG8muyZIXN94GSDJiJDfxTUbvr
         tSEfxwW4z6Gd5Mgg6D1LU7Xkdcj97Eq1La8pQUn8g+NyQpDB7j/JpoYDr4CkkdafO+Cp
         R4GMNE1F/1xFzio6lffbjoxUBHy9fV6Ydu1tNN60gjuhzrsQHK3BamNa9OkLMV6AGksf
         CkRgt4W2944d9Oxlq39/sR3V40SilNCwRbMHjh47jDO+sHijYqjRY2iU6+sASuGzqbB2
         ZxvzrGAOhpBLL/HIgsM5XTcfL0udGZyB5oFzYMcPMhVPs+FyoTUdO1IRMjM1dra854Xc
         dMtg==
X-Gm-Message-State: AIkVDXLF93/DA2fIY61wqylVipHZ/14wosrbdd4eL/wjSM4CQtx+kZFWwY0yav3S1XTOYfgPGpF4ppMY9a56dBVH
X-Received: by 10.237.34.206 with SMTP id q14mr985410qtc.101.1482261811572;
 Tue, 20 Dec 2016 11:23:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 20 Dec 2016 11:23:31 -0800 (PST)
In-Reply-To: <aad0af97-7588-632d-a113-5d8372b8b7a8@kdbg.org>
References: <20161219232828.5075-1-sbeller@google.com> <20161219232828.5075-4-sbeller@google.com>
 <aad0af97-7588-632d-a113-5d8372b8b7a8@kdbg.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Dec 2016 11:23:31 -0800
Message-ID: <CAGZ79kYNKWfnEXWJfyRUutFyaQiRD9qW--LkK4Nbwdf7FtdPQA@mail.gmail.com>
Subject: Re: [PATCHv4 3/5] run-command: add {run,start,finish}_command_or_die
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Turner <David.Turner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 10:33 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 20.12.2016 um 00:28 schrieb Stefan Beller:
>>
>> +static void report_and_die(struct child_process *cmd, const char *action)
>> +{
>> +       int i;
>> +       struct strbuf err = STRBUF_INIT;
>> +       if (cmd->git_cmd)
>> +               strbuf_addstr(&err, "git ");
>> +       for (i = 0; cmd->argv[i]; )
>> +               strbuf_addf(&err, "'%s'", cmd->argv[i]);
>
>
> Take note that cmd is accessed here.
>
>> +       die(_("could not %s %s"), action, err.buf);
>
>
> Should lego sentences not be avoided? They are not exactly translator
> friendly.
>
> Given that a lot of effort is spent elsewhere to actually *avoid* dying in
> library code, this new die() is not very welcome, I must say.

I agree on the sentiment. In a reroll I'll drop this patch and instead introduce
a function `char *get_child_command_line(struct child_process*);`, which
a caller can call before calling finish_command and then use the
resulting string
to assemble an error message without lego.

Thanks for the thorough review!
Stefan
