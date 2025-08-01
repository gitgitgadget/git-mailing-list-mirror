Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B72222590
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039701; cv=none; b=Fhef6QmiZ8S26V3nOdVWeYdExBA2goQPN2jH1tdRFHP0B+7K+yzkOMp9Gid3X/F8m5BNV+vsdFiWg5KVh+r0NfVT4e/7Ka4r13Ni5yifbnLKqhiv230E4Nw/UiRZbNbkQLUnaHlY9mleNGqbP9UNuUAJaJLVOe7yq31rjcQjykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039701; c=relaxed/simple;
	bh=GfnSggTFiqDtLCWqLNmd9SYhswDBDNEorlAFQNWiBLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pn5UIzll2Syi94UW6FEtq9xfRLPvLWa7v4fAM9ER+39zYOI9yDmzG47Ytzr8fg+emJXHCw2gXEUYlbWrFELSlmAP7PhUiyg7O1Vbuk+ncWY3BXf5KVtfSSFi5v37x8BQehsR3s8pcp5ahzm9aGc8mi1ca8gudiPJnFIG3EnQNvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VI7pbO57; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI7pbO57"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b794a013bcso788124f8f.2
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 02:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754039697; x=1754644497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F47uNx7Cfl0oerQatuVp6X0bjwgzhxIMakVmxobYWiU=;
        b=VI7pbO57y0EoCeFJnLWhjQ+HygdDN4dSK6RTqzstRVAzZuVF7xxnS7MjFeMpPMN2eJ
         eEVpHxOAT8dSW6E3VITfXgCXghaoiR8sHSII500J+V8kWjlCe3nC5ln4GrM94VUXaEQw
         bh2PjK3X2QKNo8r/p5b5oPZBHsXZIpI7Kh3cz0DeeVlHWaIRFZnZs0WAblMPgIxwmGDG
         zofXNw/MGp5/wLnG/D5XAVf84od6ot1n7sE1KVxI+XNu01OaZvHDYxgH+5z1s3aomww2
         xCs08RmImz+UgvEicJyqez61iYSy3HMdJ9iqtyz5voKofktK6bayrEaRGx9PKIXHjG05
         FG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754039697; x=1754644497;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F47uNx7Cfl0oerQatuVp6X0bjwgzhxIMakVmxobYWiU=;
        b=XfLQRd7m6pkLxUwhS9IeXl/FcfD2bi38ms2I0VI7A2Sg9ywyZypL3QY734sI2c3MRM
         fG0QWPJ2wFp/SIUEzqbO9dD34oogd0HEYCo4zCB65qbvts+qiYEBHMW95dfCIa2Ou2sv
         TZPjTsiS2kcmb5rOTn9lSLpT76brZgMn106PUtJDPMP6HESgn5GHK8pxgQYrqj5DD6Fy
         umSqhF8hBpDkMMP/ob3/rTtxUVftWziLkPcywv7mv+tKGrlY20QktxMcis5bCVjhk5Pm
         ec+cbimC5VpXeAvDjEK32eMtUS9x2I5n+62NTDR4A6JQatOR9NTsvbSVXnZ34XT8fnQN
         4Aig==
X-Forwarded-Encrypted: i=1; AJvYcCUmq3BhmVjD9n6PkDjtzZ2l/aee6bxa5OUUZKi9t4Mi8x8ec2swray9BU//5/NnBajsZtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlAn1WOyYjT2yZKu9ArbcLDCBbMNWKX30yO7tchrcjmO96B7v8
	xNEqdvh+lX0w9S0LmnKbBHdQ7FUqmiI5JXVXqmNXnSCb4pJYGo7SXFUh
X-Gm-Gg: ASbGnctW1/Jpnx0x9/d4bmgqVyhPqL9D9Y1nPYir9KwLWMBJQwgm5WMhqLAZY104eBN
	IirMRaq4ZTXSLGVmnUjzoQqKJRu5xOdXGKhEjZzKMm1jlsQLO+bOwoOFKgHN+p3y4Gy9NBmh0It
	ESTPsiriuwU4Yu2Q6jKquoMVbe9KikNJff9VeqBcLUJrQcqIEpTByz+fHciy3YnrAkbEIZZPKYn
	53osD2cokvLcKGpdhu/PDTOn9SmW4/Dbr5ThmddgPXDiaWTxzxg3Yet6G6jXh0VSEqhbdmYpolS
	PUadn5TjWP2eU0KJf2iEz2kBwwrqYFlB8HDitwgq18QuDIRR9OjoAR9+maV84A4skqjC7F8EHLA
	tqj1kSr4zoy22qF+/PlmQ9VY0ydhUzn2thZ54mFTtC6s90+sqfuKuySv1gPjagcqHX3zbsco09U
	yKXPS9+TAX9AU=
X-Google-Smtp-Source: AGHT+IGFkutm0KoDzNvXE2pRrAgI+ubdnNSU/+rbWUIIQmTMQek1F95LmYBfzAnUg28ZqjuhtCRGEw==
X-Received: by 2002:a05:6000:2c04:b0:3a5:27ba:47c7 with SMTP id ffacd0b85a97d-3b79500950cmr8598070f8f.48.1754039697247;
        Fri, 01 Aug 2025 02:14:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2848sm5101249f8f.71.2025.08.01.02.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 02:14:56 -0700 (PDT)
Message-ID: <a0fea0dc-44ed-4b8b-a28e-762f3a964ccd@gmail.com>
Date: Fri, 1 Aug 2025 10:14:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
To: Ezekiel Newren <ezekielnewren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Taylor Blau <me@ttaylorr.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
 <91f6352f-abc4-4e99-938b-6a56aba2faed@gmail.com>
 <CAH=ZcbCnEpBokM9rxmmkeM9GT948n7+RipXODHLfPssuwJuVCw@mail.gmail.com>
 <a765cde9-0fad-414a-996f-2ec162d1e4f3@gmail.com>
 <CAH=ZcbALsQqTrvNJ4ZKmVWc6PHtTA+8k8p6_D=x=BfMXxnayfA@mail.gmail.com>
 <ad453eee-23cd-42fe-97bd-1ff0fc2f3edf@gmail.com>
 <CAH=ZcbBa=1iUTcxaBOvG_kcuWsF_nJQiWGkL+BUzsNYLpzFG5w@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=ZcbBa=1iUTcxaBOvG_kcuWsF_nJQiWGkL+BUzsNYLpzFG5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ezekiel

On 31/07/2025 21:58, Ezekiel Newren wrote:
> On Thu, Jul 31, 2025 at 8:20 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 28/07/2025 21:14, Ezekiel Newren wrote:
>>> On Mon, Jul 28, 2025 at 1:52 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>
>>> Ah, I misunderstood the scope of your question. I could not fit an
>>> example of why this design pattern made sense into this patch series,
>>> so I'll explain with an example here:
>>>
>>> If C defines a struct like below then it's obvious how to translate
>>> that into rust for ffi purposes. It also makes it clear that this C
>>> struct is expressly for the purpose of C <-> Rust interoperability.
>>> struct some_struct {
>>>       u8* ptr;
>>>       usize length;
>>>       u64 counter;
>>> };
>>>
>>> This is how that C struct needs to be defined in Rust so that it can
>>> interoperate with C, and making C use the Rust types reduces the
>>> chance of copy paste, and primitive type definition mismatch errors.
>>> #[repr(C)]
>>> pub struct some_struct {
>>>       ptr: *mut u8,
>>>       length: usize,
>>>       counter: u64,
>>> };
>>
>> How is the pointer, length pair used in rust? Normally one would use a
>> slice so do we have to construct a slice every time we want to use the
>> data in this struct, or do we copy the data in this struct into to a an
>> idiomatic struct with a slice member? If we end up copying there doesn't
>> seem much point in changing all the types in the C struct as we can
>> define a rust struct using *c_char, c_long etc. to interface with the C
>> code and covert them to an appropriate rust type when we copy the data
>> to the idiomatic version that is then used by the rust of the rust code.
>> I can see the value of the typedefs for documenting C<->rust interop if
>> the same struct is used by both but if we end up copying data on the
>> rust side I'm not so sure.
>>
>> Thanks
>>
>> Phillip
> 
> Passing pointer + length from c to Rust does not incur a memory copy
> overhead. Take a look at rust/xdiff/src/lib.rs wich has the following
> rust function defined:
> 
> #[no_mangle]
> unsafe extern "C" fn xxh3_64(ptr: *const u8, size: usize) -> u64 {
>      let slice = std::slice::from_raw_parts(ptr, size);
>      xxhash_rust::xxh3::xxh3_64(slice)
> }
I'm afraid I don't find this simple unsafe function example very 
illuminating. I'm trying to understand how we are going to use a struct 
containing a pointer, length pair in code that are more complex than 
this. For example if we implement an entire diff algorithm in rust are 
we going to call std::slice::from_raw_parts() every time we want to 
access a string passed from C? If we're doing that I assume we'd impl a 
safe method on the struct that wraps std::slice::from_raw_parts(). If 
that's the case the method can easily access a field that has type 
*c_char and we don't have to sprinkle casts throughout our C code.

For example (ignoring lifetimes)
#repr["C"]
pub struct SomeStruct {
     ptr *std::ffi::c_char,
     usize len,
     // more members
}

impl SomeStruct {
     get_line(&self) -> &[u8] {
         unsafe {
             std::slice::from_raw_parts(self.ptr as *u8, self.len);
         }
     }
}

On the other hand if at the interface between rust and C, we create a 
slice that we can pass to the rest of the rust code then we also don't 
need to change the C type as there is a single place in the rust code 
where we convert from c_char when we create the slice.

The casts on the C side are pretty invasive. At least casting from char 
to u8 is not going to break anything. The long -> usize and long -> u64 
changes and their associated casts are going to need some careful review 
but in the long run I think the C code also benefits to using those types

> Creating a slice tells the compiler what assumptions it can make about
> that memory. On the C side in xdiff/xprepare.c:
> 
> extern u64 xxh3_64(u8 const* ptr, usize size);
> 
> and then it's called like this in that same file:
> 
> rec->ha = xxh3_64(rec->ptr, rec->size);
> 
> I really wanted to show my ivec type that made passing an
> interoperable vector type between C and Rust easy and fast, but this
> patch series is already getting very long.
That sounds interesting

Thanks

Phillip

