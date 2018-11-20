Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10731F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 18:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbeKUFPz (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 00:15:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37053 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeKUFPz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 00:15:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id z16so1137010qtq.4
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 10:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=z2TAjzV4ue2deSjNGtXZZjmjT8CEKhhv0Szt2G8Guas=;
        b=cdeGne6Jp6Dgnxv/3FEq5FqMFaLiy81TVpqADgQ81xsbMI+2DtVG3dKA5ylnHkeuKu
         Hp0HsljPa05wYntWnvsRtJGIYkcD2Q2HJGMhkpFifdxtYbxMudX3d+0mZa8dOR3E5Iqu
         xxdn+uq0f+MWqS6YfMl1XRJyeUM1VKuB9c3fpq5MEZ5fKpQaJUeGmJve4FU+g3j/1XIz
         ZadSYreJa12rzdkl7v2tMATr2iyPB5gganPs0c+HgBeNWH+ohABR21545ASM0xmkjWU1
         XgzfNS81twHvIp2kgS6kxxleGov0NrqvMUMbXuFj0ydbrxxVlVTIYXLXSXuXcgkyT0oo
         q0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z2TAjzV4ue2deSjNGtXZZjmjT8CEKhhv0Szt2G8Guas=;
        b=LDQenmifUHwvFKIzFMg+5xlgo9d3H5FFRt3zyhRGfehCjeVbRMRsAFVvPohP6Hkv7k
         kOfjTcFHWv8cD/52NsvKdtDyJuP4VYZTHVWqiq5HluA9/CRVIk+GtQZ13ljQxao7vSZj
         QSciwcC6QiS1gkPRaF5vybAY2liHu9XmPlvuJi9Ng7FeodGhTCWXD2N+5BZObs+pi6AN
         pRIIWIWUhzJVp2+mMxjg7tvhIcI0IxOjZA0JvV5sbq5BSix3DHV18LRaD41G3xNQ/bJF
         QoTwba3lj7DX/wuWQufM7rD33h9QUqy9jV6YDe4dd9cIQzuCGjAN4Opj+E4xc4WuDYKS
         sFMg==
X-Gm-Message-State: AA+aEWbN3jAWlQKoTtRDART7GPPJo258sW59NpB8QlM4wTfOLSPFdRas
        q6HSDt/+Zg9wkXDaaqQ3q68=
X-Google-Smtp-Source: AFSGD/WYEWZ6+NCOBjVvbVGIYsFM0nTcafFirQpLdcZO38X4CIHCrVg1TwKp70+kPBwB3bOgcJFotA==
X-Received: by 2002:a0c:919d:: with SMTP id n29mr3023785qvn.202.1542739519535;
        Tue, 20 Nov 2018 10:45:19 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:cc42:c99e:79d7:4dba? ([2001:4898:8010:0:b578:c99e:79d7:4dba])
        by smtp.gmail.com with ESMTPSA id o21sm20979717qto.18.2018.11.20.10.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 10:45:19 -0800 (PST)
Subject: Re: [PATCH 1/1] revision.c: use new topo-order logic in tests
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <pull.83.git.gitgitgadget@gmail.com>
 <ab7c2dd46fb72523b865ecf34204c7ae31dee416.1542654209.git.gitgitgadget@gmail.com>
 <xmqqsgzw9syx.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <921606a2-3deb-2481-347a-6a2f5571ec9e@gmail.com>
Date:   Tue, 20 Nov 2018 13:45:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <xmqqsgzw9syx.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20/2018 1:13 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> @@ -3143,6 +3144,9 @@ int prepare_revision_walk(struct rev_info *revs)
>>   		commit_list_sort_by_date(&revs->commits);
>>   	if (revs->no_walk)
>>   		return 0;
>> +	if (revs->limited &&
>> +	    git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
>> +		revs->limited = 0;
>>   	if (revs->limited) {
>>   		if (limit_list(revs) < 0)
>>   			return -1;
> That is equivalent to say
>
> 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
> 		revs->limited = 0;

Not exactly equivalent, because we can use short-circuiting to avoid the 
git_env_bool check, but I see what you mean.

> Wouldn't that make the codepath that involves limit_list()
> completely unreachable while testing, though?

Testing with GIT_TEST_COMMIT_GRAPH=0 would still hit limit_list(). Both 
modes are important to test (for instance, to ensure we still have 
correct behavior without a commit-graph file).

> The title only mentions "topo-order" logic, but the topo-order is
> not the only reason why limited bit can be set, is it?  When showing
> merges, simplifying merges, or post-processing to show ancestry
> path, or showing a bottom-limited revision range, the limited bit is
> automatically set because all of these depend on first calling
> limit_list() and then postprocessing its result.  Doesn't it hurt
> these cases to unconditionally drop limited bit?

You're right that we only want to do this in the topo-order case, so 
perhaps the diff should instead be:

  	if (revs->no_walk)
  		return 0;
+	if (revs->topo_order &&
+	    git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
+		revs->limited = 0;
  	if (revs->limited) {
  		if (limit_list(revs) < 0)
  			return -1;

Thanks,
-Stolee

