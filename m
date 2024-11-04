Received: from 10.mo550.mail-out.ovh.net (10.mo550.mail-out.ovh.net [178.32.96.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2565F3C6BA
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.32.96.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730762142; cv=none; b=UiBvrfOrNtHkKJv0zQOCibvtEobHGy1zxWf5S2z/z3dKcFM/tYf4jclZKrJvIbo4/mJ5l3Ss0I9qZswS7PtLbxbcrOMEk6cBLk+rhFsK8HocWXAUyAly7fMuAjt89rNCH8CqH2TXnhxrHn2lMGVZIrkhcdl9rQGdYgoy2pSUE0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730762142; c=relaxed/simple;
	bh=cyVCjMcZWifx0rHFqtlokNzM23ZJFD2SgChbRYwDwgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mvmo9c+/CENi/MT2metabYZSX3R0E32OZV758I0NjxjQFAuxUig9OOTsjZnRRJaizpMaoZnxUD+FVa7vB53dVxosEd5d6Wk8ZyrAllVmXhJsdvrU71H9WqKDf9OnCg0cama7ukw+ITFZf8oCjT5g+lCktc7uhDDIVQBPWectNBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cleb.io; spf=pass smtp.mailfrom=cleb.io; dkim=pass (2048-bit key) header.d=cleb.io header.i=@cleb.io header.b=FLT8PXL0; arc=none smtp.client-ip=178.32.96.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cleb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cleb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cleb.io header.i=@cleb.io header.b="FLT8PXL0"
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.9.148])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4Xj3Bs0pgzz1Pkm
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 20:35:49 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-7vlzp (unknown [10.110.118.109])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 999E01FE70;
	Mon,  4 Nov 2024 20:35:48 +0000 (UTC)
Received: from cleb.io ([37.59.142.110])
	by ghost-submission-5b5ff79f4f-7vlzp with ESMTPSA
	id KwTlGiQwKWckUAIA+s5yiw
	(envelope-from <iago-lito@cleb.io>); Mon, 04 Nov 2024 20:35:48 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-110S00430336a3e-11f1-4176-9e05-71a8d34a4672,
                    1AF2C5BD2C6DA634207BFA00DBF8191203A05014) smtp.auth=iago-lito@cleb.io
X-OVh-ClientIp:86.228.67.232
Message-ID: <d67e133c-f287-4009-9244-eaeffd84daeb@cleb.io>
Date: Mon, 4 Nov 2024 21:35:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `git apply -p` doesn't remove source prefix in 'rename' diff
 entries.
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <3af246eb-3473-4964-9aed-ecff62b215b7@cleb.io>
 <xmqq4j4r4enh.fsf@gitster.g>
From: Iago-lito <iago-lito@cleb.io>
In-Reply-To: <xmqq4j4r4enh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3469179091730578171
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgudefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefkrghgohdqlhhithhouceoihgrghhoqdhlihhtohestghlvggsrdhioheqnecuggftrfgrthhtvghrnhepvddthffhtdefjeeutdejjeefieegjefhveegtdevjeefvdffudelleegtdfhueelnecukfhppeduvdejrddtrddtrddupdekiedrvddvkedrieejrddvfedvpdefjedrheelrddugedvrdduuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehirghgohdqlhhithhosegtlhgvsgdrihhopdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheehtddpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=rwsr0tqYkq+nQD8WXRPy9f+TY4lcQ1W6H/ruCeJEGZc=;
 c=relaxed/relaxed; d=cleb.io; h=From; s=ovhmo4982009-selector1;
 t=1730752549; v=1;
 b=FLT8PXL0JU+OqYNBRfn3XYLHzFPZVII3S7twRFVPFgUeyleegoN1OcomURYsIOm1qyGq+598
 D37R8oAxBHKExx/ekH0JWmg7wB4rYwZCFoos4bWKBA0gIqb6YsWSbK4muWSCzEgm/FRELFJ/ELX
 /bcu/0OKac3wuhzDh9wy9y2wRvMqLOBHCyeoDISVR+ff779ragU/MGMcaFh387Xk22uVZvjTRuo
 gV05YKy2O5LePl3NuW20PpdMKYXu7VD5rAn25Nxz3vV2y0VNjII1AqTzdypnMP+LV7J9h0Jft9V
 DCQBf7aVIfZ66butEeMnYXNyTGjllkJM5EaTXgChiy59Q==

Hello @Junio, and thank you for feedback :)

If I understand correctly, you are suggesting that `git diff`/`git 
apply` are behaving correctly here, but they might not be the right tool 
for the job? I sort of sense that `git` could achieve this "z = x + 𝛥y" 
folder operation (because it has all the machinery required to do so), 
but I'm not sure how to leverage it correctly. Do I need to get into 
"plumbing"?

--
Iago-lito


On 01/11/2024 08:05, Junio C Hamano wrote:
> Iago-lito <iago-lito@cleb.io> writes:
>
>> Hello,
>>
>> I have troubles understanding the behaviour of `git apply` with respect to renames in a `--no-index` context.
>>
>> Let us craft a toy folder:
>> ```sh
>> $ mkdir x
>> $ echo a > x/a # To be modified.
>> $ echo b > x/b # To be renamed.
>> ```
>>
>> Duplicate it twice to get three identical folders `x = y = z`.
>>
>> ```sh
>> $ cp -r x y
>> $ cp -r x z
>> ```
>>
>> Modify `y`:
>> ```sh
>> $ echo newline >> y/a # Edit.
>> $ mv y/b y/c # Rename.
>> ```
>>
>> Now I would like to use git as a "better GNU patch".
>> Calculate the diff from `x` to `y`:
>> ```sh
>> $ git diff --no-prefix x y | tee patch
>> diff --git x/a y/a
>> index 7898192..4030aa5 100644
>> --- x/a
>> +++ y/a
>> @@ -1 +1,2 @@
>> a
>> +newline
>> diff --git x/b y/c
>> similarity index 100%
>> rename from x/b
>> rename to y/c
>> ```
> Interesting.  I think "git diff --no-index" is "wrong" here, but
> "wrong" is not in the sense that it is _incorrect_, but in the sense
> that it merely is incompatible with what you are trying to achieve.
>
> If you had files a and b, modified a in place and renamed b to c,
> and if you did this in a repository with tracked files, you would
> have seen
>
>     $ git diff --src-prefix=x --dst-prefix=y
>     diff --git x/a y/a
>     index ...
>     --- x/a
>     +++ y/a
>     ...
>     diff --git x/b y/c
>     similarity index 100%
>     rename from b
>     rename to c
>
> Notice how "rename from" and "rename to" information is different in
> the "real" git-diff output, as opposed to "git diff --no-index"
> output you have?
>
> At least when comparing two directories, "git diff --no-index X Y"
> could be interpreted as a request to treat as if X and Y were
> checkouts from two Git commits X and Y, and by comparing them the
> output should be identical to the result of comparing the contents
> of commits X and Y.
>
> But feeding "git apply" however may not be the only reason why
> people are using "diff --no-index X Y", and there may be a
> legitimate reason why peole want to see "from x/b to y/c" in the
> output, so unconditionally changing the output may very likely break
> workflows of other people.
>
>

