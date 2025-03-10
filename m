Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8B1DE2DF
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641070; cv=none; b=IGxfQTimpszKeD8UoyRuzxWF79/CL12X7y8D6+y+VsTkwYZ29aYKDDSUckYzh9b7yAAd+d2KmgdjPS9oAqlD/6UUKbfrnE1K6140M+aQeMwnNfNmHAM/pUiPx4+q5/JQD0iysdt8spxWpC78LOv2A1RxBQFOP7sVR/i/jJjHEns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641070; c=relaxed/simple;
	bh=kr7uTty0JEsixAEUnbG10JGg0s528XuyW8vREEEF/Js=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8j7zLdOD+eZzNpH6IRay/ft70ZNHyqcOS4nJvuGxr+xhE6S1SrZlcyTvR7579hgjI7+B7S8DqT50B5AYtIjevr2AjwBpJ9ej4x+Iq2CDiFdHaOhvgr0d/l0zTEaxBaXtHp+wbNBNW91RRVsAGJ/HQd78TflxDvgzKhwX3089go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKTn95IU; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKTn95IU"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86d30c329f2so4678698241.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741641067; x=1742245867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wR5Ayo5Hk3jyELLCT//rNRbdVTR6/eUWwx0fUj/FF6g=;
        b=jKTn95IUuZal/BvITguANxBPmXsSIJBLVeoWioujCjfxOWVLdtntanua6DI/EniF39
         UHJwl8VzsbbXJQ7ffIUNAWIzGdMWou6+5mzUR+U/D7xZoo479z3JySbCNDPU0/+Nz6xm
         g44a3iarFhsHB501ui1Jv4EhCsb/tZMfWoNE0W/hID+MuyJex59kQcLElXcXZ+7My1/o
         0xppgd0KaL1FqVbWARjyECRt3XDKvSLW/qsIKVJsE0gcYKm8fhKvqjWacoxXNYnldWF9
         SSdcIUhuYNzLBoT1bobkT10jiRLDo6SOynwEmFIcxIogsFkM4HYfUW3Lu4aKXIbIhn2D
         FC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741641067; x=1742245867;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wR5Ayo5Hk3jyELLCT//rNRbdVTR6/eUWwx0fUj/FF6g=;
        b=JWUouTXdggTYBh3/2AeDjKG6ADeNzF2reeIL1RO0zt4W2qBr2qtiZyp/P6/CWEeaRg
         YOddStiW1WgQy5gtqxI0roPDXwQaaIPeuMS/D6Y/ztIw1IZVdWOOR5Tnx6NxBBhdMJIA
         bgjW7RZG7E2VZ6xOZ0ZGu5Ct3WFgjcvCWt7FRxnzYJ5MuBnep7+WRy05I391dPVBnL7q
         mNQEYboxI8ArZ9chKUOC2riE2IiAfSijTYL78s0RXT+GT54ey6pPMkwnxjrKxw9psOxV
         Lv6wD5fKes3wfZ1tLdmQBTM+361pmFybygJho5VJWCuWg+Cfmr/FQHPeiCmrPY49sKL0
         g33g==
X-Gm-Message-State: AOJu0Yw9prSOgJ8TGuM2SphhKSTJ6ylRHGBySUj630nnHb2lOs9PQpyh
	kr/SIGkp/lTZjbmIvcTfrqwUqCo5vg6jOCr+WtBeH38ZHJHrIutwiRFQ6xExtlvbniqhVlInh+N
	PkpFIc33ChN0eJ1W3q1AXGs8dduld4aWr
X-Gm-Gg: ASbGnctIBQaWK0qp7DuugHAjHPqGNcbgmnwPvF2FDERIW8rNoLzSuQT4uDGCb+d1mM4
	M7rhL4XDs7O1VitNfPKNwq4dnk+61K/OPQ4bvmit9UwZzQ38JiNr27wp1U1wel+t9gNhyeWLHta
	8S/iXWh8gIygk1+D3+ERGizZRxwGiN+PT33R5gNA1ggHhugJYkobuiohQib5Dw
X-Google-Smtp-Source: AGHT+IF20UxHiAbCT9PCnC/PrC0sKxGHrvvewr9lAFLkaidIP3fs/XZQ5PnpJ+R5aWhqlp5txPRyEpX4eFTIPhvRHnk=
X-Received: by 2002:a05:6102:50a6:b0:4c2:fd52:c2c4 with SMTP id
 ada2fe7eead31-4c34de04a6amr757619137.12.1741641067383; Mon, 10 Mar 2025
 14:11:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 16:11:06 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250310151048.69825-2-ayu.chandekar@gmail.com>
References: <20250309153321.254844-1-ayu.chandekar@gmail.com>
 <20250310151048.69825-1-ayu.chandekar@gmail.com> <20250310151048.69825-2-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 16:11:06 -0500
X-Gm-Features: AQ5f1Jpsnnp9DyDEIVtqdMsxzWZWtNChI2ArmgcEghi_M0RwDdiJwilwb6ENDts
Message-ID: <CAOLa=ZSqgzLv=X9=7kFFeA+w_PsPwYz6iJyeqW=i4yrrszURBg@mail.gmail.com>
Subject: Re: [GSOC PATCH v2 1/2] environment: move access to
 "core.attributesfile" into repo settings
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000025e8b80630036906"

--00000000000025e8b80630036906
Content-Type: text/plain; charset="UTF-8"

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

[snip]

> diff --git a/repo-settings.h b/repo-settings.h
> index ddc11967e0..58dadd9dae 100644
> --- a/repo-settings.h
> +++ b/repo-settings.h
> @@ -66,6 +66,7 @@ struct repo_settings {
>  	size_t packed_git_limit;
>
>  	char *hooks_path;
> +	char *git_attributes_file;
>  };
>  #define REPO_SETTINGS_INIT { \
>  	.shared_repository = -1, \
> @@ -92,5 +93,7 @@ const char *repo_settings_get_hooks_path(struct repository *repo);
>  int repo_settings_get_shared_repository(struct repository *repo);
>  void repo_settings_set_shared_repository(struct repository *repo, int value);
>  void repo_settings_reset_shared_repository(struct repository *repo);
> +/* Read the value for "core.attributesfile". */

Nit: Shouldn't we also mention that we default to
`xdg_config_home("attributes")` if the 'core.attributesfile' value isn't
available?

> +const char *repo_settings_get_attributesfile_path(struct repository *repo);
>
>  #endif /* REPO_SETTINGS_H */
> --
> 2.48.GIT

--00000000000025e8b80630036906
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1cb6f3ad7eb14f4a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mUFZXa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1BOREFDQjhzaDZpTlMyQTNDSUMrakN0eG9vZjZkVQo1bEhtZHQwNTJP
Z3Y1cGxGUUhqbkx5bzBRdmZWYXVWbDJrVXFlcVBjbEpkUmhOMisxMktYcXdEQmp4NnFDNE9WClBF
N1BNbVhQRkc2cXd0OWtkQnpBZVNkN0ZEbzl5cTNBNjFLN25SUnQ2eWFpWEJoMmxMNjE0T0o0Z1Z1
cmNNM3QKUllmQzZUOVVSZmwxaWVESDBPaTNRYU5MOHFmRkJDWHkzZnQ4YTFaVmF4N25mR1pQcHBP
bnZGQ3NwMkpNU2N6cAo2OTkxeFpkZGF0eXZmMmVZanRtb3RKNmttWmFIWXJ2QXd2M1dIeXRHbG9s
T0VFM0U4QnNxUWkvQ3dKbFl3TDRlCmd3bkh5MFR2SFRCMVY2RUMwMGF0eWczc3NRc1VnRFc1eGNu
L2tDRXpNc1F0d2lzYW5VREtuVis1YnRTcEFpcHEKSmk0bFFFMGVjc3hHWFl6NnhLWDF3ZkQ4RmNF
U0h0a0g2eHNqSzIvR1Z3TmZGUXBTR3dhc1NaeEY3WDl0Y0xGVQpRd1FIdStkTnltL2hzTEtGQ1Uw
bEdGZW5MR3VYc01lRnJxcmljUXZBRnJacldmS2M5OXQxMGpCcHBXdzZPeG9iCjBBbGticWZKb1lQ
Vy9LVjlDZ1gxcklKN2tGYnZONTdjRUtoL1pkRT0KPUQ4WkcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000025e8b80630036906--
