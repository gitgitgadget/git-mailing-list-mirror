Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9B1B2EFB
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 21:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737493847; cv=none; b=FtPxLIUC+S7eanzpbvVEk7YjmefedJCBsncZP6TWV3jSh0CpgoQH8T1ZppvshV2dv39bVU91uPHr4z5lmfvKEZK01tU57Z+NK0Jmtd6v4JMB7bfcpjkPEoBuDac5otO3n+YlKzuhfEYAZyNbEtIP438ZzzDvQ9wV9bCJw2sUx2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737493847; c=relaxed/simple;
	bh=1DNFotEKYqdoSC4FqGutRaklGfgZPpq9c9H7oDUYya0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Av/kBUFDv3ZgG7d+9x9GxYONPCnItWbgPDXcknFB7hlO6D+QuwuHqhkqcvoZ/+tOws27+DIPqQjH1ilfKjlq+sQ6/6vXKWP6zLmQDE8t7QtoZAX3fARLCv34/s7513WhMHbqo5rlGv4uenfkMGrK54DQW3j9YYTlowz9sASwwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uH0gRxx6; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uH0gRxx6"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4678c9310afso11771cf.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 13:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737493845; x=1738098645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DNFotEKYqdoSC4FqGutRaklGfgZPpq9c9H7oDUYya0=;
        b=uH0gRxx6cVY23vYhF6k49PxSZrjWBYJjvTpUoXjebnrZ+3SgbYWsLehGT+EPOZZ5rI
         5wfP7Kxw+e09zK/VK6QdVV87JGmVThtZkex7jCGGgRvsI3z5CkNHleY5QzKDcdqhNMDc
         DjqMgU2orksEE1CFAFz5g6r0NleV1cuY/aNf4afj/5V2PQmivQUd6GV3BwVGGGqo8KC4
         ZJDzpaaIHo7PhbNgbgcs58cBIITWIzxD21yAwZChxX0qI1enHE+kTpJmvBTVPo32D3DS
         GbLwsRJpnwYTmu+zbGHMGbVRD8CpiUXf0ZBHgkBKWt8fZF1ZmJscDNYBKUSMQZI6ol6s
         pnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737493845; x=1738098645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DNFotEKYqdoSC4FqGutRaklGfgZPpq9c9H7oDUYya0=;
        b=X3qdhL/IePeW9wT6MLuZbdShCUChLp2F+zTHO1fEX41ugQ17/wFr8uLJqzLAQ1/sQe
         kBg+c3SbWoB+q4U8z/zSK917g1xmwIANIaQTrs2JapP02tbSVV0mpP1GCpOpkQ1yqtup
         Rp/5xHG2V9Vw7AAvXr7eTQORVgCyPSaBbq4yI/qcaTHHhGICi3KtgQOWi2+qwv5sTMG7
         7zF8qaQWENrGxZfCHpCtJhy1NYYDFgspdm2+Kt2FzhnqZvwW27IrrkwE+PBXoNMO6mpT
         Qwm8CBi83bqcvncIIquzwRT7/Y/J3LfZFhETj0ycaizgJMQQjMM66eCIz5jLRggH2FQy
         MyxA==
X-Gm-Message-State: AOJu0Yw7qiPJSF8GdPznhOl+U2X7VSgMAYJV9ympvW7XR7+sho0l/wHs
	ABFab3866/Q4XN9DGFtFmv52JQB1ye3dVOSE5FrdK4Gyana9ABSbm+QO8QQb0scjZDTh/miEN6D
	sgLFN89dYDLw8Trqi9ZcpazdCUvGxIOA9xwuzVqg5PSWgbjxBsg==
X-Gm-Gg: ASbGncvwUo6ox8spi8WGjuYQ0gFWKJR8yhjBPNVgKcrHMTEpPdHuP1Pi7L9GMYM+9aU
	HMQg6zIMGGyDVdi4LFUF+/uWHWqMvSVLvwZK5YfXFGD8E5wSH4LERWUeMAvPv6P0agRTHlj/xyu
	fu0laB5g==
X-Google-Smtp-Source: AGHT+IF3x4v/uM+Y0dcr30uDVJ09ZHyAtZdM+aO6/q0P+ecLz/Jb8FY0DF89G70aK2XkBOoLN0oIB4skkvE4IaDZzeU=
X-Received: by 2002:a05:622a:1206:b0:465:3d28:8c02 with SMTP id
 d75a77b69052e-46e500426d3mr698351cf.26.1737493844699; Tue, 21 Jan 2025
 13:10:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DB9PR05MB110863344D3776D13B436F563C1E72@DB9PR05MB11086.eurprd05.prod.outlook.com>
In-Reply-To: <DB9PR05MB110863344D3776D13B436F563C1E72@DB9PR05MB11086.eurprd05.prod.outlook.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Tue, 21 Jan 2025 13:10:33 -0800
X-Gm-Features: AbW1kvb7z9JW6xaEWh3-qQgD31KusSaEXg3spUQ4k_GQawHWUpuLuvR_Al_6i8A
Message-ID: <CAJoAoZnecm5y8243R9JsGjRDuv-Mb=UAwa+Hbj5CKDKNPBLB4g@mail.gmail.com>
Subject: Re: [Feature Request] Allow batch removal of remotes with 'git remote remove'
To: Christian Fredrik Johnsen <cfj@johnsen.no>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 3:07=E2=80=AFPM Christian Fredrik Johnsen
<cfj@johnsen.no> wrote:
>
> Hello =F0=9F=98=83
>
> I would like to propose a feature enhancement to the 'git remote remove' =
command.
>
> --- The Problem ---
> Currently, 'git remote remove' only supports removing one remote at a tim=
e. However, it would be useful to allow batch removal of remotes, as in:
>
> `git remote remove remote1 remote2 remote3`
>
> This would simplify workflows for repositories with multiple remotes when=
 clean-up operations are needed.

Hi Christian, is there a reason why opening up the config (`vim
.git/config` or `git config edit --local`) and batch-deleting remotes
from there is undesirable? If this is a solution you believe only
power users need, then I'd posit a power user can both list all
remotes *and* remove the offending ones in a single editor pass,
rather than having to run multiple `git remote` commands, anyway.

>
> --- Proposed Solution ---
> Modify the 'git remote remove' command to accept multiple remote names as=
 arguments and remove them all in a single invocation.
>
> For example:
>
> `git remote remove myfork myrepo origin`
>
> --- Benefits
> - Reduces repetitive commands for users with many remotes.
> - Aligns with existing batch-like behavior in commands like 'git branch -=
d branch1 branch2'.
> - Streamlines repository maintenance, especially for power users.
>
> Thank you for considering this request. I=E2=80=99d be happy to provide f=
urther details or clarification if needed.
>
> Best regards,
> Christian Fredrik Johnsen
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> ---> Generated this message with ChatGPT, but it gets to the point.
>
> I am assuming that this is such a niche case that it hasn't been reported=
 yet, though please correct me if I am wrong.
> There are no `github issues` I can search through to find older related i=
ssues, so I'll give it a go.
>
> Attached a picture showing the situation where I encountered the issue.
