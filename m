Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A92C0F8C
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278163; cv=none; b=k1OF+H52rYaZCMrK8d1KQLb7Lu1coVBP9I2T6UJl1AMfuYKex7+49FPxBqLna3KWxOJZWBxSQLSBi7QEFhCl+hk4/HYOl5gkbas0wnx5IkJGPZzIhG0iHkvKF/b+F6zDouigJtrvtwLVVrKxy1or6qpCkiQOshoNnDzFk2luB98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278163; c=relaxed/simple;
	bh=+tVNJvHqdk/3WutOT/aH/+cyw7wjm1Md8/Tkt5B/G0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tp7GU66e5zsJGqMliXdRSziB7TxL40MqHyXkib8yWqRd9FuEdfiarOgh+lqdep8NKXEFjiX4RX+E3qvfQ8tTYmFKJXgJ1AojHQlK4xWju8UuAt2k3Xuf4APXfCfnc4T2VaJp/jx9IoHvM1ET/LpRwfm9nUi5BH3fOCN15Fpxb6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RIyQ0m9D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a5it0DSB; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RIyQ0m9D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a5it0DSB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B380DEC0430;
	Thu, 20 Aug 2026 22:09:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 20 Aug 2026 22:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787278160; x=1787364560; bh=9vug4O6uiC
	5ZI5wfRlV7JpNqNHhCzs3VZrV0URzifnc=; b=RIyQ0m9DeYWsXdFs+562eWHxVZ
	44f/siahMdJNBgP0lxKVLH0XVh6MeptLlls2jOuTjDIk6ytpGdgHF9zR0PubYcn4
	O1yJrjkgKO7x5JniCrQOhqZqgLDfIJ409DmxxCcy5/Pg8+QswpUhkBy6XltPt8DQ
	bx2K0uba7jzmaQ0PuZuo4xbErCwUl2SQSE9Hijg8JJk2T8uzFljzjAN0ZS3FQrU/
	7dVvPu6oVPif/9J23Gj6koOj+k1Be4Oi9QTJpBfEV9AW4vEFTvLaeE/xzaj+y/Iv
	CjLnoVqKCNTciTvEW71D8Vxc2EDb5fJmyGNzZ8JT7mz3KYkGXE2oOfF0wkdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787278160; x=1787364560; bh=9vug4O6uiC5ZI5wfRlV7JpNqNHhCzs3VZrV
	0URzifnc=; b=a5it0DSBcRXjA/ameH/FEaegA0sKfxbb3Pdf6b266wrozq6wrQM
	+LiQ2mwXD/7zDQP1BCtBFpU2Uok8iRwQATxarioXeaatTd1RIPR/Ifd+n1exhnjo
	d0RJmpa67OIYgPNVXAqKcH9HrDjEg11U3fep9VL34v65+lSd2vjQ1rkq1ZBV9p2g
	I2BRFTheDkUxG7qxtYEnUCaN1Bwji72ydt8hI+Nz0YvtB2jdJtqar6C6pSLPOrZl
	rEXOCidW18SKPEYlvVMmL8lby5xluLhUuo5iISaC17BSd6ypIYclREDhh/sdzngd
	6kbRa/r+60fTq/rrUxcj+KdRDyka3GmlNtQ==
X-ME-Sender: <xms:ULOHavFuBkGjHJunm4YnmDYRWii2B4g6iWodXEB2dQ_xhBVKUghZTg>
    <xme:ULOHajWDxB6l0Vmou56iASwVQCtN6lHNav67-IOHhT3GNrh7iijdNrGjrZ69hzDz8
    v5yLIyZBkkgmDdKqy7HqfNJlERj5XV4xqC9Ha6mbHt2D7FxJfEHNa4>
X-ME-Received: <xmr:ULOHamKJUwBDV31he69ZEtx2-uX-LEjUteXY-gs5jFLfVK-5gmSe4--iogI_xAmmbKAP0ktjwgxXCtekZxwh8SX2pTBIDrdzcw>
X-ME-Proxy-Cause: dmFkZTE1GKHWixg2mHfTHOcFXJPM+yeTc91a/WDoFBx2nI5gxt/5Yu/TaIJU/6+y7Hl78r
    VpBtiC8qUuOI4zICkLw17HPjvKaLgh3vnpVNXCsVz1Fv2CqLJceCxzMbLDiUrZlosZ/xLf
    cFSGqxD0eZtACjz87TejYzXv0Htsx9bHxsZKI8vtcfwHDBEzuMSm8RPWM+drtoCl7ljU76
    1r9ism2XUaKoEBQuoWaqMhHAFJkd08zv6tvs/V2D2ZfPXNNK5yStVcivuNV2Iinosswcdl
    ybK3581RVeMenTJIfJq/vTVuOmwvSf2lM9e+E3mV7OueKaGRYQpXfLzjIZliBUOUmPBAlC
    khgjZCxSFxRoJ6v/BRp0+cLx4NyB/q3n6LC+o8uC/VsCFRus+U9uN16XVbGs5izIeIljhx
    nzy2+ykzQM+E/SDb43uXiPMTV93rELByRjx8MCtq+MPGct08eQ/Su0DiJueV8d0hXUR6rC
    O8jtfWIb3bvCETfZLWLUNklCIGXL1yP0+W6FhGUL4I9ioOIRnMXgynqxT6lfflTBTc65zQ
    wE3Qb7athUfeh4MSxitZasymnlceaNvIKkKlb+e2BD+EfITcBABF1HX92uzi0E0ojtqlzn
    AYpLoVeFVH8EIf49L02O07OKltUsKBW57fJXa1JM2UQeLdLFCu19VJiH5yrw
X-ME-Proxy: <xmx:ULOHar-Yd6xY_Pjm_uRnLl4Puh2vgr3bprTyMDAuqabpAPehs0648Q>
    <xmx:ULOHahLZfAHSsa3Pf8qjyoFWjxySO5nnTPctQI41dmMHB0EPRcfZsA>
    <xmx:ULOHaonmXNSab_1_oSRYPeCOsBK7AB3GrMm4ODqo_yqS1UPdtd199g>
    <xmx:ULOHatNR5L7NAoxtZL7-rcgmYqwqSTCADodCleH20CIuRDBQ18Pmuw>
    <xmx:ULOHahp-mcgHjHNeds-89hqjlSd5hut538Zh2AbL0xewKPYKgpPNopYX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 22:09:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yoichi Nakayama <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v2] worktree repair: detect relative path in .git file
 correctly
In-Reply-To: <pull.2205.v2.git.1787240760069.gitgitgadget@gmail.com> (Yoichi
	NAKAYAMA via GitGitGadget's message of "Thu, 20 Aug 2026 15:46:00
	+0000")
References: <pull.2205.git.1786799480344.gitgitgadget@gmail.com>
	<pull.2205.v2.git.1787240760069.gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 19:09:18 -0700
Message-ID: <xmqq1pbsteb5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is because we wrongly use read_gitfile_gently() which always
> returns an absolute path. To fix this, introduce read_gitfile_raw()
> that is almost same as read_gitfile_gently(), but it skips existence
> check of the referenced repository and returns the unmodified path
> read from .git file.

This is more or less what I expected to see, but two function-scope
static variables are worse than one.  At least let us not
proliferate the bad pattern that makes the functions non-reentrant.

The attached patch updates read_gitfile_raw() in your patch to take
a caller-prepared strbuf to store the value read from the '.git'
file, returning the error code as an integer.  Ideally in the far
future, we would probably want to convert read_gitfile_gently() to
follow a similar function signature, but let us leave it as
#leftoverbits, as it has many more existing callers and all of them
would need adjusting.  On the other hand, it is easier to get the API
in read_gitfile_raw() right while it still has only two callers.


 setup.c | 9 +++------
 setup.h | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git c/setup.c w/setup.c
index af7601ff67..052c7d669b 100644
--- c/setup.c
+++ w/setup.c
@@ -996,7 +996,7 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	return error_code ? NULL : realpath.buf;
 }
 
-const char *read_gitfile_raw(const char *path, int *return_error_code)
+int read_gitfile_raw(struct strbuf *contents, const char *path)
 {
 	const int max_file_size = 1 << 20;  /* 1MB */
 	int error_code = 0;
@@ -1004,7 +1004,6 @@ const char *read_gitfile_raw(const char *path, int *return_error_code)
 	struct stat st;
 	int fd;
 	ssize_t len;
-	static struct strbuf contents = STRBUF_INIT;
 
 	if (stat(path, &st)) {
 		if (errno == ENOENT || errno == ENOTDIR)
@@ -1047,13 +1046,11 @@ const char *read_gitfile_raw(const char *path, int *return_error_code)
 		error_code = READ_GITFILE_ERR_NO_PATH;
 		goto cleanup_return;
 	}
-	strbuf_reset(&contents);
-	strbuf_add(&contents, buf+8, len-8);
+	strbuf_add(contents, buf+8, len-8);
 
 cleanup_return:
-	*return_error_code = error_code;
 	free(buf);
-	return error_code ? NULL : contents.buf;
+	return error_code;
 }
 
 static void apply_gitdir_and_environment(struct repository *repo, const char *path)
diff --git c/setup.h w/setup.h
index 4c2fcbbeda..7394473e95 100644
--- c/setup.h
+++ w/setup.h
@@ -40,7 +40,7 @@ int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_IS_A_DIR 10
 void read_gitfile_error_die(int error_code, const char *path);
 const char *read_gitfile_gently(const char *path, int *return_error_code);
-const char *read_gitfile_raw(const char *path, int *return_error_code);
+int read_gitfile_raw(struct strbuf *contents, const char *path);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
 const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
 #define resolve_gitdir(path) resolve_gitdir_gently((path), NULL)
