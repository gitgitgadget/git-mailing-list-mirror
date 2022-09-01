Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68296ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 22:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiIAWtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiIAWtd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 18:49:33 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DAE719A3
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 15:49:29 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id z22-20020a056830129600b0063711f456ceso324389otp.7
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 15:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=yLY2lAzqhKut+6sS5JDVe01kOHwYmPbqjirD82UZoGk=;
        b=UfKvcwrFxKYOkFbrh4p/+YyMMHh4x2+faWR4OqAIhQHhssmm0UBTRvMc1yjWLTmPxV
         XCcL6DHwub9aAqRZ4ahCaMQ/M7r2kaKlqz5JmbsLq1Vh785d4GU0Io7BjMo0YqfQw14F
         EOYIPRMP2DpP5hJNga+0ArAGOdV83DrEzjcM1bCM550Gj6Opr6JbQkovLWhmBrEHJAMV
         KIm3U8v9ExrZTkS/WyboCBztPQeMs1n/BybtbG/ppligPlMjZS+shFezzdDmQnbW37I6
         2pZrgMRbyy7xyPBV6xjRWqDSx2lMOcitMV3GWqAeNJmuemUcpXgZrnHYACSUddF/2uM1
         3bNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=yLY2lAzqhKut+6sS5JDVe01kOHwYmPbqjirD82UZoGk=;
        b=eb9zrnEQ9AftKBV8H4FowXlJHDETz6I+XxiVcLpbu8XLGOeKafA+EdQjq5Dc8BzZcf
         pfQYSWYfkeI1mWfkDph8itvkgnkidS5lVZep8guQQbQkoSl6UyMZxoj07yUDTIFaplAD
         DWvjyyMrrxKWrhKRq8ylzYmm7uXUhqvCD5YO997+b04g5950qntMuMrZojiKlSZvJYR7
         MdEK+nw8nJWxxZsmzGyjEFtMKNHX2S3Z/0r1fCvKZCJnO1fzSjsLbN/7zdwl3prKCEzX
         McF5t1JFNVTL2oFRq5WHgr3HAZ1W0HXQvO1AoSSNXvnLhA4jZkOp8fEgT+PyfAJxrT14
         1tRA==
X-Gm-Message-State: ACgBeo31HwvbgOicSsxI+Af5fK7SeEjmSNBV9w2MCdtsoRIrIrF0u77U
        yBjDstATnkAMHhsRennQxfw=
X-Google-Smtp-Source: AA6agR6ATpyFi2o4B6q0dOhCYT+o8OC5Xl7hWLrfJ/9g41LviroW/jlle+Gs5NBXdagMj0m0eEmqzw==
X-Received: by 2002:a05:6830:4ce:b0:638:f7cb:2f80 with SMTP id s14-20020a05683004ce00b00638f7cb2f80mr13016853otd.172.1662072568487;
        Thu, 01 Sep 2022 15:49:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:5a60:7720:19b:a8b4:73c:2e5? ([2600:1700:5a60:7720:19b:a8b4:73c:2e5])
        by smtp.gmail.com with ESMTPSA id z125-20020aca3383000000b00326cb6225f8sm230619oiz.44.2022.09.01.15.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 15:49:28 -0700 (PDT)
Message-ID: <68c1944b-6a23-e729-90ae-1c0771776879@gmail.com>
Date:   Thu, 1 Sep 2022 15:49:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 3/3] builtin/grep.c: walking tree instead of expanding
 index with --sparse
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, vdye@github.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220901045736.523371-1-shaoxuan.yuan02@gmail.com>
 <20220901045736.523371-4-shaoxuan.yuan02@gmail.com>
 <xmqqpmgf9fpr.fsf@gitster.g> <xmqqler39f9x.fsf@gitster.g>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <xmqqler39f9x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/2022 10:27 AM, Junio C Hamano wrote:
 > Junio C Hamano <gitster@pobox.com> writes:
 >
 >> Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:
 >>
 >>> Before this patch, whenever --sparse is used, `git-grep` utilizes the
 >>> ensure_full_index() method to expand the index and search all the
 >>> entries. Because this method requires walking all the trees and
 >>> constructing the index, it is the slow part within the whole command.
 >>>
 >>> To achieve better performance, this patch uses grep_tree() to 
search the
 >>> sparse directory entries and get rid of the ensure_full_index() method.
 >>
 >> When you encounter a "sparsedir" (i.e. a tree recorded in index),
 >> you should know the path leading to that directory. Even though I no
 >> longer remember the details of the implementations of grep_$where()
 >> which I did long time ago, I think grep_tree() should know how to
 >> pass the leading path down, as that is the most natural way to
 >> implement the recursive behaviour.  This patch should be able to
 >> piggyback on that.
 >
 > To avoid unnecessary scare, the above is just me "thinking aloud",
 > after reading the proposed log message, and agreeing with the
 > direction taken by this patch.  Not giving a suggestion to go
 > different route or anything like that.  I should have said "OK" or
 > something at the end of the paragraph.
 >
 > Thanks for working on this topic.

Thank you! :-)

