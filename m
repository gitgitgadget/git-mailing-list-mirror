Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB3AC54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 14:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1394620736
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 14:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL9a6Nza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgDXOey (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726872AbgDXOex (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 10:34:53 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D32C09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 07:34:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j4so10274898qkc.11
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wE98oryLsklbOnB7XrxdQ2bBqaGBkePXRN6p3rWgcKI=;
        b=IL9a6NzaDJLnJOsELHxaFyZjd3VkYAqkYxAmGc9GGeXveFmxvEE5yU/CRehUXZsPMv
         zKC5liWOJn0f32+/4WyDGgd+hOH/q4m3hEb7JQ7S4H3jN3tUtovLxjUQo6GG5BIl5akA
         hC3lHmaGsH9bypgymkDvtDZxBWijpGubPH5fAUqo+ZDrlR1pd5XbJcZZJ0QTsXbzEDdB
         XrybaqYMj1QD3B5RL15bZ61bNvsc3Q9rRlC9xm+4HJ7nSk8Q6aSI5hlV5R+zdpkhSU1+
         O/9sJnuvrvnE4/fkQ0ckncQe1quUmqyoRT6HZM2LZzH6g7XbQLboUo2nII/2HyBPNOWr
         /TEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wE98oryLsklbOnB7XrxdQ2bBqaGBkePXRN6p3rWgcKI=;
        b=Pg6firlI2GzwTUmfLspZQKbw5ZgJ9hkLNiUqJ4qHFnHtQ01qvndr1WwvUPCyb4lcly
         v7fg8ubVPnnnJSt8i2CUK7fuouhlaTI0ecZOLKu5kRfzWN2TyqiY5PKF6DcUOLbWCa6k
         EmeriuvIC95KpyqdOoFX/OfUmFdxaD4/DfnLrSRix5SAmH5LOLl7nZG/3151hkf6x/hz
         L1WFBpTlMrFz6f6NGDE8szk0F7PL0p/ymlqRnrqHhmZD7j9vk8JtwFeiXCbs2Ks7SnE9
         oOS9xYMH9NH53uGGnZSmdIAX1+D7VzUPiR4/VR4Im2LMe/mmN9dOH0c+eeWUZL7DC6w9
         szuQ==
X-Gm-Message-State: AGi0PuZGQwbBqDyG1qs0jIh0KR0150PHLg+JIKIckieSFRUaJou/Ia83
        xqwVwFkRomD8R8x+ruV3dNuloXeV
X-Google-Smtp-Source: APiQypIP25AOux3dEOp4MqpMCpFCEEA+KFOlJQparvs6Gltfm6SmyktbszZnu63N1CWFSjrsypmsvg==
X-Received: by 2002:a37:a0c7:: with SMTP id j190mr8736577qke.461.1587738892574;
        Fri, 24 Apr 2020 07:34:52 -0700 (PDT)
Received: from mbp.home ([2804:f1c:7300:de00:d93e:c2fa:f7a:8a1f])
        by smtp.gmail.com with ESMTPSA id s15sm4136840qtc.31.2020.04.24.07.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 07:34:51 -0700 (PDT)
Subject: Re: Commit change disappeared from repository
To:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
References: <7b4f2b10-e80d-d4af-6154-6665e37da623@FreeBSD.org>
 <7dec4168-9eed-7f89-e33c-db0b50157407@gmail.com>
From:   Renato Botelho <garga@FreeBSD.org>
Autocrypt: addr=garga@FreeBSD.org; keydata=
 mQENBFn4ZqUBCACxJRWi57JkmsCrSU0gZd/CwB+B90OTUeXmF63lDPETOQ+pBA4+vJgzjW1C
 pv7rR25wxvESJKphxZJOOk9AXTXsg5QrhdP3+KQG/zNcKd2ukbt3ezkhdMx8q81wn4wY2oTl
 WXdGIVdDKvC8sCp1fc6pPKJin71/skb9wg6ThtlRFlv9en4f8QSVmRuzRKQ6VjCbl+yIpiye
 /I5BQ4I99uouPzPhzf9ya3cvp4xbiw5wSo1F3nLsThBT2osYy/nRNz2ciuCYyyX87dGhio0T
 8Pxl37eBbGQvCGwPQBApCcfoiZBN/5F65Tt4p72gIqT+AYuqq5G7Bhj+fGTC7q0QotL/ABEB
 AAG0LFJlbmF0byBCb3RlbGhvIChGcmVlQlNEKSA8Z2FyZ2FARnJlZUJTRC5vcmc+iQFXBBMB
 CgBBAhsDBQkFo5qABQsJCAcDBRUKCQgLBRYDAgEAAh4BAheAFiEExxiLNMqsn7yXmTy7W54E
 w5ZrhhoFAln4aeUCGQEACgkQW54Ew5ZrhhpTIwf+OS+Gv/ITOy7+8D+8SKXNmkfczsTO+Uqz
 6SraXcq32j1C4QcRQCwGPhVJJgKnFSvPm3kbNPFXaQh1zD+mTQ4r/Loc78Rz+fZljYcgNx7n
 aQKhd9pdpXaELOe+Y10jvGUrT0SE06Y10BP/NmQaLplt9qG8VgLAAB9ZcsuZ9pzbBbQjd9In
 OK5VcXQzHT/EBBQ1rHsl1Aq8TYdmjbKl+HKc1c8dJ5OfXrgnTIUwQdN1rauXbmH/YW/CKN7z
 zF59v/sPBTaWfFl2CS/BORhWhe1PBudrVZWFT0oJGNuG6k8dlnssoL/0ojFaN5w5xm8mvMAf
 uAuixGf4bK6C7hcE34D/ULkBDQRZ+GalAQgApiTibUM0OpeCcxf5YUep4F4y853ClU4TMqZO
 +ho38sz0GdshQWuBEBqahOtxapHUMtlmC+wJNCBAav5JYjHHrXXE9pgRm5EgVssDpMvplLB4
 5CFdx5jBu02Bt9Wp5bD21TPH3rsYJUB3rYmxWfVmdRhNBERrCJu49OIsBSKAlIinx8altYrh
 Z7bO2C1hKOG6QHWRr4ml4HTD/gZ6TTfsrR+sktBNv/5ZRkcJNDVM+eOGagXkEUOVFe9KXynD
 3KcZBbBKpwoaW5GK8OglKJt8ggUfc78CG1xk4b5nL8QCk0CBrC6VPPOYvXTpYSTHmx1QkElm
 1iNu1Tc5ccvcyAwTswARAQABiQE8BBgBCgAmFiEExxiLNMqsn7yXmTy7W54Ew5ZrhhoFAln4
 ZqUCGwwFCQWjmoAACgkQW54Ew5ZrhhoH3wf+KuIeDyvIJOui+0C5FD5r44Bwkj/SAUVUerfp
 0qtRktc+BZoSifPs3Rqjh/PpwRvLTuJnSsiqWLz8NCTThogRzVqEcQHqZR3vOjtYM60sjYJ+
 BGQl/bjm1C/YtWEEmKs7mJc+02U8qJA4rbNKSRRRoz6XngnuN6YC0fkeD7c7rxRhOg6OWasZ
 JinB9+dO1IH7eZ5c97v518qSaLRp0T7I+FpEGOp7tTFHaepZWEnuojr5D6jI1MOEywy0EWJu
 3m0TYlh935I8o7gLABqoHEmUeW7JK7r91SZaFnr8zQ6XOAxkPh50uFMTNtNZTnM7k1pRv5Ov
 fms0VzARITYzTwmpDQ==
Organization: FreeBSD
Message-ID: <21fa350c-37df-18b3-b577-2d2cb49b784d@FreeBSD.org>
Date:   Fri, 24 Apr 2020 11:34:49 -0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7dec4168-9eed-7f89-e33c-db0b50157407@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/04/20 10:21, Derrick Stolee wrote:
> On 4/23/2020 3:22 PM, Renato Botelho wrote:
>> Hello,
>>
>> I'm sending it here to devel list because after asking around at IRC and
>> also to friends we ended up with no reasonable explanation about what
>> happened, and it lead me to consider maybe it could be a bug (!?!?)
> 
> This is a common confusion with Git history. The best description of what
> is going on is [1], in my opinion.
> 
> [1] https://docs.microsoft.com/en-us/azure/devops/repos/git/git-log-history-simplification
> 
> There are other history options that will likely show the error.
> Specifically, run "git log --full-history --simplify-merges <path>" to
> do a full graph traversal and reduce the output as much as possible.
> 
> 99% of these cases are due to someone resolving a merge conflict incorrectly,
> and you'll find that merge with the "git log" command above.

Thank you for the explanation!

-- 
Renato Botelho
