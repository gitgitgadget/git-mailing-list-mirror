Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6A137758
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228046; cv=none; b=mamCCQmrJmn8FykkiTcmB1ZHxOX70ansVMxg/UJ8Z2W5e7o5eGglsczw89cDDmCDVoRh76CaV4TaMAolwt7wfHAA0IT0YEu5qZlNP90zwApR712Sl21goVebgPf9kLIlB8kmPE6SgXE8uoi5cbIGE2DXW71q5xWyRQz/IGpXR3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228046; c=relaxed/simple;
	bh=xGXz3T9oD0vhbeDIepvOB20GVcGPDUh4wajuKUkrmCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TI+wEBBSAGsqPYcuR0kBUGfRGU6L9ChMr7XF6Sn1UKcRcmSmL+lDYJ4MzL92/6ZF0KqyN9Sh6ISP+fpjdmwCTcbQ/f6iaxmokFuEvrNaIiVBWjI5hI2MxeOkEd2nmr/fTFHE7VWk2M9y7MqnIffjNcgCLIkcwQ8Ov6GzhWMwiyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTLib/vi; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTLib/vi"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5295eb47b48so4934863e87.1
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719228043; x=1719832843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jHx/WXpOuSuUKxF+8uwrxnkGVx0AYsoHg0RjScaGeVg=;
        b=KTLib/vin4AMdE9zc9gzJq2TxQWdRXkhK+d8ojitWQIP3Xex3juHAsB3PKRlpwVk+l
         eAsQyd7iAAojGpElse0SfOwjL5sFTmLIfsI3cstvgPIa9Fk7f7AEurpCEk7YG6Md7PyJ
         D0m7cna0UKfmldKNDfQ51wMXY3yVbemjKYq1iqvl0smLjKokey8RFZ9zK9UY60BiE18k
         706Bo26Z6FWybRYn39RSSV98D/RqgYt85Y8YE9zR42Jkg9xzT+EB0rFkgKiN9Kl1nEUX
         RkdmzOzddTDONiOFoPqLR+0HZhlXRXbE/NlmUuGfslzt048ILxZSDzg26iaTW+yVWYqX
         kchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228043; x=1719832843;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHx/WXpOuSuUKxF+8uwrxnkGVx0AYsoHg0RjScaGeVg=;
        b=T5FJ644DbWOGmELbgQLGbMxcJTYW/wDJnUi+RS4OUGVKxiJrmJp8pF7sqnfZIlsWyr
         WT45dK07Z1O/rrcBWB4MiwY9aTd1cA/NJ9GVeO7mBjVGK0gUhCkZdqVSkZXDTTu0hOKp
         geUdcYAthOPf471vRPu+eoLnpxhsakDIp3rKQ5zGqc6TLs7JuoJr/36km0jbZOEc8ENo
         wWGwU2wjTWXEeLNnmmCbFoi50zCPnCyYHnXJj+8jX+iai3XA1oOvr1G7TcW/6W9LJCjI
         roBvlrscjrLaNJkAOmL9jhTklJW/Cjscp5a6QbzDE0gKR0paIPPdfVawzDFrjY+8hUr3
         /mPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuRzkv8fQ3jF0f1Nbw2FNcyDMt4ym7y4oP65yL4g0RXC3IRv0JENwM3cBKVrEDt5U/HOz+oKSjKMQBBV1Oe2qAPq2i
X-Gm-Message-State: AOJu0Yz0a3hw/NLohQ/INFz6N8KWo7XVZF7cFBEOt8oCBmur5kW9IDeV
	CDa+ytEVgRwuiJquPj09L+qE9pEa0njbTYta7vupUt5JN5JDf3Nj
X-Google-Smtp-Source: AGHT+IGBpoeBdRvrBt5vQOehJ9Uu128QJ+UL1WtO125tDSSF121xMp5APwcvtLhsJSe5MeIpg11Cew==
X-Received: by 2002:a05:6512:2827:b0:52b:c296:902a with SMTP id 2adb3069b0e04-52ce0610642mr4104915e87.5.1719228042684;
        Mon, 24 Jun 2024 04:20:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3666dc46d50sm9428135f8f.67.2024.06.24.04.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 04:20:42 -0700 (PDT)
Message-ID: <054c6ac1-4714-4600-afa5-7e9b6e9b0e72@gmail.com>
Date: Mon, 24 Jun 2024 12:20:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] describe: refresh the index when 'broken' flag is used
To: Karthik Nayak <karthik.188@gmail.com>,
 Abhijeet Sonar <abhijeet.nkt@gmail.com>, git@vger.kernel.org
Cc: Paul Millar <paul.millar@desy.de>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
References: <20240623214301.143796-1-abhijeet.nkt@gmail.com>
 <CAOLa=ZRGramQ3MdzzXzZ19yeUB_rQZPbZ3u=eA=T2SfV3nhYOA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZRGramQ3MdzzXzZ19yeUB_rQZPbZ3u=eA=T2SfV3nhYOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Abhijeet and Karthik

On 24/06/2024 11:56, Karthik Nayak wrote:
> Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:
> 
>> When describe is run with 'dirty' flag, we refresh the index
>> to make sure it is in sync with the filesystem before
>> determining if the working tree is dirty.  However, this is
>> not done for the codepath where the 'broken' flag is used.
>>
>> This causes `git describe --broken --dirty` to false
>> positively report the worktree being dirty.  Refreshing the
>> index before running diff-index fixes the problem.

This is a good description of the problem the patch fixes.

>> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
>> Reported-by: Paul Millar <paul.millar@desy.de>
>> Suggested-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>   builtin/describe.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/builtin/describe.c b/builtin/describe.c
>> index e5287eddf2..2b443c155e 100644
>> --- a/builtin/describe.c
>> +++ b/builtin/describe.c
>> @@ -645,6 +645,20 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>>   	if (argc == 0) {
>>   		if (broken) {
>>   			struct child_process cp = CHILD_PROCESS_INIT;
>> +			struct lock_file index_lock = LOCK_INIT;
>> +			int fd;
>> +
>> +			setup_work_tree();
>> +			prepare_repo_settings(the_repository);
>> +			repo_read_index(the_repository);
>> +			refresh_index(the_repository->index, REFRESH_QUIET|REFRESH_UNMERGED,
>> +				      NULL, NULL, NULL);
>> +			fd = repo_hold_locked_index(the_repository,
>> +						    &index_lock, 0);
>> +			if (0 <= fd)
>> +				repo_update_index_if_able(the_repository, &index_lock);
>> +

As we're dealing with a repository that might be broken I suspect we'd 
be better to run "git update-index --unmerged -q --refresh" as a 
subprocess in the same way that we run "git diff-index" so that "git 
describe --broken" does not die if the index cannot be refreshed.

> I'm wondering why this needs to be done, as I can see, when we use the
> '--broken' flag, we create a child process to run `git diff-index
> --quiet HEAD`. As such, we shouldn't have to refresh the index here.

"git diff-index" and "git diff-files" do not refresh the index. This is 
by design so that a script can refresh the index once and run "git 
diff-index" several times without wasting time updating the index each time.

> Also apart from that, we should add a test to capture the changes.

That would be nice

Best Wishes

Phillip


>>   			cp.git_cmd = 1;
>>   			cp.no_stdin = 1;
>> --
>> 2.45.GIT
