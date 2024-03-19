Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB63A1D4
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710879704; cv=none; b=XcULFmllzDIWZJgAdRvCV0LDeNY7qurqnLdic/AaddROk0PkuCdvriXfgyiw/pFagVXxNp43aBddARWdDQnGavLL2SJ3mmJpvdkUaInOZg+SzPWU65bDVbSg/Hm92qc5JEPI7c4vNpiCExganWMt0lc/Bq+5l+XLxaNRI/hNvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710879704; c=relaxed/simple;
	bh=1LgPRCDFz8qsX4vbd//GIYpaJaeOZZvVwVGJCnukQRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=G5u3wDr0JtfUifw/llhybWKLta41YN6Jb7HnhW892/Iy+l4ePKtS4lL4Umouw0PcnuVxbw13teAwLYpcGE9WN074NjN4jqUVHa/+HTqu8H08GgbjpBIvTNg2XknuI5BMgvwLdp9kGCw37vcutfUG1e1RkMJX/KPUZKzAr0QvgCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ8UxcXH; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ8UxcXH"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso5604102e87.1
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710879701; x=1711484501; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1LgPRCDFz8qsX4vbd//GIYpaJaeOZZvVwVGJCnukQRE=;
        b=aQ8UxcXHnJebqdF7eVh6sSdrjdb+dgb6W5Zs67KGslYmdo0RWTrIINOs5xxvFreK2g
         cwEtEt0JPYgNSNzsHVcXY2akVjUThAze3aelr72Tqfjv4VIf/HmMhubx14uWxgD7NXpB
         LFyFjKsrn0QdFaFDhrjIaMUInpPT8SAb1f+5amyg06UJW6O4k/SzoUFJkzByuQX/stMN
         BzN7C2jHy3jIV9Ds8/VzHa8jJmzzcWq0vJUd5S+0pB3sehEUQ1WW8mtw0L/NSIhTlM8s
         08eUG6McmZ6qvdlA7twXX+ZlWiNyH/ooLcEnAY9sAgY1SQPZLlQuyeXOu6vYxKw/bgSR
         E4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710879701; x=1711484501;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LgPRCDFz8qsX4vbd//GIYpaJaeOZZvVwVGJCnukQRE=;
        b=bItd/B+BpZlTV3z1AwNMtzNJao+4Ma8mziLHSTdCmx4IFRS7VTgMlUuY+zhTIzIY3l
         +z5YDfBqndfebT9L82GyJ4m4goVPaZ7SS47ECN8XJ2RgbjZBKdMlmnU7kfuD2yDKwvGT
         ABWxqXpw8HLtoAl/eET+CfW7istkIdG7XcBelVq95GIVTgUTMKcJGXEtkW+Mc4sOv7MV
         3Td24MD4NNvNQ0Mx1P9iTRL+mCW5IKtVTdgRVOAsa7o9cMP28F5kjaAFZz20H2b1nh4m
         osGz66s0EP5wzeqjSg7SSg3FfA1/2kXRnb7VUbUI27O77h+lPCyvJOSrDtaH56SnHq3P
         eD3w==
X-Gm-Message-State: AOJu0YxcwRQ1NbBdS9GJi18T7SOao/K7k+7MZfGtpCtA2JT0RlFZ4eqD
	Qsgiw7r+2QXj1X7i3qxwdoIO15zonzxl2F1mBY0Bv1H3ynWKH8dv1Ty5z39DnkG2B8mc1nqJdBJ
	uoC9D5Fo/hIhf7MuX6HHUuQIiO7gp2xrh4sw=
X-Google-Smtp-Source: AGHT+IEfm4CQw2pd0JQWxUuR9CcR3GQZTn5Y6MepQiLuYNgWNB1RK5mJc0WSKbCe4THbL+GNczNyxgqhiOIDTXOiWnQ=
X-Received: by 2002:a2e:9114:0:b0:2d4:8e2f:e3d6 with SMTP id
 m20-20020a2e9114000000b002d48e2fe3d6mr7774632ljg.10.1710879700657; Tue, 19
 Mar 2024 13:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN7Jk_3_ys4tAJ3B5uy1aUpzknEgQRwdADNxFXDmLxgCL2bZrg@mail.gmail.com>
In-Reply-To: <CAN7Jk_3_ys4tAJ3B5uy1aUpzknEgQRwdADNxFXDmLxgCL2bZrg@mail.gmail.com>
From: Sanchit Jindal <sanchit1053@gmail.com>
Date: Wed, 20 Mar 2024 01:51:31 +0530
Message-ID: <CAN7Jk_0hKTacR4cQiYFW-dcj6ipA=8QcCGrVd7rrJ4vVUxUBKg@mail.gmail.com>
Subject: Fwd: [GSOC] Microproject: Use `test_path_is_*` functions in test scripts
To: git@vger.kernel.org, christian.couder@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

Greetings,

My name is Sanchit Jindal, I will be graduating with a B.E in Computer
Science from Indian Institute of Technology, Bombay this year. I am
writing to express my keen interest in contributing to Git as part of
the GSOC program.

As I prepare to graduate, I am eager to contribute to open source
development, and I believe that participating in GSoC with Git would
be an excellent opportunity to kickstart this endeavor.

For the microproject, I can update the file
`t/t9803-git-p4-shell-metachars.sh` with the `test_path_*` asserts as
required,the tests only have the checks at 6 locations which can be
replaced with `test_path_exists`, `test_path_is_missing` and
`test_path_is_file`, Please let me know if this is enough for a
microproject.

I am particularly interested in the "Move existing tests to a unit
testing framework" project. I plan to familiarize myself with the
testing framework, and the changes needed in the codebase for the
project

Regards
Sanchit Jindal
