Received: from bsmtp3.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BB438F94F
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776236074; cv=none; b=PTxgjj35IK0lOlvRQ1IZp0kLKHld/F1y8oaslFZfHBZ0zQhgNPHwwz7+xPZyFLf9/KGNRoULNUhrZ5UW61iwNCckJRDdpKtFQs0IOniQ6evh6HYck/lO/LlHswY9omGfndRdo9OTZui3dhprs2Fn7Tbsw61Abzmf3EqU12xGtjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776236074; c=relaxed/simple;
	bh=4jdYTmHQ6i6THABwJtZFHR4OBgBykPQcI9eU0fb5fIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQnjuGTDXLqSIGuRPmtgc+mMsntS4OWhQH1+ZTFzrDBqQrl3KKrC9WAQouWWlkVntOsCQ3VGfhyZSZUDyFHB+Tdo2nhze70MIcIAuBf9IhSHUPfV8IX2ijimqyxQ9ZkpHTTpPcVMwhuGAWNjCC9PXZOck70bcgI7sNAlJZ+y+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4fwX1n64QXzRpLK;
	Wed, 15 Apr 2026 08:54:21 +0200 (CEST)
Message-ID: <5880e69f-a617-426f-ab1b-12a27c763fcd@kdbg.org>
Date: Wed, 15 Apr 2026 08:54:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] userdiff: extend Scheme support to cover other
 Lisp dialects
To: "Scott L. Burson" <Scott@sympoiesis.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Jaydeep P Das <jaydeepjd.8914@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
 "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
References: <pull.2000.v3.git.1768519120.gitgitgadget@gmail.com>
 <pull.2000.v4.git.1776220063.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2000.v4.git.1776220063.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 15.04.26 um 04:27 schrieb Scott L. Burson via GitGitGadget:
> Range-diff vs v3:
> 
>  1:  e20ac5b6a6 = 1:  8e0b1e3d01 userdiff: tighten word-diff test case of the scheme driver
>  2:  fb4c8dc5d4 ! 2:  0bd51e02ba userdiff: extend Scheme support to cover other Lisp dialects
>      @@ Commit message
>       
>        ## Documentation/gitattributes.adoc ##
>       @@ Documentation/gitattributes.adoc: patterns are available:
>      + 
>        - `rust` suitable for source code in the Rust language.
>        
>      - - `scheme` suitable for source code in the Scheme language.
>      -+Also handles Emacs Lisp, Common Lisp, and most other dialects.
>      +-- `scheme` suitable for source code in the Scheme language.
>      ++- `scheme` suitable for source code in most Lisp dialects,
>      ++  including Scheme, Emacs Lisp, Common Lisp, and Clojure.
>        
>        - `tex` suitable for source code for LaTeX documents.
>        
>      @@ t/t4034/scheme/expect
>          ; This is a <RED>really<RESET><GREEN>(moderately)<RESET> cool function.
>          (<RED>this\place<RESET><GREEN>that\place<RESET> (+ 3 4))
>       -  (define <RED>|the greeting|<RESET><GREEN>|a greeting|<RESET> "hello")
>      -+  (define <RED>|the \greeting|<RESET><GREEN>|a \greeting|<RESET> |hello there|)
>      ++  (define <RED>|the \| \greeting|<RESET><GREEN>|a \greeting|<RESET> |hello there|)
>          ({<RED>}<RESET>(([<RED>]<RESET>(func-n)<RED>[<RESET>]))<RED>{<RESET>})
>          (let ((c (<RED>+ a b<RESET><GREEN>add1 first<RESET>)))
>            (format "one more than the total is %d" (<RED>add1<RESET><GREEN>+<RESET> c <GREEN>second<RESET>))))
>      @@ t/t4034/scheme/pre
>          ; This is a really cool function.
>          (this\place (+ 3 4))
>       -  (define |the greeting| "hello")
>      -+  (define |the \greeting| |hello there|)
>      ++  (define |the \| \greeting| |hello there|)
>          ({}(([](func-n)[])){})
>          (let ((c (+ a b)))
>            (format "one more than the total is %d" (add1 c))))
> 

This implements the conclusion of our discussion from three months ago.

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes

