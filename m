Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148B16C440
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183394; cv=none; b=QxQZKhK5c9pDhjIkhbTLAh53Qd4O+mUVB3Rf4s7GSGNtRDLnhzsz19CSpwqe0AeYqrSuQkXnI4cUXVb/rU/ERNxOwMP0lju/CgtXHV27Gv3cyb/Yi01ehNfU/BM1+0KxdmlPiUp7BdntttYUtFErNylkApI+eX9o7yu2/i4FgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183394; c=relaxed/simple;
	bh=oYJ/S+Te51QfMStP7GIaGU7MzLxpU6Im3MWNh6MHqKs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RK13kbD6AXrDo61pTREbpSjiurEGFQPHJQl0TwMRf1huxDmo0+JEiITHJm9ieByZutWwHDovaU0HV0FBGzuVUrlNEvtBMgawu3kcGsfSNbXDBBnyv45idmBixgytdxYI72Ky451JUJqpM/Fq+W6UHDdW7LTMj02Pxyzu81xSpnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK8+6+Ki; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK8+6+Ki"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f223e7691so414499f8f.1
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 02:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718183391; x=1718788191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g4sfGo3Zmtqt7kdNQdQmig7cswYAQ8CEbRSdJq9LwuI=;
        b=lK8+6+Ki5fihIc7hXuXTlFXgY8lcnI74j+BazdabS79AxKCZn4a71FkvJNN6+abGHm
         0x+CIVgR2NDWr8Ui2qV8O3AXZFS75zjBwSp/ICk0RnDNy3IOMA1Eot/376Nh21UVSwjv
         3ysHGhEDulfvRlBSGfeMggfZoiH0Ah4AD897T3ZTjJqIwOvGPbsQfi+LPPCcajPkDlKz
         taKBZBml5A+/893ZMV66i0xhpxMvZJCVr6GmO810SoAqMBaVTuL+pD2NDgQ+NYUp2xng
         2ta5VqIRTEzEvNANcRYVRyIRJts8glyVwGDrxPO5TPq/9rilJSOqEk35yYiCiB6GtG2e
         k1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718183391; x=1718788191;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4sfGo3Zmtqt7kdNQdQmig7cswYAQ8CEbRSdJq9LwuI=;
        b=v1oHODwwNEy/VP3BcaG0MLF55kOIClc6Vrzjc18E67rk/YGeWF8UZiT08IcZoxLs6M
         Amdb0ctQ69LClYe3Ps7nImfxvTdTQ8aXqVXrC9XD8h4W8QYVFJvvCQhuV3lnd9zNwNIy
         yf8FER39d3ysrTCOzhaGCd0gqNn7dLdGVgp+PaG0dRLnPC6Z0fUTfRYE6s3pCyPo3O//
         vFLyFJwKEY3LG6oOBXjRsLIe37khCsM823dIuvmDUJGfqmTYFkWwan1pBgAv2I5yyFw0
         cLJm4q6gRbIINzTYMv5odG20cvWv0tX7K1gjWHWjRyWKW8m7u57TUtljoMsltsaT8tVz
         5q7g==
X-Forwarded-Encrypted: i=1; AJvYcCUZTdlu/0/5IWSUJ3F2AMhb8qVTPrWo0Gqh6OdyMbSDF/gbZXhgTzh+TxxFlH30ETW6AzJyPWZxcVWhE5XO1punaZMy
X-Gm-Message-State: AOJu0YyR1YjT/uJIevwAJZIBsx1jpzrx1gbpTQ0htmThkIWiLi3/8Lws
	8UcVG00aHfbeUvKIL8zGxXHxbHKgFmE6bCHg6N59ooD1MCGL98Q1
X-Google-Smtp-Source: AGHT+IHuKMsSoXmUvTRssiuG1F5EqWroTvN5FqAfd0Aik52hX3bxfqeXrKRTRXewHostjSPoNOMzSw==
X-Received: by 2002:a05:6000:1882:b0:360:6fa6:60c5 with SMTP id ffacd0b85a97d-3606fa66446mr358014f8f.10.1718183390947;
        Wed, 12 Jun 2024 02:09:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f26857582sm6732303f8f.77.2024.06.12.02.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 02:09:50 -0700 (PDT)
Message-ID: <7b62e733-0816-43be-a1b2-4d7d288ec6ee@gmail.com>
Date: Wed, 12 Jun 2024 10:09:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 00/29] Memory leak fixes (pt.2)
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
References: <cover.1717402439.git.ps@pks.im> <cover.1718095906.git.ps@pks.im>
Content-Language: en-US
In-Reply-To: <cover.1718095906.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 11/06/2024 10:19, Patrick Steinhardt wrote:
> Hi,
> 
> this is the second version of my patch series that fixes various memory
> leaks in our codebase.
> 
> 20:  48bcd0ac80 ! 20:  144eb23617 sequencer: fix leaking string buffer in `commit_staged_changes()`
>      @@ sequencer.c: static int commit_staged_changes(struct repository *r,
>        			/*
>        			 * If a fixup/squash in a fixup/squash chain failed, the
>       @@ sequencer.c: static int commit_staged_changes(struct repository *r,
>      + 				 * We need to update the squash message to skip
>      + 				 * the latest commit message.
>      + 				 */
>      +-				int res = 0;
>      + 				struct commit *commit;
>      + 				const char *msg;
>        				const char *path = rebase_path_squash_msg();
>        				const char *encoding = get_commit_output_encoding();
>        
>      @@ sequencer.c: static int commit_staged_changes(struct repository *r,
>        
>        				p = repo_logmsg_reencode(r, commit, NULL, encoding);
>        				if (!p)  {
>      -@@ sequencer.c: static int commit_staged_changes(struct repository *r,
>      +-					res = error(_("could not parse commit %s"),
>      ++					ret = error(_("could not parse commit %s"),
>      + 						    oid_to_hex(&commit->object.oid));
>      + 					goto unuse_commit_buffer;
>      + 				}
>      + 				find_commit_subject(p, &msg);
>      + 				if (write_message(msg, strlen(msg), path, 0)) {
>      +-					res = error(_("could not write file: "
>      ++					ret = error(_("could not write file: "
>      + 						       "'%s'"), path);
>      + 					goto unuse_commit_buffer;
>        				}
>      ++
>      ++				ret = 0;
>      ++
>        			unuse_commit_buffer:
>        				repo_unuse_commit_buffer(r, commit, p);
>       -				if (res)
>       -					return res;
>      -+				if (res) {
>      -+					ret = res;
>      ++				if (ret)
>       +					goto out;
>      -+				}
>        			}
>        		}

This looks good, thanks for tweaking it

Best Wishes

Phillip
