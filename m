Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8535CEB3
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607714; cv=none; b=F7AnQVr8eyg9Csy0GZqT/IWf2n7axfIFSMPgQ/GDbxriyjWYkJ6lP6Q4X8kuxcxokntuw+MQ3nzS35ack/hqaDFfhOsuTa8bF6H5ZgCI5PV9p+IFq6I27Yta2DlnmGrMIwm/BZYpuzbB0hGQcz0+rtAhk7ICaBlO5J9rIG7yuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607714; c=relaxed/simple;
	bh=Cyf6e9Emh1wTOeCP9WJl3VOekdLJCt/h6M74f7WQ3sc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oBT/0CX2n5XXOT64VzA5AqhlDVtzKE+qVnA9TCB6y8lA5uPvI8Tel/9DTWbJWne2J4Yc27HdNLh5P+8r7r2HFXWqAI2yC2owouZIhjewdvg5x34XBw7EEpWGJ0kpiIw6Sm00HjjrLrGlT/RFIE/veOj+Vqw8QaR/+ir2WaE7730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMK8IegS; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMK8IegS"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-807e414be94so94098485a.1
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757607712; x=1758212512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nief4bxMvrlBQMTCcOnUGCQ9rRemPHmxKHD62UhMuEw=;
        b=FMK8IegS8lJCWK5uKPPGHOsBU2vPVEtD6LtQllmg3yOODTK7wBY30qnyCpuUSp13Nb
         wV5dC6vqOYnmKxVXKWX+dqsa0l/c9+kaEbM6XaAgf1Q4ROq73pyLW6f+1TImX+KhVRrY
         FeTgY5z8xM6C50tE6NNGFm4/sMrjjLE7tonBUTNLtxsXJUerYCOmxltCv5lIcWTYpSPQ
         J7jbwTGgfl5iyzgxur+pelg3DlJbiRZB4z4dGEyyxcYJOSXD9XjwPPWtx7nWTQzdjePw
         PxlBlwt5bJPVELxyNtmXJ8BX8mGfWsjkpAvgU2+a3ewjVvQlDfapypCo4CaSvMJFPxub
         L4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757607712; x=1758212512;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nief4bxMvrlBQMTCcOnUGCQ9rRemPHmxKHD62UhMuEw=;
        b=hyO/UeGmPl94BQiustMm5iB3CEbYuqpPOID/yG0dfyRnfjDcdj52IrT0qJNJbc47Jf
         Wb+T6V+jGzVcmKWBxhGZtpyqp1dv+MFuqZs3j8TWFFxcaX8MHbddQo+rGoq89AethQvI
         15uRdrue8tl9KE+snGCDGHrQVRb3FErst3oVzb7/gHuzQPVD8xldgceS3PyfnS2r/j0j
         43QY6daWlrti2U9CWVM7s3hcVR2YOeyE0yuEKETI2biabjQxamgIKrfk1xNS4IITUsi+
         muIzZhXVF9QVEeT8sjo267dS8l52aa2DrzFWpoCMztX4Y5YyqBhJsJe8dzBwOb7a6LAF
         6+Pg==
X-Gm-Message-State: AOJu0Yyz5NPH3yUuELeR/rZ+yiNvMJ77DIAnSfYLzJACWJWT7sXkXiRZ
	332PsVkgV+WlZo3AgqcjEMiETEx1ZT8M5fDSK+rVlAa/QyNDT/gQ8gdE
X-Gm-Gg: ASbGncu9Pchzio0rXMZgCAX3+pbV8KCCCWeZnjW/aMuDPwn+wHiYtOtcRVjzI5RKW8T
	31RfXlHivcbXt5JHzGNx/c6jL0CejS7W5987JPymIZXChpeFot3NDdHVGStPHRG12+GpahakvWx
	blsgsJ7Ox7at7NWLO+Gunx1XncVkGsnrqP8kdOZ91OwHdX9yWsEBYkM67JAytCM5u++DP535Jj2
	bWkzYVaAIeWxOqCGSbv/hP91sAphmE362U5NV/2nMOHmo+Fu269zMNXzRGTLWEGf2i+hdRKt1Oc
	npaAEF0QacCxXufw7UBjvMF2JcxeYILnOMiHEUcNbmUqdWeAviYSURJl84tmNcmL4421zR6n4RJ
	/NDlAej6QdLZIjnKUcdG4s3amiKUW+3BupLSejkI7vVtrY30bkPl5jwXffHCj4reRZzsjBaJl/c
	+i57hPsH0UCe7RKMZjno1zWcE=
X-Google-Smtp-Source: AGHT+IE0aGpaIvPATBRYY205b++yfA1GJP9Z89F7mggK50vUjzAlTaZ5UTvMxt3vJZLwIy1wphuEpw==
X-Received: by 2002:a05:620a:2a01:b0:7e8:46ff:baac with SMTP id af79cd13be357-813be24afefmr2211546085a.1.1757607711549;
        Thu, 11 Sep 2025 09:21:51 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:e181:657e:57d:cd88? ([2605:a601:a6de:d300:e181:657e:57d:cd88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cec300a4sm122299585a.57.2025.09.11.09.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 09:21:51 -0700 (PDT)
Message-ID: <ad8a0156-bfd8-4a6e-b196-6e591e536b8c@gmail.com>
Date: Thu, 11 Sep 2025 12:21:49 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] sparse-checkout: make 'clean' clear more files
From: Derrick Stolee <stolee@gmail.com>
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <82c24ce51980d85e1a53e746b462397e6e6c908a.1752716054.git.gitgitgadget@gmail.com>
 <CABPp-BHLcy-A4yLR8gP1Sjt_EKQ4K08kPyb7G6yifdZj+0MJNg@mail.gmail.com>
 <9b8d6c20-e91d-4ef6-9260-5016870f27c7@gmail.com>
Content-Language: en-US
In-Reply-To: <9b8d6c20-e91d-4ef6-9260-5016870f27c7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/25 11:26 AM, Derrick Stolee wrote:
> On 8/5/25 8:21 PM, Elijah Newren wrote:
>> On Wed, Jul 16, 2025 at 6:34 PM Derrick Stolee via GitGitGadget

>>>                  git sparse-checkout clean -f >out &&
>>> -               test_line_count = 0 out &&
>>> -               test_path_exists folder1/even/more/dirs/file &&
>>> -
>>> -               git sparse-checkout reapply &&
>>> -               test_path_is_missing folder1
>>> +               test_cmp expect out &&
>>> +               test_path_is_missing folder1 &&
>>> +               test_path_is_missing deep/deeper2
>>
>> Yes, but why does `git status` show folder1/even/more/dirs/file as
>> being locally deleted?  Does the code forget to update the
>> SKIP_WORKTREE status after clearing out the files?
> 
> This is an interesting quirk about how "git add --sparse <path>"
> works, which is to remove the SKIP_WORKTREE bit. It's further
> interesting that the file is still being "tracked as a deletion"
> while also being "collapsed to a sparse directory".
> 
> By expanding the earlier test cases to include these post-clean
> statuses, we can see that this change is causing this new view
> of a deleted file. I will see what I can do to determine exactly
> what's different this time and how we can minimize that
> strangeness (or: consider dropping this patch).

I'm coming to the conclusion that I should drop this patch
for now and consider this more aggressive cleaning mechanism
for a later update.

The strangest part of what's going on here is that the in-
memory sparse index collapses the folder2/ entry but an on-
disk sparse index does not in this state. That's what's
leading to this deleted entry.

I think the unpack_trees_options values are involved, but a
few experiments led to no change in my tests.

(With that, I have a v3 nearly ready, but I'll wait a day to
see if feedback on top of my comments causes me to rethink
anything.)

Thanks,
-Stolee

