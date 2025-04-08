Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA7B1A8F68
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121931; cv=none; b=cGffjuuNe1yWyeg8zOjmKqUZC14Of44ksFU6MMNppMg1GYp56D8hkSRGpMdwnYXoScKlhYJa06H36McJj4ElUJ7+peTDLxlsuHFan0GN8DsE4fTVgasvkARLJ4wQHVYokBkrfSRlw/Cl1GVSH7intxf4xgSh1BB5vWQ7ds19L50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121931; c=relaxed/simple;
	bh=KzH7LQZ+H5vuiYzeHlDYTQVz3JYpvamChUtpP0VuoHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHy7kjVRNCT1lLDvNc31i/9UaeMvkZ3YXa2J6/PIO3KYmz9CoQG3Um40O+oHvlCLzJzCXW87g6LijY13/senF6d2VWvZ2qCUDYE1HB7UMkvIU4DICnASvxx8ntvtBei1r5GMQ1x0Y1POQ8BNIYSXiw4rZm2IHbbqtxqFU8uUU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=If3mfLQ/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If3mfLQ/"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39d83782ef6so515966f8f.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 07:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744121928; x=1744726728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dUV5Sed6yVotk8IF0a4anzR/iKDtPsnrKXlIjQ8aRGA=;
        b=If3mfLQ/GVStbXhlpVkwxzhElZVS81f5QdmLv+XLx/dE6ii97FvZZ13kbahDuYTOPB
         qKhlSECEKZIopKaCzfqGOCPSnJKDOU7zsYydNpPRJrZAUz/8kdv/thKoH94LH1zmn643
         QNiiFlcKCnuwvs9xlMn2EtkLFnUGSrpkt5o3LSzldeKoY9n8Eper+b8dzX6d3QEJ9eWK
         FdIeMwKj60xS8QhcfPNR+WPOkwPsuadkrQ2O5ZpcwFRlbknY0TPqbHaayg4drIacRdxR
         FjpwYS1dT24WMVXtzyqlE4TU1LKlRns47NPr9TgRUB5nhNLYPAOjBiFyD+nhNXOhtNUS
         VjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744121928; x=1744726728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUV5Sed6yVotk8IF0a4anzR/iKDtPsnrKXlIjQ8aRGA=;
        b=kjWwoL2Vi23pYOrQjVTGYS2BVFwcVqCMB8o1EwS7Jz9h+hFn0NzXuThegFM8SJqUQo
         yzKKcYqSgXjQGqTdhLHg7ics4DqcNyxoRqIKgfnu48noQJFwZYYWDY1IO3EeNFP1p0dI
         3opKHDedM723f+6eVhcPDMajkjrdZQsrGGZJrkvkJPPtOX7sygMrtKIxlyxcl+cs2U9d
         hyhzGxyDYhRJLHgG4toqRiNVc4TEalFPfikJ8IG71uAPFSD8pP/D/p4tycl55CNiEfrU
         O1I9h/u1K94FaRf3wusazOiCS3lrNpdkB4liNTD+PuWlzMleMQTk9dMrNLF+Fqc9B6v2
         NRRw==
X-Gm-Message-State: AOJu0Ywn7FP74RWyIen8bSbNirWKSKfbRksN58e56LjmyZ3MJkihldGL
	gZLQkTbWDccH3wqzwkj8XL7lxtZt1zlBMmTdf6aKZvRCBxS+AsKG
X-Gm-Gg: ASbGncvda5tdyZft1zwCNPw0hJNuLk6K/B+gfiTfTpCwpVfAkPi2YwlYhR6sLvLd5Dm
	AszUrgnoQDJExJs92r8UuLK1EaSgDcNNzs9TcMhOgtM1oCEIzrG0Et7vmr40bEZYSJSN/CRD9+/
	AwaJ1UuL0xSLk4dtpBLdZcRzn89WxuOcczuO+JYdTu78hCp1Q1ePTcywLprm4Ig4f5S8GeZ68D8
	ZdvOTn8oO2bL8ACe51Hri1zFtIweCWTHib8OLWft3gjU2PRBmeKLsXUfn7OANVzEql+anppW6ud
	w5xM+dcyTFvOZ3nJLs0yQWL8KSD29jh5E01HbwUXEQ+n8/gKtZVXzjbzF67dd5ZMHa1Ejw19wYc
	BQdzGin4RTQ8od+YONcskIkcvloMXz2U=
X-Google-Smtp-Source: AGHT+IGimfo1g0aXyg/qmr9D5dlj+laf6Wdi1w7vrtO7LbvB9cIxWBA6FK4KdmlEC+afmcWvoWCbWw==
X-Received: by 2002:a05:6000:1847:b0:390:e9ee:f27a with SMTP id ffacd0b85a97d-39d820ec43bmr3211335f8f.28.1744121927934;
        Tue, 08 Apr 2025 07:18:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b8ad6sm15360267f8f.56.2025.04.08.07.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 07:18:47 -0700 (PDT)
Message-ID: <5012fd2b-a68b-4267-aa4b-9dd04510986b@gmail.com>
Date: Tue, 8 Apr 2025 15:18:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/2] completion: fix bugs with slashes in remote names
To: David Mandelberg <david@mandelberg.org>,
 David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <17274df2746d304db876ebd82ad8d932@mandelberg.org>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <17274df2746d304db876ebd82ad8d932@mandelberg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David

On 23/03/2025 21:04, David Mandelberg wrote:
> Another minor change, as suggested by
> https://lore.kernel.org/git/xmqqo6y3dzno.fsf@gitster.g/
> 
> I'm not sure what the expectations are around updating patches that are
> scheduled to be merged to next but haven't been merged yet. If it's too
> late, I'm happy with the previous v3, or I could send a separate patch.

Unless a patch series has already been merged to next which in not the 
case here sending a new round of patches like this is the right thing to 
do. The range-diff (which you can add to your cover letter by passing 
"--range-diff" to "git format-patch") below looks good to me

Sorry for the slow response and thanks for working on this

Phillip

1:  5f4f1eb105 = 1:  58d036a048 completion: add helper to count path 
components
2:  28c0f80345 ! 2:  0383e1c608 completion: fix bugs with slashes in 
remote names
     @@ contrib/completion/git-completion.bash: __git_tags ()
      +          }
      +  }
      +  '
     -+  __git for-each-ref --format='%(refname)' 'refs/remotes/**' |
     ++  __git for-each-ref --format='%(refname)' refs/remotes/ |
      +          PFX="$pfx" SFX="$sfx" CUR_="$cur_" \
      +                  IGNORE_CASE=${GIT_COMPLETION_IGNORE_CASE+1} \
      +                  REMOTES="$(__git_remotes | sort -r)" awk 
"$awk_script" |


> David Mandelberg (2):
>    completion: add helper to count path components
>    completion: fix bugs with slashes in remote names
> 
>   contrib/completion/git-completion.bash |  49 +++++-
>   t/t9902-completion.sh                  | 206 ++++++++++++++++++++++---
>   2 files changed, 226 insertions(+), 29 deletions(-)
> 

