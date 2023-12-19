Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F06B208D5
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="nfqJ6zP0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703004160; x=1703608960; i=l.s.r@web.de;
	bh=AyOTQK69YDwuXumc4yuD+tRYQxPNOH7/N0y7+hOBjOg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=nfqJ6zP07/uQNrX67QUUeSx0c6Ok6Ct5hMUZApmV2pRf4rGI7GWE6/lOErzJtt/k
	 nslwARb/TEBPLsOf/237z9c2466sjbcwff1244g4PBAUIwC4jbq9vHdN9J5rnTiuA
	 u/bTv5m/bkiClbmESlk4Lms5agZwY+n1E3sLw+6K5bb9YcAcDgdb/vak9FNXfRs3s
	 CYozwYrPSseMgoKdYvbISIaka0BVZVASej6OFBiw43BqiJ6xjh06PsWVorcdUUvO/
	 Khkcc4srDGM2xk+9Y7wC6etgqFaQ9SjWDjJdOf4q13luFBJ8Nz+yAZ4oMWmusgBGf
	 36O51aRmh2WG8jhmew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mkmvj-1qshhf34Rj-00luF5; Tue, 19
 Dec 2023 17:42:40 +0100
Message-ID: <6750c93c-78d0-46b5-bfc2-0774156ed2ed@web.de>
Date: Tue, 19 Dec 2023 17:42:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/1] test-lib-functions: add object size functions
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Ondrej Pohorelsky <opohorel@redhat.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>
References: <CA+B51BEpSh1wT627Efpysw3evVocpiDCoQ3Xaza6jKE3B62yig@mail.gmail.com>
 <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
 <20231212200153.GB1127366@coredump.intra.peff.net>
 <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>
 <65557f2d-9de0-49ae-a858-80476aa52b68@web.de>
 <20231214205936.GA2272813@coredump.intra.peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20231214205936.GA2272813@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xWOmLxv9w+Ot+1pxxEFYAp33fgEFUCVtAX0lBsTDWUULIXgG4nE
 lKPo1eQnZh4zkLlmZbr5lwsBQFPxzu1BYhuG/hXIFU/aP8bqINKpuGK+uohQ72mPT8xta+y
 1qUNLhPmcA8Szp6s4m3ZHMktd9rKEBHX1SVIk3ewjltji8DTlW+yQeQrs3dZG7y9aAQRl5e
 br422uN3RxtyntlqyP2bg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NIi8+OWWsIU=;Gn1NgIQ9+sv4PQzAbLjE3koTKWa
 8HxkoNENC4R6FI4yKIjyB0CmUFFUW65j9d2ghdyKuzafnswfkNPZ/uF9I8m0Nxs8vITxrnf0W
 b9hzUFEIYK+9oVPNOAPevupV6zxLS8hvbjCkCW6w8cylejYyTCE7uy0Qtr8j22eJEjvPlZsxm
 UbD1yw89xZIDR9uG3B66jraZaDFMBMbYGJfB/mKW7fOmMsZ3aULXazjkDMB1m1hTebK9AbGLh
 /DtNZDvBbpiwaMkE0WPCgQHy/AKh64Io0ZpM0JkFbEU4as05V3NpQ5w2wCHjJObED8RZEB4Jz
 HvpXUGQfkXU6k0vy7Ne9IJsoEr20JP/KhIGQzifnURCXjX/Fzri4N3xFiFFxmS1i4A/DDmRFk
 +8/X6MbxoG9nSvkJtzVGfSnzI2MFawNa1h3UmrODE66yzv8AueAJLqi7PkepVsRsm+6D9h+rt
 yI75UTQPVBfhtSYmPzHIuw/Zh11QoSoxx/8HPQztIrH6EJxLYjorLu18CLnBpjRvNVJyMn8az
 iPQA8r84LQqcE+0MjdbQn4XZYBccpEnsY63pOGP4plwj/wCwtSyjY6nnv53IjP76oSL+JDTws
 Aa22LfN4Wm+xBlV6583fk/tyVjLpaS/viBA8YoY4pBeUzBnJfVAXHIJ3F+Nmk/Z4JKjuzD/+H
 UaM4eSohxj6kJT/rzY6PUguu+jXrgzYMuroITlPMG+gTxvKxTH+qPHifQjJg2FUUmCI+0OfXS
 OC9XNBqTl45qca9hNxPlg+fPPX8IDoq+ze/wSLU6XdGNLQPWYfctkNRmnpdowUjQokZ+rr9Ns
 0Abvm0d0Sv2IbqE7iasi4UwIxZGUcB/DmUKg78ESws6PQl+5Bf4Fq5Mir1apQwPxaqfL53fBl
 ICteD382NDcpEZA5ynqUp6Gm+pKQ0229ZuJSbARB57EcKZRMS3cEsqBVU+EfE/kPqPSa2W9C6
 xF2HJg==

Am 14.12.23 um 21:59 schrieb Jeff King:
> On Wed, Dec 13, 2023 at 01:28:56PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> Add test_object_size and its helpers test_loose_object_size and
>> test_packed_object_size, which allow determining the size of a Git
>> object using only the low-level Git commands rev-parse and show-index.
>>
>> Use it in t6300 to replace the bare-bones function test_object_file_siz=
e
>> as a motivating example.  There it provides the expected output of the
>> high-level Git command for-each-ref.
>
> This adds a packed-object function, but I doubt anybody actually calls
> it. If we're going to do that, it's probably worth adding some tests for
> "cat-file --batch-check" or similar.

Yes, and I was assuming that someone else would be eager to add such
tests. *ahem*

> At which point I wonder if rather than having a function for a single
> object, we are better off just testing the result of:
>
>   git cat-file --batch-all-objects --unordered --batch-check=3D'%(object=
size:disk)'
>
> against a single post-processed "show-index" invocation.

Sure, we might want to optimize for bulk-processing and possibly end up
only checking the size of single objects in t6300, making new library
functions unnecessary.

When dumping size information of multiple objects, it's probably a good
idea to include "%(objectname)" as well in the format.

You'd need one show-index call for each .idx file.  A simple test would
only have a single one; a library function might need to handle multiple
packs.

>> So how about this?  I'm a bit nervous about all the rules about output
>> descriptors and error propagation and whatnot in the test library, but
>> this implementation seems simple enough and might be useful in more tha=
n
>> one test.  No idea how to add support for alternate object directories,
>> but I doubt we'll ever need it.
>
> I'm not sure that we need to do anything special with output
> redirection. Shouldn't these functions just send errors to stderr as
> usual? If they are run inside a test_expect block, that goes to
> descriptor 4 (which is either /dev/null or the original stderr,
> depending on whether "-v" was used).

Good point.  My bad excuse is that I copied the redirection to fd 4 from
test_grep.

>> +	git show-index <"$idx" |
>> +	awk -v oid=3D"$oid" -v end=3D"$end" '
>> +		$2 =3D=3D oid {start =3D $1}
>> +		{offsets[$1] =3D 1}
>> +		END {
>> +			if (!start || start >=3D end)
>> +				exit 1
>> +			for (o in offsets)
>> +				if (start < o && o < end)
>> +					end =3D o
>> +			print end - start
>> +		}
>> +	' && return 0
>
> I was confused at first, because I didn't see any sorting happening. But
> if I understand correctly, you're just looking for the smallest "end"
> that comes after the start of the object we're looking for. Which I
> think works.

Yes, calculating the minimum offset suffices when handling a single
object -- no sorting required.  For bulk mode we'd better sort, of
course:

	git show-index <"$idx" |
	sort -n |
	awk -v end=3D"$end" '
		NR > 1 {print oid, $1 - start}
		{start =3D $1; oid =3D $2}
		END {print oid, end - start}
	'

No idea how to make such a thing robust against malformed or truncated
output from show-index, but perhaps that's not necessary, depending on
how the result is used.

Ren=C3=A9

