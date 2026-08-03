Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263540E8E7
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768011; cv=none; b=IS7srF/ziKrQSxqW9NCR4s1vkAzTGnw0wLOBdKe6UWXeEJmU1ckUbWuujmodGugVOgXbJwIXYPrnbcLynQT7ZLHKNNg7KEDsJchSkx1gmzomtmtP1A14CYsTSDCAfbM9J3z8WBeyf4GE39aDimrtTgo8PcCrmcVMDGV53PdCcTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768011; c=relaxed/simple;
	bh=rKO2wZsuTxcuGfMrosyieNv0+QrfplH47BWLqiCfEYU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=EHIAHSnwQhF+avFvvzJyAO1yZ8yxLz2Wm93A+A3/MwNSvZXI4wkBTxzoA97KmxDpdqM/WtCkuNvGQ0ARgfbHQgzm1dPYwjPYV5JiW62SgGPv56/agQwoXXQQzU0ZoG4mBj4uNuMTohHnBtcEmJaMB0+6Pfvj1z40eHcq1n2w7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jypYL1S2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jypYL1S2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so20148905e9.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 07:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785768008; x=1786372808; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sUYCT92xUlYQo5V5CAZHisiTWwgasQWTkTSKmJOgw0w=;
        b=jypYL1S2Un4jBJmXS9XViEy4OBaNYrul24fluTnSA6y56YE2NpttFmbFZxS6F1uULY
         F5qlNKU77D7K4lvS7r2ZUXEuTQ4iaVUctQOR+nSsfFJAsI9a2AYb4ZwosU8q2Ds+iWlf
         TcaBXxWq/5g1UqfwRMtWw8ZPcxOEl1F2lpC6X7ytqDvw1axo+RsWNLBBZZhvesLkx352
         PVXtpZedoWKhiPGrdDvkM95I2x9PDl8xOSnDS7Lhrv1kfHdK2R5jWAB1SFyu2oJgIzye
         Y8ezZf5ZAWbeSfi0YLxkJfdavqOSyugXEqFaffVkm5bz2SqAcoIPs7M10uwlzD38qqzx
         le2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768008; x=1786372808;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sUYCT92xUlYQo5V5CAZHisiTWwgasQWTkTSKmJOgw0w=;
        b=eFU1yVxIWLEir4At9i4f8EMjxuTh4Od6rYM6MfVuD34Rfmxvq4/SzC0Qpp7oafHpPH
         0LHr7s1sECLWAvc7tZQ1cnO0C6L5Gri7ghK9sXud3kgoLkgEa7/411OmrOQ/X8qrZqKg
         5miC7TyQzKcQespYY5yMGUGqdnkuOfyl2l2RZy8AoZi4LxH9muIN7+15CSfLdqGXNI2J
         nIBZbO92Gm8+lLfzFbu2ZV5+N9ehbrY6tWmPgo8EqVbZQtU5z6j5eyJT5eWZfqUYBNR4
         4COt1h28Q1KuB5mAcLXH4MEP9eWYeWQc5qh8eHvc+yGVJ9IaKtIq7wbSVjR1owmw01Vz
         tJqQ==
X-Gm-Message-State: AOJu0Yx20Wi1FdJWHAA4RkwDhS16B40DiVL9nnWCn0rk4g7fVMIZkkHs
	DgOnDxwWfaX10YB9GL1EL2kg3LPHgOdDBj6+0TmpugjIQRl0nIx6v2rv
X-Gm-Gg: AR+sD12IoAKeopSMBkVDAUzOvEsq7HzAZFTVStveIJ1zE8A+7t/k8qlzs00PPIxK59M
	GbhQuhlwLCLTTD9FY1u8ZlHYYceDS8WqjEPolPUQySbML71l/Ktch51xqbJVKUBAoPrKI8yYcAE
	Rjq4ChakHeejdMh4ASL6fGWR4hZbL5929fF8Wx6shau+uuAjLhNIxp8RepkoOQw7ptPa/jr/fJW
	zYsnNxOIa5vIEczr1w897WZvK3azQfjYav/mxMNoFb3yMpkplzPuIMJ3SqMwYC3t3QdmXKmVdpw
	zrJqWPRhybiu8m/i+In7E9ouVpLZvYiDKkkApW3NBWx8NLJI+y77VC+IfQE1odZf0lcBTse8kEP
	ljR1ImnOSB7MFltVWllgGZE6S7NWiz4TjRwz1K782BsnrfzzaqD/AxDyzy7EfHQdSBEjUfx/vXx
	kaEpvimDGVewoRHMlh35cZ6h+0A3GFrUEcRkKch72CFQTRkaD8PXEh7bcio0ahVjcAJSeCiomyP
	w/PB6as648KNSxMjsAOlXEeZm35dSGpPLBYhzeM36o9fIcoi9eLa66ncNP7xhu2Zg/y+wL9iKX3
	ADtOSGcV5kHHYdfhqOSz469ZiDDVvBexFv/1hK49Bbhpdng1avZAxOy7Zdim1s9bzaTfeULfwRo
	dzU2tmv++EhLlLYSG
X-Received: by 2002:a05:600c:3b03:b0:493:f262:b8 with SMTP id 5b1f17b1804b1-4980c66d884mr218361805e9.1.1785768007350;
        Mon, 03 Aug 2026 07:40:07 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b86d66sm106482575e9.1.2026.08.03.07.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:40:06 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC v3 0/8] cat-file: extend remote-object-info to support
 %(objecttype)
Date: Mon, 03 Aug 2026 16:39:27 +0200
Message-Id: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OvQ6CMBSFX8V0toaWn0YnEwcfwNE4FHqBGqHYl
 kZCeHdLYWBgPDfnfN8dkQEtwaDLYUQanDRStT7ExwMqat5WgKXwGdGIZhGjCVb5Gwprhw6w6bt
 OaYuBEyizc0JExJAfdhpK+QvQJ7o/1A29lqvpw3jmrT0N39477VKea7U0VukhPORIQKzudM/tC
 I4wFUnB4zzneUmuVcPl51SoJlgd3SBisougHsHLlLEkIyBStkVM0/QHI//2qiQBAAA=
X-Change-ID: 20260724-objecttype-support-ea1ef6941d07
In-Reply-To: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

Neither the client nor the server knows how to handle type. This series
continues the work for git cat-file --batch-command extending
remote-object-info to support "%(objecttype)" end to end. It is based on
its predecessor series "cat-file: add remote-object-info to
batch-command" [1].

Type is the last property that is identical on the server and on the
client once fetched.

Whether to support more metadata such as:

- objectsize:disk
- deltabase
- objectmode (needs context)

should be discussed, unlike size and type, the rest depend on how things
are packed on the server and on what the client already has, so they
cannot reliably match local once fetched. IMO they are not worth
supporting, I can't find a use case for them.

To add a new placeholder, follow the steps in this series and add its
wants_* flag to struct fetch_object_info_results.

Patches 1-4 are preparatory. They don't change what the command does:
- 1/8 is a test cleanup.
- 2/8 fixes a possible bug in case of a truncated response.
- 3/8 and 4/8 refactor how the object data is stored and handled. The
  why about this refactor comes from [2].

Patches 5-8 are the actual objecttype support:
- 5/8 teaches the server to answer type.
- 6/8 teaches the client to parse it.
- 7/8 advertises the capability so the client can start asking it.
- 8/8 unifies the default format.

Note that wants_type is added in 4/8 while the types array only appears
in 6/8. This is intentional, it shows that asking for an attribute the
server does not advertise just outputs an empty string, as it would for
any other placeholder.

Based-on: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>

Github CI: https://github.com/pabloosabaterr/git/actions/runs/30821717187

[1]: https://lore.kernel.org/git/20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com/
[2]: https://lore.kernel.org/git/xmqqzez67yg1.fsf@gitster.g/

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Changes in v3:
- 1/8 (was 2/6): reword the commit message to explain that "wc -c | xargs"
  only strips the padding some platforms add.
- New 2/8: die if the server sends fewer object-info lines than
  requested OIDs. Preexisting bug.
- New 3/8: drop struct object_info_args and pass its members directly to
  fetch_object_info().
- New 4/8: replace struct object_info with struct
  fetch_object_info_results to hold the results. This also drops the
  object_info_options string list, remote_atom_map[] and
  free_object_info_contents().
- Dropped 1/6, which replaced the hardcoded "size" in
  send_object_info_request() with a loop over object_info_options, as
  that list no longer reaches it.
- 6/8: follows the new result struct, so it only adds the type array.
- 7/8: quote $hello_type in the test.
- Link to v2: https://lore.kernel.org/git/20260731-objecttype-support-v2-0-af577461ed57@gmail.com/

Changes in v2:
- Changed t5701 test to use test_file_size.
- Changed the for loop to use for_each_string_list_item().
- Moved "fetch-object-info: request all supported options dynamically"
  patch to be the first one as it is prep patch.
- Typos and nits.
- Restored the test mixing info and remote-object-info, adapted to the
  unified format.
- Link to v1: https://lore.kernel.org/git/20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com/

---
Pablo Sabater (8):
      t5701: use test_file_size() to get the size of a file
      fetch-object-info: detect truncated server responses
      fetch-object-info: pass arguments directly instead of a struct
      fetch-object-info: use dedicated struct for the results
      protocol-caps: add type support to object-info
      fetch-object-info: parse type from server response
      serve: advertise type capability
      cat-file: unify default format

 Documentation/git-cat-file.adoc        |  17 ++--
 Documentation/gitprotocol-v2.adoc      |  18 ++++-
 builtin/cat-file.c                     |  69 +++++-----------
 fetch-object-info.c                    | 141 +++++++++++++++++++++------------
 fetch-object-info.h                    |  37 ++++++---
 object-file.c                          |  10 ---
 odb.h                                  |   3 -
 protocol-caps.c                        |  21 ++++-
 serve.c                                |   4 +-
 t/t1017-cat-file-remote-object-info.sh |  78 +++++++++++-------
 t/t5701-git-serve.sh                   |  41 +++++++++-
 transport.c                            |  12 ++-
 transport.h                            |   5 +-
 13 files changed, 271 insertions(+), 185 deletions(-)

Range-diff versus v2:

1:  3fb0ea6af4 < -:  ---------- fetch-object-info: request all supported options dynamically
2:  641911ed87 < -:  ---------- t5701: use the test_file_size() helper
-:  ---------- > 1:  84810a5500 t5701: use test_file_size() to get the size of a file
-:  ---------- > 2:  16e2735bd5 fetch-object-info: detect truncated server responses
-:  ---------- > 3:  f42882ee03 fetch-object-info: pass arguments directly instead of a struct
-:  ---------- > 4:  3053d33534 fetch-object-info: use dedicated struct for the results
3:  a77e38e171 ! 5:  1331fab35f protocol-caps: add type support to object-info
    @@ t/t5701-git-serve.sh: test_expect_success 'basics of object-info' '
     +test_expect_success 'object-info supports type' '
     +	test_config transfer.advertiseObjectInfo true &&
     +
    ++	two_oid=$(git rev-parse two:two.t) &&
    ++	two_size=$(test_file_size two.t) &&
    ++
     +	test-tool pkt-line pack >in <<-EOF &&
     +	command=object-info
     +	object-format=$(test_oid algo)
     +	0001
     +	size
     +	type
    -+	oid $(git rev-parse two:two.t)
    -+	oid $(git rev-parse two:two.t)
    ++	oid $two_oid
    ++	oid $two_oid
     +	0000
     +	EOF
     +
     +	cat >expect <<-EOF &&
     +	size
     +	type
    -+	$(git rev-parse two:two.t) $(test_file_size two.t) blob
    -+	$(git rev-parse two:two.t) $(test_file_size two.t) blob
    ++	$two_oid $two_size blob
    ++	$two_oid $two_size blob
     +	0000
     +	EOF
     +
4:  8fb55d9b54 < -:  ---------- fetch-object-info: parse type from server response
-:  ---------- > 6:  3929b1a6fc fetch-object-info: parse type from server response
5:  70e65acd83 ! 7:  35e6b6a068 serve: advertise type capability
    @@ t/t1017-cat-file-remote-object-info.sh: test_expect_success 'remote-object-info
      		cd "$daemon_parent/daemon_client_empty" &&
      
     -		echo "" >expect &&
    -+		echo $hello_type >expect &&
    ++		echo "$hello_type" >expect &&
      		git cat-file --batch-command="%(objecttype)" >actual <<-EOF &&
      		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
      		EOF
6:  4fe367eb58 ! 8:  fe8163ebab cat-file: unify default format
    @@ Documentation/gitprotocol-v2.adoc: object-info
      Its main purpose is to allow a client to make decisions based on this
     -information without having to fully fetch objects. Object size is the only
     -information that is currently supported.
    -+information without having to fully fetch objects. Object size and type are the
    -+only information currently supported.
    ++information without having to fully fetch objects. Currently only object size
    ++and type are supported.
      
      An `object-info` request takes the following arguments:
      
    @@ Documentation/gitprotocol-v2.adoc: space.
     +	obj-val = obj-size | obj-type
     +
     +	obj-info = obj-id [SP [obj-val *(SP obj-val)]]
    ++
    ++The values in `obj-info` appear in the same order as the corresponding `attr`
    ++lines, with exactly one value per requested attribute.
      
      If the server does not recognize the OID, the response will be `<oid> SP`
      regardless of the number of attributes requested.
     
      ## builtin/cat-file.c ##
     @@ builtin/cat-file.c: static void parse_cmd_remote_object_info(struct batch_options *opt,
    - 	struct object_info *remote_object_info = NULL;
    + 	char *line_to_split;
    + 	struct fetch_object_info_results results = FETCH_OBJECT_INFO_RESULTS_INIT;
      	struct oid_array object_info_oids = OID_ARRAY_INIT;
    - 	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
     -	const char *saved_format = opt->format;
      
      	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
    @@ builtin/cat-file.c: static void parse_cmd_remote_object_info(struct batch_option
      	data->skip_object_info = 0;
     -	opt->format = saved_format;
      
    - 	for (size_t i = 0; i < object_info_oids.nr; i++)
    - 		free_object_info_contents(&remote_object_info[i]);
    + 	free_fetch_object_info_results(&results);
    + 	free(line_to_split);
     
      ## t/t1017-cat-file-remote-object-info.sh ##
     @@ t/t1017-cat-file-remote-object-info.sh: test_expect_success 'batch-command remote-object-info git:// default filter' '

---
base-commit: 71e19e8d2713f385c3fcef59cf6f29bcbd93d91f
change-id: 20260724-objecttype-support-ea1ef6941d07

