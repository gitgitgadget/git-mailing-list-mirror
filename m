Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B1941F858
	for <e@80x24.org>; Mon, 14 Nov 2016 18:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934371AbcKNSok (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 13:44:40 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36431 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932809AbcKNSo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 13:44:28 -0500
Received: by mail-pg0-f52.google.com with SMTP id f188so56733064pgc.3
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=z4003vBlBgKwLRPqNRQAs1RT0Lb2hJAaA3En7GZ8fjc=;
        b=ZQ/60S8TXCEVRlyU7SmqvSaOGJodm51xHmxiTFYWSt6jDkB3Ooq9r8m/OEH0cADrUe
         CSete2efwkSTYQr8z5ljnDr3b16QZt6Kn0Uvxn/8+i2G3VMYHKVOSdtkswgHTCmfUYVP
         gggw4Xhv1ZIwMfE3q8tNM9JT9KE+AK8xYFSIXcLIjlzECmWaEp+9TYWBT1yY0+rGS565
         YORcmm0ZMsOqNk6Iggabk6fWoIHYnVAGNhHB6oOIOT+1YkcTpgnaIqrIw9xnfow4zQbE
         C4I2Cb2M4UZvf2q0Rj5yIm/BHpIfSHVCI2j2OPMZ8oUjJyXKEI997MtLkBgKchxm/vi8
         zBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=z4003vBlBgKwLRPqNRQAs1RT0Lb2hJAaA3En7GZ8fjc=;
        b=NBv5mYJK9s3kBQWqoNq5Jr9fInJiDKMO9dO7/BFcB+POiGtRS+LclV3qCrjhV5NEqJ
         9o5zTZ6ePTwmS0uwZQohX3Eg8gKL609yAa8b56XseNGibCHrJ3wgPnwbobRcUSTP8UI6
         rcEajH5zz3dAoQdx5RLhEpdvX0mz7MOnG5LSYhWloIcw7tFtiPUq0F5GNltXiAjer9Pc
         miJmqjfOrptjzQXmZKrLNNpS7VP8vBPCSG/T1OxOEA1DaePA3ezOHyn6p7SppARegnJf
         S4+tCvHdfshtwnf5lSxQ2RoX/t2tFXZe0c5V7fIawgw+drNb5pUt5uXCXpRvC4NJVRVc
         zqdQ==
X-Gm-Message-State: ABUngvdv4GnCCJtaOyhXHK+MegTY/e+Lo2nCsndkwYfZLczuoVfd60gGw+GNMXbVDJuN1ui/
X-Received: by 10.98.200.8 with SMTP id z8mr38408100pff.176.1479149067747;
        Mon, 14 Nov 2016 10:44:27 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:1c50:6e1d:7dd:6ec1])
        by smtp.gmail.com with ESMTPSA id bc9sm36990654pad.34.2016.11.14.10.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Nov 2016 10:44:26 -0800 (PST)
Subject: Re: [PATCH v3 5/6] grep: enable recurse-submodules to work on <tree>
 objects
To:     Junio C Hamano <gitster@pobox.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1478908273-190166-1-git-send-email-bmwill@google.com>
 <1478908273-190166-6-git-send-email-bmwill@google.com>
 <xmqqk2c6x79c.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <c83066bc-5b2b-998c-7e22-c4fccbaba5de@google.com>
Date:   Mon, 14 Nov 2016 10:44:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqk2c6x79c.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/14/2016 10:10 AM, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> Teach grep to recursively search in submodules when provided with a
>> <tree> object. This allows grep to search a submodule based on the state
>> of the submodule that is present in a commit of the super project.
>>
>> When grep is provided with a <tree> object, the name of the object is
>> prefixed to all output.  In order to provide uniformity of output
>> between the parent and child processes the option `--parent-basename`
>> has been added so that the child can preface all of it's output with the
>> name of the parent's object instead of the name of the commit SHA1 of
>> the submodule. This changes output from the command
>> `git grep -e. -l --recurse-submodules HEAD` from:
>> HEAD:file
>> <commit sha1 of submodule>:sub/file
>>
>> to:
>> HEAD:file
>> HEAD:sub/file
>>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>
> Unrelated tangent, but this makes readers wonder what the updated
> trailer code would do to the last paragraph ;-).  Does it behave
> sensibly (with some sane definition of sensibleness)?
>
> I am guessing that it would, because neither To: or HEAD: is what we
> normally recognize as a known trailer block element.

Yes, it behaves sensibly :-) because "Signed-off-by:" is preceded by a 
blank line, so the trailer block consists only of that line.

Having said that, it is probably better to indent those examples in the 
commit message (by at least one space or one tab) - then they will never 
be confused with trailers (once my patch set is in).
