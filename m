Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206A1C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiHBPlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiHBPkt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:40:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4857E1403F
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:40:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f192so4459148pfa.9
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nLWBIcSR3982Lk2QeGA1662JxZgj3TeESxRCOIY5UXs=;
        b=GsfB8re+PIp9L9BwY0Ho+PToXT1M4ld3oyUxkx6VouCuZ8tB0n3I0mvOZXU5andcij
         jUvHTUQyWHoFuPZnvpXP/cO90aCkitQ6SQNPNn75nZVPYqmdYHXVLWAtYhD0p0DiwZuV
         QbyxLdbH630oeHcelh1J42nLu1+XBIwVLNDCtsiVhCazGUa6MCTxAjvuGHYlocDwetE1
         lUrliFDA6eTCD0LDLPZwhWmzIfrTZ6bq5iIXUl4nNdnGMrgs2lTAVt0aaCu2SFPdu//T
         gGrO0vZVMDY55w1faf4uZ4Zfl0MICD6YNREClCVUMI7+1DYSB+iTAqN+6+Utwp65OiJ0
         azeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nLWBIcSR3982Lk2QeGA1662JxZgj3TeESxRCOIY5UXs=;
        b=dkylvPOKdq3yBXwyNeNTKvQNDDmKoNWyDfmK5HUMN0+urxaZZ0Fvj9BW0jQBjjTqG/
         MFFPFBugOx+lLgIYTHhR8Dh/U4LpQ3nktjaP2chh+QIWOC+Nzv7IgLSMB729OPSlg9WV
         iG/qHjZntx8fKIZRVwqCrVyJk0v0Zi/PLKz7dAh/cw7sboH7Jzd2Rx/8t+gqOeNRg52d
         GSMCw0GvNz5QWa27UfdQ+5LTbcFBPCj0L0fvt7tt7tpbbCSs/KtmcsIqaO3AjX0RvG0Z
         Y8ecvKPPMgKBjsj40eRDk6ZzOhcCG5XLemQpA6wpSmV3CCDRjBjqeJvGrnRrrUoS83s8
         rg0Q==
X-Gm-Message-State: AJIora8nvHAumTWBOLIpQ0Gc6lelRT7jaxNJWi7hHLoxHvCJcQZ+Jr/H
        N45eIpDXTMGVq2zHdoWWNNPj71EGgq4Y
X-Google-Smtp-Source: AGRyM1st2F/YiFm7Ot539rIAhkL8hzL9EK4mJiOwJ1hcirSEpa9HXBLDFeONe7regOG2Dh23xeq6Ng==
X-Received: by 2002:a05:6a00:1797:b0:52a:f2e9:ddd2 with SMTP id s23-20020a056a00179700b0052af2e9ddd2mr20857387pfg.12.1659454823308;
        Tue, 02 Aug 2022 08:40:23 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id q43-20020a17090a17ae00b001f2e6388fe6sm14041528pja.6.2022.08.02.08.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 08:40:23 -0700 (PDT)
Message-ID: <0f175c9c-726b-4f73-ecd9-ed7df9dee865@github.com>
Date:   Tue, 2 Aug 2022 08:40:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 2/7] builtin/bugreport.c: create '--diagnose' option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <932dc8cddacf1841996cd3e0d512b95828213015.1659388498.git.gitgitgadget@gmail.com>
 <xmqqtu6vmwxb.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqtu6vmwxb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Create a '--diagnose' option for 'git bugreport' to collect additional
>> information about the repository and write it to a zipped archive.
>>
>> The "diagnose" functionality was originally implemented for Scalar in
>> aa5c79a331 (scalar: implement `scalar diagnose`, 2022-05-28). However, the
>> diagnostics gathered are not specific to Scalar-cloned repositories and
>> could be useful when diagnosing issues in any Git repository.
>>
>> Note that, while this patch appears large, it is mostly copied directly out
>> of 'scalar.c'. Specifically, the functions
>>
>> - dir_file_stats_objects()
>> - dir_file_stats()
>> - count_files()
>> - loose_objs_stats()
>> - add_directory_to_archiver()
>> - get_disk_info()
> 
> Yup.  As this does not "move" code across from older place to the
> new home, it takes a bit of processing to verify the above claim,
> but
> 
>  $ git blame -C -C -C -s -b master.. -- builtin/bugreport.c
> 
> shows that these are largely verbatim copies.
> 
>> +#ifndef WIN32
>> +#include <sys/statvfs.h>
>> +#endif
>> +
>> +static int get_disk_info(struct strbuf *out)
>> +{
>> +#ifdef WIN32
>> +	struct strbuf buf = STRBUF_INIT;
>> +...
>> +	strbuf_addf(out, "Available space on '%s': ", buf.buf);
>> +	strbuf_humanise_bytes(out, avail2caller.QuadPart);
>> +...
>> +#else
>> +...
>> +	strbuf_addf(out, "Available space on '%s': ", buf.buf);
>> +	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
>> +...
>> +#endif
>> +	return 0;
>> +}
> 
> As a proper part of Git, this part should probably be factored out
> so that a platform specific helper function, implemented in compat/
> layer, grabs "available disk space" number in off_t and the caller
> of the above function becomes
> 
> 	strbuf_realpath(&dir, ".", 1);
> 	strbuf_addf(out, "Available space on '%s:' ", dir.buf);
> 	strbuf_humanise_bytes(out, get_disk_size(dir.buf));
> 
> or something, without having to have #ifdef droppings.
> 

This makes sense, I'll probably follow an approach similar to what was done
with 'compat/compiler.h' in [1] (unless adding to 'git-compat-util.h' would
be more appropriate?).

[1] https://lore.kernel.org/git/20200416211807.60811-6-emilyshaffer@google.com/

>> +static int create_diagnostics_archive(struct strbuf *zip_path)
>> +{
> 
> Large part of this function is also lifted from scalar, and it looks
> OK.  One thing I noticed is that "res" is explicitly initialized to
> 0, but given that the way the code is structured to use the "we
> process sequencially in successful case, and branch out by 'goto'
> immediately when we see a breakage" pattern, it may be better to
> initialize it to -1 (i.e. assume error), or even better, leave it
> uninitialized (i.e. let the compiler notice if a jump to cleanup is
> made without setting res appropriately).
> 

I'll go with the "uninitialized" approach in the re-roll; I like the
simplicity of relying on the compiler to determine if it's unassigned.

>> +diagnose_cleanup:
>> +	if (archiver_fd >= 0) {
>> +		close(1);
>> +		dup2(stdout_fd, 1);
>> +	}
>> +	free(argv_copy);
>> +	strvec_clear(&archiver_args);
>> +	strbuf_release(&buf);
> 
> Hmph, stdout_fd is a copy of the file descriptor 1 that was saved
> away at the beginning.  Then archiver_fd was created to write into
> the zip archive, and during the bulk of the function it was dup2'ed
> to the file descriptor 1, to make anything written to the latter
> appear in the zip output.
> 
> When we successfully opened archive_fd but failed to dup2(), we may
> close a wrong file desciptor 1 here, but we recover from that by
> using the saved-away stdout_fd, so we'd be OK.  If we did dup2(),
> then we would be OK, too.
> 
> I am wondering if archiver_fd itself is leaking here, though.
> 
> Also, if we failed to open archiver_fd, then we have stdout_fd
> leaking here, I suspect.
> 

If I'm not mistaken, both 'archiver_fd' and 'stdout_fd' are always leaked if
they're successfully created (they're never 'close()'d). There's also an
unnecessary check for 'archiver_fd < 0', since 'xopen()' will die if it
can't open the file. And, as you mentioned, the wrong file descriptor 1 is
closed if the 'dup2()' of 'archiver_fd' fails.

I'll clean this up for V2, thanks.

>> +	return res;
>> +}
> 
> Other than that, looks good to me.

