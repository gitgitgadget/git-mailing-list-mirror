Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8964A28641B
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695733; cv=none; b=feQ6AEJ2H393ocH4wDkKHYu7UqpNsW57TP5r6+EFPtCQxj/JqbSptaY3Z+P6QhlVglGhU5dioD6ZabRYn3aOFtgX94tEHvfkagfFgwYGOMZuHxszIXGGIC+bcj052O4633L4hC5mTifsl052oZDSTAxJrWKYMPF+nz/wxLnK/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695733; c=relaxed/simple;
	bh=4+MN15pWFK1uxaCvKgHLg8GYBbbmWtHs/Ex03Z+WHIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yx5hFJ0HijdPzGJieSAhSjpvLc2JhG8Oj1aWxR5y1eFwj0B9NDFTjTNzm1StPlm7GoS3xHNbPNA/MeEpZ1KElo/NpSStNJU4EXN5sbSaSj92dOfoGNsYJNKkIIsvlufhble5QVFwLR1BjwIsvGAJy5lE6MwKd46Cm3QortskRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d/8TIKRg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dkcduVLh; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d/8TIKRg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dkcduVLh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A78061D00258;
	Fri, 12 Sep 2025 12:48:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 12 Sep 2025 12:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757695730;
	 x=1757782130; bh=A4g9hi50B4gZ7+v2xiv9eechvI5I95FyPHfBYChUDqw=; b=
	d/8TIKRgaEu0AUx/e2cURH68w7DEuqv4I50UaMzrTWG5yh+OmanJOT7kJ1cS33Rs
	zvyugigOQPEII87IOMyzKYwxYLdX5zcpC6tNkW6zjYb8+IXbLnHIj5cGcDz2teY8
	KvMv4rZ65g486kYMhDShwtxd7DHQte6SGg4+TqnjhMkqZ2CEJf/aN9IWA3SZX0cX
	xunzNV9aUB63uoWcT6PPBasY3O8Ub+HOpRQylyeFYrpGtX33wWQ5egaIPVLmlAHa
	KScFwiPdQ3HCVubcpJ+egjKEtVgDfl+rDhgsSLut6Qk8POE0kc9McOmuFfGtJbSf
	zdZb+JI+/oFRlEIP87QYGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757695730; x=
	1757782130; bh=A4g9hi50B4gZ7+v2xiv9eechvI5I95FyPHfBYChUDqw=; b=d
	kcduVLhOBUgxQznMtZ7JVDOtHJUyLlMixDBFoBYds8aU3oUPG4ZAupdgp+vv/Mrg
	cheaIA1N7nlIsLjG8cg/CyVE2Uma1dQqocAOqQHfgqKPprrZQgCpMe7r2fD0KTrS
	U+z6D2VETbkUpbU2albSDdnc607TqnJfv6JDPTeQ5hfkKruq/tw8+IaSZd7nwTau
	yGE3PaRU4iXZWpJyoSCqQ02syip8NTjd08arPKyEx4gUK2l0RCdvMz4PHrE4uRHh
	4cPN+B2nmJ+xGc/FTnci0mDdeNwMwvx5m9GXbIjmVjYE+NPiW0OWT/O5gVSl6DmZ
	lAoUFvtNgP/YE44pcLoMg==
X-ME-Sender: <xms:8k7EaGqg0DdB2FA_c0JdG5m2uOeYg-s0-y2DFx5hug_Ymtn_4C5E2A>
    <xme:8k7EaH6RKTZt4y2p12M7-zUbY1BwIHShc_qYzzWjfXo6rMqCRNMTKPnR79_mgdm8d
    1zFappbUUAdHxRKtw>
X-ME-Received: <xmr:8k7EaEqqXLWkcXTjkM4W3DlaVDBWAFgKwlCskLlyJRjARZ8IKH1NvEQzbQIgvEovJ5DlGdlCVZHN_rC0bX4W4t94XoAhGbiOZNPnon0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkefotd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekgfdtuedvjeffgfehueefueeghf
    dtjefhgfekhffhteeiffetheelhedtgfehtdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtohhrihgt
    rhgrfhhtudeisehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8k7EaBh5DAx75WdGLCc65axBRDmzMH_oJJtzkgz8pSEg4bgdl8b46w>
    <xmx:8k7EaGKgzNIVtR1gj7FNg0AcQl3LNclXefQK4Nl4P7zzx8Vdv2GvnA>
    <xmx:8k7EaJBfY93O8r8z0BsbVYBokeWAQik-9TkZ3ICooUX6gp9tRXOqew>
    <xmx:8k7EaOjQGecCimeFRdcmrwW9LhAEUufeig_Hbcw56QKFadTcfTQm6w>
    <xmx:8k7EaBf6QJUTd7_rmQYww7uf2PRubIgSngewWxFfoSX5_lAFv9UQXelG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 12:48:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Guo Tingsheng <CoriCraft16@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] git apply misplaces patch when similar code fragments
 exist in the same file
In-Reply-To: <SN6PR03MB428591529FBE9413B427B030AE08A@SN6PR03MB4285.namprd03.prod.outlook.com>
	(Guo Tingsheng's message of "Fri, 12 Sep 2025 13:33:20 +0000")
References: <SN6PR03MB428591529FBE9413B427B030AE08A@SN6PR03MB4285.namprd03.prod.outlook.com>
Date: Fri, 12 Sep 2025 09:48:48 -0700
Message-ID: <xmqqfrcrmxan.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Guo Tingsheng <CoriCraft16@outlook.com> writes:

> 2. In another branch, Commit_2 introduces additional import statements before HeaderComponent, shifting its return statement further down (around line 10).  
>    In Commit_2, the button text in HeaderComponent is modified as follows:
>
>    @@ -10,6 +10,6 @@
>         return `
>             <div class="layout-section">
>    -            <button>Click Me</button>
>    +            <button>点击</button>
>             </div>
>         `;
>     }

This hunk shown here may be a fabrication (it only has two
pre-context but three post-context lines, which is unusual unless
the shorter one is at the end of the file), but in any case, a patch
hunk above is applied to a location that has exactly these lines:

        return `
            <div class="layout-section">
                <button>Click Me</button>
            </div>
        `;
    }

that is the closest to line #10.

If there are more than one places in the target file that the
preimage (i.e. the context lines that are shown with " " at the
beginning, and the preimage lines that are shown with "-" at the
beginning) would match, the patch is ambiguous.

It is very much expected, depending on what other changes have
happened to the target file since they diverged to make the matching
places move from the original place, it would be applied to a
"wrong" place by chance, as the preimage does not uniquely identify
where the patch hunk should to be applied in such a situation.

You can generate a patch with wider context if you can _anticipate_
the issue (for example, you may _know_ that commit-1 already had
multiple lines that match the preimage in the hunk before running
"git diff" or "git format-patch") to give it a better chance to be
unambiguous, e.g. "git diff -U8".  But in general it is impossible
to guarantee that your preimage in the hunk will be and stay to be
unambiguous.  After all, the receiving end can make independent
changes that happen to match the preimage the patch is looking for,
no matter how wide the context you pick when you generate your
patch.

It might be a good starter project for aspiring Git developers to
teach "git apply" to notice this situation and warn about it.  The
tool cannot by definition to always pick the right place to patch,
but the tool should be able to recognise a situation where a patch
hunk is ambiguous and can apply to multiple places in the target and
let you know about it.

