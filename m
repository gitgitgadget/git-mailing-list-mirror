Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B4209662
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624773; cv=none; b=QIhmYpavkslblqjn6DViI6BQ0ZOv1fuM89TjQ5TE1oVmMAnjEKFH9B5SZpJbbwst2I0oc6002IJFIalDoO00/+lIY3N675jxelo/YKMVAaS1ejI32zUuCf/fvA0146J0GZOz0viS9DXZZ0zq8ynen8MRR+qwmKV9z4IKQmUWZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624773; c=relaxed/simple;
	bh=59KpGOuy2cH2jC7/dRXpKCeGMeT3DZ83tCE8QEjsopg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI1jCSyM/Oujje+w9blIoijX0FoddYOX7x93LeMQ8Cm0rT6IZ2MXK4lMa+X23X7VZ6bH5q07ypr9EY0fgkLCUtArKbn0B1XBMREOilY5A39+NXiwcYXBPL88h7zdaoi9schjNl8kjEzqnk+9wMPuEy7HrL9rqD8CmaBLgecbZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j6BXUpMI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+qlTwwq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j6BXUpMI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+qlTwwq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 79D96114012A
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 11 Oct 2024 01:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624771; x=1728711171; bh=Tfv8KEuPps
	Xrz70WMtkezaBgwKtmBBGsp3/EIgSPKbg=; b=j6BXUpMIENTXUSJhSJ3rrxU4OW
	pQ8SQQ8a6SkaWYaS6b68ADEdjr77VbU6Cwlsv2ogzWTBbe5gEYMD4MCGTr8QNxJW
	i8xdgeS+N3XAMffrG0Ht5/fJX1eH5Pd14mb4XllBmMY20QkkJZiy+yNX1tSQdCLi
	uN88tOMT+HGbOVEF/c+T3IKiOrv58J/Dl+wqv2yQp5DdG1zhfOe7QGBSzIlEnby0
	cDh1hPX5Q8tQUhKsNNrG2tL6+Ep5PFx7y4vM63pPY6rUHmmrOBB7owVYQvg2dBTb
	xtariq28F3yHDcNGYOwmxJLr5ODB+X4tTR7q1hFFCe8F3iCdoP27Iw9dLJWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624771; x=1728711171; bh=Tfv8KEuPpsXrz70WMtkezaBgwKtm
	BBGsp3/EIgSPKbg=; b=d+qlTwwq4QdkHXwgzM8pmpqBXWCs2qRRbSBhL+jcJ508
	G5jvzEVeOyKbIb/4rLCbINrZYcC6QjuHYAAP/n3xFB10nytXeAZOHEK/vMtmbEtX
	EHHYFmaKig8TE6lhg3PqpZO+mNoEKLaEKKr7pQb1JEnbZ2IQG3VPP59yC+robzoa
	0EypzfhDXFC+x9iynsDzLCTJgXaoX2Sw33McdIaRtkR/nwdUWfA3WNOgaBlyDDBC
	EUaC6KxU28gX6bTpSypwi8yfiAtpVaSGJvlN/SaSwhVZvbNICDz17rb0HOk4AbAN
	91jV8Oyj9yPhMrej0nlWMPhBQBL/YQqIBSMkiegqkg==
X-ME-Sender: <xms:g7gIZyFnynWqrRUS-RzVsOsaUXDAcSzXrPBsJZxwUrVAJFdyeYzL1g>
    <xme:g7gIZzWrN_gI-wSbDG_KpZGbWU3_Z0wCBFNbB2WAWl4ObLE9BjGIT88KXBGxRp9qA
    4-ukP0SYAbydnX9dw>
X-ME-Received: <xmr:g7gIZ8LbwXX3mDD7FLzCmdJx7xiQ5PU2VaoGJmOg9L8IXyCDE_dhUDJxVHKfn1azBLXzFDs8veT2EN_f_oDqDCjWMqrjtnq18wrqyIs3EyeNevU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:g7gIZ8FJtmZY-EK4Ic2Twaki3tcfqn7b31a3QPfrJlBqaINWFIKYMA>
    <xmx:g7gIZ4WREBrXiBnRRhByOlf2yW0lyfmKh4-mxWZL1tM6vm-LwTtF6Q>
    <xmx:g7gIZ_MPTvkjBBERr4q3sQgfVLWjAZ2HNCZSlbyQrz_GiktxxpXTdw>
    <xmx:g7gIZ_2tMilaojZZo6CQAvv1XH5IC5JDfoETm0KqVD324FtGYAfkKg>
    <xmx:g7gIZzdsihj_pQ-2Ul3niQHaWJ2iQcF0DXKHNh6is9NNFfCuTEO4wSoG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2eda4aa5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:44 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/21] builtin/tag: fix leaking key ID on failure to sign
Message-ID: <9e4bc5bf73f47d59af012ae3e5798570570722ba.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

We do not free the key ID when signing a tag fails. Do so by using
the common exit path.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/tag.c  | 2 +-
 t/t7004-tag.sh | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 93d10d59157..c37c0a68fda 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -164,7 +164,7 @@ static int do_sign(struct strbuf *buffer, struct object_id **compat_oid,
 	int ret = -1;
 
 	if (sign_buffer(buffer, &sig, keyid))
-		return -1;
+		goto out;
 
 	if (compat) {
 		const struct git_hash_algo *algo = the_repository->hash_algo;
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b1316e62f46..42b3327e69b 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -10,6 +10,7 @@ Tests for operations with tags.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
-- 
2.47.0.dirty

