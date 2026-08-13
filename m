Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE7380FEC
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639790; cv=none; b=sbTMDAB1/L1QjWmCPr8/9gvQXczPspxpmBX+/xinAPWjTQhcTHuScBwhNgssHLmBjZrIOkVqIOfONG6jipLG0Ami1C4RgnYGT1NT2ZH8fr49V72SdXyB/aUQ0fe6ePMFneTWe1U8kpBOUw8Mx5Ho5LKdR+lCtz9e2vmIh7CQOqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639790; c=relaxed/simple;
	bh=nlpCH/NmaurrHWhRJ8oAgcV7Ad66dBTf/DgQ5vGL20o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ctJi0BqXCik4B9Op1xBbYhlOuneCNeXDjkExBRDlfe/2I30kBT95WIrBILabCf8qD7zn8dO+fH9TCccZg05H0Dgd3K7EsLFs6EqFCfW61GpAhvW3KJRMUbOqqCMv8H3MaMuR5vLVEV/3wOngn09EQPgHD4lQRjcsU8pbpYmJ0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DrcBvOML; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y44WeYmX; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DrcBvOML";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y44WeYmX"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2294814001F0;
	Thu, 13 Aug 2026 12:49:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 13 Aug 2026 12:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786639788; x=1786726188; bh=GQQwfw7UOp
	o9xg4EAv4jR88HT6oVLcOgNUyA1H772LY=; b=DrcBvOMLcGxiZrEZssG3ONgfbj
	u4x2KfxpooCSlrFzddo0jiUmOfjpaNl2GeBJcJxAmHw8l4y0c/Z1crPyFGNYBGVg
	yT9ImVK3om77ZfE5h3e0SghCOOZsthtZuMI+UqxxIMF23maMIzU6SM7N9woEnAty
	3FLhTFni+IDMYisECNXNj4s3cvt4q3Dg/3Odh2nu8tX4d+xvD/EqMD8PRFPARKld
	SX42ZLy3/B69Yo/2L0ENwUGeGK9CpOHzG0IkYxCFsDLeCwsnLoDRsGN2zcuLL1cz
	bXykk4C/2PJ6HJb5I5rz8ZitEQvtyO8MaW6BUFlWd/iHBYel9eJcW18O+j7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786639788; x=1786726188; bh=GQQwfw7UOpo9xg4EAv4jR88HT6oVLcOgNUy
	A1H772LY=; b=Y44WeYmXWJWo9Arc6d0i7kFCinhwVUGt4w4VZyQeaZtAdOmowpK
	x4NzLXGtpE9SHv1UB1uAJoljMUjK1D4PpRteTlb74yeMBNEHR3fWQVQltOshQyGk
	D7sZu1esz5D1zriRBExoECcSZvq6afGaZr1ff3FLtHr1AErigpb9gQA5nstTVY3q
	3hNYRrXqEO4a6qQShb7bmfyRBQkQPzqB9x50WB+En4G/wS+QTayEATB8Ei2mncAk
	acIA2TVhzEQbZfzNDYsOYO2gSxULmkzjeExUaAH3NA3gebW4sI0B6zfviNL7E5/s
	rsVVLi9uJZViXQnbbzMRnJlvJfgbfmo8tKw==
X-ME-Sender: <xms:q_V9avSuUKlKFopmg2OJLEobq6h3ZNgKUsqJnBT0NUmvqN115uSKCw>
    <xme:q_V9anqcppApeTNx4g31YxJmLAgF4hVtS2JYvMKitXLK4-jwc_5PpOIWfI-5d1aCR
    pdbog_xub7FMGJnr1DHD6k6gXpvNu-WI9SFhbLpiH6Ij2P1iC7a5Ak>
X-ME-Received: <xmr:q_V9atLOEPeWQiR8oURnThVNmjnB-mWiusf9rSpawwKCQdvuZBSjg8zjQ1MjgEY7b85_DJZTwBbTcTW79cGj_6FEXpI5Y0zU3A>
X-ME-Proxy-Cause: dmFkZTERENXTSqAogmCoLaH8cl8r4GixRLcftbZmt1m7hXANooxKTSUxIrjg77X+kf/8Uv
    LXpUyjBJdzxg30rYiCIs81BtVcc4wcqWPfbCimDLNBfSIlovzbE3jih9jwHwGl0lGDdFCk
    3CWjZt9yaACg+MdrIJknPMAx2WUUudB1r88wWrmQQNoA6Qn00DXQzzGTd9JcpEWA0WD9W5
    6CVRlPCtStKUKRRZrkvkF5INJd96MrGldYznzBsYSzNaqK13MXzbBeWMxU6HfKRHVXyeff
    e7qbM9Q+LGrP1NgBF2g3iFl1u+dsNTFOLYhltiz1q+V/ISuloJaX4E8POCs06zAR7OIzXh
    buzNGVDMYtylyDDV0/mDgJCZsYPNhX+0AAIxbiNEwWwBoaznbEWylMjk9cpEnFlWgUaYbt
    FuTLgGA+L1crBVVAkiqH8Kwy8Zf1SuFkt0yAcSs9y/7a1zDjW4RtJLNMRm/gUk4a06o30J
    VEZHKnmVizaMMBO8O8pbyDWDrswaBH3GlPnXPqFQqsuSycHiHwBnwb4C4G7+aqdosTB4jT
    rcu/YxNJRMyNBLmvZAEqtT4z3U94lQwQA1jn+su/LbFcn2Hp/G0+DgCJJ1+mXSrCQ0xzcx
    v6mdTI8MTt4fEdLZO4xDXxbOuMXWCAPzOvl6VHmBiZgotty1GJFjtbuE789A
X-ME-Proxy: <xmx:q_V9aqrlMZdrBOvGAvLAMsL6njS0q998uTZmyCE09aRgLmp5BzgGzw>
    <xmx:q_V9alxCY45VlQoi2D6QtA8vfEB-kKDZ9udkKfvHzhL7PJJtZGzRNQ>
    <xmx:q_V9auNCrsYWK5KJnA2AKydANoESgfOfXQtb7mYGeGLXo44-9_tunw>
    <xmx:q_V9aq60xwHyK_Fnzi2rdKpzjcCMcCRR3b293iI8j1ePoKRZpq8Tyg>
    <xmx:rPV9ahCnO73DgFK2P-7WMaWOJojT1sh5Jrnn1gfHXpulOQEbOzVbUaHY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 12:49:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 00/13] Next size_t stop: pack-objects/delta
In-Reply-To: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Thu, 13 Aug 2026 14:55:38
	+0000")
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 09:49:46 -0700
Message-ID: <xmqqbjb6t179.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch series continues the effort to stop using unsigned long where
> size_t should have been used in the first place. This makes a difference on
> 64-bit Windows, where unsigned long is 32-bit.
>
> With these fixes, the pack-objects machinery works as intended on 64-bit
> Windows (and any other 64-bit platform where unsigned long isn't 64-bit).
>
> Changes since v2:
>
>  * Now zlib_cap_buf() is also widened in this patch series (I had left this
>    for a later one, originally).
>  * The unpack_object_header_buffer() function is now also widened in this
>    here patch series.

Both changes relative to v1 are just as expected.  Nicely corrected.

>   7:  ca928b4579 !  7:  e4528f9034 packfile, git-zlib: widen `use_pack()` and zstream avail fields to `size_t`
>      @@ builtin/pack-objects.c: size_t oe_get_size_slow(struct packing_data *pack,
>        	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
>        		size_t sz;
>       
>      + ## git-zlib.c ##
>      +@@ git-zlib.c: static const char *zerr_to_string(int status)
>      + 
>      + /* uLong is 32-bit on Windows, even on 64-bit systems */
>      + #define ULONG_MAX_VALUE maximum_unsigned_value_of_type(uLong)
>      +-static inline uInt zlib_buf_cap(unsigned long len)
>      ++static inline uInt zlib_buf_cap(size_t len)
>      + {
>      + 	return (ZLIB_BUF_MAX < len) ? ZLIB_BUF_MAX : len;
>      + }
>      +
>        ## git-zlib.h ##
>       @@
>        
>   -:  ---------- > 13:  bc4a58336a packfile: widen `unpack_object_header_buffer()` to `size_t`


IIRC, there are some topics in flight that have their own local
workaround for some members this series fixes the type from ulong to
size_t and they may need to be adjusted but in a good way ;-).

Thanks.  Will replace.
