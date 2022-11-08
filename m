Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C94C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 03:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiKHDps (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 22:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiKHDpr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 22:45:47 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411E023178
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 19:45:46 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gw22so12602690pjb.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 19:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vBPiP/Wi1ZUyyw9ezT10BaZxDtN5iId+gdmm/nX0R8=;
        b=FhT5nput4i7KPXPK3c6UF4/XUR9BUNSeulIbY9i8TCLRDsQwjAzLwEMd1yzLNReXg3
         cZUVRIezYBeZ35dv669nmak3HoF/O1HvFnkqES5pzacLYscvjve+4xjHzk7ebb1cuEr8
         pjYaILkqa4RcoUVVL2VbwQYgYH4FhboQivaciNcORMZuzwPertbSDLj9ZpaxsLQ0Mn2/
         YJCqtdQK4HlNBCJ7VzWmMolz8V41y7ved+dS+mg4b/a0x9rtCeZJnYUopZ7W2RVVqX8J
         4zMJlfZ1Rb64A+402XQC+tZMiWZaoKY7Z9YygkfUx2MPwOKn00HAz7zfR2RYtrfoFUwd
         BcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vBPiP/Wi1ZUyyw9ezT10BaZxDtN5iId+gdmm/nX0R8=;
        b=T1K0XBE6AXO/DmO6xJU80msjJOiNDPlfQEhst4Ll4FpP+W1oGkS5sDehJqlX3z65QK
         o742uAJO22TmHgzrzLJy0XP0rvp+lgdmDVindpt1D4nUL7dGov/Ix0V6S/DLMafOWLHy
         XjxBJNPPK3rXAJdUOipeOz80jDux3rfi/GrxCd1oCTrdUbGsqF6GW75ZRqyhvhvW+Ano
         RqWbxTza6uPESQ5X8XTj3oOqQPs7h/ScbgM8gg6vHTVFDZBCkYsJq7+Y3OlAIVgYgfe6
         +ROIfVzzbiMBwXgn7ygTi5W6T6f1luojI8UzRhO7grXqjz63yOAbGWdnfRn+DUJ4VK+c
         c2Dg==
X-Gm-Message-State: ACrzQf3Nvczvyff5E8wn0HDcM39iIJ7ticQ4BhMYlLx14OUOBhgQ634A
        GQhzBstshZibgcgsQdDSxIm3ol8Jn73E/9dy
X-Google-Smtp-Source: AMsMyM5zvN2c7TS0+GIwI43Z7XY7gC01wPwNS2KXC0QzcOT+oQLp2QNwaPTTa7AacZwK30gsLU9cNA==
X-Received: by 2002:a17:902:b697:b0:187:1acf:249c with SMTP id c23-20020a170902b69700b001871acf249cmr45937710pls.14.1667879145623;
        Mon, 07 Nov 2022 19:45:45 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.50])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b00177f25f8ab3sm5809044plh.89.2022.11.07.19.45.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Nov 2022 19:45:44 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
Date:   Tue,  8 Nov 2022 11:45:38 +0800
Message-Id: <20221108034538.11849-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.384.g2475ea0c04d
In-Reply-To: <221107.864jvax1hz.gmgdl@evledraar.gmail.com>
References: <221107.864jvax1hz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ævar Arnfjörð Bjarmason" <avarab@gmail.com> writes:

> Just make this:
>
> 	--no-blank-line:
> 		Suppress the insertion of a blank line before the
> 		inserted notes.
>
> Or something, i.e. when adding a "true by default" let's add a "no-..." variant
> directly.
>
> ...

Yes, that's what I propose to do originally, but I can accept either NEG or POS
way. So, I will hang this up for a while and try to hear more inputs.

> > -		if (d.buf.len && prev_buf && size)
> > +		if (blankline && d.buf.len && prev_buf && size)
> >  			strbuf_insertstr(&d.buf, 0, "\n");
>
> Maybe this needs to be elaborated in the docs? I.e. it sounds as if
> we'll insert a \n unconditionally, which this shows isn't the case.

The current doc add the content about this circumstance corresponing to this
"if", which describes as:

>  append::
>  	Append to the notes of an existing object (defaults to HEAD).
> -	Creates a new notes object if needed.
> +	Creates a new notes object if needed. If the note of the given
> +	object and the note to be appended are not empty, a blank line
> +	will be inserted between them.

... so you mean we should add more detailed information here?

> This should be a test_when_finished "", for the previous test, otherwise
> this one will presumably fail if you use the "wrong" --run="" arguments
> to skip the last test.

Yes, I agree, will fix (although if we replace it by "test_when_finished,
because of the dependency of the previous repo status, execute
`sh t3301-notes.sh --run=60` also failed).

Thanks.
