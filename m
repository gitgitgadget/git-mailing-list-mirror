Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2577E367B99
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140435; cv=none; b=fw9hCgl2aYLPAY2D/08g+eyEHd7bYQq7xE3Lh1FIYzKrOjGaF6RJuzmmqJNXmeBVJ827D9vvlqIaVkcy+oyto1lbD91So9akzZX7KMmkzk28RyDnHtdVFwg5vQ6NUWHXfkfxIqaIPR+xNLhahjbfJojodkBs7qvM2uibTBbGbcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140435; c=relaxed/simple;
	bh=oAunZLSGJ06W7JuqV8IXHtpPI6h7GSH0pbha3/NAcFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=f37wjD6o8++u+F44xRRSE6kGHvjF0mgofkw+XunwNH7lOHCp+laBvx4dHb0ctiUNPva5C6WsTB1a+k4AdCSA9VHzoAjcbooaE3noXBth93ad9y8N38NlAPBnbEJ6/f8u4xhadGdY1W7qp9BzQX/EltrekzNZXExVnJjThTcBKa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNxZb1KK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNxZb1KK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-495590dde14so507555e9.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140431; x=1786745231; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZFRWbo1qjRSLIy5GZ8D4LX4w3o/e9ndbvMARP6ZXtTw=;
        b=cNxZb1KKl4+/8NWgTiuXiRfF1tov//fnG1n6kPRfUKPtNjc18u2kplNGppCck5YcgT
         4dvH4w2jfB2sisvCCA+L4wAd2GGO60Eo27HLnfy9jeRLb+3JZLXx7pdigku7aT1Nlq0G
         pRtTuvV1gGDjjoQ/Sqc1WS+bX9v30ATUDV1pfRNRfA2x5Rvygn1DK6u8nfbSs7nS0eRI
         jLx3sjQxF8chN/4F61Oq3ZdG7+G7HcxVazTu51EYwfhG5TUUYTipP5xPX/fLepgENSxu
         YK0diGK+om7cMsRnFfq06awPggra/MZwqerpNqF9yVQGrKUomvGiyY0QgACWZJjU/gk8
         1qCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140431; x=1786745231;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFRWbo1qjRSLIy5GZ8D4LX4w3o/e9ndbvMARP6ZXtTw=;
        b=PRIojkBfF/9tknDWTnlhuKdvBeyZcyNFpKlJTZPwrIuSM7XY5mPEZ0NUicP8LG6c2a
         JczCXa6xMF2NzTdCfNZ3KSCQvEj3wyoKFNgn6yYGIsPW1k17YX7f0nHqL8Lwi25i6nns
         ZmVaH842bpIVEB1AZM/2V4VMsdoyDjBkdSRcQw4iK8f5KNA/s4AoIcx4vbQ2DYRkA/VY
         WmUmsmtjtmiJLiWhuZY5p6wD6cI5mQT7zmuBwKPEiA7K7eNg1QzmE55PqcuACIhAqC9O
         kaMasRI9O6zsKlAva/hGx7cOU6R/gc0/JZpfT9K7WQfTRL8xYFiFvVXVYzz2/yUCxYiL
         UzoQ==
X-Gm-Message-State: AOJu0YzYHkbt/8s8GsMOwgupQjjzEw78DcPSrG7zMrb8HdaR/3WVDt8f
	dqXyQu1aH5kudhXR1w7+Oo7r8H+js+LsKO8LDrLtWN4dc4wVaBDL7uSd
X-Gm-Gg: AR+sD13b5ZrAO1ChrJ4zEUBw6mlqUcVromkcHvNLv/ypYJ84jgT3qw/94sh0U09XH0w
	gmVTATloGIxH3/v3BXV4imBdnHtl9hI9lb2Z05STSwNIpge5L/20JyH7tE8E8fhTMRkwlzudtY4
	Etvj9bIvtmU9xW4uWghKyc6VrM7Ey4o+BTlkuP/qnTzEBQlyapuB7tPUwxGzmZkDhSrnL11E3cd
	svA2yPNEKC93eTJlpF7L+bn9RLwrckV7CbpZc/fn8vxr71rtBfkk3u9cRiCFLvjmIwRR4G7T2+B
	HF5QBy6IPs8qQ0vZK06HoDFIDQ8ezxdBQ7l4NIMdFCx6s2Hn48+CzkSTQPBzW08AxqW1PW6oZJp
	C5ZKy3g3KU2MXZuhf4xpagEZw0Jf/4SAZfbAw6u8SgEIjszSDuyfLp/vGHemJ31qkiJZFDIAzJM
	eghDw2oZiY/O7HnfdYLpk6IMP677jOjx+nm1fX9OHqe9kFW7uNPAvPr2nhzCYxYe7/n3++VwKP+
	S3vsdqdBLs4znuZ2B0tR/hT1svr0hTnTY0HP1eLvk5bnU5cnNh4E66bSuapKGj6AKk55cmbXUoW
	KrEaVnR8cYYfZ8H7fY4QY4GW9ZuD3I2mS8MmOqHIikQG9eL8WBuFaUQABheTLQ3cvi9YGapjoDC
	FoGwge6Tb0ywwV9pFx911LjFBEvDjPEZIHWOHzB1iPO1cqg7eov7yzUlU3otCfpiYLHcFgA==
X-Received: by 2002:a05:600c:4f86:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-4994e72f7c1mr336747065e9.2.1786140430999;
        Fri, 07 Aug 2026 15:07:10 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b4499sm69478545e9.3.2026.08.07.15.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:07:10 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC v5 00/10] cat-file: extend remote-object-info to
 support %(objecttype)
Date: Sat, 08 Aug 2026 00:06:55 +0200
Message-Id: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Qz04DIRAG8FdpOIth+LNYTyYefACPxgPsDi3Gl
 hVYYtPsu0tpEzfNHod88/vInEnC6DGR582ZRCw++XCsg3rYkH5vjjukfqgz4Yx3THNJg/3CPuf
 TiDRN4xhipmgAXbeVMDBN6uIY0fnfhn6Qt/fwSj6vr2lqyxfvlov4M9XOfA1fYnufcoin9qECj
 bh1q7XuApRRPsjeCGuNdfCyOxj//diHQ2stfEEIWCV4JYxTWssOcFD6nhD/xBMTq4SohAbdOey
 d3ip2T8glsXrEIishQAFYxgVYXBLzPP8BsxcaH6oBAAA=
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
batch-command" [1] merged into master.

Type is the last property that is identical on the server and on the
client once fetched.

Whether to support more metadata such as: - objectsize:disk
- deltabase
- objectmode (needs context)

should be discussed, unlike size and type, the rest depend on how things
are packed on the server and on what the client already has, so they
cannot reliably match local once fetched. IMO they are not worth
supporting, I can't find a use case for them.

To add a new placeholder, follow the steps in this series and add its
wants_* flag to struct fetch_object_info_results.

Patches 1-6 are preparatory. They don't change what the command does:
- [1/10] is a test cleanup.
- [2/10] fixes a possible bug in case of a malformed response.
- [3/10] and [4/10] refactor how the object data is stored and handled.
  The why about this refactor comes from [2].
- [5/10] drops the last error return left in fetch_object_info().
- [6/10] drops the remote object-info fields from the transport struct.

Patches 7-10 are the actual objecttype support:
- [7/10] teaches the server to answer type.
- [8/10] teaches the client to parse it.
- [9/10] advertises the capability so the client can start asking it.
- [10/10] unifies the default format.

Note that *_type appears from [8/10]. Before this series, "type" is
already listed in the client's allow-list, but the prep patches drop
that list, so the client knows nothing about type until [8/10] adds it
back.

Github CI: https://github.com/pabloosabaterr/git/actions/runs/30938909345

[1]: https://lore.kernel.org/git/20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com/
[2]: https://lore.kernel.org/git/xmqqzez67yg1.fsf@gitster.g/

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Changes in v5:
- New [6/10] by Jeff King: drop the remote object-info fields from the
  transport struct and pass them as function parameters instead.
- [5/10]: keep the const qualifiers on parameters of fetch_object_info(),
  matching how the signature was.
- Link to v4: https://patch.msgid.link/20260804-objecttype-support-v4-0-31511b0231be@gmail.com

Changes in v4:
- Rebased onto master now that ps/cat-file-remote-object-info was merged.
- Dropped the Based-on trailer.
- Reworded [1/9] so it shows that we also benefit from preserving the
  exit status.
- Changed [2/9] to also check if a response returns more packets.
- New [5/9]: fetch_object_info() dies on its last error return and
  becomes void.
- Moved the introduction of ask_type, wants_type to [7/9] instead of
  [4/9].
- Link to v3: https://lore.kernel.org/git/20260803-objecttype-support-v3-0-7176fecf7950@gmail.com/

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
Jeff King (1):
      transport: drop remote object-info fields from transport struct

Pablo Sabater (9):
      t5701: use test_file_size() to get the size of a file
      fetch-object-info: detect malformed server responses
      fetch-object-info: pass arguments directly instead of a struct
      fetch-object-info: use dedicated struct for the results
      fetch-object-info: die() on the remaining error path
      protocol-caps: add type support to object-info
      fetch-object-info: parse type from server response
      serve: advertise type capability
      cat-file: unify default format

 Documentation/git-cat-file.adoc        |  17 ++--
 Documentation/gitprotocol-v2.adoc      |  18 +++-
 builtin/cat-file.c                     |  73 +++++-----------
 fetch-object-info.c                    | 149 +++++++++++++++++++++------------
 fetch-object-info.h                    |  37 +++++---
 object-file.c                          |  10 ---
 odb.h                                  |   3 -
 protocol-caps.c                        |  21 ++++-
 serve.c                                |   4 +-
 t/t1017-cat-file-remote-object-info.sh |  78 ++++++++++-------
 t/t5701-git-serve.sh                   |  41 ++++++++-
 transport-helper.c                     |   7 +-
 transport-internal.h                   |   4 +-
 transport.c                            |  24 +++---
 transport.h                            |  10 +--
 15 files changed, 294 insertions(+), 202 deletions(-)

Range-diff versus v4:

 1:  ef807d2fa2 =  1:  e5f8dd814c t5701: use test_file_size() to get the size of a file
 2:  c3c3e37c36 =  2:  4c108f4a59 fetch-object-info: detect malformed server responses
 3:  193f71d224 =  3:  54fe4136de fetch-object-info: pass arguments directly instead of a struct
 4:  ee82d07710 =  4:  f286159201 fetch-object-info: use dedicated struct for the results
 5:  b5c09feca9 !  5:  dbf5832d05 fetch-object-info: die() on the remaining error path
    @@ fetch-object-info.c: static int parse_object_size(const char *s, size_t *res)
     -		      struct fetch_object_info_results *results,
     -		      const int stateless_rpc,
     -		      const int fd_out)
    -+void fetch_object_info(enum protocol_version version,
    ++void fetch_object_info(const enum protocol_version version,
     +		       const struct string_list *server_options,
     +		       struct oid_array *oids,
     +		       struct packet_reader *reader,
     +		       struct fetch_object_info_results *results,
    -+		       int stateless_rpc,
    -+		       int fd_out)
    ++		       const int stateless_rpc,
    ++		       const int fd_out)
      {
      	unsigned ask_size = 0;
      	int size_index = -1;
 -:  ---------- >  6:  f89a6a8c1d transport: drop remote object-info fields from transport struct
 6:  2c95d76b46 =  7:  56a9cdbde6 protocol-caps: add type support to object-info
 7:  8c6b342c3a !  8:  1fd7392db9 fetch-object-info: parse type from server response
    @@ fetch-object-info.c
     @@
      static void send_object_info_request(const int fd_out,
      				     const struct string_list *server_options,
    - 				     struct oid_array *oids,
    + 				     const struct oid_array *oids,
     -				     unsigned ask_size)
     +				     unsigned ask_size,
     +				     unsigned ask_type)
    @@ fetch-object-info.c: static void send_object_info_request(const int fd_out,
      	if (oids)
      		for (size_t i = 0; i < oids->nr; i++)
      			packet_buf_write(&req_buf, "oid %s",
    -@@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
    - 		       int fd_out)
    +@@ fetch-object-info.c: void fetch_object_info(const enum protocol_version version,
    + 		       const int fd_out)
      {
      	unsigned ask_size = 0;
     +	unsigned ask_type = 0;
    @@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
      	size_t wanted;
      
      	results->nr = oids->nr;
    -@@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
    +@@ fetch-object-info.c: void fetch_object_info(const enum protocol_version version,
      		    server_supports_feature("object-info", "size", 0))
      			ask_size = 1;
      
    @@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
      		break;
      	case protocol_v1:
      	case protocol_v0:
    -@@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
    +@@ fetch-object-info.c: void fetch_object_info(const enum protocol_version version,
      	case protocol_unknown_version:
      		BUG("unknown protocol version");
      	}
    @@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
      
      	for (size_t i = 0; i < wanted; i++) {
      		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
    -@@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
    +@@ fetch-object-info.c: void fetch_object_info(const enum protocol_version version,
      				die(_("object-info: duplicate 'size' attribute"));
      			size_index = (int)i;
      			CALLOC_ARRAY(results->sizes, results->nr);
    @@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
      		} else {
      			die(_("object-info: unknown attribute '%s'"),
      			    reader->line);
    -@@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
    +@@ fetch-object-info.c: void fetch_object_info(const enum protocol_version version,
      			    object_info_values.items[0].string,
      			    object_info_values.items[size_index + 1].string);
      
    @@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
      		string_list_clear(&object_info_values, 0);
      	}
      
    -@@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
    +@@ fetch-object-info.c: void fetch_object_info(const enum protocol_version version,
      void free_fetch_object_info_results(struct fetch_object_info_results *results)
      {
      	free(results->sizes);
 8:  0964658eb6 =  9:  76f52c455b serve: advertise type capability
 9:  77a193bf5c = 10:  e5cebc08f0 cat-file: unify default format

---
base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
change-id: 20260724-objecttype-support-ea1ef6941d07

