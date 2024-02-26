Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EAE7F7F7
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976709; cv=none; b=KoczH5h8LQpszVuEWEQItLYjnRkIB+NXisNW6VRJewgf/cHqOD5AxypguiXvTOSGUQZ1l4/6fw8jnwVeOcO8Ev2RW+OxNlEEVCtYNZqLK4UjX7CfipHsudV3J0vCtpccYD3GF1PxIInlPMSSW8BB1h/fBigoXOaZzNGYd+mnFbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976709; c=relaxed/simple;
	bh=2H36Cf3CQqQO7WbynypLGWqLmRUGO/P9XXhkw4hUYhY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=J9y/4HSu/H3z8yJIj3HLd3F5LwvWBMieEIVW2JMz/qT4gpgPBKArPChC2aYx6wq2WhMXcpGED8use8QX+S5K8C5LaVK3L+IGDpSZvJ5vGMZHHdgR1mP7A+FAs0ocUPVLeNm2rwbxB5x0yLhWhryRVgDF7BByKuGhb+sWL6r1OaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuOl03N1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuOl03N1"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412a7b68809so7032445e9.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 11:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708976706; x=1709581506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uIpErFMwrWlDAkeVL+SVKjyvwpSkiC73sWlzRjSf3mc=;
        b=FuOl03N1V/XiDKY3GwFUZo33fl+l6mF+GEtaoHschYTQMUb61wX94QbJN4FglvM6bw
         lxw/UKRc+JVVHS8Aqe6gtkGHawjdkKcrYSLr57N97quFt+SmrzuLmvFjCiCS2pb4XbDg
         DMqaHK0jtHf/cdKyMfqjNbpjAjVsAK/hPMhP+17GwchCeV0l1pQvoiveSVYh9ZetTXbn
         lesJrdvFVMGu44yk5BXsdZviKo+wR6DdpQrnALkh3KJHKmMleQGAG9qTp2ZDGixiUABe
         rQiBcmSkolUMP4wggnkYWai9zrxr4NmtaFmJLUAXVatgdg4qoC/hsCQJXAPyl/p0tmZq
         WFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976706; x=1709581506;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIpErFMwrWlDAkeVL+SVKjyvwpSkiC73sWlzRjSf3mc=;
        b=uUlkVPptCJCe8FkZB9fk3+vIOMnhSzGksljhHPMiCKjgtgJYgCZgepW3+xV3kRBVNp
         fZZnlbC7SNzF75pIlF6ID7/hbxST0R87VinYP0IieZtnUyo+c0IQ+rAG4Oa9KaHr7SAi
         QsGYxQxprnMwQnRc6VtXFHhTkY5AQ8NBE9R8exXfd6Yd9GF/pDMNpcjPh/Mlw9SYXAO9
         WvqvRh+xREv7ORcQmIEXrJUTo2vRHtIRmiY20NVlHu5EUPXCAwgEkULv+TpjMWq9BYLU
         tAp/+mWDyL6kuuBS+/i5bK84tXJaJLL2832YMJVYe9mjaLFbImGUZPa4k8GqXOSfJFOP
         32Kg==
X-Gm-Message-State: AOJu0Yy5DG4ZKficE5+A/ck8chgDxJiBJjN3alS1cN0Oy+/I3fWZWAI1
	97yajSf+i6XRC/vVK4m4shTWQoUgg/oLemzxEjttXvE4k7U5CqJK
X-Google-Smtp-Source: AGHT+IFBLkL/EZm8hJtcp7pc2Z8tpWHlnCGOfUxAC9vK9Tf3vBwF5OKhWvet4QBRPLXLamrOUcR3Ng==
X-Received: by 2002:a05:6000:18c7:b0:33d:9c3d:f930 with SMTP id w7-20020a05600018c700b0033d9c3df930mr4709327wrq.66.1708976705469;
        Mon, 26 Feb 2024 11:45:05 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id az14-20020adfe18e000000b0033d2541b3e1sm9520094wrb.72.2024.02.26.11.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 11:45:05 -0800 (PST)
Message-ID: <1eba5cd0-67d1-461a-b525-05d2c1b8a55d@gmail.com>
Date: Mon, 26 Feb 2024 19:45:03 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
Content-Language: en-US
To: rsbecker@nexbridge.com, phillip.wood@dunelm.org.uk,
 =?UTF-8?Q?=27Torsten_B=C3=B6gershausen=27?= <tboegi@web.de>
Cc: git@vger.kernel.org, 'Patrick Steinhardt' <ps@pks.im>
References: <01bd01da681a$b8d70a70$2a851f50$@nexbridge.com>
 <01be01da681e$0c349090$249db1b0$@nexbridge.com>
 <20240225191954.GA28646@tb-raspi4>
 <01ca01da682a$5f6a7b60$1e3f7220$@nexbridge.com>
 <5e807c1c-20a0-407b-9fc2-acd38521ba45@gmail.com>
 <76962a0c-adfd-47a5-a017-a117ba14ae09@gmail.com>
 <025301da68e6$68956940$39c03bc0$@nexbridge.com>
In-Reply-To: <025301da68e6$68956940$39c03bc0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/02/2024 19:02, rsbecker@nexbridge.com wrote:
> On Monday, February 26, 2024 11:00 AM, Phillip Wood wrote:
>> On 26/02/2024 15:32, Phillip Wood wrote:
>>> Hi Randal
>>>
>>> [cc'ing Patrick for the reftable writer]
>>>
>>> On 25/02/2024 20:36, rsbecker@nexbridge.com wrote:
>>>> On Sunday, February 25, 2024 2:20 PM, Torsten Bögershausen wrote:
>>>>> On Sun, Feb 25, 2024 at 02:08:35PM -0500, rsbecker@nexbridge.com wrote:
>>>>>> On Sunday, February 25, 2024 1:45 PM, I wrote:
>>>>>>> To: git@vger.kernel.org
>>>>> But I think that this should be used:
>>>>> write_in_full()
>>>>
>>>> My mailer autocorrected, yes, xwrite. write_in_full() would be safe,
>>>> although a bit redundant since xwrite() does similar things and is
>>>> used by write_in_full().
>>>
>>> Note that unlike write_in_full(), xwrite() does not guarantee to write
>>> the whole buffer passed to it. In general unless a caller is writing a
>>> single byte or writing less than PIPE_BUF bytes to a pipe it should
>>> use write_in_full().
>>>
>>>> The question is which call is bad? The cruft stuff is relatively new
>>>> and I don't know the code.
>>
>> I should have been clearer that I do not think any of these calls are the likely
>> problem for the cruft pack code. I do think the reftable writers are worth looking at
>> though for git in general.
>>
>> For the cruft pack problem you might want to look for suspect xwrite() calls where
>> the caller does not handle a short write correctly for example under builtin/ we have
>>
>> builtin/index-pack.c:                   err = xwrite(1, input_buffer +
>> input_offset, input_len);
>> builtin/receive-pack.c:         xwrite(2, msg, sz);
>> builtin/repack.c:       xwrite(cmd->in, oid_to_hex(oid),
>> the_hash_algo->hexsz);
>> builtin/repack.c:       xwrite(cmd->in, "\n", 1);
>> builtin/unpack-objects.c:               int ret = xwrite(1, buffer +
>> offset, len);
>>
>> Best Wishes
>>
>> Phillip
>>
>>>>>> reftable/writer.c:              int n = w->write(w->write_arg,
>>>>>> zeroed,
>>>>>> w->pending_padding);
>>>>>> reftable/writer.c:      n = w->write(w->write_arg, data, len);
>>>
>>> Neither of these appear to check for short writes and
>>> reftable_fd_write() is a thin wrapper around write(). Maybe
>>> reftable_fd_write() should be using write_in_full()?
>>>
>>>>>> run-command.c:                  len = write(io->fd, io->u.out.buf,
>>>
>>> This call to write() looks correct as it is in the io pump loop.
>>>
>>>>>> t/helper/test-path-utils.c:                     if (write(1,
>>>>>> buffer,
>>>> count)
>>>>>> < 0) >>> t/helper/test-windows-named-pipe.c:             write(1,
>>>>>> buf, nbr);
>>>>>> t/helper/test-windows-named-pipe.c:             write(1, buf, nbr);
>>>
>>> In principle these all look like they are prone to short writes.
>>>
>>>>>> trace2/tr2_dst.c:       bytes = write(fd, buf_line->buf,
>>>>>> buf_line->len);
>>>
>>> This caller explicitly says it prefers short writes over retrying
> 
> Replacing xwrite with write_in_full  the above worked correctly. Do you want it or should I write this up?

I'm glad that worked for you. If you are able to write it up that would 
be great. There are some dodgy looking xwrite() calls outside builtin/ 
as well. It is probably worth checking the return value of 
write_in_full() when you do the conversion for the sites where we ignore 
errors at the moment.

Best Wishes

Phillip

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index a3a37bd215..f80b8d101a 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1571,7 +1571,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>                   * the last part of the input buffer to stdout.
>                   */
>                  while (input_len) {
> -                       err = xwrite(1, input_buffer + input_offset, input_len);
> +                       err = write_in_full(1, input_buffer + input_offset, input_len);
>                          if (err <= 0)
>                                  break;
>                          input_len -= err;
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index db65607485..4277c63d08 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -456,7 +456,7 @@ static void report_message(const char *prefix, const char *err, va_list params)
>          if (use_sideband)
>                  send_sideband(1, 2, msg, sz, use_sideband);
>          else
> -               xwrite(2, msg, sz);
> +               write_in_full(2, msg, sz);
>   }
> 
>   __attribute__((format (printf, 1, 2)))
> diff --git a/builtin/repack.c b/builtin/repack.c
> index ede36328a3..4916870992 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -314,8 +314,8 @@ static int write_oid(const struct object_id *oid,
>                          die(_("could not start pack-objects to repack promisor objects"));
>          }
> 
> -       xwrite(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz);
> -       xwrite(cmd->in, "\n", 1);
> +       write_in_full(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz);
> +       write_in_full(cmd->in, "\n", 1);
>          return 0;
>   }
> 
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index e0a701f2b3..6935c4574e 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -680,7 +680,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
> 
>          /* Write the last part of the buffer to stdout */
>          while (len) {
> -               int ret = xwrite(1, buffer + offset, len);
> +               int ret = write_in_full(1, buffer + offset, len);
>                  if (ret <= 0)
>                          break;
>                  len -= ret;
> 
> 
