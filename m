Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C786E1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 18:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbdAZS06 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:26:58 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33500 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754117AbdAZS05 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:26:57 -0500
Received: by mail-pf0-f179.google.com with SMTP id y143so67033156pfb.0
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 10:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=G61q9EWiURJ8YTo6BYBFz7k2edwC41ch7rX3jXCuO0c=;
        b=hofVHqrPDyduD2TQ7y5CjMvqMErayjMz4mBhZWDWSqfhz9Te5L+dY4hL0SvnOKPRyS
         baAQAQBlpvvdr971fOAHaLDIUg0JM8dLZNhkcQIT42D1qkzZTpwUpafUe4RBQ8PUAEf1
         EG59gIkfdECKlnMXkTPyfbwDvAt4+cOsYgOItGi4uhn4C/DrwO9Eu63zgWQNQGgQBu0B
         txHXhPu/00EfjCN0/8kcE7WuP7juXm9ruDPcYayeC68i7p4oKVwNdgI9uo4B5OVwQZ/O
         74MLeFByJcH8jJAPq8bGdFsobnWqJg1obKSQFhuiwM58KGlcSfYsbZAfJqHsLz0hntRW
         DRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=G61q9EWiURJ8YTo6BYBFz7k2edwC41ch7rX3jXCuO0c=;
        b=rDwIxrYVQGy2vYlq6YrOhXVgxNAjsmAumCPc6B9LLWInlzl7uS52pLUdgx7k3ZR/Rp
         EqQOd4MAW+VTTKkbkpf3FDadUNyCy0u6KwBdTYCKb8TXFMoxUSrLbY+re/lHCY8zHXgj
         Mec/Icy+o49d9071MahFB816kzHz0k2TDQKM+mK2SI0v9t7z1dhn9c6kWDheBQBDd36h
         8auMJDqWqHRh2HatQ2f+iVpD2xN2arAMreUI6z/QxUOWQHrzJ/8syKPvSNXWbqZc0P7G
         gyvolp+fNsqfxzIY/98H7Ox7vHg45BAaccqQkgaUDSaG0V+Bjq3bqyXs8maOOFyjEAVu
         z9fA==
X-Gm-Message-State: AIkVDXKqLTOr1NmBHjcemiEKjVVblE3UmQjKYVzUblDAal6XpBsfJCdmqQHgmupibibMaFuo
X-Received: by 10.84.217.68 with SMTP id e4mr5937295plj.99.1485454708469;
        Thu, 26 Jan 2017 10:18:28 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:f0de:f19e:2597:5e36])
        by smtp.gmail.com with ESMTPSA id u14sm5096478pfg.18.2017.01.26.10.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jan 2017 10:18:27 -0800 (PST)
Subject: Re: [RFC 12/14] fetch-pack: do not printf after closing stdout
To:     Stefan Beller <sbeller@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
 <db1db5d0e5563464c09d1678234c9c5e8ae5b2f4.1485381677.git.jonathantanmy@google.com>
 <CAGZ79kb+VVQoimCDCxk1JPtVdDcS0vgi3NgVfo_aZ_=feed8Cw@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <bcdeacb6-4517-b3de-cafe-27540dd4f7d0@google.com>
Date:   Thu, 26 Jan 2017 10:18:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kb+VVQoimCDCxk1JPtVdDcS0vgi3NgVfo_aZ_=feed8Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/25/2017 04:50 PM, Stefan Beller wrote:
> On Wed, Jan 25, 2017 at 2:03 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
>> In fetch-pack, during a stateless RPC, printf is invoked after stdout is
>> closed. Update the code to not do this, preserving the existing
>> behavior.
>
> This seems to me as if it could go as an independent
> bugfix(?) or refactoring as this seems to be unclear from the code?

The subsequent patches in this patch set are dependent on this patch, 
but it's true that this could be sent out on its own first.

I'm not sure if bugfix is the right word, since the existing behavior is 
correct (except perhaps that we rely on the fact that printf after 
closing stdout does effectively nothing).
