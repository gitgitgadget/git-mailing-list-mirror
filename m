Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0690BC4332F
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 15:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242879AbiA0PRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 10:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242946AbiA0PRN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 10:17:13 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8381EC061751
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 07:17:10 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id o9-20020a9d7189000000b0059ee49b4f0fso2859530otj.2
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 07:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YAMUa2HZjfi1F8m6b/U+0jxWu1dlQRya0UjttMOP3rg=;
        b=UxxLd7uSSYUbk3xsi0nZco2SyyMbo3KLNR6TSkw166sy0sHAH71mTiOPEJbGQdXr9s
         wfAdx/UG+Ylm2D8+j0hCe7x58GZxhkcbbcclOL2ZInyb5/DuUAjypRloiXIu4krDlTNh
         I/Wvf+BYSSs/o8GvP2K2WCBJgxlEr4kIZLgHUamOPl/ZS4GS30CgOXe/tossyXeolDW/
         mCgdrViy5/dUy3cceHACW4SE4bbrD6lZgCRWLNjECnrz7xSPFDsROqadf5y3HxEg8isa
         ePzXWhhIedxEL8Dkny8ImWGO5WzKXgpX5BpzU60SSWwp0BSYrkqmWUAhJrQwv2hNSeYt
         1GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YAMUa2HZjfi1F8m6b/U+0jxWu1dlQRya0UjttMOP3rg=;
        b=qXR6uWmCQ9bRUDxDNmUVXOp39VteDMWyNTcpeUusXZP5Aj7u7WwyWzFUQNrC5A8eV8
         irv6hhsocJb8idvPEDuGKP4XXdt6QgI6pQizzQ5O2QEhMVrdfQCvlUzCbUOY9ifR5bNh
         gWc3mRaMUAWBzaP4iRZmQOHwVUDgATRmD9HJDEy6+PAqTVN+q+ZPWWNBrwd9jnSGJnmK
         W3MD+Zo+rz1LDBIvO2Z8rBO5leWXE4DMvVhJrULw3h/B68Kc7T1rFpd/5WkAQRYbnUC4
         Jx3DXblVMNsLt8wv9o+5nwrXXmvHo7xnRUvJY2X3oNvnX0A/TnJ7Y+5HSSUyVVUTBbCM
         JavA==
X-Gm-Message-State: AOAM532Pf7YlRXapdzVyPT93pmh+I2A8UMpXKsqyHbTTj0HcupUVkSii
        g9IDeC3uBgVtN0wZPJy170k=
X-Google-Smtp-Source: ABdhPJxn4dJ2ZXILbV+tXzzOScaOEAzazlHcKgz+vhCWrPIlz5Ql3jvZLUn5QyAE+c7LhyulnNvI8g==
X-Received: by 2002:a05:6830:3148:: with SMTP id c8mr2399652ots.226.1643296629587;
        Thu, 27 Jan 2022 07:17:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d9cb:250e:9ea6:f8? ([2600:1700:e72:80a0:d9cb:250e:9ea6:f8])
        by smtp.gmail.com with ESMTPSA id a2sm11668414oiw.33.2022.01.27.07.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 07:17:08 -0800 (PST)
Message-ID: <027ebd30-77c7-1f09-9fe1-0523b9487319@gmail.com>
Date:   Thu, 27 Jan 2022 10:17:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/5] scalar: teach `diagnose` to gather loose objects
 information
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
 <213f2c94b73f90fc758c2e3872804cf640cb2005.1643186507.git.gitgitgadget@gmail.com>
 <YfHQSrdkieNuBEXT@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YfHQSrdkieNuBEXT@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/26/2022 5:50 PM, Taylor Blau wrote:
> On Wed, Jan 26, 2022 at 08:41:46AM +0000, Matthew John Cheetham via GitGitGadget wrote:
>> +	while ((e = readdir(dir)) != NULL)
>> +		if (!is_dot_or_dotdot(e->d_name) &&
>> +		    e->d_type == DT_DIR && strlen(e->d_name) == 2 &&
>> +		    !hex_to_bytes(&c, e->d_name, 1)) {
> 
> What is this call to hex_to_bytes() for? I assume it's checking to make
> sure the directory we're looking at is one of the shards of loose
> objects.
> 
> Similar to my suggestion on the previous patch, I think that we could
> get rid of this function entirely and replace it with a call to
> for_each_loose_file_in_objdir().

There is a possibility that there are files other than loose objects
in these directories, so summarizing those counts might be helpful
information. For example: if somehow .git/objects/00/ was full of a
bunch of non-objects, it would still slow down Git commands that ask
for a short-sha starting with "00".

While this shouldn't be a normal case, the 'diagnose' command is
built to help us find these extremely odd scenarios because they
_have_ happened before (typically because of a VFS for Git bug
taught us how to look for these situations).

Thanks,
-Stolee
