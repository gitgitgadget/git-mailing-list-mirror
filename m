Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC5412B145
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510994; cv=none; b=BwE/7DvIUFwA5YDmTyBHK0PQzI13KwfViODlJOuf2JfpEPx9eNIlJ7ganIkWPc2FmgIOgy6+1DXpOJFjvlB1q7GF9r7CZWyFPpKO0hxUitCA6gyil3dB6ZHiJQfNsTaOWqhjdPaBPi1K53jrPLZUyyMwpeyu7q1YNZ15TP/VJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510994; c=relaxed/simple;
	bh=79iRtJrLMLajbzfIZicIfkuisf4fSPVNH3som985E54=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D6fODFxRRLIvqHZiafarm8DotpF05djfIc7p2L9jH8s+ncLJC+KwR+qX/HpOHHJgmmuN+aBt26I5wSjuaLSJq87VaPZcqatCm3c9YhtYiLxKy0xML+JBYtDU9JL8XZByil6Qkqvklwciij7qUHy7b5K5d3o5OTh/9GqVC6/rImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5UtSte7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5UtSte7"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35dc7d0387cso5765648f8f.1
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717510991; x=1718115791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2OZ7d/OF8Jc4hyn4ZFj0g+Q73CtsoFYV8wGWIdZ2q4=;
        b=j5UtSte7DomAF3SBseLhGFY7WXbod8HLwbeURc6GCIrm/Bm1tCnbl/G0CckvpJ4RT7
         D/UoWdizuB9hhtosQFT2lxv1UfhI+8afO5dKGvtW88Vd5TUruiXVQHGcoj1m63dFiHQj
         ZQRwxB/lAMDlOkpE8UlJdKr45rVTvwo0d+HLROjyxWAcATZ4juqimJSfNJpgM4eyorKU
         jU4HytT/E8+N1khW8+P4bViY2vo/QFdr7iTJDFQkAgB/pWs63bjIbcvObf0oyQNZ34hP
         OY7OW/kHHSf1c3b1bt3rxoK04IWNq1w0v+dyg/eo6V+NdNegk+fjY77wqUaS2MwJNvYz
         fL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717510991; x=1718115791;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2OZ7d/OF8Jc4hyn4ZFj0g+Q73CtsoFYV8wGWIdZ2q4=;
        b=crufCGJBKOZSTqplyl6WB5G+DxBQCXNbneq4ws/IAqy6cVsyM2/s3BsowMWgbcy3Kg
         TE+7mBY2kcTNO0xIyWRte9g0mPiHpMKb/FRWaW9F7uCake1lM7Cqr0QIHsyJ+fbf4Jj6
         qr5B+wQY02QVsWcKUFjP9R7RFXmoU2tVVs7U9vE6+fgxk4Zjse41fWjyhL2Dqg5If9yQ
         xU5hdVqHI+hbr4GmXsMXulvYIu8PwJBCU/NvTI8w2vL/tQXmwkRkUZAuGt30tsSobBnK
         facLDQlnMbqOyfrKN4SAN7N9iJeINWEYlEtr4CwZMTQsKESDTg9rKsqq2/MCDujwzDnp
         j+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnBek4x1ATZv4cDNjuT5pnSnMQDuQXj6Q0cQmc4jwjvWOK+Q52miYiKJ5HtIPCmZusWAMfGY9AnRzEFeDPCiKy8Lv0
X-Gm-Message-State: AOJu0YxX2jhWMZ/ccifab4yLRHqH6kirVauFDJYtui5XEqE07NfQpxxd
	muK7jIhN9IWhyv2+Y2Mo8AmSTe5Fj/udSpO6focFOH9G4X6cHWfi
X-Google-Smtp-Source: AGHT+IGehQladhDg4Zpw2pA1Yfu6VRmyJelSap0cQWslCawXJ9nR5/XLGEaiE51pYZDpIFpqLghsiw==
X-Received: by 2002:adf:e38a:0:b0:354:f286:4f0c with SMTP id ffacd0b85a97d-35e0f325d08mr11571110f8f.51.1717510990846;
        Tue, 04 Jun 2024 07:23:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:641:9001:124f:b55:b414:cf29? ([2a0a:ef40:641:9001:124f:b55:b414:cf29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b838b4asm158619405e9.6.2024.06.04.07.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:23:10 -0700 (PDT)
Message-ID: <f231d5ff-08e5-47b3-aadc-0f88566c2588@gmail.com>
Date: Tue, 4 Jun 2024 15:23:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 0/4] docs: document upcoming breaking changes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Dragan Simic <dsimic@manjaro.org>, Karthik Nayak <karthik.188@gmail.com>,
 Todd Zullinger <tmz@pobox.com>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717504292.git.ps@pks.im>
Content-Language: en-US
In-Reply-To: <cover.1717504292.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 04/06/2024 13:32, Patrick Steinhardt wrote:
> Hi,
> 
> another day, another version of this patch series that aims to give a
> framework for documenting upcoming breaking changes in Git.
> 
> Changes compared to v5:
> 
>    - Note that Git 1.6 was a breaking release, despite the fact that its
>      major version wasn't bumped.
> 
>    - Several smallish rewordings.
> 
>    - Note that items on the lists should only be discussed anew when
>      circumstances have changed.
> 
>    - Add some conditions to the move to "sha256". Also, note that we do
>      not plan to deprecate "sha1".
> 
>    - Note that replacement refs are also superior over grafts because
>      they can be carried across repos.

This version looks good to me

Thanks for writing this document

Phillip

> Thanks!
> 
> Patrick
> 
> Patrick Steinhardt (4):
>    docs: introduce document to announce breaking changes
>    BreakingChanges: document upcoming change from "sha1" to "sha256"
>    BreakingChanges: document removal of grafting
>    BreakingChanges: document that we do not plan to deprecate
>      git-checkout
> 
>   Documentation/BreakingChanges.txt | 128 ++++++++++++++++++++++++++++++
>   1 file changed, 128 insertions(+)
>   create mode 100644 Documentation/BreakingChanges.txt
> 
> Range-diff against v5:
> 1:  67cb4de5cb ! 1:  a260bbf281 docs: introduce document to announce breaking changes
>      @@ Documentation/BreakingChanges.txt (new)
>       +breaking versions is typically measured in multiple years. The last breaking
>       +releases were:
>       +
>      ++* Git 1.6, released in August 2008. In retrospect, this release should likely
>      ++  have bumped the major version.
>       +* Git 2.0, released in May 2014.
>       +
>      -+The intent of this document is to track upcoming deprecations for the next
>      -+major Git release. Furthermore, this document also tracks what will _not_ be
>      -+deprecated. This is done such that the outcome of discussions documente both
>      ++The intent of this document is to track upcoming deprecations for future
>      ++breaking releases. Furthermore, this document also tracks what will _not_ be
>      ++deprecated. This is done such that the outcome of discussions document both
>       +when the discussion favors deprecation, but also when it rejects a deprecation.
>       +
>      -+Items should have a self-sufficient explanation why we want or do not want to
>      -+make the described change. If there are alternatives to the changed feature,
>      ++Items should have a clear summary of the reasons why we do or do not want to
>      ++make the described change that can be easily understood without having to read
>      ++the mailing list discussions. If there are alternatives to the changed feature,
>       +those alternatives should be pointed out to our users.
>       +
>       +All items should be accompanied by references to relevant mailing list threads
>      @@ Documentation/BreakingChanges.txt (new)
>       +described item back then.
>       +
>       +This is a living document as the environment surrounding the project changes
>      -+over time. An earlier decision to deprecate or change something may need to be
>      -+revisited from time to time. So do not take items on this list to mean "it is
>      -+settled, do not waste our time bringing it up again".
>      ++over time. If circumstances change, an earlier decision to deprecate or change
>      ++something may need to be revisited from time to time. So do not take items on
>      ++this list to mean "it is settled, do not waste our time bringing it up again".
>       +
>       +== Git 3.0
>       +
> 2:  b36ffcbaa6 ! 2:  f7c6a66f71 BreakingChanges: document upcoming change from "sha1" to "sha256"
>      @@ Documentation/BreakingChanges.txt: be changed to or replaced in case the alterna
>       +and will thus change the default hash algorithm to "sha256" for newly
>       +initialized repositories.
>       ++
>      ++An important requirement for this change is that the ecosystem is ready to
>      ++support the "sha256" object format. This includes popular Git libraries,
>      ++applications and forges.
>      +++
>      ++There is no plan to deprecate the "sha1" object format at this point in time.
>      +++
>       +Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
>       +<20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
>       +<CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
> 3:  4142e472ac ! 3:  b25b91a5e7 BreakingChanges: document removal of grafting
>      @@ Documentation/BreakingChanges.txt: Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zom
>        === Removals
>        
>       +* Support for grafting commits has long been superseded by git-replace(1).
>      -+  Grafts are inferior to replacement refs as the mechanism can lead to
>      -+  hard-to-diagnose problems when transferring objects between repositories.
>      -+  They have been outdated since e650d0643b (docs: mark info/grafts as outdated,
>      -+  2014-03-05) and will be removed.
>      ++  Grafts are inferior to replacement refs:
>      +++
>      ++  ** Grafts are a local-only mechanism and cannot be shared across reositories.
>      ++  ** Grafts can lead to hard-to-diagnose problems when transferring objects
>      ++     between repositories.
>      +++
>      ++The grafting mechanism has been marked as outdated since e650d0643b (docs: mark
>      ++info/grafts as outdated, 2014-03-05) and will be removed.
>       ++
>       +Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
>       +
> 4:  9ff94b6f32 ! 4:  4fafccc3b9 BreakingChanges: document that we do not plan to deprecate git-checkout
>      @@ Documentation/BreakingChanges.txt: Some features have gained newer replacements
>        that the old way of doing things will eventually be removed. This section tracks
>        those features with newer alternatives.
>       +
>      -+* git-restore(1) and git-switch(1) have been introduced as a replacement for
>      -+  git-checkout(1). As git-checkout(1) is quite established, and as the benefit
>      -+  of switching to git-restore(1) and git-switch(1) is contended, all three
>      -+  commands will stay.
>      ++* The features git-checkout(1) offers are covered by the pair of commands
>      ++  git-restore(1) and git-switch(1). Because the use of git-checkout(1) is still
>      ++  widespread, and it is not expected that this will change anytime soon, all
>      ++  three commands will stay.
>       ++
>       +This decision may get revisited in case we ever figure out that there are
>       +almost no users of any of the commands anymore.
