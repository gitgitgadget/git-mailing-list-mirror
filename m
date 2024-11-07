Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C3F186E2D
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 04:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953035; cv=none; b=h3vT/w9cZu5zZtU1NDZdlELgWEPxlvoElAtx+gU8RIBsuYynikrXFsno5fuesKHJPEoobxUXbZGs4Ol+5Kgb8wbqx43RBg+NqehfX6MqgAggAn1ZNwHcyHeTCUAUqYpDlTaZgP+g2MYsHyLkTBVncDPTUqCqDh30KA4lOMze7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953035; c=relaxed/simple;
	bh=LBPO7rdta21az92R/OGmHhQRdCnXpb9tpOIk0T/n9qA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=a66CKpFnCVglgK4XBX4xWuohTDQA3cotmr3Pq9KklilUOWFHFLpcIyT2LaLSK3+cQo3ZnzRMD8jsd0bQoPg3MVl6Mr8uha8LOQRtUCDHLaMvETRSoHm/lsi9xrpts4VkVHxpxan0h7yIw6HiF2mQmkslBHflEYV+CY+FUJFAPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzXdA1rb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzXdA1rb"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so2834312a12.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 20:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730953031; x=1731557831; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gj0ETZ57V1NY7oZxqHPFsZ5zIobtbS+b2BQYE9CBpj0=;
        b=BzXdA1rbfVBU9lS0uTE/9j63l7wuIwo5D5Roby66VK4lgPDpn1sExNO++KRTknQZa0
         TnIFBOBRfi93bWhzsUckjlhhOFUqQ3ndnG2+GwNfGGsYdAHyZIXHS21r+TQJCcAT9t8H
         Lkn5kXwg12Ok5+uPUO8ldnQVLgf6C9XpOmev03/LYclQNOs51ZMKOdXi6BPlbMXYBX0m
         la8DQsgyKUFhxf6oFSzN3gO9mfihvGyc/ukN4MihJgYEGiKgict0Br1GadcV7zZASM8K
         dMBi4+dudNF/T/P3mul9tGkMZbvnH0mQZIipX4Nl81YfiRRPYNS3g/3Xh4pYdQnamjXP
         6FIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730953031; x=1731557831;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gj0ETZ57V1NY7oZxqHPFsZ5zIobtbS+b2BQYE9CBpj0=;
        b=TG1kJC+jGdhjHkkUCuduf/ceFXm/Jr/Xw0hURRszoBGICeY13ynYJpxUVd+9jHefQq
         kUOmGtml5L5b+Si8+ArpjGG8xhnRBH/YZfqszRZgqkwNWtWkagXP+POuXSXkwNqBAlvH
         HVTmO+4dBHXzinuUFtlFldAqKEZH/sGT3AeMxBJQRBoIVxQKjXbIEOlge5e6eVawCrm1
         EMGYsSGymkp+2vNw7kMMLdkVGHJRYHdySUE58RbxAJcFhdxe7REJkmKWQrSre8+USsuD
         9QED+Wo95GEqSS667xIxjY0IQFa8V2JJ4CGkATLFadcYBpY2wEua1ZN/ZHyoSzayktr9
         LjhA==
X-Gm-Message-State: AOJu0YzScSC4rmaO94NwjWJI1Cbyw72DhCgbK7kKnpLX+LzigCxQxv4/
	9AxPKccEq6yxnyOOasw9B5H0nln347yXgZbzkKp0IhLkGckhvXsaBVX9wOR6VMEMy1sEUQq7mZd
	qXpqej9ujvI//3n3TiodpSrtBFQvpyR7D
X-Google-Smtp-Source: AGHT+IGLMOT+fjWdCiw5pFHV8EAXv5GGpaP53ozAYgnJDvoSVN8kT8EkBLSUENl5zej+2na27X164tcXDG8Bc7kQh+o=
X-Received: by 2002:a17:906:d551:b0:a9a:a3a:6c48 with SMTP id
 a640c23a62f3a-a9ed4c5f8e5mr162037766b.2.1730953031195; Wed, 06 Nov 2024
 20:17:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yarden Bar <ayash.jorden@gmail.com>
Date: Wed, 6 Nov 2024 20:16:34 -0800
Message-ID: <CAJPGt+U1icoNJHPtiFcidtwN6ts03jH9WpaGxDGoE5RBQSCCLA@mail.gmail.com>
Subject: gpg-ssh signing with AgentForwarding
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Git community,
Not sure what search terms I haven't used, but I'll try to describe the use-case

On my local machine I have a SSH key, and I use AgentForwarding when I
go out and about to other hosts (dev machines)
The usual workflow of using the forwarded socket works for pull and push.

Where it gets pitch-dark is when I try to use my ssh key to sign git commits.
Following is my git config on the remote host:
=====================
[user]
    name = John Doe
    email = jdoe@jdoe.com
# on my local machine(gpg-ssh signing works): signingkey =
/Users/jdoe/.ssh/id_ecdsa.pub
    signingkey = WHAT_SHOULD_I_PUT_HERE # on my laptop its the path to
the public key from Secretive, or just omit it?
[gpg]
    format = ssh
[commit]
    gpgsign = true
[gpg "ssh"]
    allowedSignersFile = /Users/jdoe/.gpg.ssh.allowedSignersFile #
contents is: "email1,email2 key-type public_key comment"
=====================

I've tried
1. `ssh-agent -a /path/to/ssh.sock` - errored with address already in use
2. signingkey set to a path on the remote host with my public key,
errored with "no private key found"

I sense that I should be able to employ `gpg.ssh.defaultKeyCommand` to
use the socket somehow, but I can't wrap my head around it or find
some docs/guidance.

Other (related) links
https://developer.1password.com/docs/ssh/git-commit-signing/ - I think
that 1Password invested the time to make it work
https://github.com/maxgoedjen/secretive/discussions/338#discussioncomment-11170722
- asked the same on Secretive repo, which is one way to store keys
https://github.com/maxgoedjen/secretive/issues/405#issuecomment-2460948732
- also here.

Thank you,
Jordan
