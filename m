Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5911AC2D0CE
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 13:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB2320722
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 13:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seP8hfAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfL2NXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 08:23:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39086 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfL2NXi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 08:23:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so30472512wrt.6
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 05:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:in-reply-to:from:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=qNwSdAjdzhzpAZWlocD4BR9s1FdYs5ze+V37GW4OpLw=;
        b=seP8hfAAnir1gYqdU2G01QwzZGhoziiCAxcY+oLOp6ZCsMxZR+6iYHMpqIKcgSdiZ0
         h8ibuGzDn8s2VabZ4fSkOwdaw2oi2nOc/8IR2O6AOLxtaEEtsN6wa9+DWiZWbluRYQEd
         B+YHO80tNuRtk2o+Yi4kBUKGNE3yMRRAh4kry29F9OlXa7yRyW27vlFG8SwMOgajOpnP
         2hoIbUuY3CmznbVaF9RLsP1ucxQqOVIN2+93bLd8pszY7Yi36ZcmOhHr/WN3h3mleU9L
         if1gYxWS1sS7x/ztCoKzBMpArSIAAMIazsi/yzbJgPbBDCMqf2MrxALqsSH9qN8mrbfn
         XMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:in-reply-to:from
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=qNwSdAjdzhzpAZWlocD4BR9s1FdYs5ze+V37GW4OpLw=;
        b=tN1aQhEXMtEO2hdDeNo66Vre6VPQtFkbGEoH7FPtQQQhyX9yoE4evaTxiKs+XgJDjk
         4CKfxRs1uevd8WQ28OGJiarOdlsQnEoFehLndqHnfEZlSiK841we+VCyqwZSKgoz0WDK
         rvz3yY6PB403S9OzNESTbO5rL1IvhZgEb0u2zlRSmzBb212U20Qcl5JPrxI09FiF9QaM
         vlZpRmCwTXpR/rGwZ5bGVhlly8EX+vgxx9Ijxlx7f78+wx2Dgk8Rh5aKbAXFV4O2vQgb
         XhqIpZIBkO6OnSsnAZnk4C6Weepp3NdinGFSoXTx8TrERtw9TrCnu0iGS0fSYomeoN4N
         BBkQ==
X-Gm-Message-State: APjAAAWQcHLMjbmBFg0tgarW3hN32mGkZBKf7Z++Qs18oEhi+Wx2dh5u
        rFYwF7nAqRm0jYgyzd9Ybk4lCSUW
X-Google-Smtp-Source: APXvYqwJ9waJClOBiLfTr69U1oBANAPfL+MX/6MwGewFbh/XgPrRiFcHW9ZUQmIjvLoXUSmB/g6cPA==
X-Received: by 2002:adf:d850:: with SMTP id k16mr58395243wrl.96.1577625816145;
        Sun, 29 Dec 2019 05:23:36 -0800 (PST)
Received: from [192.168.0.108] ([188.173.146.22])
        by smtp.gmail.com with ESMTPSA id w20sm17433413wmk.34.2019.12.29.05.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 05:23:35 -0800 (PST)
Subject: Re: Re: [PATCH 1/1] git-gui: add possibility to open currently
 selected file
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
References: <pull.499.git.1577386915.gitgitgadget@gmail.com>
 <fce80f1b95f83915076640ca0be01aa473744777.1577386915.git.gitgitgadget@gmail.com>
 <20191227193418.36uzeizs37nv7ywb@yadavpratyush.com>
In-Reply-To: <20191227193418.36uzeizs37nv7ywb@yadavpratyush.com>
From:   =?UTF-8?Q?Zoli_Szab=c3=b3?= <zoli.szabo@gmail.com>
Message-ID: <c681ca1b-cdcb-d021-95a9-ca3ad944cfa3@gmail.com>
Date:   Sun, 29 Dec 2019 15:23:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

Thanks for your thorough review.

On 2019.12.27 21:34, Pratyush Yadav wrote:
>> ...This change enables just that by:
>>   - Diff header path context menu -> Open;
> 
> Would it be a better idea to have this option in the diff body context
> menu (.vpane.lower.diff.body.ctxm) instead? The problem I see with the
> way its currently done is visibility/discovery. It is not very likely
> for a user to try and click the file name which doesn't give any
> indication that it is clickable. So how will someone who hasn't read
> this commit message know that they can use this neat feature. The diff
> body context menu is much more "visible" IMO.
> 
>>   - or double-clicking the diff header path.
> 
> An alternative to the above suggestion would be to make this path
> underlined and blue in color (like a hyperlink in a web browser). This
> will give the indication that this is not just plain text.
> 
> I like the latter idea more, but I don't mind either.

For me, the body context menu holds the diff-related options, I am not 
sure the "Open" fits in there. But I do like your suggestion of making 
the filename web browser-link-like. I'll try to implement that.


>> One "downside" of the approach is that executable files will be run
>> and not opened for editing.
> 
> FWIW, I do not see it as a downside at all. The menu option is called
> "open" not "edit". So if you click it, you should expect the file to
> open. In case its a binary file, executing it is the correct outcome. In
> case its a text file, opening it in the editor is the correct outcome.

Alright then.

>> +proc do_file_open {file} {
>> +	global _gitworktree
>> +	set explorer [get_explorer]
>> +	set full_file_path [file join $_gitworktree $file]
>> +	eval exec $explorer [list [file nativename $full_file_path]] &
> 
> This executes $explorer, which is 'explorer.exe' on Windows. I'm not a
> heavy Windows user but AFAIK it is a file manager. This makes it quite
> different from 'xdg-open' which is used to open _any_ file/URL in the
> user's default application. So it also happens to open _directories_ in
> the default file explorer which was the original intention of this
> procedure.
> 
> Have you tested it on Windows? Does 'explorer.exe' do the correct thing?
> 
> Looking at MacOS's 'open' man page, I think it should also work like
> xdg-open and shouldn't be a problem.

I am in fact working on this patch on Windows. explorer.exe works also 
for files and even brings up the "Open with..." dialog for 
not-recognized file types.

> Tested on Linux. Works fine. Looking forward to the re-roll.

Thanks for testing it on Linux. Since I am working on Windows, I just 
read about `xdg-open` and `open` and assumed everything should work OK.

All other points I agree with you and will push a new version of the patch.

Thanks,
Zoli
