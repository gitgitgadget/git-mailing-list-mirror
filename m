Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5D1DE882
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218505; cv=none; b=K6y9P86d15WGRpvkWtiBDmwvluYOSkiRdZHXa8oGZZSiyhczPeALJsEsI7uAeSgCMsj+Ld64hbKj2g+u1ccKQbZjTaq8GPuA8U6N2ed0SX9G8MGq719OVz8PF9vxAwPh5sDYbfcWZZHLQN3xJtAnv65x84/grrQLW0Q72cE77e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218505; c=relaxed/simple;
	bh=ALLKgDXCkpTR0EVWe3TR/IbHL2Rem9Q8tZkCt3sxmso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxnA1bguI1OU1RNn8TIrlwhHrTsmSsNLIEQvIaPkFhkwR244A6gTkzZUQVzzrEnX264yu6MMKLPsv9h7ewZgWQJAkU8riM2XjYm2VqyDv3yo7QolENPkz0op4e9uLTOPGZcC9Q7gyoN5AKjZqUIVviWgM3mGDF5PUnu6cp8R+3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XQkM24CC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IaCPKYHf; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XQkM24CC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IaCPKYHf"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E520F254018A;
	Tue,  3 Dec 2024 04:35:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 03 Dec 2024 04:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733218501; x=1733304901; bh=/U50o4h8E1
	Xmc57WDD0qX1ukqR8YQT9156Z6gDOgM3s=; b=XQkM24CCu3M7u/bGqcOzysOvFg
	TMOXdHIKKprvtyxSwNHY7d5hSP4a8EwjawV9BSEOy2xeovH1f7uspSLV+RZe5i/e
	AytXtJzaWvXQwi8ns9yM1QM3U3j6W6zsy4lQk9RAV2eo4JLUWlIxtxMvcLja0u2a
	goKA2FFt5q2RYISZFJ5XEnHRXiAAtYZWkFI9pdsmnyvEoNx1rAw1Abj0fiF7+iuZ
	Qxc/nTne3YskTONvmlcOcjOBWbnZOuhgbVCvtqPcefzxuAboHhtp8A33KpbwNwsJ
	qdOiKPpRoo4s0TPBuP/3FTeIXfismX8B190YekXXNlonYYjJI+KjTgehWifg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733218501; x=1733304901; bh=/U50o4h8E1Xmc57WDD0qX1ukqR8YQT9156Z
	6gDOgM3s=; b=IaCPKYHfo3sBsE9aRm6nDWRx4DnDCfQLaCEDZ8WcN5lh+0vACPS
	6UQCCjCRDK9uCMupq6HP6zsmdOUUw4MtPsNdeCkMXNq9JaycHP4Nbbidx4g1OKe/
	eams/KKGasyelQnfNj13FR4KOh4HAA1/MNgWnDCQs2LQ0B4iegOm0X7qSQnAnVuo
	QWcUj6Gqx7o4KvbumOqTyrQulfrZfDCbr3vLOVywn0PTCnGiBWmU+4u2M+66VINs
	4cqnWT1PQhk1wZfq4DNWPZ61zneEweBx7NUgoS9BwQbw6P60TF/aV//fdnyWvRKs
	fWdIzqnqd6cCtycw/1Tqwvn02IAkNMdADgA==
X-ME-Sender: <xms:xdBOZwda71JOogxChc6QPdbe6VhExAYCtuABrfLR3AsCuaj2mROz9g>
    <xme:xdBOZyO7NbM1Ypt-YdOpl-Vd08kj4EnjtszAtzDA-KYpxwcKYknsKop2dWk0EKZ-W
    TEg6p1u_4PCVG371Q>
X-ME-Received: <xmr:xdBOZxh4pmlSW_VlEyRByInoXT0LwgNs2bmFIMPj6PqeT2LdkMlRfbLv6PSGWu3hw0PBm6MTPGow-0rCTWpy6VOYQ-4mbFMaktBl2WdJbZxscA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedvgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xdBOZ18eylZlGXaOh_4MXYQmZrba2WAnH5Leg9bSzikxBBYzsIIZ2w>
    <xmx:xdBOZ8sMMCmkgmFyHD8eXyR1a9cCvON65ntNC6pFC4_fxre9rkhlwA>
    <xmx:xdBOZ8Fw_gr2B7pUz8b1R317n1aReCEKKu8MkNirOGLwT6_SZe2crw>
    <xmx:xdBOZ7P5LAqSqS9rKlwnWDxcVWD40UeLRHT6KvhFd8uAWUrwKcNkBw>
    <xmx:xdBOZ4LNYYMArOF_rjUOSAWplsNvqlnoFYKueLjGpWsJT9fD1vhNgoLW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 04:35:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 10bb3114 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Dec 2024 09:33:41 +0000 (UTC)
Date: Tue, 3 Dec 2024 10:34:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] fetch-pack: split out fsck config parsing
Message-ID: <Z07QqowPVEgJ3sIw@pks.im>
References: <20241127005707.319881-1-jltobler@gmail.com>
 <20241127233312.27710-1-jltobler@gmail.com>
 <20241127233312.27710-4-jltobler@gmail.com>
 <xmqqed2wox8n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed2wox8n.fsf@gitster.g>

On Thu, Nov 28, 2024 at 12:25:44PM +0900, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > For `fetch_pack_fsck_config()` to discern between errors and unhandled
> > config variables, the return code when `git_config_path()` errors is
> > changed to a different value also indicating success. This frees up the
> > previous return code to now indicate the provided config variable
> > was unhandled. The behavior remains functionally the same.
> 
> > @@ -1866,9 +1866,9 @@ static int fetch_pack_config_cb(const char *var, const char *value,
> >  		char *path ;
> >  
> >  		if (git_config_pathname(&path, var, value))
> > -			return 1;
> > +			return 0;
> 
> So, after getting complaint about a misconfiguration, the caller
> used to be able to, if they wanted to, tell two cases apart: a
> misconfigured variable was ignored here, and we happily parsed the
> configuration.  Now they no longer can tell them apart, because we
> return 0 for both cases.

I wonder why we want to ignore these errors though. Grepping through the
codebase surfaces that all other callsites of `git_config_pathname()`
return its return value directly, which means that we'll die in case the
path name cannot be parsed. Shouldn't we do the same here, or is there a
good reason why we need to ignore it other than "We used to do it like
that"? In other words, I would have the below diff.

Other than that this patch series looks good to me.

Patrick

diff --git a/fetch-pack.c b/fetch-pack.c
index fe1fb3c1b7c..c60627bba4e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1863,10 +1863,13 @@ static int fetch_pack_config_cb(const char *var, const char *value,
 	const char *msg_id;
 
 	if (strcmp(var, "fetch.fsck.skiplist") == 0) {
-		char *path ;
+		char *path;
+		int err;
+
+		err = git_config_pathname(&path, var, value);
+		if (err < 0)
+			return -1;
 
-		if (git_config_pathname(&path, var, value))
-			return 1;
 		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
 			fsck_msg_types.len ? ',' : '=', path);
 		free(path);
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 138e6778a47..73d6b3874de 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -240,6 +240,15 @@ test_expect_success 'push with receive.fsck.skipList' '
 	git push --porcelain dst bogus
 '
 
+test_expect_success 'fetch with implitcit fetch.fsck.skipList value fails' '
+	test_when_finished "rm -rf source repo" &&
+	git init source &&
+	test_commit -C source initial &&
+	git init repo &&
+	test_must_fail git -C repo -c fetch.fsck.skipList fetch "file://$(pwd)/source" 2>err &&
+	test_grep "unable to parse ${SQ}fetch.fsck.skiplist${SQ}" err
+'
+
 test_expect_success 'fetch with fetch.fsck.skipList' '
 	refspec=refs/heads/bogus:refs/heads/bogus &&
 	git push . $commit:refs/heads/bogus &&
