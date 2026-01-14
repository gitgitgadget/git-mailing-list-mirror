Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537F2C032C
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408045; cv=none; b=C9Bb97sWYisxZG1B1fg8TFhY1ihWkRGjmFSDeVMRk3WCaqfmOAwEIOP456cupN008MdFRoOjFxCPXzTX76peIuuAtXA8wMSJ5YutPN8mMc2pKvdZY4PlfUP5sQLHcYt1tsQvf3ksw2srPfL6pusz7BXW2LlzVvjb6M7O/LCvDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408045; c=relaxed/simple;
	bh=fhlDEM2o11PTF27QWKQNMDlKIwv+J/qAyaO0j3namEE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=icjag2iQWZYM1G7Vsd793YwZ4pFsM+jjg3fcBCYuQu1uf8LokecM6AhUIhzrvi4rd/cX8zc7h66IXHD0T44KVJ7H9amwuHDSpUuJw0rusq4+IEeEyde3+Y23hJq+dG8TKz95u8pAQfigmY5t7hbzHd6FSp8bdjC5M74vSqcsfNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZ3jkPBp; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ3jkPBp"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93f523bba52so726984241.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768408043; x=1769012843; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOZujYlsp6dlwviMj+4ZnYFHcx0XKDTCj4eX4+wnu1w=;
        b=OZ3jkPBpuaZJUfbZ88Y4APTv0uVmHGlByfLyhO+/SmuvHUARhn5xRuhpUI1envK4ov
         Dmyk8JMhKT/tt9wC+EWGMMHX/JOpg644v19d1JGEOCC3pWssAjFifEpcipXihJB5mums
         fNzUHZqM1TzrauOQRvocnmsFs5GWMN8HNRIMEh1nTrpdhHh1I3/ejP5x9U9yEDDsKGlL
         T9udv3klEARMtRbarNHyjAzlcllaWVvXGDAgPuIxlPmRbdRR7AUPzQMiwL/mBWURX+9w
         7G0hSwMCy0vGQ4n7l/tEp4wVEJltLorN1E21GK71PCHsxYO+IRVku94OzFKWyP3NhLLw
         DOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768408043; x=1769012843;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOZujYlsp6dlwviMj+4ZnYFHcx0XKDTCj4eX4+wnu1w=;
        b=WuCJOa4kL+8X0cGlej+YXcAUhM4lTvNdPaapyFqLRAx3pFIfgNt4tevp/ebqlsceMI
         NBHeEeYiMpcea7235qs8mL0SpqL+2mfT94JeD9+7690uUpEVxQklXRfyl2rWesxoK5Yr
         v0NVAY1YPIGEYkW57HtDnFwg7CZofMc7TmlQpi1K55CV8q8mQu0irQWrbPsmWkf1IW1M
         TyNVUbuynmE/qmeL6dssTj+AK1+EBHs/I632AtNDFYxSNxFfK5BbhL7vwmzMygv19cLz
         zT4WopBIW0MfIzRLVRJkrPMYM12EVUMmWJPK2hnTL9taihuswXRoIQhOY+9W7r3bteJf
         TCeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+57y0deC8JpY5U39AQk2HNmAMcJ6IYErmfJXIQujhHAuwI0dRKgR1VbxKvZyetfyMJsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMc6cPd7w5/1bXqFKK2bEKlKTW/6UqxYbAQKIG5M4WsUG8by15
	ZwGVNCoJHHNlSukBQ9BB07gEyzRF0FPk9cPf7+oxAXygbo/5HxGMBNTCp0aseiShcO1aH/nAIi+
	sRPphjKV0lP/WzvM6jLYci8TCS36MadPEEQ==
X-Gm-Gg: AY/fxX41df3CsM2s5rtsg3dJQ/xBel9EKcqzB/h2Rq67Ork6YKcJ0NTLVWC4tYwrBgg
	vbMqqCNFJwHGn/2cHojwjhtEbYxc6blbtrxOG6xWxHGS0P3d8pBTFTDeHYdcMFu1J/dyXa/Fs8L
	fyfz1DzZEalIXVTwyeqqfmnQxjMlbpyDDHNUQnpKLUDVrE7jhD8yspOZorlSZ+uq9M41yJ5ONHO
	l2hiP6AUoHTdPAwMQN6mCaFHMGgoTREPTYqcp0BJeLY4JwxsdnGnZqAKPI5khXjhcZUjMZzhUau
	erHQ3vTWJvNCv/MjI1hyQRPW3FOhyA==
X-Received: by 2002:a05:6102:3e90:b0:5f1:4fc3:855c with SMTP id
 ada2fe7eead31-5f19242939bmr6509137.7.1768408043410; Wed, 14 Jan 2026 08:27:23
 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Jan 2026 17:27:21 +0100
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Jan 2026 17:27:21 +0100
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAGe2LO0nxXuNNRYS0fk0JuPBDa3UCT8EDJ6G1u4GNW1d9rzRgA@mail.gmail.com>
References: <CAGe2LO0nxXuNNRYS0fk0JuPBDa3UCT8EDJ6G1u4GNW1d9rzRgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 14 Jan 2026 17:27:21 +0100
X-Gm-Features: AZwV_QikZRggtIqyWfOW8cY2AYtpD4h_n3DgvsJmC_WvSiAAuT5AETDDnwPZHxM
Message-ID: <CAOLa=ZT4fQdHqG+1AeviYuLUR5VG33voJk_DU1y0MzhUKBQvvw@mail.gmail.com>
Subject: Re: [BUG] Git push sends too much data unnecessarily
To: Rajiv Sharma <rajiv.tilakraj.sharma@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003ef51606485b95e1"

--0000000000003ef51606485b95e1
Content-Type: text/plain; charset="UTF-8"

Rajiv Sharma <rajiv.tilakraj.sharma@gmail.com> writes:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> I tried to create a new branch pointing to the commit which was the
> ancestor of the current branch (i.e. HEAD~1) and pushing it to the
> remote. Since the commit was already known to the server, I expected
> the push to be kind of no-op since it's simply creating a new pointer.
> However the push ended up taking 10+ minutes. Since I was running with
> the `--verbose` flag, I realised that the push ended up sending
> multiple GBs worth of data just for creating a new branch on an
> existing commit already known to the remote. After some
> experimentation, I managed to find an easy repro for this issue:
>
> Clone a non-empty repo from some remote (e.g. git clone
> https://SERVER_HOSTNAME/repo_name.git) in two locations, `primary` and
> `secondary` and ensure that both have the same branch checked out.
> Navigate to the `primary` location and create a local commit for repo
> `repo_name`. Push this commit C1 to the remote server
> Navigate to the `secondary` location and try to create a new branch by
> running `git push origin HEAD:refs/heads/shiny_new_branch --verbose`
> (or by checking out that branch and pushing it). Note that `HEAD` here
> refers to the `HEAD` commit as seen by `secondary` which in reality is
> `HEAD~1` compared to the remote
> If the repo had some commits on the checked out branch, you will
> notice the verbose output highlighting objects being sent to the
> server where there was no need to do so
>
>
> To understand more about exactly how much data is sent, I ran a few
> more experiments and came to the conclusion that the git client sends
> HEAD commit + all ancestors of HEAD commit except the commits which
> are also ancestors of some other branch / ref known to Git.
> Pictorially, it can be represented as:
>
> B1  B2       <-- HEAD
> *      *         (sent)
> |       |
> *       *         (sent)
> |        |
> *        *        (sent)
> |      /
> |    /
> *                  (NOT sent)
> |
> *                  (NOT sent)
>
> This explains the multi GB push in my case because I was working on a
> long standing branch with lots of commits. Initially I assumed this
> was a server problem but then realised that in the push path the
> server just advertises refs and where they point and it's the client
> that does the negotiation. I think the bug exists somewhere in the
> negotiation logic but I am not sure.
>

Thanks for the detailed explanation. I don't think this is a bug per-se,
but that doesn't mean this isn't something we can't discuss and
potentiall optimize

To reiterate my understanding, I did a quick local PoC:

$ git init remote
$ git -C remote config set receive.denyCurrentBranch ignore
$ git -C remote commit --allow-empty -m "C1"
$ git -C remote commit --allow-empty -m "C2"
$ git -C remote commit --allow-empty -m "C3"

$ git clone remote/ base1
$ git clone remote/ base2

$ git -C base1 commit --allow-empty -m "C4"
$ git -C base1 push -f --verbose
Pushing to /tmp/remote/
Enumerating objects: 1, done.
Counting objects: 100% (1/1), done.
Writing objects: 100% (1/1), 704 bytes | 704.00 KiB/s, done.
Total 1 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To /tmp/remote/
   78c400c..affbad8  master -> master
updating local tracking ref 'refs/remotes/origin/master'

$ git -C base2 push -f --verbose origin HEAD:refs/heads/fun
Pushing to /tmp/remote/
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 16 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (4/4), 1.98 KiB | 1.98 MiB/s, done.
Total 4 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To /tmp/remote/
 * [new branch]      HEAD -> fun
updating local tracking ref 'refs/remotes/origin/fun'

What you're stating about and can be easily seen here is that while
pushing C4 from base1 only transferred one object, pushing HEAD from
base2 (which is C4~1), pushes 4 objects.

After base1 creates C4 and pushes:
==================================
remote:     C1 --- C2 --- C3 --- C4 (master)

base1:      C1 --- C2 --- C3 --- C4 (master, origin/master)
                                  ^
                                  |
                         (transfers only C4)

base2:      C1 --- C2 --- C3 (master, origin/master)


When base2 pushes HEAD (=C3) to refs/heads/fun:
================================================
remote:     C1 --- C2 --- C3 --- C4 (master)
                            \
                             fun

base2:      C1 --- C2 --- C3 (master, origin/master)
                        ^
                        |
              (transfers C1, C2, C3, + tree object)
              (4 objects total)

This boils down to how Git negotiates between the client <> server.
In our case, remote will list the references it already contains. So in
our experiment, that'd be:

 - C4: affbad8

With this information, the client should find all the objects the remote
would need to satisfy the new references being pushed.

Since C4 is a reference the client (base2) knows nothing about, it
cannot find a common ancestor between the provided commit vs all commits
present within the repository itself. This is seems obvious to us, since
C4~1 is the common ancestor here, but base2 doesn't have sufficient
information to come to that conclusion.

So it sends all objects required to create the reference, in our case 4
objects, in your case GBs of data.

> What did you expect to happen? (Expected behavior)
>
> I would have expected the push to be extremely lightweight without
> sending any objects to the server.
>
>
> What happened instead? (Actual behavior)
>
> Already detailed in the first section above.
>
>
> What's different between what you expected and what actually happened?
>
> The git client sends loads of data to the server when it shouldn't
> have had to send anything at all.
>
>
> Anything else you want to add:
>
> Note that there are workarounds for this problem. If I do a `git pull`
> and get the latest state of the repo before performing any push, this
> problem doesn't occur. Nevertheless, I think it might be worthwhile to
> fix this. I managed to repro this across OS (Linux, MacOS) and across
> versions.
>

That said, I do think we can potentially optimize this, AFAIK the
negotiation phase has the server listing its refs and this is compared
to the list of refs locally present to determine all missing objects.

So any commits which are not represented by a ref, would be missed. One
way to reduce this would be for the server to also provide additional
information such as commits which are not represented by any refs. But
how many such commits? What about sampling? Finally we'd have to
consider if it is worth it.

Thanks,
Karthik

--0000000000003ef51606485b95e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 71ad2dcbbbd74842_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sbncrY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1grQy85ZWZLcm1Gb2dvWkloLzhNWUV5em9UdGRTZwpqdFVzZlZ6TVlV
WlRweWs3L0RKSTdMMTVrRnRXU3l4QWJ1YWhDempiZzlkWUtLa1VOb2tzSU5tZVpnQW15RTF6CnJZ
MElLM2QvUVVFRzFpUDFZZTVkN2Q3OStQNjR5aHpIKy8vOFN6bXNNdkZ4azhFNEZRbTBnSHNFZ2NH
R0xuLzUKcWUxL3RBWG5od0o1SFZNNGprbWdwaU56WXgvN2tnT1gzMThBU0VxRDFZYS9KUEFqd2xY
S2dwS2JYclMycGZldQpoendxQTM1ZnhEdVR3R2V2bjJ3Z2dJT2E1aktMZ0UwSDllV3Mrd3J1dDVW
eEtyeUhJemJLKzkyb0JoT2xLWUZ2CmovKyszR1c3OFkxWmZZRkthdlJ6eUI1MFA2SjVDbmpENUw2
NGlNcWlFeitzcjRGQy9FTnpGZm02K2pGT3hPNmUKYXhDbTVtWXQzZEE4UU1pQWgrUkJYUElxWGFu
Z3Z3RDlDU3I3UXh2bFNBeHNWR3JaRzloUjBEQzFqQ1lyTDhFdAp0dlV1WTdkRXhlcERMMU52NGdP
MzV4ZTJvOUZNOHdBNW5wbHFnQ21BSDdmakxZcjJxNGxKWGtpZ1dxQkdZL2hoCm1IRzZ2Q0Z6bXdZ
YXQ5SmFEbUFic212V3ZtUEwvbjNFY1RpcVZEVT0KPUlzcEgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003ef51606485b95e1--
