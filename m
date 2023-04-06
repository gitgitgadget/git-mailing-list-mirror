Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F994C76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 12:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjDFMHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 08:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjDFMHT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 08:07:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D13DC1
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 05:07:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r29so39257787wra.13
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 05:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680782837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JlZX3zrY8LQKLt/P4v4CNMxi1zULjzvlsh7O6yhpCTM=;
        b=A8j1PjFer1w79KiEtqO1OWHvLjGndPxQT9zTxtnpzqH20Ajkgm+nT4dBG0WsUqyHKM
         iyOvy5C95+sInpZQ6moYvwMrSVhL05e6ny02fWw11ealkRyACjBvJJ8J+mw+etngtecC
         t+rMKkzN3KrxNqQTtX7CiSk6VeIxX0IjnUfo62PZ6LRpz721/xI8Lc5ERNL0HTNRRd/8
         wUsLHfNwXSSJvKejfPXuRGRvrBT4jkUJbHwEa65p5O4eX+1FYETg2zyNRRd0/r/m1CVk
         YDc5q4dnQFtYCZI9OVnYNhUNfIKHUud26UHOxwf1zI1xkx+DtKr+CwqKzOE6PrdEultH
         rEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680782837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlZX3zrY8LQKLt/P4v4CNMxi1zULjzvlsh7O6yhpCTM=;
        b=i0GI5DWY1fLkeDm4KHuSlQgEIzHNbe4qK8cCbh2a8SvE3Hp4Or1wwk7rsnbRcq0QcI
         Zd68k9aFo8ko+V3vL9Yxb15BpNKubq6+7v44e4TbQTIDDd6iauTIf3yRme3bbZ6LJOt1
         b1o1XCcDRifQEORbBCjFlSOSQO+Rtvze61bI0JNtamiMJxTujJab95ZJxh+yViOfITb8
         uSwWwBnDrmReswWvejGZWwf1jZj48F9V3aFLGtNNdliy3ImvJSv2SThFtqIz7vfnKTFJ
         nbDKxJaA0lzIErS9UZwSw6dese4cRCoehYfCJN5Q5GmvZJUq3vEauf0gNxy6yi58JR9/
         CLbg==
X-Gm-Message-State: AAQBX9f7XCdCISEGCbf8P5aJN398m3+4uuaTfpDQ5JjbKlv3tlOTvLU8
        xw3zRXZZgsht0M33ez8249M=
X-Google-Smtp-Source: AKy350ZcIoEFFIAA/D8i+H5K4mqKTAHTg/VcKWDuox1z6R7YLrdeJHKzt/BbRTngMoLGAuYvAPQwrQ==
X-Received: by 2002:a05:6000:86:b0:2c5:3cd2:b8e with SMTP id m6-20020a056000008600b002c53cd20b8emr6530944wrx.1.1680782836981;
        Thu, 06 Apr 2023 05:07:16 -0700 (PDT)
Received: from [192.168.1.195] ([90.253.53.152])
        by smtp.googlemail.com with ESMTPSA id e17-20020adffc51000000b002ef2e148d59sm974284wrs.16.2023.04.06.05.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 05:07:16 -0700 (PDT)
Message-ID: <7e99ff9b-99b7-1ea9-4131-43f507780284@gmail.com>
Date:   Thu, 6 Apr 2023 13:07:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Possible bug in git-rebase man page
Content-Language: en-US
To:     Stefan Haller <lists@haller-berlin.de>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de
References: <db535468-c991-df18-61bd-ec312fdb5ca0@haller-berlin.de>
 <51aca4bd-0f2b-0689-4b51-260349cc4151@gmail.com>
 <f3e522f6-294d-4c08-b261-34d8e5b03b46@haller-berlin.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <f3e522f6-294d-4c08-b261-34d8e5b03b46@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

On 06/04/2023 11:48, Stefan Haller wrote:
> On 06.04.23 11:49, Phillip Wood wrote:
>> Hi Stefan
>>
>> On 05/04/2023 18:36, Stefan Haller wrote:
>>> The git-rebase documentation has an example for a git-rebase-todo file
>>> when --rebase-merges is used; one of the lines in that file is
>>>
>>>     reset refactor-button # Use the Button class for all buttons
>>>
>>>   From reading the code that parses the file, this doesn't seem to be a
>>> valid line; as far as I can see, comments are not supported for reset or
>>> label. The label is the entire rest of the line after the command.
>>
>> You're right that comments are not supported for labels, but for the
>> reset command do_reset() ignores everything after the label so it does
>> effectively support comments.
> 
> I don't follow; do_reset() simply uses whatever is stored in
> item->arg_len, and this is set to go until the end of the line for
> "label" and "reset" in parse_insn_line().

But it splits in line in do_reset()

		/* Determine the length of the label */
		for (i = 0; i < len; i++)
			if (isspace(name[i]))
				break;
		len = i;

		commit = lookup_label(r, name, len, &ref_name);

>> I've got some patches to support comments on other commands which
>> I'll hopefully submit before too long.
> 
> Hm, for label and reset this will make it harder for third-parties
> parsing todo files. What's a real-world benefit of supporting comments
> for these?

It started as a request for comments on the "break" command but the 
discussion convinced me that we'll keep getting asked why doesn't "xxx" 
command support comments if we just add them to some commands. See 
https://lore.kernel.org/git/pull.1460.git.1673519809510.gitgitgadget@gmail.com/

Best Wishes

Phillip

> -Stefan

