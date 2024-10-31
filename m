Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B001BC092
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392251; cv=none; b=RQpAPNZC5+P86U4vghZj1t2kcua5UZHqWs76H8JU3HcOajshFAc7TmO0q5XQ9d73KgF0EgtqqjV3UPa82hKZvdT1+SqAN5q5TRHUrqFfBIkhVXHAjlf5/sAPwG+GBIZuaA3KQVQgzdB6AIfXrUMhNBboQvIoekMgqUcUmZ8uf9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392251; c=relaxed/simple;
	bh=FoxbeGEPoHM/8PAsS5VNrVwfYiV7VCNazDDX/jeSWOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KX3Ed8oHa17o2/EuMiPC5thMSnXONE80fCXlTajJLiGYrsqQPNy2nypFG5ZG4C3bFRsJZiqDv7pfDZTXxtCT2bwqk7TeYONzpmXSHykexooTJADgHpdHONYFPWzWcnfl/9AnP5HQz2iOmtk+Ye0eKXGycDZxERi7+Sd44NHbkWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8zubmSR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8zubmSR"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso9943925e9.3
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730392248; x=1730997048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pTEboSFHT599Bvxnvxl2p5OZ0Sy2KW7cCiXDv5bicxc=;
        b=h8zubmSRn+c0q371ptuzulHdI3rOaLWdkE1YYYXRf4rBL6pdxIxeO9439zqXmvqou7
         EkB9AJzoiV4fM2e0uchi+4EpKJxVvFNKm8luZRFmnUwzDsigloqooRSUR5TbIIp/oIqu
         ntRuK2qAy2aOWNzl9zrZvrhDuQJmhkaZwf7p0K3WWvvZn6Ti4x8fkulvhGshMNmmTpTP
         KpjgW7R1HdVHFauPpSrCrtkwDZytSaEIJI+hUHuo4ctfr7cRhyBQONcIwUkGG41ELYnR
         U4JiNzTt2wr+A2E8Amsll7krdeV9u1GHjgqD+r66EqFND4iYfzsOufCG36jeD7wEQUf0
         cpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730392248; x=1730997048;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTEboSFHT599Bvxnvxl2p5OZ0Sy2KW7cCiXDv5bicxc=;
        b=Bjl1f7FUhf6A2GKq+5zllm2wx8Rb0NCOiNy8deIqBVshhLLRjIDfGt2sMVYwcg3suq
         zuVp6wCxehcmcSZj1clnHGBx7ZdNMEl9bwwaSZ2NFm+W3tQJ8bu46HopBSPNFHyA7Y4c
         1Myc+ClXjuxInXP8rWok102APBtKGIXtH7b9SvSbR6U6kc1MaWvhlBcUnzb5WHpEOZLq
         0n00pqVjIFz/nF+/VMct//BCqA6mDZoLLXsnfK83AfMND85iITko65hKgA5awnCON2pe
         mHdpi1rW4e91qwqnvJepEl6qSUzeCY819rFyv+hpS3cWh84ty1UMGFqxQBbX14/IoEFg
         HFQg==
X-Gm-Message-State: AOJu0YzEtxlyt+Zwh1RUsghbvlBaduA/pPmg5sARy5OBh+DzZP2wJdp+
	rJEFXJR61zwq8KmKN5Spc6C5altZvyS+xk14oDWDbrW78e0HbtsI
X-Google-Smtp-Source: AGHT+IHByN1PV077K8IG2W/n3iqDdBeRaInntrssrvf1CSCWpUMBIpbYCxMsR4H5v9zWEbhQiItKqg==
X-Received: by 2002:a05:6000:188f:b0:37c:cd71:2b96 with SMTP id ffacd0b85a97d-381be906966mr3345089f8f.36.1730392247341;
        Thu, 31 Oct 2024 09:30:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116b575sm2578593f8f.108.2024.10.31.09.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 09:30:46 -0700 (PDT)
Message-ID: <14993bd1-034b-40ac-a991-cc3eabc956be@gmail.com>
Date: Thu, 31 Oct 2024 16:30:45 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: comment checked-out branch properly
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
 <ZxlEJ+44M8z03VOj@nand.local>
 <20cca28c-cc0f-4bfa-bc1c-6a3dd6bc25a8@app.fastmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20cca28c-cc0f-4bfa-bc1c-6a3dd6bc25a8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

On 23/10/2024 20:53, Kristoffer Haugsbakk wrote:
> On Wed, Oct 23, 2024, at 20:44, Taylor Blau wrote:
> 
>> Makes sense, but the following command turns up a couple more results
>> even after applying:
>>
>>      $ git grep -p 'strbuf_addf([^,]*, "#'
>>      sequencer.c=static void update_squash_message_for_fixup(struct strbuf *msg)
>>      sequencer.c:    strbuf_addf(&buf1, "# %s\n", _(first_commit_msg_str));
>>      sequencer.c:    strbuf_addf(&buf2, "# %s\n", _(skip_first_commit_msg_str));
>>
>> I imagine that we would want similar treatment there as well, no?
> 
> Here is where I got confused.  I tried to make this test appended to
> `t/t3437-rebase-fixup-options.sh` yesterday in order to exercise this
> code:
> 
> ```
> test_expect_success 'sequence of fixup, fixup -C & squash --signoff works (but with commentChar)' '
> 	git checkout --detach B3 &&
> 	FAKE_LINES="1 fixup 2 fixup_-C 3 fixup_-C 4 squash 5 fixup_-C 6" \
> 		FAKE_COMMIT_AMEND=squashed \
> 		FAKE_MESSAGE_COPY=actual-squash-message \
> 		git -c core.commentChar=% -c commit.status=false rebase -ik --signoff A &&
> 	git diff-tree --exit-code --patch HEAD B3 -- &&
> 	echo actual: &&
> 	cat actual-squash-message
> '
> ```> And the output looked correct, i.e. all-`%`.[1]
> † 1:
> 
> ```
> % This is a combination of 6 commits.
> % This is the 1st commit message:
> 
> B

This line should have been be commented out when adding
"amend! B" commit below

> Signed-off-by: Rebase Committer <rebase.committer@example.com>
> 
> % The commit message #2 will be skipped:
> 
> % fixup! B
> 
> % This is the commit message #3:
> 
> % amend! B
> 
> B
> 
> edited 1

This message should have been commented out when adding
"amend! amend! ..." below

> Signed-off-by: Rebase Committer <rebase.committer@example.com>
> 
> % This is the commit message #4:
> 
> % amend! amend! B
> 
> B
> 
> edited 1
> 
> edited 2
> 
> Signed-off-by: Rebase Committer <rebase.committer@example.com>

The diff below shows a fix and a new test that fails without the
sequencer changes. The fix is based on master, so it might need
updating to go on top of Junio's series. The test could probably
be improved to use the existing setup.

Best Wishes

Phillip


diff --git a/sequencer.c b/sequencer.c
index 353d804999b..6e45b8ef04f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1941,10 +1941,10 @@ static int seen_squash(struct replay_ctx *ctx)
  
  static void update_comment_bufs(struct strbuf *buf1, struct strbuf *buf2, int n)
  {
-	strbuf_setlen(buf1, 2);
+	strbuf_setlen(buf1, strlen(comment_line_str) + 1);
  	strbuf_addf(buf1, _(nth_commit_msg_fmt), n);
  	strbuf_addch(buf1, '\n');
-	strbuf_setlen(buf2, 2);
+	strbuf_setlen(buf2, strlen(comment_line_str) + 1);
  	strbuf_addf(buf2, _(skip_nth_commit_msg_fmt), n);
  	strbuf_addch(buf2, '\n');
  }
@@ -1963,8 +1963,8 @@ static void update_squash_message_for_fixup(struct strbuf *msg)
  	size_t orig_msg_len;
  	int i = 1;
  
-	strbuf_addf(&buf1, "# %s\n", _(first_commit_msg_str));
-	strbuf_addf(&buf2, "# %s\n", _(skip_first_commit_msg_str));
+	strbuf_addf(&buf1, "%s %s\n", comment_line_str, _(first_commit_msg_str));
+	strbuf_addf(&buf2, "%s %s\n", comment_line_str, _(skip_first_commit_msg_str));
  	s = start = orig_msg = strbuf_detach(msg, &orig_msg_len);
  	while (s) {
  		const char *next;
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 7929e2e2e3a..59c031005e6 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -220,4 +220,34 @@ test_expect_success 'fixup -[Cc]<commit> works' '
  	test_cmp expect actual
  '
  
+test_expect_success 'fixup -C comments out previous messages' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	test_config core.commentString COMMENT &&
+	git checkout B &&
+	git commit --fixup=HEAD --allow-empty -m "EMPTY FIXUP" &&
+	test_commit new-file &&
+	echo changed >new-file.t &&
+
+	write_script editor.sh <<-\EOF &&
+	sed -n -e "1,2 p
+		   3 {
+			c\\
+			edited
+			q
+		   }" "$1" >"$1.tmp"
+	cat "$1.tmp" >"$1"
+	EOF
+
+	(
+		test_set_editor "$(pwd)/editor.sh" &&
+		git commit --fixup=amend:B new-file.t
+	) &&
+
+	test_must_fail git rebase --autosquash A &&
+	echo resolved >new-file.t &&
+	git add new-file.t &&
+	test_must_fail git rebase --continue &&
+	test_commit_message HEAD -m edited
+'
+
  test_done


> % This is the commit message #5:
> 
> % squash! amend! amend! B
> 
> edited squash
> 
> % This is the commit message #6:
> 
> % amend! amend! amend! B
> 
> B
> 
> edited 1
> 
> edited 2
> 
> edited 3
> squashed
> ok 13 - sequence of fixup, fixup -C & squash --signoff works (but with commentChar)
> ```
> 

