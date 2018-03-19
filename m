Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5FA81F404
	for <e@80x24.org>; Mon, 19 Mar 2018 19:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966969AbeCSTJQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 15:09:16 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:37126 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967253AbeCSS1v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 14:27:51 -0400
Received: by mail-qk0-f173.google.com with SMTP id w6so6394656qkb.4
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=axafVI+5EK2aEeX2rQsB7z6jBbegyusJt9PncSaU4Vw=;
        b=pECX9u2FLPsGqCL8NnHrEbRImbXJBrwE0HeyXqkST6Ilut98npzH4n8Q+FWuvLI86n
         6Cfex8lCLl/jNEGpkLFs+2dPlDEbkDNPDhYI3xMXbdC8VZkNlECRuSbENeBiRgfCg8uK
         Vh9gLcrxmb2QB9PwrVcOTuVFOMrfmL9RzVr0zXvEZWMMYj8WyNG7kMeOELmjmmESq8iW
         PV7/xSgtucRvGhC9PKvrEEVHXc+ULKjL7fwfa5LqF/aU6VeK/RkH6W+MKOn9id6iKcV+
         XzXBDk7So0KCRCiY//vo5AamZ+ErKsdz4Y/IS7lNIDeHaEHEIXeCXFwY9FO3xkjp765I
         291Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=axafVI+5EK2aEeX2rQsB7z6jBbegyusJt9PncSaU4Vw=;
        b=OvhZdfNlv+imEZWJhOEsUoJwfj5XMWNAFbAB1VouBFkPh9H9USSEpGCMVQ1IS7HJ2/
         k25K9Uq7KFi/+BaWx6iZ1DZPMNqImAT8+9di9cX85+HdWSle8mD5NWIHATnqXpJyrFaF
         fL6JxQ2xSK5TOK8IUHacIR46NbTZeInFr/2KEPefsKAeOdPlY58YpK2MdIm+FYmGyILg
         Hl2zCHvWsIOyS5My7CHfbAXd7l2Dxhpq8+MiYuUxZtTfpm2L/jmME+2YPUFRxLl21tLS
         zVBkNdVEtO8hZjeVWq/xpjKpCLY+UDPsWRRlIqKtzTnndRyV6LWRNxVzqkSrNIw0x2Qv
         Z6zQ==
X-Gm-Message-State: AElRT7Hm1L5vvkYYWXn6V6JuTXa9CA6eQuSFgiEBmNdmivsYXNfEprWs
        xC/4kJtTU7C9G7jOeG14Ij0=
X-Google-Smtp-Source: AG47ELvYWnyG7WAOHcarcnRYkSdW+asOiq0VR+THk+w5qxVR7Ho7o7eq2UdpcEFWOvRQy2mn9o2MqQ==
X-Received: by 10.55.217.143 with SMTP id q15mr19309535qkl.304.1521484070627;
        Mon, 19 Mar 2018 11:27:50 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id r125sm412827qkd.46.2018.03.19.11.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 11:27:49 -0700 (PDT)
Subject: Re: [PATCH v6 07/14] commit-graph: implement 'git-commit-graph write'
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
 <20180314192736.70602-8-dstolee@microsoft.com>
 <87bmflcy8a.fsf@evledraar.gmail.com>
 <5e394b91-fa78-5b70-8c5e-b06cc332bb3a@gmail.com>
 <874llccetp.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0c2f17fa-5c0e-9539-a081-7827a6678bf1@gmail.com>
Date:   Mon, 19 Mar 2018 14:27:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <874llccetp.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/19/2018 10:36 AM, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Mar 19 2018, Derrick Stolee jotted:
>
>> On 3/18/2018 9:25 AM, Ævar Arnfjörð Bjarmason wrote:
>>> On Wed, Mar 14 2018, Derrick Stolee jotted:
>>>
>>>> +'git commit-graph write' <options> [--object-dir <dir>]
>>>> +
>>>> +
>>>> +DESCRIPTION
>>>> +-----------
>>>> +
>>>> +Manage the serialized commit graph file.
>>>> +
>>>> +
>>>> +OPTIONS
>>>> +-------
>>>> +--object-dir::
>>>> +	Use given directory for the location of packfiles and commit graph
>>>> +	file. The commit graph file is expected to be at <dir>/info/commit-graph
>>>> +	and the packfiles are expected to be in <dir>/pack.
>>> Maybe this was covered in a previous round, this series is a little hard
>>> to follow since each version isn't In-Reply-To the version before it,
>>> but why is this option needed, i.e. why would you do:
>>>
>>>       git commit-graph write --object-dir=/some/path/.git/objects
>>>
>>> As opposed to just pigging-backing on what we already have with both of:
>>>
>>>       git --git-dir=/some/path/.git commit-graph write
>>>       git -C /some/path commit-graph write
>>>
>>> Is there some use-case where you have *just* the objects dir and not the
>>> rest of the .git folder?
>> Yes, such as an alternate. If I remember correctly, alternates only
>> need the objects directory.
>>
>> In the GVFS case, we place prefetch packfiles in an alternate so there
>> is only one copy of the "remote objects" per drive. The commit graph
>> will be stored in that alternate.
> Makes sense, but we should really document this as being such an unusual
> option, i.e. instead say something like.
>
>      Use given directory for the location of packfiles and commit graph
>      file. Usually you'd use the `--git-dir` or `-C` arguments to `git`
>      itself. This option is here to support obscure use-cases where we
>      have a stand-alone object directory. The commit graph file is
>      expected to be at <dir>/info/commit-graph and the packfiles are
>      expected to be in <dir>/pack.

A slight change to your recommendation:


OPTIONS
-------
--object-dir::
         Use given directory for the location of packfiles and commit graph
         file. This parameter exists to specify the location of an alternate
         that only has the objects directory, not a full .git directory. The
         commit graph file is expected to be at <dir>/info/commit-graph and
         the packfiles are expected to be in <dir>/pack.

