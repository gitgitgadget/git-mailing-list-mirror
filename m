Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DB64CE17
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068015; cv=none; b=O22hNj+cYVwkw9wI/tWJGUUKpAL1LLRvgnqLYVEsuR+DaR1H0u/1EQKWar8IZGpsIfMaQYHuStH5KDX1csDMnTYEtrIfM6XaF3ZMYppCGDgMlDMDaQ9B1q+oxyUgIoP+A06ksVuNBmCSLkybPjuGFjT/sNQn0M4kPtPcejDnpVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068015; c=relaxed/simple;
	bh=K3NspFO1xibd+g26vFnTE6WdU/EyqLNk09H+ZObB778=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=cGgJO0bANIqCoXvHZ4UDer5FHr532EdeYxRIsgvpnwiTMoHHSDpN0rUcj494FHqK+s5Iwj729xA2RJB9ADzATPBtZWA3/xgJkxtEZRjrXOl6Zd0GXUVkRFLa1H3tBYKKFr9Tl/hdOZmml7tAlCLGRmxUbirXZM6W1r9r7qHF0GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSkhX0UO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSkhX0UO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412b34fb36bso86865e9.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 13:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709068012; x=1709672812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jhTs5tz7KKR3O3D6aIyKeNtlLCiqkkpqPahI8/qs9Zo=;
        b=GSkhX0UOrhKTFfhKpq251WL2RqURP/bVLgX/G11YZTxWhq4vw8z2p4kp3CsBqP3Mpn
         aNck2yrjxHpGzKBrcHBusKUymWw15h3uOUkUazQHfusOPM8tQp1V9hYcppAVR5bsvNHY
         3OZhocFf2t/igVVxF400TBF5NPIxPS5RaUXyCwaOyFI/7ntC3w/4mQXLJUlVqd6jJt65
         KyPYHa5I45lzse2TaNXWImSNA/5zshj57gzTA54u6t/v8ackmICOcWEzZ6fu56bP2lbo
         cbbAg9xxTQtiCRP/2Qlyg3/TsU9dAcoDEgncJtK0/s2n9BWoUyrg2nfaGOS9kKMyn5tZ
         baBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709068012; x=1709672812;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhTs5tz7KKR3O3D6aIyKeNtlLCiqkkpqPahI8/qs9Zo=;
        b=jg/yD3hcVyRQAhV7SEXbOk4enaFrBB1XSA9+IApg4iHbxQTED4CRegt0OAczTf4zWk
         quOP7EGmAsQ1J8Kuut49jPMIYWUT4X3BTjPcboV2U1KVeRpPKGqHvij8ecRXvzv93Qwg
         jwaxbL9KrSZWSLMtJBoINMzoBEyHlNiKAzUGIT24A65i3Jt5IMfYL00xKUpuZ0c9p5mF
         r7baEDKpH15Ea0Ghql4qAZoPI03Gld6UIa19YAx9Lr4+6Y2JqAaSaZF6LjSiiHDnUpCa
         L6T4cka/mcy7n2YJmel/kihr8akiOZ0/PfUOK8WbC5Dy+wIgV7Z9y9iSeYUW1gUR4b5/
         1n+w==
X-Gm-Message-State: AOJu0Yz/loBeps9oTnJ4ec7AvYh+96tuh3bDKa/L4QRyyT0RwNB1yC6z
	hSRKwS1brXlIVqVe8TUEfzAZQnTKlM1ikCWFiPrpZ8pFyDvdSKUUjPwczLO6
X-Google-Smtp-Source: AGHT+IFveTVT5dkBdhBPy87y6T4iZHrgqsjNzGpVqGUHac/ulT/Zl/mn62Mvbf9voVN9ug5G5PFf4Q==
X-Received: by 2002:a05:600c:c17:b0:412:a482:cd75 with SMTP id fm23-20020a05600c0c1700b00412a482cd75mr5406314wmb.7.1709068011514;
        Tue, 27 Feb 2024 13:06:51 -0800 (PST)
Received: from gmail.com (18.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.18])
        by smtp.gmail.com with ESMTPSA id j7-20020adff547000000b0033b87c2725csm12176664wrp.104.2024.02.27.13.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 13:06:51 -0800 (PST)
Message-ID: <b8f09e20-d0d3-4e0b-afe2-31affeb61052@gmail.com>
Date: Tue, 27 Feb 2024 22:06:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] completion: fix __git_complete_worktree_paths
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <a1561e02-40dc-4ac3-ae7a-666db0f810ed@gmail.com>
 <eaf3649e-30cf-4eba-befa-5be826c828a8@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>
In-Reply-To: <eaf3649e-30cf-4eba-befa-5be826c828a8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use __git to invoke "worktree list" in __git_complete_worktree_paths, to
respect any "-C" and "--git-dir" options present on the command line.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

I stumbled upon this in a situation like:

   $ git init /tmp/foo && cd /tmp/foo
   $ git worktree add --orphan foo_wt

   $ git init /tmp/bar && cd /tmp/bar
   $ git worktree add --orphan bar_wt

   $ cd /tmp/foo
   $ git -C /tmp/bar worktree remove <TAB>
   ... expecting /tmp/bar/wt, but ...
   $ git -C /tmp/bar worktree remove /tmp/foo_wt

The function __git was introduced in 1cd23e9e05 (completion: don't use
__gitdir() for git commands, 2017-02-03).  It is a small function, so
I'll include here to ease the review of this patch:

        # Runs git with all the options given as argument, respecting any
        # '--git-dir=<path>' and '-C <path>' options present on the command line
        __git ()
        {
                git ${__git_C_args:+"${__git_C_args[@]}"} \
                        ${__git_dir:+--git-dir="$__git_dir"} "$@" 2>/dev/null
        }

Here are the changes since v2:

"test_completion" already asserts if something is printed on stderr.
Therefore "test_must_be_empty err" does not make sense.  Removed.  This
makes the test_completion with an empty response, more valuable, IMO.
But I'm open to change it.

The second test_when_finished has been fixed.

Thanks in advance for your review.

Range-diff against v2:
1:  4cc071fb8e ! 1:  de5d2ca1d3 completion: fix __git_complete_worktree_paths
    @@ t/t9902-completion.sh: test_expect_success '__git_complete_fetch_refspecs - full
     +		cd non-repo &&
     +		GIT_CEILING_DIRECTORIES="$ROOT" &&
     +		export GIT_CEILING_DIRECTORIES &&
    -+		test_completion "git worktree remove " "" 2>err &&
    -+		test_must_be_empty err
    ++		test_completion "git worktree remove " ""
     +	)
     +'
     +
     +test_expect_success '__git_complete_worktree_paths with -C' '
    -+	test_when_finished "rm -rf to_delete" &&
    ++	test_when_finished "git -C otherrepo worktree remove otherrepo_wt" &&
     +	git -C otherrepo worktree add --orphan otherrepo_wt &&
     +	run_completion "git -C otherrepo worktree remove " &&
     +	grep otherrepo_wt out

 contrib/completion/git-completion.bash |  2 +-
 t/t9902-completion.sh                  | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 444b3efa63..86e55dc67f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3571,7 +3571,7 @@ __git_complete_worktree_paths ()
 	# Generate completion reply from worktree list skipping the first
 	# entry: it's the path of the main worktree, which can't be moved,
 	# removed, locked, etc.
-	__gitcomp_nl "$(git worktree list --porcelain |
+	__gitcomp_nl "$(__git worktree list --porcelain |
 		sed -n -e '2,$ s/^worktree //p')"
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index b16c284181..aae2cbeeea 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1263,6 +1263,29 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 	test_cmp expected out
 '
 
+test_expect_success '__git_complete_worktree_paths' '
+	test_when_finished "git worktree remove other_wt" &&
+	git worktree add --orphan other_wt &&
+	run_completion "git worktree remove " &&
+	grep other_wt out
+'
+
+test_expect_success '__git_complete_worktree_paths - not a git repository' '
+	(
+		cd non-repo &&
+		GIT_CEILING_DIRECTORIES="$ROOT" &&
+		export GIT_CEILING_DIRECTORIES &&
+		test_completion "git worktree remove " ""
+	)
+'
+
+test_expect_success '__git_complete_worktree_paths with -C' '
+	test_when_finished "git -C otherrepo worktree remove otherrepo_wt" &&
+	git -C otherrepo worktree add --orphan otherrepo_wt &&
+	run_completion "git -C otherrepo worktree remove " &&
+	grep otherrepo_wt out
+'
+
 test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
 	test_completion "git switch " <<-\EOF
 	branch-in-other Z
-- 
2.44.0.1.g0da3aa8f7f

