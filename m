Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11215381A
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984077; cv=none; b=ZHj0pZRgr0FzIozCyDEdtzrhUP9Vo47eOakwP0zM9jTauscFMpNorGbjS9/7d/LTnWgc728kn9lBRLqb5k3Nv10F6wzwy102dvccc0wGJTWO9aFUytAVwtfnNumJ6yxn7Le7xD/lf58NqkC2diwgceKKDQuZrB/YE9UU/xhkrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984077; c=relaxed/simple;
	bh=WaUv7kRENGPJzoVHyJ4SNP/+6Ahn9iANetrAHY2yiMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YcZB3QWjDE1FkrYob5J6eWJZxCuycbN93X+KffgDIvCaNrnEmrZqXyjnBCuPDDeMzELwbPMKSZMxlEuysVVmziRhZy8Zfs3oVUOpJrqPlNgk3VJqVuOoZttnohoHBLJgIMev8VZD+MCDbhAVHurZ7Knu6JD0pIpbvV2+rBL5Bqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecIijy8n; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecIijy8n"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913d45a148so5393176f8f.3
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 03:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742984074; x=1743588874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRhNfbFpNIr2hZLDRh8m3Fo08xW0TzwJb2NOeL5T3L0=;
        b=ecIijy8nQlhIyWPB04mQMFsEFbZZNGnkKRyO0djaMe1lExdmYOozwpzbLvM8xB+qGy
         /g9+U01V0uKq+74XVbpkJLE1BivTKmeYQR5zU+Jx+1pqzpHk1CwPNWKh8KlbQomYOPu7
         UpJxZRzUepx7qs0CsDoh3Umx4tTMtks99upqgOWclKnQYbnjbc99KAxNCr2oMt6mbfBo
         ZUaPyezt3bAcLHvs6UT4FV2HMU9ftvJxLwx1a8sPrSjVjDEiMf5AmD7nWfZMYB5jiYzZ
         +W77ExfLltJ/R2LbmoMCUpQdzlxJFvFPlZe6h6CByhK3CJlJ0Y5FOR5o97Pa+8CbXZ8Z
         qhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742984074; x=1743588874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRhNfbFpNIr2hZLDRh8m3Fo08xW0TzwJb2NOeL5T3L0=;
        b=Pn1HpnVFD2i9ty1302tXAExXlcbm6ppmzSa3Z7qCHEQDweYCoeQgUMzw9TJF6UjL3M
         ce6a4t1iFySJWw+nLRl2huabwKM9nGHppjlVOSi8qtmlTPR1A5Zlk3pB4VTPcqyuUHYs
         sLtC4986iEASHmr+eDHqLp5LhVz3fY5W1dpjOJXMKdgCz6+J4hOLRz681VJtCgBOBYre
         9WYALDtuq2uX9nUVq2EzmgI4Q+dGQAnYLHWE+grHEhlOKu4eN1pnmSbLf8xphew6M1zr
         Ct8tjJvZuMZAdRUP5dC1wEgyOtMiVDmh58QFq2iCn32cfSgpLysZsUb9zekSG2g1QnHj
         5OzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX02Z0NNIGn/wmJqOhclR8TT50q72/nkBxi4/SLigXEKojoW7v9nrGCbSd4Zbiym7FEaBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPlsuXemaNggBsjw+3wiXwdyqs7KodLV8FJBnCc3VqDCCiTvyP
	PbY6cChmFp0QoWZGPsSVi0I9Uk0SRZKgk8rRkasytY/z2q0BV56bE5DJuw==
X-Gm-Gg: ASbGncv7hOJnJ8GulewtX01Vm0lDHDLzH1gJt+oaZuEt5By5ONoo+06VLb8JvXqvRUB
	mFGH6EueFkVIiD6xwQW1Vp+ZtLZZqqHilgWKsU/c/kBVh2Tp/TnIwlZe9/lSN7PMgjQZ4uR37hz
	vaFDWcdhMSpM2AguHT26uQ1dIil+4/V1WH0QYzrn/75VQGH3BvVkw8AuS5eYACUHvR3mMcYB+SH
	dofqoJSvOXrcdCZdQSzhOxEkx4vCrWEYJ/PINyl0NlY2KDz6zJnvbcIXhtSQioXXrRGL8jaU+E9
	Rqj38ThnCppoTNel5ARZVJgI9z+MKbu0jUioq4lZuGqJo0ksS/ECsn0dBPkL9IjnAoVMx2vU/sP
	e+nduL3NTkInGObxuvKXq
X-Google-Smtp-Source: AGHT+IEDSu1F0GHjGSCEVILwrcQEChdaGUUJuLPHE1aotHQ+JIYXDmIUjA+BYtDqwUAM7xxjhFpakw==
X-Received: by 2002:a5d:64af:0:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-3997f8f8321mr18147684f8f.1.1742984073911;
        Wed, 26 Mar 2025 03:14:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f995606sm16548361f8f.13.2025.03.26.03.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 03:14:33 -0700 (PDT)
Message-ID: <a7506e7b-f86f-426c-b816-540be282518b@gmail.com>
Date: Wed, 26 Mar 2025 10:14:32 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 07/10] wildmatch: explicitly mark intentional use of
 the comma operator
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Philip Oakley <philipoakley@iee.email>, Patrick Steinhardt <ps@pks.im>,
 Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
 <9a6de12b8076266fb0c88f6b658c20d37409ce13.1742945534.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <9a6de12b8076266fb0c88f6b658c20d37409ce13.1742945534.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 25/03/2025 23:32, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The alternative to using the comma operator would be to move those
> assignments from the condition into the loop body; In this particular
> case that would require the assignments to either be duplicated or to
> introduce and use a `goto` target before the assignments, though,
> because the loop body contains a `continue` for the case where a
> character class is found that starts with `[:` but does not end in `:]`
> (and the assignments should occur even when that code path is taken).

I think that would be clearer, something like the diff below

Best Wishes

Phillip

---- >8 ----

diff --git a/wildmatch.c b/wildmatch.c
index 8ea29141bd7..7230544c356 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -223,7 +223,7 @@
  						p_ch = '[';
  						if (t_ch == p_ch)
  							matched = 1;
-						continue;
+						goto next;
  					}
  					if (CC_EQ(s,i, "alnum")) {
  						if (ISALNUM(t_ch))
@@ -268,7 +268,10 @@
  					p_ch = 0; /* This makes "prev_ch" get set to 0. */
  				} else if (t_ch == p_ch)
  					matched = 1;
-			} while (prev_ch = p_ch, (p_ch = *++p) != ']');
+			next:
+				prev_ch = p_ch;
+				p_ch = *++p;
+			} while (p_ch != ']');
  			if (matched == negated ||
  			    ((flags & WM_PATHNAME) && t_ch == '/'))
  				return WM_NOMATCH;



Phillip> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   wildmatch.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/wildmatch.c b/wildmatch.c
> index 8ea29141bd7..ce8108a6d57 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -268,7 +268,7 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>   					p_ch = 0; /* This makes "prev_ch" get set to 0. */
>   				} else if (t_ch == p_ch)
>   					matched = 1;
> -			} while (prev_ch = p_ch, (p_ch = *++p) != ']');
> +			} while ((void)(prev_ch = p_ch), (p_ch = *++p) != ']');
>   			if (matched == negated ||
>   			    ((flags & WM_PATHNAME) && t_ch == '/'))
>   				return WM_NOMATCH;

