Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63B142E85
	for <git@vger.kernel.org>; Mon,  6 May 2024 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714996909; cv=none; b=GP1QO4T82o9xWpU5uBKZJrGMLcn6iO819xU437M+1hIrRilwyeZpEwXZe5RlB8aaqiSKfX/VQEVYplv/4GXlrtF/YMzE4Z3/Hzamh+1SjlUfQrmOOVtPm3PkLjNR701n52EbcegqPRnMrZSqFm0lcVgbXAscRmI1qV7BhTQPyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714996909; c=relaxed/simple;
	bh=K95ATOYXWIxd9JTMARND1pe4nmL7E/xLjcyqTig82Jo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5+WM8/oa9w7uCPSOW7tMTY0ix1lBVAk+f8/YrwYcaKPOgVWB2QZQU4FPJkrCvM7NkzXPf62rbBzzIDUPPDPMuiepE2VWBCEVlhwWTlBjlik3Ci2AV3buOybRtpKlFznRT52LHRjMr8W4Ue0/JHpiXrX7NGLVkPysGTLc7XN7Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZubNVwH; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZubNVwH"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c96be1ef20so527262b6e.1
        for <git@vger.kernel.org>; Mon, 06 May 2024 05:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714996907; x=1715601707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOqRHzaqFxevVRljKUY5Za5+fpGzx18eisz7is7g4os=;
        b=EZubNVwHINWDSUNoMAZkQXDZjGFJ3K6uY0voXY4SXasEswirkA965Xnw82AQ4thwaV
         9j7uQuc7EnCPkjZ4kS19HKNEWvDYY3Wg4gQXQse0d193bbh2Qc3oHw+rbsCUPeDdIfMV
         oHeLgoakx++hTr2WY0AK8DJPtk8ksWn+pDeXW9LvfPVjqcGB+qwByjk2eXVqOwjT5Fr5
         feKXfa6minAFLtGKped6LghQCyhTyZNZFgDabrX5KFNCLR62G+tVN1PIWKSyoQfXOzTz
         Om4XeBdlvCRuezyWtLqAl/tOxQa6XUct1BTev3N2U9YY6k37Gq1YX9q3dUX5H1+VI8/F
         wdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714996907; x=1715601707;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOqRHzaqFxevVRljKUY5Za5+fpGzx18eisz7is7g4os=;
        b=ouay7D5+OCylb7F3ThIsNEwVvmu8ZlaoJdIqICJnD4Ro0Z1rVNtO6Bq+o1dVF8ZwD/
         MOT6h+tMJRlskzKP8HUAEgGcCUlB3K5ik2+jJk/ngE7cHXmX9CMa24w2HhHfaa4U9QWG
         EeZCxVnuBbKqBsEeOwEgTDQ50CQ1eAncMpNoyAvJCQ/HsYrt4dpNqXM7p9fsyIsu9hU5
         uFN/QdGarJU3WPRGMSiPgwxHh4vRn/3LgyX7swcYNVpKW/4uLBG5EG2QVfPrjvrtL6mm
         aYVH1T7YS0QssNrcYMGYiMLdHRBiHPT+OUncHe/vB2pQupy/Qztdu0lmsywSDemHj13E
         FpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8+7w25+sFVeJLtiSRxrCGng0pJZGeSZCR1ngs7bwLk8qx1dLUC51kIkF6vQ0WBtlZygcicNeQoScNghfO8ckv4/5u
X-Gm-Message-State: AOJu0YwN1z8gCdfdSevw2Dvz1uL80dne//bHmrOVyTcpdWQnaAVqRpvi
	R8cl0vdKicDaMBAtXKjX9QRFZY0tGTkLd8gjqRR+Wj1o8/qSY63kXb9EiTPGa/3j9MvXs607JBS
	g3FNM7Go05bIH8cQTd6R5jI3zL4/ljA==
X-Google-Smtp-Source: AGHT+IFBSjYys0bD+TP0YKBsXPPN5kfKBoMYwRW191p0MqBwV8oTngAZ9m4l/sPhnDWmdtpf/2MVM/UCe4zbVYC1FdQ=
X-Received: by 2002:a05:6870:7249:b0:23e:619f:9c29 with SMTP id
 y9-20020a056870724900b0023e619f9c29mr11134374oaf.49.1714996906325; Mon, 06
 May 2024 05:01:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 May 2024 05:01:45 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.1668.git.git.1714802221671.gitgitgadget@gmail.com>
References: <pull.1668.git.git.1714802221671.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 May 2024 05:01:45 -0700
Message-ID: <CAOLa=ZQUEHO0oCcccgHQqzvgXkK-gMOqhpCQ2fGTLLMBPB+Pag@mail.gmail.com>
Subject: Re: [PATCH] Bug fix: ensure P4 "err" is displayed when exception is raised.
To: Fahad Alrashed via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Fahad Alrashed <fahad@keylock.net>
Content-Type: multipart/mixed; boundary="000000000000649c4d0617c7d5c7"

--000000000000649c4d0617c7d5c7
Content-Type: text/plain; charset="UTF-8"

Hello Fahad,

"Fahad Alrashed via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Fahad Alrashed <fahad@keylock.net>
>
> Bug fix: During "git p4 clone" if p4 process returns

Nit: I haven't seen us use a prefix for the commit message. Also we use
a max line length of 72 characters (see .editorconfig). The commit
message seems to be wrapped at a much lower threshold.

> an error from the server, it will store it in variable

perhaps `in the 'err' variable` or `in a variable 'err'`.

> "err". The it will send a text command "die-now" to

s/The/Then

> git-fast-import. However, git-fast-import raises an
> exception: "fatal: Unsupported command: die-now"
> and err is never displayed. This patch ensures that
> err is dispayed using "finally:"
>
> Signed-off-by: Fahad Alrashed <fahad@keylock.net>
> ---
>     In git p4, git fast-import fails from die-now command and err (from
>     Perforce) is not shown
>
>     When importing from Perforce using git p4 clone <depot location>,
>     cloning works fine until Perforce command p4 raises an error. This error
>     message is stored in err variable then git-fast-import is sent a die-now
>     command to kill it. An exception is raised fatal: Unsupported command:
>     die-now.
>
>     This patch forces python to call die() with the err message returned
>     from Perforce.
>
>     This commit fixes the root cause of a bug that took me hours to find.
>     I'm sure many faced the cryptic error and declared that git-p4 is not
>     working for them.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1668%2Falrashedf%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1668/alrashedf/master-v1
> Pull-Request: https://github.com/git/git/pull/1668
>
>  git-p4.py | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 28ab12c72b6..f1ab31d5403 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -3253,17 +3253,19 @@ def streamP4FilesCb(self, marshalled):
>              if self.stream_have_file_info:
>                  if "depotFile" in self.stream_file:
>                      f = self.stream_file["depotFile"]
> -            # force a failure in fast-import, else an empty
> -            # commit will be made
> -            self.gitStream.write("\n")
> -            self.gitStream.write("die-now\n")
> -            self.gitStream.close()
> -            # ignore errors, but make sure it exits first
> -            self.importProcess.wait()
> -            if f:
> -                die("Error from p4 print for %s: %s" % (f, err))
> -            else:
> -                die("Error from p4 print: %s" % err)
> +            try:
> +                # force a failure in fast-import, else an empty
> +                # commit will be made
> +                self.gitStream.write("\n")
> +                self.gitStream.write("die-now\n")
> +                self.gitStream.close()
> +                # ignore errors, but make sure it exits first
> +                self.importProcess.wait()
> +            finally:
> +                if f:
> +                    die("Error from p4 print for %s: %s" % (f, err))
> +                else:
> +                    die("Error from p4 print: %s" % err)
>

This part looks good.

>          if 'depotFile' in marshalled and self.stream_have_file_info:
>              # start of a new file - output the old one first
>
> base-commit: 235986be822c9f8689be2e9a0b7804d0b1b6d821
> --
> gitgitgadget

Thanks,
Karthik

--000000000000649c4d0617c7d5c7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: eba9c104463ee1c1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZNHhxY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjNNREFDUEVITHBZSUJLSnFNUFpMV3phL0FqNDJwUQpqVThKRzZKY2s5
VFJhTlRYV3ptdlY4MHZvb21xQXIxWDFpUDVXOER5TSsxQ3pwSGNzRXhEZVlRSVNNK0VkZUIvCndq
S2xvODRDU0Vzd0lCNG5YTXNPYUJ0Tjk0TlBER0ZIVmhYMGRid1prZ09WM2pZekorcjQ4ejYxYjFp
RnM2VHkKTERqejdNMGw3akxuTVpkTUVtUUZsUVZLSXNHaXh1emVlcWN4UDluQ29vdm1IVUhnSnhY
ZVY2SExNRUI0MFpHRwowMnpaMTYyVTRkaU9sdytBMmE4NVZkeFQ0Z3UxaGYrUklBcnZKVzlSM1ds
VUdQTkZrQi95dGpvaWZJMXJnZmZaClhBSDFRamMvZ284ZUlOZ29DSG52NXhNdnkraVdkaHhDTHdN
OGlvNFIwUjhMTktOTVc2dUU0dFpNcFNMMDlPMFcKTlpsZVRnOExMUS9SbzlEa0l6cEVkZjd3c09r
L2RIV0lXcEljNjZZcCtUQ2kwSy9hb2FZUW9LcTJtT2FOeTJKYQp0KzNPRE9pMXhyV3RVR0tHU1cy
dWVldjdGZmpxU3NiRjBhcVhSMlJzRUZlOTNZRG5xT3Z3dG5HVDJkQ1g0TytXCnkvbFhLRElrdVZU
Vzk5RzA1R1lhcjR1Y3h6Q05rbHRSSnFyREVCST0KPXBuRzkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000649c4d0617c7d5c7--
