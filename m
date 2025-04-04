Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3B3D984
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743764910; cv=none; b=LDaRmXJA12p6mfvRagnxt3887ChJ1aEf7Dt99n8ryLAHwIvIifE6Ib1Yt3SOOcpyKuyua8c6PVwjHlP+e4ztSbPx2jKFZ6fsbf2VlgZLrkaX8dSuP+RdN9w9J7ROl1QDVvFguKD8o/rRo0qWS08gJGU1lhfSBuLs4HqKICyhvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743764910; c=relaxed/simple;
	bh=wzif7DxQJXEWM/mIP285JxwHjjvMYqcc6y/7FW0L2OA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYzNpLCQkSt3Dr8TuwGrRZ3kZRBJ0aotB/gS02tZGPRZmbPvYKRXq4ZGKU3h7ZE+buAXI1xNeWlY+C4TnzaOA6VjK5RF1j2oIL8kPsUpY490ByhbosH4ryohla8MLa9E8/0hd88xxfgnWGIgwbcQ1L1OlzHJsaY5EyWZF1rTQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2etyvr8; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2etyvr8"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so2592157241.1
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 04:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743764907; x=1744369707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O6xoAP0Mc+oKwVN/6lsz3Qipl/hqeM2buZQ6ehaAbh4=;
        b=J2etyvr8OM3mAeskuNLppqn2LtYZOho0+OG7NQREKHqFpZ/0B+e33UoEoxr+iOEdfq
         aUDuxgJDGmD8XIbPDnL9v/lFOpIEmX6Ig52Oep/5sSadPpixrOsb0dh3UxPS2MtkiIjy
         kwu43X+DUk5ZfR9a78R277JeHC2TYGEECNbGwzZWFgcWsJBk93ftS9A1/L8iMt2ogdZE
         B+3Ah4OLhL7G33jKN0ZRVf10V5KclAj7Tr70msjeczAY8ZWMRxh4TKh+9HldlK1dg4SY
         4UkwiwhpRPo4OyPlqMUeRBqOIOjC7zUhou0/oEU5NbCYx0iBW7+HS+RELoiaTLpZ5Qjc
         ZZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743764907; x=1744369707;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6xoAP0Mc+oKwVN/6lsz3Qipl/hqeM2buZQ6ehaAbh4=;
        b=ADLz5dOyFIgDDES3ZgWicn8+rbfCUM3w9BHvL74IwDA3xHLzu0MtnCd8StYg8YdD00
         R7FJUqPpGgeTE4OH2yW84hGMofTHJoUustHHAu1L1jEgIU3g5rtL7BSRTQOgNeyiGnEl
         PxogS3AJ6o2ewljBwspi+RreW2Xehdz8PQ4tSc9TTmPXTlpFyKIg6Li21ZpYhCs2chDe
         8xQv+pXFjs6aCKI4qcs54+yl3RPZUHMnXsM+B8oiPbiSFC5x268vZVHJ4zC4wvuw8/Jl
         /sGV5Dfzw8+4MZU3xuKRDGGtWr+6qNbbjLlwwXwsdyr12hmn6TXvuZBtbA9FlWKter5e
         4TRg==
X-Gm-Message-State: AOJu0YwvC+RQ6BkDTS8Dc5Tpa3wyUMRjio4bpIlO1sByocOt0UWmkC30
	Bo+dq7NR0SAz6GgEfC8VdO3n7Wew1vMwSDPgOECSZCQaYmVsUvF/xwvONgqLIg3FMYoRakPV0Dr
	1nck3hxbbqVxnkdDLHkMSOVwFE5KzWr3j
X-Gm-Gg: ASbGncs+B1Z2cJUpHHmxI/gdz/oLOFrLZiYdMUDW5yEXdr8s155VKl9eRm1LjpLFdDK
	5LAz9nerSaWP2K0KKiDJhj0E/ZSXfcs7NwiHH6OU2aalMVAlhazXLLMrqB4SKTVAp1wU0VD6g3i
	9Myj92OsuM/hClFfEtJVizRYRTwn8ka6UzzXq0JlIfvsbW4V3rAx1OxwwIqnDs
X-Google-Smtp-Source: AGHT+IEGGCGvYMLHpeeoytDHYAI2Tz5B91si6CfaRLouWNfZYI/PtVAS/+R4HjKL9qg6bWiYqXx61tk53EaveOKcFrg=
X-Received: by 2002:a05:6122:181b:b0:524:2fe0:61bc with SMTP id
 71dfb90a1353d-5276491b0d8mr1687317e0c.5.1743764907181; Fri, 04 Apr 2025
 04:08:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Apr 2025 04:08:26 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Apr 2025 04:08:26 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250403154404.3459805-1-05ZYT30@gmail.com>
References: <20250329150248.2274482-1-05ZYT30@gmail.com> <20250403154404.3459805-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Apr 2025 04:08:26 -0700
X-Gm-Features: ATxdqUFgIVSYQDmrhhwWCcGWLezbmAyIw8p3vDzxu5v4cyylJpybbtwt6ZM1aGE
Message-ID: <CAOLa=ZTTPuNyaE5Z-bfkQougmKQSrRZZwLaxJUL7mdmj8uHoFw@mail.gmail.com>
Subject: Re: Discussion on git-refs list Implementation and Possible Approaches
To: Zheng Yuting <05zyt30@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000dd662f0631f1e774"

--000000000000dd662f0631f1e774
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Zheng Yuting <05zyt30@gmail.com> writes:

> After an initial review of the code and documentation for `git-show-ref`
> and `git-for-each-ref`, I believe the functionality of the `git-refs list=
`
> subcommand can be categorized into two major types:
>
> 1. **Filtering options**
>    - In `git-for-each-ref`:
>      - `--count`
>      - `--sort=3D<key>`

I would categorize '--sort' into a third subcategory. Filtering refers
to possible change in the size of the sample set. While sorting is more
of a presentation utility.

>      - `--points-at=3D<object>`
>      - `--merged[=3D<object>]`
>      - `--no-merged[=3D<object>]`
>      - `--contains[=3D<object>]`
>      - `--no-contains[=3D<object>]`
>      - `--omit-empty`
>      - `--exclude=3D<pattern>`
>      - `--include-root-refs`
>    - In `git-show-ref`:
>      - `--head`
>      - `--branches`
>      - `--tags`
>      - `--exclude-existing[=3D<pattern>]`
>
> 2. **Formatting options**
>    - In `git-for-each-ref`:
>      - `--format=3D<format>`
>      - `--color[=3D<when>]`
>      - `--tcl`
>      - `--shell`
>      - `--perl`
>    - In `git-show-ref`:
>      - `--dereference`
>      - `--hash`
>
> Additionally, for filtering functionality, the `--ignore-case` option
> from `git-for-each-ref` should be supported across the board.
>

This is indeed a special case which applies to both sorting and
filtering.

> **Note**: The `--verify`, `--quiet` and `--exist` options in
> `git-show-ref` are intended to be implemented as separate
> `git-refs` subcommands and are not within the scope of this
> discussion.
>
>
> ## Implementation Considerations
>
> At this point, I haven't come up with a perfect implementation
> plan, as each approach has some issues:
>
> ### Approach 1:
> `git-refs list` would support both filtering and formatting options,
> meaning it could provide:
> - Filtered output
> - Formatted output
> - Combined filter + format output
>
> However, I see two potential problems with this approach:
> 1. Would it make the `list` subcommand too complex?

You mean complex from the user perspective of having too many options or
from the implementation perspective.

I think from the UX perspective, it is a good time to rethink usage and
need for the options you mentioned above. , for e.g. with '--format', do
we need to have '--tcl', `--shell` and `--perl`?

> 2. The performance could be worse than `git-for-each-ref`.
>

Why would it be worse? The performance difference between
`git-for-each-ref(1)` and `git-show-ref(1)` stem from the formats they
use by default.

$ hyperfine --shell=3Dnone --warmup=3D3 "git for-each-ref" "git show-ref"
Benchmark 1: git for-each-ref
  Time (mean =C2=B1 =CF=83):       4.0 ms =C2=B1   0.6 ms    [User: 1.9 ms,=
 System: 1.9 ms]
  Range (min =E2=80=A6 max):     3.0 ms =E2=80=A6   5.7 ms    680 runs

Benchmark 2: git show-ref
  Time (mean =C2=B1 =CF=83):       2.9 ms =C2=B1   0.4 ms    [User: 1.2 ms,=
 System: 1.5 ms]
  Range (min =E2=80=A6 max):     2.0 ms =E2=80=A6   4.3 ms    909 runs

Summary
  git show-ref ran
    1.38 =C2=B1 0.28 times faster than git for-each-ref

What I found interesting was that changing the format for
'git-for-each-ref(1)' gives it a boost:

$ hyperfine --shell=3Dnone --warmup=3D3 'git for-each-ref
--format=3D"%(objectname) %(refname)"' "git show-ref"
Benchmark 1: git for-each-ref --format=3D"%(objectname) %(refname)"
  Time (mean =C2=B1 =CF=83):       2.4 ms =C2=B1   0.3 ms    [User: 1.1 ms,=
 System: 1.1 ms]
  Range (min =E2=80=A6 max):     1.7 ms =E2=80=A6   3.6 ms    1070 runs

Benchmark 2: git show-ref
  Time (mean =C2=B1 =CF=83):       2.9 ms =C2=B1   0.4 ms    [User: 1.2 ms,=
 System: 1.5 ms]
  Range (min =E2=80=A6 max):     2.0 ms =E2=80=A6   4.5 ms    833 runs

Summary
  git for-each-ref --format=3D"%(objectname) %(refname)" ran
    1.20 =C2=B1 0.23 times faster than git show-ref

> ### Approach 2:
> Split the functionality into two separate subcommands:
> - `git-refs filter`: Handles filtering and filter + format output
> - `git-refs show`: Supports formatting options
>
> For implementation, my initial thought is that `git-refs filter` could
> reuse the formatting options from `git-refs show`. Perhaps this could
> work similarly to how `git-add --patch` and `git-restore --patch`
> share logic, though I haven=E2=80=99t thoroughly reviewed that part of th=
e
> code yet. Would this be a reasonable approach?
>

And what is the expectation that when you want to do both filtering and
formatting, would the user be expected to do `git refs filter | git refs
show`? Generally users want to combine both of these options.

Also wasn't the idea to already implement `git-refs show` as a
standalone which simply shows what value a reference holds (without
derefence)?

> ## Overall Plan
>
> If Approach 2 is preferable, I could start with `git-refs show` since it
> only deals with basic ref listing and formatting. I would then make
> the formatting code more reusable to support `git-refs filter`, which
> would focus solely on filtering.
>
> If Approach 1 is chosen, the implementation plan would remain the
> same, but everything would be handled within a single `git-refs list`
> command.

While I would think Approach 1 is the better option here, I'm also
seeing how it is complex, perhaps a good option to get started would be
to implement a simpler subcommand as a first case? Perhaps the
originally discussed `git refs show`?

>
> I would appreciate any feedback or alternative suggestions on the
> best way to structure this functionality.
>
> Thanks!

Thanks for the proposal!
Karthik

--000000000000dd662f0631f1e774
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3e401f387a0241a4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mdnZhTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOTBtQy80OEpUUi9jcWU1b3UvdDVPbUJKQ1ROZldneAo5VnFHTEFCeDll
UlE0NTNNSjFTbTdnL2hKdjR0QnVIU1o2eXZsQ1BaNlUzVUsrbEY3SkFSRmlUOXFlMVo4aHNBCndW
S2tGclNBZ3VBNlBJcEFSYXJrYjdha2QwQ0tBVTFtVXZqeDVJRnlkMVppWXU2UWJCamhSa1JJS1ZZ
UFJyQ1cKQk1Lb3Z1N2NOU0I4SEJlZGdBeUplVzBsVjd1dURnWGh0RFI3RFIzVXZPRCtEYnhBYlpz
TWRvcFFzbU5YSXpURwpTUjZoaUFLK0c0b2FTWEJITVJDMk5xU0pRQjBkMEM2TDVxRlREVzl4NlVi
NlBlY1U1UlhKV1NBSG45Si91RGI0CnJSYmVYYkowZXU4ajRxYmtUSzBDOXA4WmRVTVRZWGhUWmpO
dTc0VEg1djdWeFo3SWdvNjlHd1A0bXRveStXV3cKOVlSd2JIUmpjYUpCNTlTSWxKWlBHVnlWQkcr
KzAva1lvZFlQWjdDc25FTGtJd25xOTJZcWdIbW4weTFhK05ENApMS3Q1QzlHa1NkU2llT1BaL1hW
WURrWVRhVUtQNHpReXRpSjIxQjBUWVJmNHk1aWZ2emFCMVcwR1gyOGtrZEkyCjJ3ZlJ0L0hFc012
RURzT0t2ZGNPbTFLWVBmZzRoZzM1dElkYXJnbz0KPS9WeTEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dd662f0631f1e774--
