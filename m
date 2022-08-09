Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63A5C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 11:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiHILYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 07:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiHILYr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 07:24:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F76A1EC65
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 04:24:46 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b133so10506853pfb.6
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 04:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=5dA7/a1VOSEEcqOFgc/fb7QYGLEt+qhD/57o1h2Jq40=;
        b=i77x+QhE+5Bv3Qu3V7y5Tkdlm3NEbt5FEyAOaUXSQSrqktlwLkR1XD6g4TFASMM+D5
         4iR81RUP0TTPG0Uh1DXCJrTJ5YrmAyagcUsGMybfInPXlNJnI/15INOwEL2d4sfRHYVV
         pAc6J/rw3406KdXBZDjDr79LEXfg6XbgicF5EDjzi21UvfjxZqtDMizH0WRuzmoVvWju
         CgEhhQRJuq0cLKHoa+k/HGkoVIVTrpcOuB8Ou1a76zhR51v4Z/8H/N3Ho+TDS12Z6GcL
         Z21pKTa2O3s1gw/T/5XNOd7Ux68qXurfm0+o/znsK7uZtPJvLadRS2vjoktvWdfpGFVt
         jcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=5dA7/a1VOSEEcqOFgc/fb7QYGLEt+qhD/57o1h2Jq40=;
        b=uLuG+Jtw8wniq3HejO/cQbGVPfXb8eCEINy00NHFwZZACJPZ3j8ANajrY9xbIwDT5D
         t3RDvRxevkErlcALKAiSFS7ftRxS3r43z/Yju1gkdQ5v3vHh8O99n1d+gW5tsM9hi+80
         KZMGhMOLKp37N3ar2skr2RFdAGGPgZfwvJ+s1t8UPyTd1odz4U2zlYOEtbQNMnuyGJli
         CMfAhNH90/ZWVqtS32P526Qh34xGcNqC/lH2nde4zhTuyTtj7k0L1eKORdV7aUdVGC5r
         qUecPe70WOoSGVOuLDXGLFQ4xKGJPt6AjyFbn2w1PQUbGYZ/Y9tvTlHfqGVIfkck6/0R
         +1RA==
X-Gm-Message-State: ACgBeo144QnOULgf+VFmQyT34ySabiOHK4T5m3h6ghJc7PKLg/mxqCZz
        GQwHHe91KxpIyHPEQ1IuMQtCn1XRwoiO9Q==
X-Google-Smtp-Source: AA6agR5XrkIwpI2EysadpIsE/fAku3twDwGdVHmzjdc1Wxs9uC4mJGoHIBnYjNjQvYVJoZ1a+V8RnQ==
X-Received: by 2002:a63:907:0:b0:41c:cb97:6969 with SMTP id 7-20020a630907000000b0041ccb976969mr19216626pgj.194.1660044286175;
        Tue, 09 Aug 2022 04:24:46 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id x10-20020a17090a6b4a00b001f6c86e6ff0sm6936287pjl.36.2022.08.09.04.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 04:24:45 -0700 (PDT)
Message-ID: <3c4ee06e-1145-8efc-ddb9-eeaed81079f5@gmail.com>
Date:   Tue, 9 Aug 2022 19:24:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/9] t7002: add tests for moving from in-cone to
 out-of-cone
Content-Language: en-US
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-2-shaoxuan.yuan02@gmail.com>
 <bd80881d-b2a3-c220-8f2d-a07a46e14207@github.com>
 <651d89e2-5282-2cf8-ffc3-8650a023c80a@gmail.com>
In-Reply-To: <651d89e2-5282-2cf8-ffc3-8650a023c80a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/9/2022 10:55 AM, Shaoxuan Yuan wrote:
 >> 2. Move a (clean or dirty) in-cone source directory to an out-of-cone
 >>     destination where one or more files in <src> overwrite files in 
<dst>.
 >>     For example, something like:
 >>
 >>     echo test >sub/dir/file1 &&
 >>     git add sub/dir/file1 &&
 >>     git mv --sparse sub/dir folder1
 >>
 >>     I don't have a strong opinion on the behavior (does it fail the 
whole
 >>     'mv' operation? move everything except the files that overwrite
 >>     something?), but it would help to have it documented via test here.
 > OK. I think it will fail the whole `mv` operation. The program will 
report unspecified
 > overwrite during the early checking phase. The actual "moving" phase 
won't be touched
 > at all because Git complains early.

No, actually this example does not fail anything. Because
"sub/dir/file1" after the move will be "folder1/dir/file1", and this
move does not involve overwrite at all.

I'm still adding a test case that precisely reflects the main idea
here, though. Thanks for the suggestion :)

--
Thanks,
Shaoxuan

