Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A075547050
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579763; cv=none; b=KEMpf1FrxO+IyV1Mez/EEn6pPLx7PmA6zx/3UFNeV/iTQHpkWAam563zzUwZOd4ImuW34EOOChjNUGQVIeD8RG3AMkU/0P7u7uOdXHIbyzn5HsbdY0jD4ZwuE7PFlCnB9VOqGZG7b5MtNRffduBtBVmTZf6aBxU/eGJ8vpNa5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579763; c=relaxed/simple;
	bh=bXd9YNsoiXiNm6QvjBgtDmM3wkSamUIIBYupdmxqWeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/YzbmhoAtAk5XbgA1BNMPRtOzxezGAKlsnLwRHFq8x1fi+mMOni26WgIlZDeSf2kRkd8+PkqK5nkmFItBQrzWFPXMNHDEdbhlRWWKi/EPoC/uK0YI6QZJYz/ngoRP5Qe5Alb1YhPS2J5FeVlyx/iYh/CX3tVtt6TcdmPweUKpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nH+X58/Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZVl24tNt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nH+X58/Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZVl24tNt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 887F614000BF;
	Mon, 28 Sep 2026 03:16:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 28 Sep 2026 03:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790579761; x=1790666161; bh=Uy2DrOyTh/
	pYI9jW0udBo11dzWdSb15fh7PN5n6gT34=; b=nH+X58/QlFKO30g1h1upFq/wM7
	nYf2DdAEHlzzuOdjPh6g/GjyvBiqDzooZz/wauznHK8lM23gXD3IuH2yH20LAOV/
	i5u+u/j93BA/Iu836uzfbjWeZVUDPY+5BM6JsDEBYUyTTiHp25HNMm7goijrogoS
	VWmKnyjEeOxHZe0ZI/NABwVbsoBjmx0CELXYdlLrVMMYWAiDlCBkpKQM8BjJLGKI
	eU+jL/BjUhPdU5saMsn4oJCYAv9MZqaBuHXifRQGnwzZcP/1m4URyugDV34bsajg
	rg7z4ZGiJjybvcK8wwRaEX1xeRO8DvsmXqhIkVo8Gc4Etm4B80u12b8HLdGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790579761; x=1790666161; bh=Uy2DrOyTh/pYI9jW0udBo11dzWdSb15fh7P
	N5n6gT34=; b=ZVl24tNthAwl9KBMaIDFBIiCMfBfqymI3Q7PsTLzeTPY3PF73VW
	axP7nHF4lR3suULWVRxbYAXAYi1Gk7JW4WDjwVH5e3zm8l8uAZ4jn7/r2b72Vsf8
	5Bpr9rUEL/o5QrIChN78tVtm2HSgd4BVcJ0gprWlE2G4YRNzvuQR4gZcvNm8z31B
	zswjHQRB6qQMANxMk4bED+T/3ryRIsd7Tw59XwiGF1oaXcKEo0bUJYKvF3tVUty7
	S9/vtPv0X8AzFXQyFHpXXJeyS8JkW038/M743feiKSZYbiQ2zlnJDXGmWv2y/4h1
	wcEiZNYZSCudXwYFQjg4uwE68lZDgFAhEoA==
X-ME-Sender: <xms:MRS6arwFLOhO0tQ_Wh6jloWA6Oz3IGcDKN0r56YeqzOlNN5qlscJtg>
    <xme:MRS6apT4yJFj0lNWOqbTshiAE6XlLsGFuSUUPD1vP3qBs7n-5tsp263sTDbfwTOTN
    gGfF4G05UqnNj-oH1QFnP0GDbxWNSVkDOY__nNcWcbVAwr6dDNyAyQ>
X-ME-Received: <xmr:MRS6ai_Fn1bEj1N19esy-ShebId_pkC0UXI1khxmBR8HdKSyh6t_Vg>
X-ME-Proxy-Cause: dmFkZTGFBWdfjY/BZ32WzvUdYAZwsrkfH1e8FxrPNS9iTjyG7iW9Q72TTCdr9CFXkDmbkC
    dvQKnT50Aqjug2uO2hRszhiEf6ZmKi988DNtSDDJvaWoWhSdBscTkja2JQHO4aijbGM/3U
    KXJZEZ9BEYlWWYhHRjMPnkH4kE4baNCq1EaIzwGmvJ8jgj0kS0SF+FkvMN2qHH0q5sL+NZ
    k5MmhoZ2pqoFiqZCGUQjjRW71DeDFUJ9SQBn/3KJgUTdu0uHCX3HnFyCZuWgNRiQOgoYtO
    1mwH8NvyjjxuNqKiC/S7Ap/bP30hEm3jKXAVX1ybr+CE+429Fy4OIfYihap6zJen+SvNFq
    UevB/V2dLb+jvF+21i2TV7T0IXpcL5LwOpFgRMEmepTXat7tvw7Wj735zPjIfzjOG9nc2k
    Se089a5Do7g5r0AQqfEHlUm0JNwnSMXsV6H4b7j7azs7SAjGvVKyBGuioKc4vCZizPvPcy
    tfNG2HtH68qBBCvbFu0Hzed1v3EdwxpXdEQ8D+E2B6WXGQrbu4+4hd0tMI9LdXua/Lqje8
    Y3vJinTVGlxzimhYbrIErojU7HbAj4gy6DeY5Hbc5Cgz+kkKQoxpzDMrK/ZQyHmPmash0S
    T9L8dMZjOE4nebccQW7KSTlqqEYaAKq4GBUmYkmk/rkrDBaoclqyVwGeAg9A
X-ME-Proxy: <xmx:MRS6agp4XR7AjZE9lENz7yxLSF5ofFRuRb4dl_IhZAyJUZkTQ49XvQ>
    <xmx:MRS6avmVoybKgMsDgXHfrEtTAmMNSz_s0Sgv7fDku9wcXPH2RcRUXg>
    <xmx:MRS6anJ8iDk0BmVUBotSCISAB1hOB6JHA68kmWV8FQJX8J1CXiTXfA>
    <xmx:MRS6akwbmI8Tbd2jLMz6l6-wfCq8XEr9lOVZ08WkJa0Zz6552XC5og>
    <xmx:MRS6anj826N2LwTXvFXxJZa0g7IRYuVd0AWUeb5P_VqRo8iwqGSO4pIn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 03:16:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 88c11fb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 07:15:59 +0000 (UTC)
Date: Mon, 28 Sep 2026 09:15:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/7] path: introduce
 `safe_create_leading_directories_no_share_const()`
Message-ID: <aroULK79T-UkwkoM@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
 <20260924-pks-create-repository-stateless-v1-2-11499557cf31@pks.im>
 <4770b19f-9a8d-4a4c-8cc6-745aa2868b94@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4770b19f-9a8d-4a4c-8cc6-745aa2868b94@gmail.com>

On Sat, Sep 26, 2026 at 01:19:42AM +0530, Kaartic Sivaraam wrote:
> On 9/24/26 14:49, Patrick Steinhardt wrote:
> > 
> > diff --git a/path.h b/path.h
> > index 7e7408dd05..e2d62c4978 100644
> > --- a/path.h
> > +++ b/path.h
> > @@ -254,6 +254,7 @@ enum scld_error safe_create_leading_directories(struct repository *repo, char *p
> >   enum scld_error safe_create_leading_directories_const(struct repository *repo,
> >   						      const char *path);
> >   enum scld_error safe_create_leading_directories_no_share(char *path);
> > +enum scld_error safe_create_leading_directories_no_share_const(const char *path);
> > 
> 
> nit: All other variants are mentioned in the documentation blurb just above
> the declarations. Would it also be worth mentioning this new one there?

That's fair. I find the comment to be somewhat unwieldy overall. How
about this diff?

diff --git a/path.h b/path.h
index 7e7408dd05..922bd6e377 100644
--- a/path.h
+++ b/path.h
@@ -234,14 +234,11 @@ int safe_create_dir_in_gitdir(struct repository *repo, const char *path);
  * race, callers might want to try invoking the function again when it
  * returns SCLD_VANISHED.
  *
- * safe_create_leading_directories() temporarily changes path while it
- * is working but restores it before returning.
- * safe_create_leading_directories_const() doesn't modify path, even
- * temporarily. Both these variants adjust the permissions of the
- * created directories to honor core.sharedRepository, so they are best
- * suited for files inside the git dir. For working tree files, use
- * safe_create_leading_directories_no_share() instead, as it ignores
- * the core.sharedRepository setting.
+ * The default variants honor "core.sharedRepository" and temporarily modify
+ * `path`. Note that this configuration should be honored for all files in the
+ * git directory. The `no_share()` variants ignore "core.sharedRepository",
+ * and should be used for working tree files. The `const()` variants do not
+ * modify `path`.
  */
 enum scld_error {
        SCLD_OK = 0,

Patrick
