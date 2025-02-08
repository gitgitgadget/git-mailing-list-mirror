Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9717ADE8
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739013303; cv=none; b=DwYzoKhruOUegwHKtPCJwTDWkZZQP3RdMlOd9IXjjJA0U0Pd0iQfD7XUuKHutfh+t515y56nBkpAPH9ui27Z2uNH/grRf7xciaPGiowPXc/jdp/TITJjTSzZBQQHqSpStgHdXR95FQ9G/BwxZzIPF2m5Vuvd/gkUXLJ9gFLXBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739013303; c=relaxed/simple;
	bh=pRCVTWq8R3PwKwnfyE/kZ4fOUrAC3MjWrt9OPRXzMOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=PVWTXhei2l3vnXPzVlheZmrvEc4er1tkSmjFkqfPlIDd6SjeV/60A8a+kZ2MNwxsK6th2FJVNjGwGnvP+oNt8NEEi08oubVyr5QtyqNixhTtNXheEiREDZdp6ipx66TrvzvWTreFYh/iPHrMYM5Re0SHUb9gTIwpDdmDN0xOkpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTpT1b5c; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTpT1b5c"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436345cc17bso20149845e9.0
        for <git@vger.kernel.org>; Sat, 08 Feb 2025 03:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739013299; x=1739618099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MugkENNUKQJ9bOXGsZ0xbtiFC5xnB7j7u4g5/YhiS8w=;
        b=MTpT1b5cLKBoUuLjF0RPuPRpo302U5+jIllSHWjJOICgGzu5y3CthZV1pEdDxSBRaY
         DXVGE10fT4X3zTBDKtXDEG2FtEp7XJL1npQVp4zcrfMg6Lt2scam3s+aWzTIQsJuJYoQ
         fl05r72vyhrY3ErPk9i0IeRo8WBgJqtP4zItyGZSlzPy2H59N0GaIuYNVGGlMuBaSa4Z
         NhBLZlbqgCEMO162JQ0hIlp3l9Z0JQMKoSacisMI9P1l2DSd9N83GVxWIvh3HnOlyrDl
         c2qJboX0JVdi99ejsbs0UJrK5BUUoqmEZZ9BsZ6+jQ4HMZBNCeWt6AMmKIDsQu5kDAfA
         5kbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739013299; x=1739618099;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MugkENNUKQJ9bOXGsZ0xbtiFC5xnB7j7u4g5/YhiS8w=;
        b=qtU1GLoPUzMv9YjEDNyHzB32G33Ii84lDefac20aTSSO4b5MyPcp1tjKq7Qf9QMBYn
         zsWFU/z0U1ToNgK/rM6jvDnjhwGE/B/xJD2czk+oOszkrIO34+AWbiVV9ZvkJnvkT0Ta
         T9Xo6qTy6IjkKZlSOfZYoJ9wWvLAEUtkGIsA1pVJhVbSXp1SXnw6kd9KqDzJN+oJK+9/
         /rGmnaFcAg9D+vohJ/2YQKoZVXJLL3KfXlfOff/RcuM4OgPH2KNOHQrcIgVElo4utHQD
         ieSrB1vlmXDceALXhmsN2OeH0USEYXOdniCFPzqe3cg+H9Ftb5dLhu2968Zz80tmIY+o
         lQJw==
X-Forwarded-Encrypted: i=1; AJvYcCVIkTr91xj/MoFQjcWdrguCXe8IfjTOX6paB8kjs8eBqUmZOBrA9W5rbfDHfGTi2O73hgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2EAd3lvEmNNztCtS6DvuRFM48E7weMSAr4HvHt6TsTMMIVstL
	U7VbwCJXa9iM89k72BF4+RVLjuZjEHS77zCMELcwgvKcgH4ykZAKoMUpIA==
X-Gm-Gg: ASbGncsecSUXpcNkOHMmo3j9j59H1CiSslxUt1TblQm/x9d73UkJfJ/NLV2jyDi3k6k
	kOjYSjqEmErpKNAIBc5KMfLTic1CNMczRu/Xx1k8ARkbMWq2McmIB87aWehMf+0/k1tUrhtOPRr
	65FvKxKAOZvJZsB5ZIYNsX7oXsBqkde2snhRCEgh14XOOgvkv7uqtFLthMp9G8UWX//HcOjbd76
	LiErMoT8Qbq4zJHJlskzPOr7sv1Nn0rY8HIrolkvzPQWQ3PodHmrmRiVLaP6q9XQPw2FhPeYOtR
	kRXZDMlaO+vtU4CnIeDU4nFkhIfxJxRrrtNFIdgzBluHlrXUjSck+yyA8UKVlof6USBQXw==
X-Google-Smtp-Source: AGHT+IG/M5GH76mL/ObY558GjKYVyj2tBItwIq+4K72/OYdHxuzySZyv6r9QdTewlhtjHxCueDDTvg==
X-Received: by 2002:a05:600c:1e15:b0:436:1aa6:b8ee with SMTP id 5b1f17b1804b1-4392497ce92mr51221045e9.2.1739013298906;
        Sat, 08 Feb 2025 03:14:58 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43907f61ca4sm71945445e9.1.2025.02.08.03.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 03:14:58 -0800 (PST)
Message-ID: <ba65ce17-8768-4d60-aec6-badd12930b81@gmail.com>
Date: Sat, 8 Feb 2025 11:14:57 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: renormalize histroy with smudge/clean-filter
To: Elijah Newren <newren@gmail.com>, Josef Wolf <jw@raven.inka.de>,
 git@vger.kernel.org
References: <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de>
 <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de> <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de>
 <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de>
 <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: "brian m . carlson" <sandals@crustytoothpaste.net>
In-Reply-To: <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Elijah and Josef

On 08/02/2025 00:23, Elijah Newren wrote:
> On Fri, Feb 7, 2025 at 12:34 PM Josef Wolf <jw@raven.inka.de> wrote:
>> On Fri, Feb 07, 2025 at 06:01:43AM -0800, Elijah Newren wrote:
>>> On Fri, Feb 7, 2025 at 3:13 AM Chris Torek <chris.torek@gmail.com> wrote:
>>
> I also see I didn't look closely enough at Phillip's
> suggestion, which was:
> 
>     git rebase --root -x 'git add --renormalize . && { git diff --quiet
> --cached || git commit --amend --no-edit; }'
> 
> which will work if you do a lot of manual work to resolve line ending
> difference conflicts.  Since the git add at each step will modify the
> files on which the next commit is based, that causes the application
> of the subsequent commit to conflict,

Indeed, I'd missed that (like you I've not actually used any 
smudge/clean filters)

> and you probably will have
> difficulty seeing those conflicts since they tend to just be line
> ending differences.  But, mixing that with Brian's suggestion, you
> get:
> 
>    git rebase --root -X renormalize -x 'git add --renormalize . && {
> git diff --quiet --cached || git commit --amend --no-edit; }'
> 
> which should probably work if you have a linear history

I've tried that out with a small modification in the script below which 
seems to work. The modification is to add "--attr-source=$(git rev-parse 
HEAD)" between "git" and "rebase" so that git always has a 
.gitattributes file to read when rebasing commits that were made before 
that file was added. I wonder if we should add something about 
renormalizing a repository to the FAQ based on your footnote

 > [1] The renormalize option to the merge machinery ensures that new
 > blobs produced by the merge have normalized content, and avoid
 > conflicts when the only differences between files are normalization
 > ones.  This option does not ensure that new trees only reference new
 > content nor that they only reference normalized content; _any_
 > pre-existing blobs in the repository are fair game for new trees to
 > reference.  As per the manual: "renormalize...This runs a virtual
 > check-out and check-in of all three stages of a file when resolving a
 > three-way merge..."  So, the existing behavior of the renormalize
 > option to rebase/cherry-pick/merge is correct.  It may not be what you
 > want, but I don't think cherry-picking/rebasing/merging with the
 > renormalize option is the right tool for this job.
 >

Best Wishes

Phillip

--- >8 ---
#!/bin/sh
set -e
d="$(mktemp -d)"
cd "$d"
git init
echo "The   quick  brown" >file
git add file
git commit -m line-1
echo "fox  jumps    over" >>file
git commit -a -m line-2
echo "the      lazy   dog" >>file
git commit -a -m line-3
echo "file filter=space" >.gitattributes
git config filter.space.clean "sed -e 's/  */ /g'"
git config filter.space.smudge cat
git add .gitattributes
git commit -a -m 'add .gitattributes'
git reset --hard HEAD
git --attr-source=$(git rev-parse HEAD) rebase --root -X renormalize \
     -x 'git add --renormalize . && { git diff --cached --quiet || git 
commit --amend --no-edit; }'
git log -p

