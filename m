Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4313C6FA82
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 11:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiI0Li0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 07:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiI0LiY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 07:38:24 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CC114AD7F
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 04:38:20 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13189cd5789so1114548fac.11
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 04:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1vSerMz8oe70MGwXd2pYy4CUqGTn5vndS/AonQ0o884=;
        b=aHMnyKPNYj3bdRnmMSR0a9aDzCAtrSEEV92M0QVxPl45eeDqTyPk1gCDd+TQi3YZHH
         nyTOnuEpo1P5p+KJuR8o6VOgx0OgxD5RcYlWqKBfKcNts/RBop4XzItbHrw40ZmnEGJ+
         /MhJPdsyMQLNo0lcnSFyrrvfOUoemnzZDO5gAEYlgFKSR7NiM/W/87MJRAMcTeZ4Faf7
         bmKrYu1sqYkX/A4kY65RyjPr3DZz2JIPqJQ43o27FVV4OaedQVCKvEHiufvIIsV3hem6
         y8YGQgf6OuQ0aRXOsV79SxU2AElPKeoDp4xgVuSYh3sAAwcMVjeUcEdU1NqL2cZHByDY
         SlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1vSerMz8oe70MGwXd2pYy4CUqGTn5vndS/AonQ0o884=;
        b=Yxy6xK/gJvcRnD0LTzkVavvcdlZAKkEwdlR/x3xTFRa67HIGBc4wv5xMEs5FRGO8iq
         G2YzqIrcIKjREtT+j0ZjQ/V1vGmQnZW/8LFIyJoNDSOqxKryrLKmv0tqNziaEDZR4B4r
         9ulceinYK/1z8owMaD+G2uM8DQLATOoVoeQNFpvgz3EjiwtH+LuNt6pU3IlZ9LWFqVBi
         8k3jSi8Lqlgocc2sGojHZGijjwFqPuU/TiinBK84YZz//e2QQTcBTVV1OAzKLsj0F+sJ
         W+tXcchi3N0CJUtz7JS0a2/pqTgqPo6awuFoIexPVBEOJqp3Mmi0wzWs4i88FyDTCYlm
         EHDQ==
X-Gm-Message-State: ACrzQf1VdYWfi7GwvBT7lJcyn+l5npCbtEGNoaOl3Nd+4vk33J1yvoez
        iTAxvzgvPOjEzKGRDufqOUlo
X-Google-Smtp-Source: AMsMyM7VNndAGQalKYe0rhQFXZ2mEWV+YCvb49nAkUXSIC1dLvTBgU3gyCkH+fGbgDEB7Cj50LyIQw==
X-Received: by 2002:a05:6870:248a:b0:131:8e5d:1bb4 with SMTP id s10-20020a056870248a00b001318e5d1bb4mr539491oaq.261.1664278699549;
        Tue, 27 Sep 2022 04:38:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6d75:31c0:4041:5d27? ([2600:1700:e72:80a0:6d75:31c0:4041:5d27])
        by smtp.gmail.com with ESMTPSA id z21-20020a0568301db500b00638ef9bb847sm506661oti.79.2022.09.27.04.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 04:38:19 -0700 (PDT)
Message-ID: <b1e6f118-046c-42f8-01a8-2543e792685a@github.com>
Date:   Tue, 27 Sep 2022 07:38:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/3] maintenance: add 'unregister --force'
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
 <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
 <8a8bffaec89e55da0c5bcac2f04331e0d4e69790.1664218087.git.gitgitgadget@gmail.com>
 <xmqqa66lby1w.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqa66lby1w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/26/2022 5:55 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> @@ -1538,11 +1546,23 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>>  		usage_with_options(builtin_maintenance_unregister_usage,
>>  				   options);
>>  
>> -	config_unset.git_cmd = 1;
>> -	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
>> -		     "--fixed-value", "maintenance.repo", maintpath, NULL);
>> +	for_each_string_list_item(item, list) {
>> +		if (!strcmp(maintpath, item->string)) {
>> +			found = 1;
>> +			break;
>> +		}
>> +	}
> 
> Just out of curiosity, I ran this in a fresh repository and got a
> segfault.

Yikes! Thanks for catching. I think there was another instance in
the 'register' code that I caught by tests, but I appreciate you
catching this one.

>  An attached patch obviously fixes it, but I am wondering
> if a better "fix" is to teach for_each_string_list_item() that it is
> perfectly reasonable to see a NULL passed to it as the list, which
> is a mere special case that the caller has a string list with 0
> items on it.
> 
> Thoughts?

I agree that for_each_string_list_item() could handle NULL lists
better, especially because it looks like a method and hides some
details. Plus, wrapping the for-ish loop with an if statement is
particularly ugly.

I think this might be more confusing that
git_configset_get_value_multi() can return a NULL list instead of
an empty list. It boils down to this diff:

diff --git a/config.c b/config.c
index cbb5a3bab74..39cc0534170 100644
--- a/config.c
+++ b/config.c
@@ -2416,8 +2416,9 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
 
 const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
 {
+	static struct string_list empty_list = STRING_LIST_INIT_NODUP;
 	struct config_set_element *e = configset_find_element(cs, key);
-	return e ? &e->value_list : NULL;
+	return e ? &e->value_list : &empty_list;
 }
 
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest)

However, this change causes a lot of cascading failures that
are probably not worth tracking down.

I'll get a patch put together that changes the behavior of
for_each_string_list_item() and adds the missing 'unregister' test
so we can avoid this problem.

Thanks,
-Stolee
