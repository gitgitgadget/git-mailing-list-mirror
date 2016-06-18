Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC2F1FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 00:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933305AbcFRAIa (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 20:08:30 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36562 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933134AbcFRAIT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 20:08:19 -0400
Received: by mail-it0-f68.google.com with SMTP id h190so738041ith.3
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 17:08:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QkV6P9wWxDauHJSUTWqx69BhXJtltvrW1eJGxdKgZ+U=;
        b=Q5ytV/oAsoBOGyhOpZvycBH4j4mcv+hv7lyA7MoNjr4YNQ8Nvf6oKXCItwSXYzsDil
         JzHIK6qcVSC7xWUzo8XF1smOdT05d1P99RAL0kTBVm5SFe6OyMB9DnHeDWYYrrxfinW5
         bBOsYgz2PwmY2pwWBrDGaYBQkB5C8ex4X7imcQSdljjvkTJ2OK6XqyyQe1tC7/HuttPR
         hGgNBCiXLdWQaRR5QLR3tIWfUGEX/IpP5ivTNRiD0SXxKM6UJfCfY51U6/KpZdjpDLPF
         NvbH8mqS7mpKwTBnwL8qOd1xGJHIdgbsWUvyUarGWDwCYq09t36S46Y/3xWltKM2N6p9
         cV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QkV6P9wWxDauHJSUTWqx69BhXJtltvrW1eJGxdKgZ+U=;
        b=P/D7fplLuVL9Zzv4KhWnrXv3QXJFO+9avGdZtUEf/fTuHzUdv4/kC60UdP09xEYEho
         +LxlkJN6nf+zlDEViWeSXIc+BAuEKITDpUPdLL4hJkMIjTFDDHivR4M44H0ODc2TIO9y
         A2s+SDAuuSuXMxT6MF3NilzHCfj3Hejnv4RmcuQqg5bnFAVhy5XJ0+cTKr1hv4LCZ0V0
         zE2/BA9uy1tjKWRxHB6YXLbp7ZDPZn81Z0D1Ber++TkTYaPxhMh0lWASDZ9SGrZ8LQUO
         YFG/PelszlsG5Oc5J3SqYDmlyEQQh0jKW+hfT+eKnh+hdanOPpHVjcykOlTZ/KjXiRlH
         WQUg==
X-Gm-Message-State: ALyK8tKSs6jC5qH8epKoBXVIsUiXrOnplwLbAOgoy8vfBHvq38kPr7fTz9aJZ/k7QeV8CA/kUEMeXYYK9HS/6w==
X-Received: by 10.36.80.139 with SMTP id m133mr1653153itb.63.1466208498439;
 Fri, 17 Jun 2016 17:08:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.173.167 with HTTP; Fri, 17 Jun 2016 17:07:49 -0700 (PDT)
In-Reply-To: <xmqqk2hnzdkc.fsf@gitster.mtv.corp.google.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 <1454724190-14063-1-git-send-email-pclouds@gmail.com> <1454724190-14063-2-git-send-email-pclouds@gmail.com>
 <xmqqk2hnzdkc.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 18 Jun 2016 07:07:49 +0700
Message-ID: <CACsJy8CKWpLwn=ffEce8TxKuQGk+-2-374DyRmLnE1uP_5NQiw@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] grep: allow -F -i combination
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 18, 2016 at 4:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>
>> -F means "no regex", not "case sensitive" so it should not override -i
>
> That logic is flawed, isn't it?
>
> "-F" means "no regex", so it should not touch opt.regflags at all.
>
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>>  builtin/grep.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 5526fd7..4be0df5 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -809,7 +809,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>
>>       if (!opt.pattern_list)
>>               die(_("no pattern given."));
>> -     if (!opt.fixed && opt.ignore_case)
>> +     if (opt.ignore_case)
>>               opt.regflags |= REG_ICASE;
>>
>>       compile_grep_patterns(&opt);
>
> In grep.c, we do this:
>
> static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
> {
>         int err;
>
>         p->word_regexp = opt->word_regexp;
>         p->ignore_case = opt->ignore_case;
>
>         if (opt->fixed || is_fixed(p->pattern, p->patternlen))
>                 p->fixed = 1;
>         else
>                 p->fixed = 0;
>
>         if (p->fixed) {
>                 if (opt->regflags & REG_ICASE || p->ignore_case)
>                         p->kws = kwsalloc(tolower_trans_tbl);
>                 else
>
> It is possible that your later changes _depend_ on having REG_ICASE
> set in opt->regflags, but if that is why this commit is needed, then
> you are going in a wrong direction.

Yeah.. some commits down the line, we need to avoid kws (because it
can't deal with non-ascii) and fall back to regex after all special
chars are quoted. Will fix.
-- 
Duy
