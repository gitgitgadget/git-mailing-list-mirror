Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E613A87A
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586743; cv=none; b=T1ZHWrEOQhStYZuDBfJxo0OgW4O/pEuTkscFI2GLj1qAP0MnOpCXQI/4yb2eukYn4ZHWkZwPi5qtQ04Iwg7biu+Dkdrt3bAbvfcVsWHKd+vMhgJi4wdxfoGa5RrAF0BoFE/CAjEw9DYhYGVKfBgI87fcTRdM4uA0l97qo1Qaxyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586743; c=relaxed/simple;
	bh=NIX9cisWJvXKQgBiGFEeA5TDWrNRGsx+R19mZdkiXDU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlRlli2r9h1hOV/NN33/Bq1AwMtSUpp9hWt3QFxLF4n4H5ttoBD81xkSGrkJFz3BlfDvFrXkB6tTVu056sIWm9IGmpPHRQ/h7cBcBhchtOrNYp8XU5zeUE/87c4+aMOaYVP/WRmMql826nflmfjca5BkIpk5IyU1aE7QWc8RPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhurk2eI; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhurk2eI"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50d24099415so1485553e0c.3
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 01:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729586739; x=1730191539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8BgsXHNYBvtfH3F1MY6fXwGXzMFSZCAZXm/11GyI0c8=;
        b=mhurk2eIiiPYPFlbWUeX5Wy0TNsUSWyUQZ9zvhEQwXIrnkYGmnzdXhoWiYJCXDnZyg
         8NH9o3tFSat2NklvCZPbeRy79oc8OKY2qMj4fPxU8sEa9BvYifi/mbOv3oquC4W9S6gv
         Qn/fYTRpFCFNWHryH/z17+JKUe4TtHZZf3crd+kfoWsuEXjWAjhkToYNPkcr1dxBYz50
         +4AODDhNl68WADHncbjrgfoz8/jFGsllgSNI9PWuyH2LTBiy1UQldv2+DItaUXGuZnMi
         2Rbe4bF+fF04DgD0JidW7vPRHh8CcEYiN9DGMAQ3z8E4T76KqUFVGsoxNaejC6K0x8sr
         laFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586739; x=1730191539;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BgsXHNYBvtfH3F1MY6fXwGXzMFSZCAZXm/11GyI0c8=;
        b=MrgMppgymxM/nCe37OucSNPZsAX3Om8XtOxwa/qor1Sy4Mn0GJ2ZSq2s9aMO7gdltT
         KXQqy+9V3845tIZnjOviZsIAJMeXZf42Nx7EO18L7Qdep93bKbTdYUwEXxCCYGeV75KR
         vpmM8TuDNSxWB4DIVrPtWHKwm3/uMAn3C3F/4Cnf0GP7iIt8Q5L6kOn+LqsWAen0xkij
         eaNceLPQ0Bv1hGWVgyEGYyycb1g2ke+DEpwZ6qf+KfV7NhwlFnzY3YZ5W7HJf0ZUakFn
         QQrVcFCaGg5hHgyZi+X8uSM+zz7PAdnZlvHzTGCCaU9ClnLHl5EZCufa5ExBoFWpV7fh
         VVXg==
X-Gm-Message-State: AOJu0YzlCK9Gx7HG3T4ZdwcPWOaJytPcyrWVNcZCPTGa3URL87WOMh3e
	89Dbs22vNffwHHDFtici/C7glUNkWwBgDiB/THPW5oUyhLoFmMfZjlndv3O0DNUOYpd9XqynjH3
	G7ChUbT6qtPtL4nG9PZXmzZNv6EviL7I7
X-Google-Smtp-Source: AGHT+IFGqWFz7DkgmrKlCcVmXbELIpCj9YTbqQUOLT8MWUosHKzKeiYqpLDg97PTdomgdpHSa+Tg+Lmmj/LxXe+Zcow=
X-Received: by 2002:a05:6122:30a2:b0:50a:cb38:31d5 with SMTP id
 71dfb90a1353d-50dda3a1f9dmr11379467e0c.12.1729586739306; Tue, 22 Oct 2024
 01:45:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Oct 2024 03:45:38 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZxazVG65+W0qKLXh@nand.local>
References: <20241021124145.636561-1-karthik.188@gmail.com>
 <ZxZP01C-9RngukZy@pks.im> <ZxazVG65+W0qKLXh@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Oct 2024 03:45:38 -0500
Message-ID: <CAOLa=ZSPmkdngn3=cksBM-syO94-zYANLk8FWBsQYpTR8XT9FA@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: discourage arbitrary suffixes in
 function names
To: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000034892406250ccbcf"

--00000000000034892406250ccbcf
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Oct 21, 2024 at 02:59:00PM +0200, Patrick Steinhardt wrote:
>> On Mon, Oct 21, 2024 at 02:41:45PM +0200, Karthik Nayak wrote:
>> > We often name functions with arbitrary suffixes like `_1` as an
>> > extension of another existing function. This created confusion and
>>
>> Micro-nit: s/created/creates/
>>
>> [snip]
>> > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> > index 30fda4142c..b8e2d30567 100644
>> > --- a/Documentation/CodingGuidelines
>> > +++ b/Documentation/CodingGuidelines
>> > @@ -621,6 +621,11 @@ For C programs:
>> >      - `S_free()` releases a structure's contents and frees the
>> >        structure.
>> >
>> > + - Function names should be self-explanatory, clearly reflecting their
>> > +   purpose or behavior. To maintain clarity and avoid confusion,
>> > +   arbitrary suffixes such as _1 are discouraged, as they provide no
>> > +   meaningful insight into the function's role.
>>
>> Names being self-explanatory is certainly a worthwhile goal, even though
>> I guess that it's a bit more on the idealized side of things. Functions
>> will often not be fully self-explanatory, which is likely just a matter
>> of reality. I mostly just don't want us to end on the other side of the
>> spectrum where we go militant on "Every function must be no longer than
>> 2 lines of code such that it can be self-explanatory".
>>
>> And yes, I'm of course stretching what you are saying quite a bit, I
>> know that this is not what you want to say. I'm merely writing down my
>> own thoughts while thinking it through.
>>
>> So, that being said, I agree that we shouldn't use arbitrary suffixes,
>> as these are quite hard to understand indeed and typically don't really
>> provide any context. So as long as we interpret this rule leniently I'm
>> happy with it.
>
> I am not sure here... I think that using a "_1()" suffix means that the
> function is processing one of a number of elements that all need to be
> handled similarly, but where both the processing of an individual
> element, and the handling of a group of elements are both complicated
> enough to be placed in their own function.
>

The crux here is that this meaning is internalized by people who know
the code through in and out. But for anyone new to the project, this is
not evident from the naming.

> It's also a helpful convention when you have a recursive function that
> does some setup during its initial call, but subsequent layers of
> recursion don't need or want to repeat that setup.
>

I get the usecase of having such functions. I totally see the need, it's
mostly the naming that I'm trying to change.

Let's consider two of such functions:

1. mark_remote_island_1: This function is called to do _some_ work on a
single remote island when iterating over a list.
2. find_longest_prefixes_1: This is a recursive function which is used
to find the longest prefix.

If you notice, both use the "_1" suffix and do different things (operate
on a single instance from a list vs provide recursive behavior). So the
user has to read the code to understand, which makes the "_1" a bit
confusing.

Second, this could have instead been named:
1. mark_single_remote_island: Which reads better, giving the idea that
we are really working on a single remote island. Whereas having a "_1"
doesn't easily imply the same.
2. find_longest_prefixes_recursively: Which also reads better, and gives
a hint on how the function operates and why it is split out from the
base function.

> So I'm not sure I agree that "_1()" is always a bad idea as this changes
> suggests (i.e. by writing that "they provide no meaningful insight into
> the function's role").
>
> Perhaps we could rephrase what is written here to suggest a couple of
> instances where we wouldn't want to apply this rule, and the two that I
> have written above could perhaps be a useful starting point. But I lean
> more towards not adjusting our CodingGuidelines at all here.
>

I hope my reasoning convinces you of the benefits, this is mostly coming
from me spending more time than I'd like to admit on one of these
functions, trying to understand what they do :D

> Thanks,
> Taylor

Thanks,
Karthik

--00000000000034892406250ccbcf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 39afd9a1bf9d6093_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jWFppNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0p1Qy85TXdPeDFaRHo2TXJJKzkrR3hXS05wcnFTUAo2V3loKy9iQndX
RmlVNGZLN0lkZlN0dkpacnNKNlRSYytqZ0svZHhlblV2ZHAzeXVjSzJ0WWtBc0ZrNGRBZ3g4ClMz
K0ZqRWs3SUI5cjU0YTBJbUE3U2NqcnRkak9ENzltbFprcnQybHkzNFg4VUp2bzEvNGo1RVRBbFdF
a2IyTGsKRlEva05UZU0xZUNiQUlJNGZkem5vbEtKbEZhRVE4OTZaNzBYNHNnT09IdEFmbnZBYVJp
NVg0QThlTUNIRkhRMQo0RUMyR3R6V0tKQndzRlQ5Y0hiYndYZWdtSFlQdWdTenNyc3NqV01vQ244
V3BtdTZVOHdDc1Vhdk5KcXVjemRQCkxxR3ZidUduVkxJYm1scnlXTHdXNDRyaHI2L3VtbHR0NC9H
bXl1bEppZHR1WkxlcTBreDYvOFlTOTVNNGFVWkgKUkFQN3BFN29aOFBhSVBCc3pVaVBTMFhRNmI0
RVVGelkvVXRmMzVyZUJSUlFOOEwxbE43YUV1WUFqMG0razl1dgowWXBEMVVhZ2doL01Kemx0cDBW
UUZDaG16TU9tUWNBTFBvOHBsUjErZFFST01lVmUxTGZqMkdVcmVORGtXbEZpCng4R0VzZEZyWGlT
Q05hc1lRR1IveUgrTmhqRDI0ckdncC9EcFUxYz0KPXZ6RU4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000034892406250ccbcf--
