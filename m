Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A9D186E40
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477272; cv=none; b=Sf9Y6DwmaN7FTP2LxTdvlgSouXuqthQdCtfYv0yx44AaoPeLCuhzIThotk4LPxJRFun7S22AXP5i2iqPz+Gi5jKKhB8TN4Xors31XpYhnexGvhQPe6BwonU7JGNLe5DCcpLxbB9OAr9Bosn5omhKgdIKpCYYYWXm8oO+q+DtYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477272; c=relaxed/simple;
	bh=nMfD9kPLToxyNYgRwk3MiWmarziPcsYPeh46rDUrpBk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qyl2oARYz2Gl6tpn6vwIPld3rFh/HKcOIQtY+63Sz8XzXXGBciOKgxKxO0/9K7aetgbkR0wrC3KCZ8iQ/Kzr0LdpTY13/z62cfYqBhBvVk3KO0uSQWzv976km4Lns4djMmPzjruutXOPaVIPWSELg5uRAY3CYlrmy+ydbrezHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggJjoxo2; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggJjoxo2"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5fbc40239so1270942b6e.3
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 09:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730477270; x=1731082070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EXeA2UeYImSI/z6vSUJ8liG0SStvIrcFlR9F9VPf4ds=;
        b=ggJjoxo20nlsYzxAAggTBGGJDBWZ158HG62x2iwcHBDwtpYVo8xzYCHS+2wpQkFfch
         akzNAogtCMI5EeFljijPvw7LexGG+6MZ8wtPgVMJwdvNYM5v7aWdWF+/KWknmjnsvAg0
         jV2cQozJEIRRTlbs5IiHxpvfgYuY71DJsfOmWhzGjA7pwFf4h+ZasMMC9KLqaAmXbHQH
         KlgUBRNs/80MvGEf1KOz3GEd9VZ5zwDExrs/WCDUW8pkvnLeYtXyXzkYSlg5pBfKkfhf
         UrzPqdI5HR7kC/T/GYChPQ12Yo1cmxcrYh2rRYSl+WLecYBxUZq6NmDu+UZo6kis4jKl
         E85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730477270; x=1731082070;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXeA2UeYImSI/z6vSUJ8liG0SStvIrcFlR9F9VPf4ds=;
        b=Hc9+KUxe9zsy5ituU+tJD2a9mJ1TMbKlOIY93DNR9AaUM8FNbgu/5T2LqibXz7vFT9
         atqKxu7LdJKehZ9NStwtjJFGrBlNhPj+hBZSpH6STSaiqi/wEn5aHd+VyWZpuMWuKGq/
         jffmgJuehNnD0QYilpbqMI5cTNqnor2vSPNWBtP1LVFK1/6RNHo335ymILq++gAIgvQ2
         CkyQ2ebOBl7RBG40WFfIT2PPFIk6lzq9GBumoDrjjTAbOBvKRigbeYQeBh0xsN5qiQsF
         9+F3RDF6Sz01v3NsyIg+juj3pT+OZN0kcovikZ+x9zoEbzieZTZieKur8SoeJe6EkqyF
         LDUQ==
X-Gm-Message-State: AOJu0YyYVw3MSpNK6Te9c0kojmyrHXuT0HxyTaVwYTCUab7vPVQbDYPx
	MIANQkrs81KInRM6weNZYC2yvE6kdXBWfDg9yzk8Hd9Be4+xuAxFzn4fm8Rkey+e2fWd8gjFTT3
	lsapmtYplZhXU+uE482KtganPxgfOnmnO
X-Google-Smtp-Source: AGHT+IEoNIiOD6bbvPon7bB7+Nj3HitAjdfYrqn0qjdVctsda9/vZrtmz4+zmStIu9ChmUFsT6JDlBvg8PD26woaLq0=
X-Received: by 2002:a05:6358:b58b:b0:1bc:583b:a173 with SMTP id
 e5c5f4694b2df-1c5f98f227dmr251839155d.10.1730477269631; Fri, 01 Nov 2024
 09:07:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Nov 2024 11:07:48 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZyTnhrBLuvesK1yB@nand.local>
References: <cover.1729504640.git.karthik.188@gmail.com> <cover.1730366765.git.karthik.188@gmail.com>
 <ZyPjJKYZzeFGLxin@nand.local> <ZyTnhrBLuvesK1yB@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 Nov 2024 11:07:48 -0500
Message-ID: <CAOLa=ZTp=QqD0P2zhGunrOfmAebwvLJ20bQq9Tog3eLaO9pwoA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] packfile: avoid using the 'the_repository' global variable
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, peff@peff.net
Content-Type: multipart/mixed; boundary="000000000000f3cd860625dc2260"

--000000000000f3cd860625dc2260
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Oct 31, 2024 at 04:05:56PM -0400, Taylor Blau wrote:
>> Hi Karthik,
>>
>> On Thu, Oct 31, 2024 at 10:39:43AM +0100, Karthik Nayak wrote:
>> > Range-diff against v3:
>>
>> Skimming the range-diff, this new version looks good to me. It would be
>> nice to hear from another reviewer or two before we start merging it
>> down, but I think that this is looking good to me.
>
> Hmmph. I spoke too soon, this new version appears to break CI on
> Windows, and thus broke the builds of 'jch' (and 'seen', by extension).
>
>     https://github.com/ttaylorr/git/actions/runs/11602969593/job/32309061019
>
> Can you have a look?
>
> In the meantime, I'm going to move this out of 'jch' to let CI run there
> again.
>

Thanks for letting me know, I think the fix is simply

diff --git a/packfile.c b/packfile.c
index f626d38071..737cd60377 100644
--- a/packfile.c
+++ b/packfile.c
@@ -27,8 +27,8 @@
 #include "pack-objects.h"

 struct packfile_config {
-	unsigned long packed_git_window_size;
-	unsigned long packed_git_limit;
+	unsigned long long packed_git_window_size;
+	unsigned long long packed_git_limit;
 };

 #define PACKFILE_CONFIG_INIT \

Tested it on GitLab's CI too this time.
https://gitlab.com/gitlab-org/git/-/jobs/8248707713

Will send in a new version including the fix tomorrow!

Karthik

--000000000000f3cd860625dc2260
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b2b23fd0cbfd3f90_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jay9OTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meU5lQy85OTRMQUwybVpreTVUZ25CWnljU1R3ZnFKbgpMVGQxdE9uWHh3
M2FrbmpmaEpib2hCUEtQYXNOMjI0VVdKR1VtNWw5TlRzYktpKzVlS0I1RERIZkJ0S1VoN0hRCk5k
bG8zbmNiaUU1RGdQckw5SnZObnNPWXR0c3JudjFLZzRETXJrVUY1ZGZOS3ZRenJDNnQzeE1MbUpj
WUFOUGUKVFJVZDdVbHNZZFJzeE1TaW5TZ3BRQ2g5MTg1RHUxcnN5Wk9qTC9uOGp4UzRSYWlHTmVM
d040Z005YXBnb0l0QQphMmV5WG5PR08ybFl1RW90STNsMTBWNW5HWHRsMkQyNVR4NmtQUEVOUnZv
ZWxZSENkSDhBd2NJdmw2OUtWUnRECjc5TEpvcDBFSXlYcXJLSUJGN2tKZlNhN1d2eTJHSXFoL2NI
elA1Znk2Z2pTZWs5Z3Frc01teFVVUU5zMlg5d3YKTTI1NUZBSm5KaVVvWG1UOWJCblVCQXBmaDBB
R25mNmdPZ0IrblFIMmRISVA1Z05HYWhkWXNndzF0eVF1dW9GbQpDbGtITmFqRVlUYkR4VTNPRVhE
bUxEYXZlRmxWem9lSnRQTFpiR0hMczlyS2VZK2NxaDF3Z1hQU2xJRVBYYlMvCm9TeWtvRmUyU2JS
YnhDZmlzQVNtK3k4eTFkOVlZd2JRZEU4QVNLdz0KPVV6eEgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f3cd860625dc2260--
