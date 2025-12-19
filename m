Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29AC322B9E
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766152725; cv=none; b=IM47LviJxkaatF81e4puba68/n9zbRM6mfmiBd3VHerZYMlUHbyTsfqVQ9YKeXbo5vTSlexwor7LQsgxfCVNYqiJxQsrU1IwJi1PK3uNjqnO4QFbq7OYbF48JCN2gYIFf1Uj6U6p3QfsPUa5+Hla+DXwPmbtoz/glUFUWHYFTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766152725; c=relaxed/simple;
	bh=Fe7WaBCXyG5nR1W9TANQscv10QJxsjKesCRQ+ZLX6NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqhkfrmUk6zYFgt9WwYG7icjEjhHUtk3xrfrVBU/7sGmcos+QU7D9QlmPzEjaodwlJxhIdpf8korxwCuqbfhJKqJ4REvJMa2cgTqKHa8oiuieZ8cTqh7ercBhA67jaRC3XiG6RQTylfmNRcwCj2mD9l+0/pyojCTPZg/PyR4haA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDM13TAp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDM13TAp"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b61f82b5fso2291066a12.0
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 05:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766152722; x=1766757522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIkkjWq9EHi8ZnfKVaGjLXyrxzrNxlq9655xTK34q3w=;
        b=dDM13TApkK9aI7SCP+YaJqTanBDQ38i7/TTvnpY/dkIwsXvTE4oEkhDU5PPvRn8GnN
         qhwZ67gL0CK3QJTr+PPUXDp2yymy/aIY9+u40QfWSb2w5kPnK1sxStJvtZB+5ct3bfYC
         w26j7AcDRymVJYlKIiY1WAu8dStcOYoyGpaEmH2E+coxJ2POofGeqrdqC8bPKt543r9+
         SUD01omGzIS/pqUqkuUawac3zkzXAonZgIFdRpJPN97j3q9dFDkRgokGKx+0xUQeTHjH
         SeaN+36/1Hkc30GAp3rzg0h0hZHXpl1RaMPbkDgwUyTVUHEdS319QZh2XIcpcvcVtXX1
         s/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766152722; x=1766757522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIkkjWq9EHi8ZnfKVaGjLXyrxzrNxlq9655xTK34q3w=;
        b=pVc8IBvXmy3oXzzjrEIka6rpMqtxq/3xUWHzQnXPZz/sw+weaM64exMF1MKItHsvUI
         cdpaB6lH8/zepNHe576NjithdvvpyT4kl7egSVnwHyUNhF9RMBegwn41PgI5k6Icz4Bf
         QTf7Mefg9+g5LmId1BuUhgidSWEfE9nLtE9+kmLncyzK81XGb6+IlwmdMYzAQ2xCn0Ki
         BLtllVMcXrCbPb01uSbRo7PNbxVCEcRDlCDrsBHzl6vCPB1BKo3frXIIHh0XPGw7QsXr
         s4XVJPGj9NBIsf16+zMBWiXFM7QDjyEIoT+VkXWSQ+6FnccDuUSOXOoUsxOBMOnIr9Ej
         TBHg==
X-Forwarded-Encrypted: i=1; AJvYcCWPvsHR/3AClGvYo4oLggFAVKraGjK4bdpEazNagL7j9unUHV5PaDy5SihkM7qchJsN6R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkikeNlN2UtZt83iasKKzFoGqSYu8dEf8u/XjozRYVOG/SsYc9
	CGr8WXzxG9AhVGASV2jRzdxffDH663TfejELod9c/naoM/EsFmqS2Tn1
X-Gm-Gg: AY/fxX4DTmfdhBsk1DacZPNhPBvfmvMrsfxc4UGF8XUMH1uzMwPn9pkvTl4eKXLf0tN
	BbTbkcEaO1ogB+HU/USTspykDiv6lDojVNDkuc1NCTD+CBC590rSB0om8pnPM5iI+mRUk8exp5K
	JGg4Z9cFZdx82+9wxNqcq/9IDG5aiJijcQOr0Fkk6d7Pua3H3HHf3ZoLB7IElt+som/+oc1Hdl+
	ZhBqXubuUBjpuOLLzlhth2NQRt1c1yxc8qvv9CUqFHvTncT8H8I0Q1uOy8BsUggEOsc+HS5G7z/
	TOp8mcTN6hp7RpmsarbvTO9wdteM7OYp1YgNJuNEDItiyyVgzweg5rKfPO62NqcYlAzKjV3SEX+
	1+z133vi3cEk7KBS89+UfopnSPGRcZVRIuvZUSfkQPgpe2qhGe6+0CeOkSoVrQP00ihFRs1nHcv
	frv2Xlk+BDKjkGxhhRo164O7agDXlx4pWeyKSRh2VsoYPK6aYTDRrDp7cp2MliWimCwHMgLUC1
X-Google-Smtp-Source: AGHT+IEXREMLiGB64gKbCOds7byrJ19S9sfHBV69s16GKgSPwPK/ypKF+7u+Ia5psIS7sWAi752DRw==
X-Received: by 2002:a17:907:7f8e:b0:b76:eec9:a1a9 with SMTP id a640c23a62f3a-b8036f34039mr260729866b.7.1766152721730;
        Fri, 19 Dec 2025 05:58:41 -0800 (PST)
Received: from localhost (20014C4D24C7FE00ECFA290F2E78D970.dsl.pool.telekom.hu. [2001:4c4d:24c7:fe00:ecfa:290f:2e78:d970])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f37ee8sm231676866b.59.2025.12.19.05.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 05:58:41 -0800 (PST)
Date: Fri, 19 Dec 2025 14:58:40 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>, phillip.wood@dunelm.org.uk,
	Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
Message-ID: <aUVaEPGoOkATQGl3@szeder.dev>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im>
 <aMsWL2cSoytbmRjA@szeder.dev>
 <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com>
 <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
 <a6efc710-4062-4955-8fe8-bb6d428a44c1@gmail.com>
 <xmqqms3qh13e.fsf@gitster.g>
 <aUVDax0PbkaXGB61@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aUVDax0PbkaXGB61@pks.im>

On Fri, Dec 19, 2025 at 01:22:03PM +0100, Patrick Steinhardt wrote:
> On Wed, Dec 10, 2025 at 11:18:29PM +0900, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> > 
> > >> Its mostly because I don't like too much magic and because I think being
> > >> explicit is always better than not.
> > >> 
> > >> So from my POV, I would expect "the simple case" to be "the simple CLI
> > >> call" and if I want the tool to do magic and "rewrite all the
> > >> things"^tm, that I would need to specify a flag for that.
> > >
> > > Thanks, that's useful to know. I'd assumed rewriting all the branches 
> > > descended from the rewritten commit was the natural thing do do but 
> > > clearly not everyone thinks it is.
> > 
> > It probably depends on the way one looks at the tool, as a building
> > block (in which case less magic may be preferrable) or a complete
> > solution for one part of workflow.  I probably fall into former camp
> > more often than other people, but for this particular one, I tend to
> > think it is less confusing if we moved all branch refs away from the
> > commits that are obsoleted by rewriting/replaying.
> 
> Okay, so the majority of folks here seem to favor rewriting all
> dependent branches, which is also the default that JJ uses here, and
> git-replay(1) does it, too.

I can't find the word "conflict" in this subthread, so let me bring
back that little history snippet from around the beginning of the
subthread:

  Let's suppose I have this piece of history, I'm on 'branch2', and I
  drop commit B.  Which commits will be rewritten and which branches
  will be repointed?
  
     A---B---C---D   branch1
              \   \
               \   E---F   branch2
                \       \
                 \       G---H---I   branch3
                  \
                   J---K---L   branch4

If we were to rewrite all dependent branches after dropping commit B,
then besides 'branch2' we would rewrite 'branch1', 'branch3' and
'branch4' as well, right?

Now, let's suppose that dropping B would cause conflicts when
rewriting commits G, H, I, J, K and L.

When does the user have to resolve these conflicts?

If not right now, then how exactly will those dependent branches be
rewritten?  (I understand jj can store conflicts and they can be
resolved later...  But are we there yet?)

If right now, when 'git history' applies each of those commits, then
rewriting all dependent branches seems to be a horrible idea.


> But now that I've thought about the problem a bit I think we can avoid
> that issue by implicitly identifying the range: it's all the commits
> between the commit we're about to rewrite and HEAD. So, same as with
> git-replay(1),

I think 'git rebase --update-refs' does the same as well.

> the set of branches that we'd need to rewrite is any one
> branch that points into that range. It keeps the UI simple as the user
> still only has to think about a singular commit, should be sufficiently
> fast to compute in most cases, and it allows mega-merge workflows like
> JJ supports.
> 
> Does that make sense to everyone? If so, I'll revise my stance and will
> adapt the current implementation to do exactly that.

I would very much prefer that the tool would only rewrite branches
that I explicitly allowed to be rewritten, with an '--all' option that
would allow the rewrite of all dependent branches.

Or at the very least there must be an escape hatch.

