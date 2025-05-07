Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1428C5A0
	for <git@vger.kernel.org>; Wed,  7 May 2025 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637338; cv=none; b=KcZQLodWrfDLCAlKhmi2XrsXKW5gJZbQbL5/bkntYSzDiIjLVM1npvkZz3HbdEY+xmT42sjct1IxTEyHY+UAkmr7QSD1vSnOAo82RcuPNe6EnM2BDapEswumIZGnFwSwpvnkeJbPR9KrpaYOZjzqaObCx15YUXqB6T0+tXHvMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637338; c=relaxed/simple;
	bh=/2Oe2CvbAJ/pVg8LAakxFWkx9Skes2MCNFalDyxH6jg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bm/nuUwr5T8a22V97ZTDTH4ZZcJsagYSRwK/6gt7iXi5HMh6uHkEV7s/bKTDOFhOKz93WEbl0yf8miNRsgcmfhxTYht1UHDwg1chXIO5FR94UaOGTRzpoM2WKvfs9IZrbfVfD5Ead9Q9roNv7cqZBqo/w1K4PiySVLkVlrXl80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h5V/NDe9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oUMZTJH/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h5V/NDe9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oUMZTJH/"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 51B26138016B;
	Wed,  7 May 2025 13:02:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 07 May 2025 13:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746637334; x=1746723734; bh=4wLNGHHmhr
	SRoGWM2+F4/2QR07iL7B/5zKl8kS3rUj0=; b=h5V/NDe9SeM5wMEGimcN3F+Rgo
	yX5A115iddFCEK1cl1nOS4so7/dlcs5CY9+eWvfyRgQYTotiSje2/f0vpHbV801+
	pXhsLQzndtaY7KKJ+XPJxg38CeWp1Dz2K4JhgbGNsoxq/s8lFQc92NP9fepESmi7
	vk3QCNLnN/DZ2II6FS/ihNqpGlWoIuGoS/QztcRBqm5BhgDUpgN7eoJZYtZFePkJ
	zT5EW54onFgA0KFldESRumiRiC6GtzsH6qBEPTnUKTcMYBFlii/eOq1ZypYVhAMA
	ouAxrn3FzrnbEfjjj87wStPa+AUVKNS2ciAB8qZ32jQYPYpblgBA7i47x1Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746637334; x=1746723734; bh=4wLNGHHmhrSRoGWM2+F4/2QR07iL7B/5zKl
	8kS3rUj0=; b=oUMZTJH/HjQ5lbBuJU0lCePHGXu1XLljj0PJvO/puUBEh/vFRXv
	aZQglYMbiBFXUWEdzifJeVONzZ2/WWL3EmydjOFMy0cVQiWCgKjIxte9Xn/rS460
	mdLfHZStX/ixYroImIuY/QIQf9TPHfZ6BSf0KJQRSST1xVeXyfidSrZWcf9pPysF
	FXDLWsBjRpvWbz0HTRcJ8n4tKlSPZJqlUo4268Rh2Cyj4KjJaBRuVRUF55U7x+Q3
	rGWs6OooPlnq7vI5gnpErq0EPyUgXrnAF9xkEs5HrpsCV7GaDe9jdDgcwZuC01G8
	mrqleL4dG5nNQ0UojF7b+IV7OhIVQ31kODg==
X-ME-Sender: <xms:FpIbaMwXbMf-GdL2M54AG7kz-05uKVCK9Jd4rDO28JU6tHIaOCYieQ>
    <xme:FpIbaASGbSaqHINRJ0AOgzzTonxXh7pibpI_UQQb-Jsb0L04f0D3hVohIT39IQ7Jv
    Vr0A9j-_HK_XZrtng>
X-ME-Received: <xmr:FpIbaOX_Gb6r80yP9xfT-nRvOkF1kUdih5AzoB_M3pNyPax4ZyAmqPHtjzdxZLXdRQ-OtEJ5z2nnIM5nhiemSJWyw8ZLn2b8dVzF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:FpIbaKge-Q6e56u5X7KzbOnpL5iW8Y-BPvS9f6Q36dm3JdHSgW5MwQ>
    <xmx:FpIbaODBwGC-If1xmIKWAImdbyM4dVz56jfviLgE5VD07ft8SmVJFA>
    <xmx:FpIbaLJoqNsHSUgByZkxmMHpj12l3K-LZOZRG24kwsAHnuXOpkJvlw>
    <xmx:FpIbaFAReick3GQaCdZLeegxjpVNKNih3ZsAcWltnlIxqrSQ1gY3fg>
    <xmx:FpIbaONQeaKvDH-aGpEiqruFB0xiyvBnZVWuaEo_b6bOjb3UTipwFdFJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 13:02:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 00/17] object-store: carve out the object database
 subsystem
In-Reply-To: <5bea19fe-6616-4f01-a78d-9b7da94db899@gmail.com> (Derrick
	Stolee's message of "Tue, 6 May 2025 21:40:16 -0400")
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
	<5bea19fe-6616-4f01-a78d-9b7da94db899@gmail.com>
Date: Wed, 07 May 2025 10:02:12 -0700
Message-ID: <xmqqa57oe4mj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> Patches 1 and 2 involve renaming some core structures, and I had
> some questions around these names (since we hope to be stuck with
> the new names for a long time). I was thinking out loud on a per-
> patch basis, but now want to collect my thoughts around these:
>
>  * raw_object_store currently describes the abstraction that contains
>    all objects that can be accessed within the repository. This may
>    include multiple alternates. Patch 1 renames this to
>    'object_database'.
>
>  * object_directory currently describes a single directory that
>    has the same structure as $GIT_DIR/objects/ but may be an alternate
>    or a submodule object directory. Patch 2 renames this to
>    'odb_backend'.
>
> My concerns around this are basically around not liking "backend" for
> this purpose. When I think of a backend, I'm thinking about the
> implementation details (like the refs backend being files or reftable)
> and not multiple distinct locations that have their own objects.

Yup, odb_backend_files (aot odb_backend_redis) or something?

>  * 'struct object_directory' could be renamed to 'struct odb_shard' or
>    'struct odb_slice' or similar. I may even recommend 'odb_partition'
>    though that does imply some disjointness that is not guaranteed (an
>    object can exist in multiple parts).
>
>  * In the event that we create multiple implementations for storing
>    objects, then a 'struct odb_shard' could point to a backend to help
>    find the appropriate methods for interacting with its storage.

Hmph, I do not have strong opinions, but I consider it an
implementation detail of one particular backend, namely, the
filesystem based backend, that it can link together multiple
object_directory instances and present them as if they form a single
object database, just like all files within a single object_directory
form an illusion of a single object database (aka key-value store) even
though some objects are stored in individual loose object files while
many others are packed in a single packfile.

I did not expect you would want to go to the world where a single
"shard" consists of an object_directory backed by the filesystem and
some other more database-y backend.  It is an interesting idea, but
we'd need to worry about many things we do not have to worry about
right now.  E.g. what do the precedence rules among different
components within a single "shard" look like?  How do we express "in
this repository, local filesystem-backed piece is consulted first,
and then check this piece backed by low-cost but high-latency
storage backend"?

> I do mention that the rename of the object-store.[c|h] files may be
> unnecessary, or perhaps could be delayed until this series is merged
> and the collateral is calmed.

Right now, merge-fix needed against all other topics in flight look
like this, in order to merge it to 'seen'.

$ git show --oneline -U0 merge-fix/ps/object-store
c8afa0ab8e merge-fix/ps/object-store
diff --git a/fetch-object-info.c b/fetch-object-info.c
index 1b2c6c4d27..6c2abb7805 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -7 +7 @@
-#include "object-store.h"
+#include "odb.h"
diff --git a/fetch-object-info.h b/fetch-object-info.h
index 7910d7f153..d35284bd6b 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -6 +6 @@
-#include "object-store.h"
+#include "odb.h"
diff --git a/transport.h b/transport.h
index 5a4f27451a..3ef3acf865 100644
--- a/transport.h
+++ b/transport.h
@@ -8 +8 @@
-#include "object-store.h"
+#include "odb.h"

IOW, not too horrible.
