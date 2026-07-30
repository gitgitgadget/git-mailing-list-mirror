Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739283FE36C
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403334; cv=none; b=DBB/8e5TKCn3q2nihqEv9CoXnAJ6PxXeLTlfeh8bXvF+ZRtiqypfl/dvWyVBEHYZFeg/vbUUKpNS3NofzE/tZMVKuMhl4/Rhi1bm9j0MDAqNusEN107dwXQXLedjwZ2obf3iUuxLMOEnbtRqI6NQzBYG2TIZmnGh5HEstzsjKfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403334; c=relaxed/simple;
	bh=d5KqntJgNp5FMqBAUT+PjjjkfT51GmEi/UHJIwR+1rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDX7r3IxKVMF6XwdBM3pxkNht7ty7U1KCu2GGxUk1kv0qn52vvPML41Gg4nC6IeBPoIOmHrTDQPTEGpC08GrwjEfrxUYcbJBIDEUwyE3qkxH9HB3RmgRUdxkMvB8KlgUwKgYXMn7zpIZkTCNrI02vbnQ3yp9G4RZlLJ+Vsy8k9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qWnifvEi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JjfkBpUt; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qWnifvEi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JjfkBpUt"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 914837A01C8;
	Thu, 30 Jul 2026 05:22:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 30 Jul 2026 05:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785403332;
	 x=1785489732; bh=5gZCu+hlXfxN7hiS9T2mk4t0FuVzvmgZaYCG/OHkito=; b=
	qWnifvEiZlHuajz29yYkW1QzpAqI9s5jJ2TYwoc9KeZsEfN9PeFes5CtBMhOqYjr
	PopJjtnRKMWMx5Z+0fCs/wrYE2pB6R+u3Ta0pwD2urYn6Z0Y2jYb7ucDqq5WGsQz
	f418m2IqmBTm8uk8Zxik2z5bVQgrn5xrJjJiL/Zh9hhqUwNKaekizWd5mYSjNDFI
	P69KXpVc6uMnZms+qXYnx3i5bHnkW34Khk8sAUFuh7LqrfBVKd1MNIIY8/OXgZc0
	WrTChDtAqfkfHOnA3ZZXazqIaFyhXx/gC/pE9sWxQgU++06fm3KT5h6KuXj3NiBs
	gZ4laqHgL/WLoCn5ffniTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785403332; x=
	1785489732; bh=5gZCu+hlXfxN7hiS9T2mk4t0FuVzvmgZaYCG/OHkito=; b=J
	jfkBpUtm/RQhLFvON7xiIITb2ghHH0YByjcZAcLgsqjuz8E1dWxR1g53UwtIldXv
	/zz0XOG/W2R32gBoXZSM9ClgoTiuteSciziLanEnPig80tWOw6zDAByuK//WwOEz
	J8W/XkcX5AGW035cZemqdVm83mzy1SfGtagrmqNj+kqaDxxiRR2qEhF4h9pj9Ej9
	DIOyXoIfxDRxOpMo+tEtCDfw1f/6gqaaYp1NhCzfNh4g/lH78DNk71SnBUMwkU3L
	eGysDZDWHuKhx4V6akoRO6zJNObdu38a7apJUMYceN5HqVhpz6seV32JR1qttfuk
	fjqLpscdsqnnznvv/wWsA==
X-ME-Sender: <xms:xBdrasOALbMS_MmXqjLYo9xvunYOB99xrEofD6Zy2t2w_MwXUdRMUwk>
    <xme:xBdraiAAPIhZdNzO6ok2JGJ_5fXovjQC-ISPsHGRktLEnqbdJIBbioUk5Hc5_fNom
    AkDaCp3P0B4RNU_VTc5JtFLrXpLvSbXe8VVmbDFEyRM6GvKQdYSlg>
X-ME-Received: <xmr:xBdrapeLtVqkikku2oRQjCk5X0-rHm0yzpIHHkv8Ex49klRutHk3sYXZ3vNmQrHw0Nom5zCBD8C9DcN-0w1YUcmpOPZxPn6z7wyV5fM5TcdDpWE9wgekxsg>
X-ME-Proxy-Cause: dmFkZTG0anCw8LVd9KnlbjgDXHJ2wfOg9o8HCHWfpKK2pcV80M8SugnvW9e/Ndgz/bO99M
    GyiOm/2w1FvdiSvL2DhDtpl3sXzlEdY/tLXIyyuYeiD5QGgTiQWocHsPjOrXtyewJyI8Aj
    9uYAttCdaMwA8kwS5q6V5Ko4DEu8sIsxD9Pu7LbOsC2NlRFst0Q4HNQzdwEr7fcMWUaBg2
    auJi8f5y3QJwHRPuUiHPeFHbHolZ4p3s7I7ts0yBVdE0m9Bm51WfzHGwkqpn8lpAZxQUiW
    iFwcWeoAHG1RSxS2eZStYWbcWRai4qnkPhrhbJi4cOv49r0MPwjXMbrJH/Qp2bQg6iRMBs
    evz4F0OQj8H9D55y0YC3O0Heeoir4Sm8cGWokX2Yovf2MXA3WHi1HEK9X/Gb+NjDoildz5
    X2vcG4FflCL13jA4N471lCzFw+nAbz13twuei0SCrsED8b03KFw8BVrbACCXMRm7Hnu6P1
    A04Ey2VMmecKVbBIUsuq9PIMuZvVZdn776HuFrP2zB85/g4YfKsNf2u9B3hAXmt1Ny7c7Q
    aXNeiUOnF96CC6MjMhONekI3wQ+SNQ26jLIHwTNp9Zj9vvlmGBo84OvsuPBvuJiphCSvvs
    JOHjCSHNtGDmv0NivHwMANxOOs7z6ADByPG66tYm2YSCtjNdyGMW5KoErwaA
X-ME-Proxy: <xmx:xBdrahM309AE9nQygVT19vpuw8O12Wd4mu9fObQfrp9iaVa182egBw>
    <xmx:xBdrapITLBUhcbQw2b762V0MknwY1lWHrgcx9qDLpfJETnXSTVbApg>
    <xmx:xBdrahJ_qSSJJfP7rjpHIhzTcAk_UOES1W07Xx3Q4uPU2g9WfPKPag>
    <xmx:xBdraj6XsCdSgONgLyWVcIM2fEawqjieaSHvub5bb-LmYaUJkfX7ug>
    <xmx:xBdramBIEKbR988kOP0TEUBbQfmX5f_v58X83lK_1ATfrUWa8Pu2MvJB>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:22:10 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 11/11] doc: interpret-trailers: document comment line treatment
Date: Thu, 30 Jul 2026 11:18:24 +0200
Message-ID: <V4_trailer_comment_lines.aed@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Comment lines have always been ignored but this is not documented.

The primary motivation here is to reasonably complete in the
documentation of how trailers are parsed; this is after all the only
documentation page that documents this format. However, and going beyond
that point, we could imagine that someone would want to use this format
outside a commit (or tag) message context, like say in Git notes.

On the other hand, it seems far-fetched that someone would be caught
off guard by this considering that comment characters/strings are not
likely to be alphanumeric,[1] which would mean that these comment lines
would be treated as non-trailer lines if they were *not* detected and
removed as comment lines.

† 1: A notable exception is that Jujutsu VCS uses `JJ:` as
     the comment string

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Msg: rewrite motivation for documenting this. The motivation is
      not super solid, but it reflects my own ambiguity on the matter,
      so to speak; I think we ought to be very thorough about
      documenting the format, while making sure to not use the main text
      to exhaustively lay it all out. The information should be
      somewhere in this doc. But not in your face.
    • Msg: Add “(or tag) message”. See patch “not just for commit
      messages” where trailer support for tag messages are mentioned.
    
    ---
    
    v3:
    • Msg: finally fix area
    • Demote this point to its own “other rules” section, out of the main
      running text. It is not important enough for the main text.
    • Since writing this I have realized that we can go into that long
    
         # ----- >8 ----
    
      Commit message separator scissor line, maybe other things. But I stop
      short here. These things are even less likely to become a problem for
      anyone. And maybe we’ll add them later?
    
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index ac59ef51f80..b4988d39eab 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -117,6 +117,16 @@ key: This is a very long value, with spaces and
   newlines in it.
 ------------------------------------------------
 
+OTHER RULES
+-----------
+
+What was covered in the previous section are the rules that are relevant
+for regular use. The following points are included for completeness.
+
+This command ignores comment lines (see `core.commentString` in
+linkgit:git-config[1]). This is for use with the `prepare-commit-msg`
+and `commit-msg` hooks.
+
 OPTIONS
 -------
 `--in-place`::
-- 
2.54.0.22.g9e26862b904

