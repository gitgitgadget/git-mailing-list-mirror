Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29518EFD1
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 04:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749701979; cv=none; b=MJ6C4jq/+28TVCij5RMQFKjIplUtSoD9OlX8krRlUEqVU3zXQocXGlZVG5lJ7fawWa1/pX4/d3zQT7KzCBhRDnxJ15ZTyFUf3birEl2VvMMIGQHW/tbJIbXVg1Eo19OFhJAC+OiIfERayqKGnPsp+8ywLyYqnmSFcZhm793KX7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749701979; c=relaxed/simple;
	bh=UtH4FsilXFD85gILU5JwuO5Qxr8CBGMQr6KN4clxLN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bHBV/6tD6M29ONTAi8T7o96zv2eqna1slbrvNvItJNbwHu/2MC5UJC6/USdAjTAPixHIOps4Eywc1DSnCV9xUtzGC/lLC8lzBKpF8ZAfuNYUZNnbYSbOxgDIiXfq0L/hapbXnl/7I0QrjyXc5orVwm7fcQYI/fw3uZbj3DyEs4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fc8qxh0b; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc8qxh0b"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234bfe37cccso6808665ad.0
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 21:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749701977; x=1750306777; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OiCfLyX3J5VZdU2o1vRJ9C5EmdNLsosZQ9UBwnFhxZQ=;
        b=fc8qxh0bnu5dvTkhyKxkAvRCpXQ+a5Nu9Gcf6yXSvnsKNn8Llhx5iRrSr8t9FaIoPh
         4gB4VMqWt0/P7Rqj/Ymje3A77TqE311/1jxf1GrU8eyCBKcXNilrUadN0mMtWLE2Xg5C
         Cejld446tVX0pGnkc7eGfWqMoXA4wge3CRfq4ztVO1Waycdh1wlJx+I3Wbcwh+6+ZvNu
         ICYXF3X/70oATzi/K3dEnBQtBC7x/OHtlSjqq6piY4Z6e5/HYeFvrd8vnaqrD8mS27ZB
         1dxY1XU79PB6v576qRrInjtV0NrPDhkCykwCLUsO6NXKWXV2vYJqHajWvJsGs1wI3FGh
         L0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749701977; x=1750306777;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiCfLyX3J5VZdU2o1vRJ9C5EmdNLsosZQ9UBwnFhxZQ=;
        b=Wrx0f6TUUa6rKTWUJn38DqmQyg+73u0eU6WHBPQ/8inLeILNxqKeGBQMgEYoerDT3h
         jPw2hZph2om2hTj5yanj1n7cK4apECJuCYyUYN2deSsiA0LsNbXDChF69GkpLqqr0EJl
         E61hlJ33Orni8dCru3svY0lL4lcJm3RE44gBwH9FOAI4t5ecKhiqpnw3kNs7b9t6shD1
         twypf1/FP0zmgaS9PNIyCzzqYq9iDOVrhJ9YiL0jvrZE1ql3XqfYSW+Cvd1V5VixKSVn
         U+cZ5lNNcuXRoqlCyI6M8F3ScIirSWor4yhhvIvPCa04zQ5Wka1YQuJbI0UzRIH4lR9T
         KxNg==
X-Forwarded-Encrypted: i=1; AJvYcCXx1d+mJNs6+hKsWpIk1S0bth4HpHtbPQgdqqI20hIlJUPSmnaJe/Uq8FXbd1UOFM9knqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdVE14GLdbNd/ZHMOoObvkVeAefcFOKUzCYWOP6YzeIKRvgCjy
	UFokKBR3fhAEMU87eaOSUDdoz4pUqEE+fYtSVlMwj2HZTltAG8kjIteBVoJ6PQ==
X-Gm-Gg: ASbGncu2pzbB+vKcWSgkHkCN6C1ZpoMvk1RDWFHs/cF5fKBwdGGXM5SaVBQv3k5hHJ1
	5AzWeXjGK8a4jpJU5nS2kArZYdM7xQNkTOJbqpE8IBe3zNIgrpvmimy42I+anjrxxDSaNa0msFa
	fQzX895CML7wsEEcRB7hCQg3QdZlCo26GKdPb6V70xyN8spvA2cpE8w5lC+Z8l2XtGg97/ezxC4
	sBNtD02MKK6sSh5gXrhhTgKaZCMPgAx6uKiCUNDegMDF6wDY8pHgERJQlAXvBdpVLSQlHpWHdEj
	i7S88lM1nMniMuAkkd+RvWEoDhddrqHkbzv5dPwIVc8=
X-Google-Smtp-Source: AGHT+IHYFMq3sDf3NhbW59wXB5BLAQPnF4pAZPy/omHBrci0pVYHhVhZEm97W+rAucJYIShvaHTEMw==
X-Received: by 2002:a17:903:1b0c:b0:236:15b7:62f6 with SMTP id d9443c01a7336-2364ca864b8mr30926455ad.34.1749701977197;
        Wed, 11 Jun 2025 21:19:37 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::53de])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c4e3b9sm499815a91.29.2025.06.11.21.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 21:19:36 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Brad Smith <brad@comstyle.com>
Cc: Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org
Subject: Re: Solaris sed
In-Reply-To: <caaa5d54-d32d-40b3-9bf3-0f322e7c4316@comstyle.com>
References: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
	<xmqqo6utfvxu.fsf@gitster.g>
	<caaa5d54-d32d-40b3-9bf3-0f322e7c4316@comstyle.com>
Date: Wed, 11 Jun 2025 21:19:35 -0700
Message-ID: <874iwlegmg.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brad Smith <brad@comstyle.com> writes:

>> Totally untested patch follows.
>>
>>   GIT-VERSION-GEN        | 2 +-
>>   generate-configlist.sh | 8 ++++----
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git c/GIT-VERSION-GEN w/GIT-VERSION-GEN
>> index 208e91a17f..de989657fb 100755
>> --- c/GIT-VERSION-GEN
>> +++ w/GIT-VERSION-GEN
>> @@ -82,7 +82,7 @@ read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trail
>>   $(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
>>   EOF
>>   -REPLACED=$(printf "%s" "$INPUT" | sed -e
>> "s|@GIT_VERSION@|$GIT_VERSION|" \
>> +REPLACED=$(printf "%s\n" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
>>   	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
>>   	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
>>   	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
>> diff --git c/generate-configlist.sh w/generate-configlist.sh
>> index 9d2ad6165d..75c39ade20 100755
>> --- c/generate-configlist.sh
>> +++ w/generate-configlist.sh
>> @@ -13,16 +13,16 @@ print_config_list () {
>>   	cat <<EOF
>>   static const char *config_name_list[] = {
>>   EOF
>> -	sed -E '
>> -/^`?[a-zA-Z].*\..*`?::$/ {
>> +	sed -e '
>> +	/^`*[a-zA-Z].*\..*`*::$/ {
>>   	/deprecated/d;
>>   	s/::$//;
>>   	s/`//g;
>>   	s/^.*$/	"&",/;
>>   	p;};
>> -d' \
>> +	d' \
>>   	    "$SOURCE_DIR"/Documentation/*config.adoc \
>> -	    "$SOURCE_DIR"/Documentation/config/*.adoc|
>> +	    "$SOURCE_DIR"/Documentation/config/*.adoc |
>>   	sort
>>   	cat <<EOF
>>   	NULL,
>
>
> No errors or warnings after this is applied.

Likewise.

I checked on my Linux machine and both files are the same before and
after the patch. Before the patch on Solaris 10, the following is
generated:

    /* Automatically generated by generate-configlist.sh */
    
    
    static const char *config_name_list[] = {
            NULL,
    };

After the patch the output on Solaris is the same as on Linux.

So the patch is perfect.

Reviewed-by: Collin Funk <collin.funk1@gmail.com>

Collin
