Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99666F2F6
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290234; cv=none; b=lWhHoM3QwdFRW7e2Me5fbPJ6fZoG2AhIviD30MyjVzBRrtHFhqs4UyGjmKjTclenZ6QvpMs9MoJu+K+TzbLYfcgra8EZl6se0rwNSJ47N003lMbG21h71lthSv7pmF6RNyJj22eONxqyCFw+pba+u5jXa+Z0nm5QYNEZ4kRE4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290234; c=relaxed/simple;
	bh=2M6bPyDEwfVPDKyMlfIg8t8jc6ycJ5MrZL7+KwoRLdQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hISQYqNyW4UWfcTNKI1bBW3xRlT8Cj+lYRv03OAMOhCjxnNZtGURVXU5UMCB9k65J4LkYVXQwo3anmnMfFPUKLJu06ZUWgTyAlnx8h8b8/sNyGs7o0ThGtSINEKgxKnkBa36ZR4CfePncCt3xrSFi2vt4Qfatg1mtY0VxqGAEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNmmminM; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNmmminM"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d92df7e83cso500533b6e.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721290231; x=1721895031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OtCu6CQ7/mjAX6vtSk0ZF17nMQQa7pEfPCY5hNFEpTg=;
        b=SNmmminMsBZuDpI7h4JiPrVU7g9liptnV8W4IeLWKXGnd6MiZSFfwQd5uUhiueO2Km
         N/DJbwJ28PyYbqWgXYqds8HtB1CDpP3zCUr3gSdXQ0dyNuwBaClqCR1t6JAi6uWjdP2t
         erWwXRQxaUIRMdZCvTJKypzLRisyrTmKIiwq36rYTi8QMKltLFuVIIITQv768PTsfvjo
         J6Tzak3qrBANUEXNXr5SiUApe9O/JevqXrRiZwQvEBmCQdssniLjVi3hgbMBZbgSNmKD
         89uGaulXdlfjqmwci8EwdH0MnCIU5uI3bes3g1oMWOV8eb+OTWGF7J2hEZ64xfmMmdGo
         KoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290231; x=1721895031;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OtCu6CQ7/mjAX6vtSk0ZF17nMQQa7pEfPCY5hNFEpTg=;
        b=UuPwidv/1UPX6W4xDSvdhxz92YlHrYcqpCfEenEsFqXQngy7MY45PEGBSHLQ1j4qCN
         /rv6sBBK4CkmBLFSncnPXntpQdDBd5w+oPzAKlQ2ZgQsNKUKEOcHc71Xe2gyohw1uW7z
         ja0bXOBvqOHmLBV/S2gG02/lkHIZYRRIN8sGD+1T/zR285vIhroRWJMsTM6EJhpCDSI7
         K6pbMqy1ypzIIxDOoQbVsal38/3d3AcmZ5gfTpRrsVUPRBasEEUwD3WibBdAoKFs8/7M
         zTGP0NO1v8Gjcc4PUTZsHiQryPvG0jOuyQC2pLQhsYJMJdc96HjfHtHq0ADaEb0uVmCw
         BGng==
X-Gm-Message-State: AOJu0YwVutpNZwJHHuKlDuX8EtfuuCEOSGeOsbu2YeRYlLca5PqGd7V6
	eBF05b/EQGDOiDZ605WhQA/P/W5KE2gMV4LIT4ui46NWrIz7oMIa9TpHKxo45p/54rHbzAoyHty
	Bdb5BUBjNAT2uoLGClZyHGK6Jd+s=
X-Google-Smtp-Source: AGHT+IH0CA5kFdKNJC/1cLUGZZhDs7urLoCtyuw3j/NuX+Qyw19Hg9Rhxte2voZ4UVLiytKkl8pYDuIxSmSrWS+e90g=
X-Received: by 2002:a05:6870:210e:b0:260:e777:32a8 with SMTP id
 586e51a60fabf-260ef737686mr870756fac.2.1721290231563; Thu, 18 Jul 2024
 01:10:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jul 2024 01:10:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CA+J6zkRWzq_XNf-E7Nx4_D7rOOjN4Bwi4g3zgzV6YCiVoCe8rA@mail.gmail.com>
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com> <20240716075641.4264-3-chandrapratap3519@gmail.com>
 <CAOLa=ZQxDXDDWXQrt9kpykuMr6nxSA8uf2U2nu0ChTf3yuH8sQ@mail.gmail.com>
 <CA+J6zkQLXsDdSa5xjizr82bPUCng0-XZJRNQ1CAV7ttDbE03xA@mail.gmail.com>
 <irlg4rgsbfedphbxemj6pns35aceuwqrth6gyj6hi56fmr25n6@yvp4od2ydc26> <CA+J6zkRWzq_XNf-E7Nx4_D7rOOjN4Bwi4g3zgzV6YCiVoCe8rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 18 Jul 2024 01:10:31 -0700
Message-ID: <CAOLa=ZRGV1-3cDxgJd9zENTCEPqz04AFwWmkQnYwj5Cbg=EmfA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] t: move reftable/tree_test.c to the unit testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>, Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik188@gmail.com, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="000000000000cee39f061d811c20"

--000000000000cee39f061d811c20
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> On Thu, 18 Jul 2024 at 03:45, Justin Tobler <jltobler@gmail.com> wrote:
>>
>> On 24/07/17 08:00PM, Chandra Pratap wrote:
>> > On Wed, 17 Jul 2024 at 18:09, Karthik Nayak <karthik.188@gmail.com> wrote:
>> > >
>> > > Chandra Pratap <chandrapratap3519@gmail.com> writes:
>> > >
>> > > > +struct curry {
>> > > > +     void *last;
>> > > > +};
>> > > > +
>> > > > +static void check_increasing(void *arg, void *key)
>> > > > +{
>> > > > +     struct curry *c = arg;
>> > > > +     if (c->last)
>> > > > +             check_int(t_compare(c->last, key), <, 0);
>> > > > +     c->last = key;
>> > > > +}
>> > > > +
>> > > > +static void t_tree(void)
>> > > > +{
>> > > > +     struct tree_node *root = NULL;
>> > > > +     void *values[11] = { 0 };
>> > >
>> > > Although we were comparing 'char' above, here we have a 'void *' array.
>> > > Why?
>> >
>> > The array is passed as a parameter to the 'tree_search()' function which
>> > requires a void * parameter (i.e. a generic pointer). In the comparison
>> > function (also passed as a parameter), we cast it to our expected type
>> > (a character pointer) and then perform the required comparison.
>>
>> The point of `values` is to provide a set of values of type `void **` to
>> be inserted in the tree. As far as I can tell, there is no reason for
>> `values` to be initialized to begin with and is a bit misleading. Might
>> be reasonable to remove its initialization here.
>
> The thing is, the values[] array being 0-initialized makes debugging
> a lot easier in the case of a test failure, so I'm not very sure about
> getting rid of the initialization here.
>
>> > > > +     struct tree_node *nodes[11] = { 0 };
>> > > > +     size_t i = 1;
>> > > > +     struct curry c = { 0 };
>> > > > +
>> > > > +     do {
>> > > > +             nodes[i] = tree_search(values + i, &root, &t_compare, 1);
>> > > > +             i = (i * 7) % 11;
>> > >
>> > > It gets weirder, we calculate 'i' as {7, 5, 2, 3, 10, 4, 6, 9, 8, 1}. We
>> > > use that to index 'values', but values is '0' initialized, so we always
>> > > send '0' to tree_search? Doesn't that make this whole thing a moot? Or
>> > > did I miss something?
>> >
>> > We don't use 'i' to index 'values[]', we use it to calculate the next pointer
>> > address to be passed to the 'tree_search()' function (the pointer that is 'i'
>> > ahead of the pointer 'values'), which isn't 0.
>>
>> The `i = (i * 7) % 11;` is used to deterministically generate numbers
>> 1-10 in a psuedo-random fashion. These numbers are used as memory
>> offsets to be inserted into the tree. I suspect the psuedo-randomness is
>> useful keys should be ordered when inserted into the tree and that is
>> later validated as part of the in-order traversal that is performed.
>
> That's right, the randomness of the insertion order is helpful in validating
> that the tree-functions 'tree_search()' and 'infix_walk()' work according
> to their defined behaviour.
>
>> While rather compact, I find the test setup here to rather difficult to
>> parse. It might be a good idea to either provide comments explaining
>> this test setup or consider refactoring it. Honestly, I'd personally
>> perfer the tree setup be done more explicitly as I think it would make
>> understanding the test much easier.
>
> This probably ties in with the comments by Patrick on the previous iteration
> of this patch, that using 'tree_search()' to insert tree nodes leads to
> confusion. Solving that would require efforts outside the scope of this
> patch series though, so I'm more inclined towards providing comments
> and other ways of simplifying this subroutine.

Agreed that refactoring `tree_search()` probably is out of scope here.
But rewriting the test is definitely something we can do.

Perhaps:

static void t_tree(void)
{
	struct tree_node *root = NULL;
	int values[11] = {7, 5, 2, 3, 10, 4, 6, 9, 8, 1};
	struct tree_node *nodes[11] = { 0 };
	size_t i = 1;
	struct curry c = { 0 };

    // Insert values to the tree by passing '1' as the last argument.
    for (i = 1; i < ARRAY_SIZE(values); i++) {
		nodes[i] = tree_search(&values[i], &root, &t_compare, 1);
    }
	
	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
		check_pointer_eq(values[i], nodes[i]->key);
		check_pointer_eq(nodes[i], tree_search(values + i, &root, &t_compare, 0));
	}

	infix_walk(root, check_increasing, &c);
	tree_free(root);
}

Wouldn't this have the same effect while making it much easier to read?

--000000000000cee39f061d811c20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 80860d74e8a8164a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hWXpmVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMDZHREFDZUVra0xoUzVXT0xaa2pEckwxa2RqeFcrRgpOV3NOYkFBMHJD
QWdtWHppenVZcENLeTRWMmRlOWRTQjlxTHhyd25hTEdmNDRVd1JYVk5hd1VqVUEwZmlDZkYzClN5
WmhFSTdvb01vcWkzSExXRUswT0dMRkJLckFXZUxJenFDRy9PYTVUNEdxOUNOS1liKzRFQmVIdktt
ZGVmRTEKN25zbGdOM0RrdnNyN0ZteDh2MzlGZ09ReGlPRUlHMjIxT2pPNVZ1L1NPMEkwQ2pUZjZW
NTYxZ3lvUFVoaWJMaAp2TldpRjRjS01zTlloaUNHWUZCdzlMUWlJejJTTXFSaFZ6L2NzeGJScWpY
TFo1NHJ4VXplbno3L000OTQzb1BSCko5a1ltTWJCQTZoNXNleHJzbmFIbjZ3V2d5dUs3eTlJSXQ3
bGxPUEU1K3hPY1ArTDFnVTFFZUNHQVpxRk1jeG4KdGhhZHBqclBNMm1FTUoyS1UxU0hSM0FhTnVt
T1FpU1ViR0RNbjJoNlluK1h6SktvUnE4Tmd0SlQ4djBvcmRJeAo1Q3pVUTRERVozOTRtV2p4L0M1
MjQ2QVo5Z2VDSllaaGlicjR6M2RiazhCWnVPb2FlaG84dnllR3lqTmFpaTdTCm0yWHRKdkt5OEZD
N2p0eWhrVEl6bUxPMDJaTEw4Wi9iYnlaU1dVST0KPTZZMXoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cee39f061d811c20--
