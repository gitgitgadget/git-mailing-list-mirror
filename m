Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8713D4418D7
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063403; cv=none; b=qT7x0eoBbvj8ls/cgAFgwb525tDyWHXPEg5+diqHkkt6zsyrf3grpme6N0I6Jr7LHXzaD7N659xua9W+Fku71AwycqFDnMK17rNsadp8j7uM7cFU7zigfPB/pXlGGpHac8mm+gwy3VUvH9yNzDM3r25eydL0bG8Wy3fk2ltHGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063403; c=relaxed/simple;
	bh=GOy8c4a+Cn5pN+YJMvP5k0go9Uk4FJL5TvDuQSymHwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWl9UzETMauBKMkPyMI5n8G6QNcLKT8QDtZ6fTskqBPUi/N4TMF3GvX+zS3EGAwFy8q0g+m0A1onPHCltpUPnesBZh0wZTmfsNlkQn5CCzOqvxE58+/p/Tdq9JUPQC373JcDHGGvy26pI3/gaVK2Hstrm9zljugGElvWvf/hbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTPNPJBk; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTPNPJBk"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c76afacbb0bso162461a12.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 10:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775063402; x=1775668202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVjuHpbBp4/go9wIYUJ5A4GOq38uvYt3fcF+zD8I2bY=;
        b=VTPNPJBkz/nCfWAi5MM89Tgh+kBAGxpC9+cfbkBiil4vaE9XZ4vOAqqynT6h1lGeXq
         4M8KI/l8dVjC8asF9iMUyNHgNm5yyxdESeuYaYQqmy++hsZ5Fsfy6yoZJQV+IrqfKVDb
         JDKBQqPQshYJn2Zgun7H3ZWrZAfEXmvQISmWm/obUOSnJS6Ym3GFfn70vn4dHpwu53pu
         Wa/bivxfBktilcDaOcVQfmCF8EL9ti3Fsv5E3U5kR5JzxLKgmLdPHMYtmxpJkjMoHUEs
         dAMzKyAETT3w5gimPv6APS4H7XPYqkatIO+fkVzkb10QIsWPRmInPsAOw5K40OW9hL5t
         V33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775063402; x=1775668202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVjuHpbBp4/go9wIYUJ5A4GOq38uvYt3fcF+zD8I2bY=;
        b=tMmP/bGzg9MwjaXEFceTuuR+ak/05+zh3rMObPvku5vCbGTu+W/obQFCsDg7VadvIm
         3pZN4CCyhMEEUyxM8cFGHaAYMZUILBiUBAwiqyx8fu33VgxQv3lRjv7XJMVphwpkdgNT
         kuyiKXXbFftQGjp+3cJPZmBouq+FZisKqj/NFqO0h/sRXkxCIBLIpPT/fwGj+5tOd3m/
         r8xGtd6crrnlKP843rbY1Uj6eQiK+6bCyPyIlkaLmrw3MPMZj/4fQdXRS8e0ycYdaPYL
         7Txm/Zs3C1UoGlPQqB3034GEp2Ig5kWoZO6DqYmih69BEsq2QVszONWI2ef0lxbeEt+X
         QMCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnrdsugIZ2qVKKPdSi3RbumV6jnXR0/jjf/Un4MLb5ytsaFPYmclZqanwRwL4dhprDELc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyphmr/LxA/z4ICO/AyXcNAljfs4b4C0I1bzCKkMbbjhQSAoH1i
	iKNcrruZovuUCDdDTKhs8bprSKaMBFxAL416T8fgwekQOU5XMQvdlna0
X-Gm-Gg: ATEYQzxpqGp0Mc7KzPc3NC5wu/e1BNSQcq7GgKEoyH4XqMJnuh2t4DkrHzw8rUivFhe
	pLWXSMUJiSEAt92p4k4WIupWWpdeKZ1yBwoydNJdOUH584y2p3Vmt7EXUgH/FPOzcc1PF5UfXcl
	hk5OB93lnOuDj6sOsroKgyFRhfWeK9PvX8jvfR1MnonQfe1AfrZsgVfWzkinjx4VegoNJQvDfcA
	3oK0mtrxHxAKOtxTEoK2DbBJjJZcJgdDd5pTKGH6IxQVZ5tyzIjVAGni/l5QvKe20zS8PTej872
	Hyrx2b5j5ElJCkQlEojZdwl4eU74VG6FjdkUujJTs5P1Iau7CHyzFKkEzQvALfl+2QjCi8vzEkq
	t1OFiG6E44FHXRP2rPHanZVwBr+61z4DCnOwtYWuSHBXdNT+gtx1LowEcdeSRw8jnxJnr7gQq0y
	MneV7Vbmqd7HoHSl/74mSAQhYHQb26n0pp0RVHcs65+1QcEEOMglf8eFNyozipaPQ8HSRM4ZqRa
	NFlGqkn2lU=
X-Received: by 2002:a17:90b:224e:b0:35c:30a8:31a with SMTP id 98e67ed59e1d1-35dc6d6c077mr2741792a91.0.1775063401656;
        Wed, 01 Apr 2026 10:10:01 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dba590d49sm2701927a91.2.2026.04.01.10.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 10:10:01 -0700 (PDT)
Message-ID: <0c2ee025-3fe3-4f8f-b8ea-62d2f101c15d@gmail.com>
Date: Thu, 2 Apr 2026 01:09:56 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][PATCH v3] t2000: modernise overall structure
To: Zakariyah Ali <zakariyahali100@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, ayu.chandekar@gmail.com,
 jltobler@gmail.com, karthik.188@gmail.com, siddharthasthana31@gmail.com
References: <20260326192603.23961-1-zakariyahali100@gmail.com>
 <20260327234019.95591-1-zakariyahali100@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260327234019.95591-1-zakariyahali100@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/28/26 07:40, Zakariyah Ali wrote:
> This test script that dates back to 2005 certainly shows its age and
> both its style and the way the tests are laid out do not match the
> modern standard.
> 
>   * Executables that prepare the data used to test the command should
>     be inside the test_expect_success block in modern tests.
> 
>   * In modern tests, running a command that is being tested, making
>     sure it succeeds, and inspecting other side effects that are
>     expected, are all done in a single test_expect_success block.
> 
>   * A test_expect_success block in modern tests are laid out as
> 
>          test_expect_success 'title of the test' '
>                  body of the test &&
>                  ...
>                  body of the test
>          '
> 
>     not as
> 
>          test_expect_success \
>                  'title of the test' \
>                  'body of the test &&
>                  ...
>                  body of the test'
> 
>     which is in a prehistoric style.
> 
>   * In modern tests, each &&-chained statement in the body of the
>     test_expect_success block are indented with a horizontal tab,
>     unlike prehistoric style that used 4-space indent.

I like this commit message. Nice.

Would it be better to add a 'Helped-by'?

> Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
> ---
>   t/t2000-conflict-when-checking-files-out.sh | 122 +++++++++++---------
>   1 file changed, 66 insertions(+), 56 deletions(-)
> 
> diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-conflict-when-checking-files-out.sh
> index f18616ad2b..af199d8191 100755
> --- a/t/t2000-conflict-when-checking-files-out.sh
> +++ b/t/t2000-conflict-when-checking-files-out.sh
> @@ -35,30 +35,30 @@ show_files() {
>   	sed -e 's/^\([0-9]*\)	[^ ]*	[0-9a-f]*	/tr: \1 /'
>   }
>   
> -date >path0
> -mkdir path1
> -date >path1/file1
> -
> -test_expect_success \
> -    'git update-index --add various paths.' \
> -    'git update-index --add path0 path1/file1'
> -
> -rm -fr path0 path1
> -mkdir path0
> -date >path0/file0
> -date >path1
> +test_expect_success 'prepare files path0 and path1/file1' '
> +	date >path0 &&
> +	mkdir path1 &&
> +	date >path1/file1 &&
> +	git update-index --add path0 path1/file1
> +'
>   
> -test_expect_success \
> -    'git checkout-index without -f should fail on conflicting work tree.' \
> -    'test_must_fail git checkout-index -a'
> +test_expect_success 'prepare working tree files with D/F conflicts' '
> +	rm -fr path0 path1 &&
> +	mkdir path0 &&
> +	date >path0/file0 &&
> +	date >path1
> +'
>   
> -test_expect_success \
> -    'git checkout-index with -f should succeed.' \
> -    'git checkout-index -f -a'
> +test_expect_success 'git checkout-index without -f should fail on conflicting work tree.' '
> +	test_must_fail git checkout-index -a
> +'
>   
> -test_expect_success \
> -    'git checkout-index conflicting paths.' \
> -    'test -f path0 && test -d path1 && test -f path1/file1'
> +test_expect_success 'git checkout-index with -f should succeed.' '
> +	git checkout-index -f -a &&
> +	test_path_is_file path0 &&
> +	test_path_is_dir path1 &&
> +	test_path_is_file path1/file1
> +'
>   
>   test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
>   	mkdir -p tar/get &&
> @@ -83,53 +83,63 @@ test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
>   # path path3 is occupied by a non-directory.  With "-f" it should remove
>   # the symlink path3 and create directory path3 and file path3/file1.
>   
> -mkdir path2
> -date >path2/file0
> -test_expect_success \
> -    'git update-index --add path2/file0' \
> -    'git update-index --add path2/file0'
> -test_expect_success \
> -    'writing tree out with git write-tree' \
> -    'tree1=$(git write-tree)'
> +test_expect_success 'prepare path2/file0 and index' '
> +	mkdir path2 &&
> +	date >path2/file0 &&
> +	git update-index --add path2/file0
> +'
> +
> +test_expect_success 'write tree with path2/file0' '
> +	tree1=$(git write-tree)
> +'
> +
>   test_debug 'show_files $tree1'
>   
> -mkdir path3
> -date >path3/file1
> -test_expect_success \
> -    'git update-index --add path3/file1' \
> -    'git update-index --add path3/file1'
> -test_expect_success \
> -    'writing tree out with git write-tree' \
> -    'tree2=$(git write-tree)'
> +test_expect_success 'prepare path3/file1 and index' '
> +	mkdir path3 &&
> +	date >path3/file1 &&
> +	git update-index --add path3/file1
> +'
> +
> +test_expect_success 'write tree with path3/file1' '
> +	tree2=$(git write-tree)
> +'
> +
>   test_debug 'show_files $tree2'
>   
> -rm -fr path3
> -test_expect_success \
> -    'read previously written tree and checkout.' \
> -    'git read-tree -m $tree1 && git checkout-index -f -a'
> +test_expect_success 'read previously written tree and checkout.' '
> +	rm -fr path3 &&
> +	git read-tree -m $tree1 &&
> +	git checkout-index -f -a
> +'
> +
>   test_debug 'show_files $tree1'
>   
> -test_expect_success \
> -    'add a symlink' \
> -    'test_ln_s_add path2 path3'
> -test_expect_success \
> -    'writing tree out with git write-tree' \
> -    'tree3=$(git write-tree)'
> +test_expect_success 'add a symlink' '
> +	test_ln_s_add path2 path3
> +'
> +
> +test_expect_success 'write tree with symlink path3' '
> +	tree3=$(git write-tree)
> +'
> +
>   test_debug 'show_files $tree3'
>   
>   # Morten says "Got that?" here.
>   # Test begins.
>   
> -test_expect_success \
> -    'read previously written tree and checkout.' \
> -    'git read-tree $tree2 && git checkout-index -f -a'
> +test_expect_success 'read previously written tree and checkout.' '
> +	git read-tree $tree2 &&
> +	git checkout-index -f -a
> +'
> +
>   test_debug 'show_files $tree2'
>   
> -test_expect_success \
> -    'checking out conflicting path with -f' \
> -    'test ! -h path2 && test -d path2 &&
> -     test ! -h path3 && test -d path3 &&
> -     test ! -h path2/file0 && test -f path2/file0 &&
> -     test ! -h path3/file1 && test -f path3/file1'
> +test_expect_success 'checking out conflicting path with -f' '
> +	test_path_is_dir_not_symlink path2 &&
> +	test_path_is_dir_not_symlink path3 &&
> +	test_path_is_file_not_symlink path2/file0 &&
> +	test_path_is_file_not_symlink path3/file1
> +'

test_path_is_file_not_symlink and test_path_is_dir_not_symlink look 
rather unfamiliar, and sure enough, only four test scripts in the Git 
test suite make use of them.

These two functions were implemented four years ago; the commit hash is 
456296b5d1f05ca16949e7d37ae87f5750118564. Although the names of these 
two functions are particularly simple and straightforward, I’m not sure 
if it would be better to mention them in the commit message.

>   
>   test_done

Thanks, Yuchen
