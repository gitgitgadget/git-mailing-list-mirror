Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8737FCD37BC
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 12:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjIPM4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 08:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjIPM4e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 08:56:34 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23BD1B1
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 05:56:29 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76dbe786527so189049285a.2
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694868989; x=1695473789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2hisrb5M2OaIII+/jPDv8VLTJMCGUaurez8TH0LybA=;
        b=iP4Fbtt9PLHVXvO3XZlEEMbjEMIbf+tIAsXj7eLhGZ4qUZ8IJGiCAuZcMAsXwc/JAV
         x0Kg2Uks/CLAcQcFtAZRiu2Obui7O/7KtDZpWSXFFdmMfv3nSderOEhHM2KaUT6d178T
         jPeLmypfzbu68zZ9d8CgBvKeZo4wSV0B/qjY+mFaYKsYadoZEda4wYZ7vliEwzTceWu5
         erXsLtoRzHyfoIlKeeIvTHJQ5KlMsiidGvgABrTT8nOkoVG9JmDQxJzvlJSLuN+94cK0
         z2xDZKnO8t22EL0hYw1jkp9PcltGwaBNmxZokW5T3T+kvZBQehqnmzX0Y639w9TjphHc
         DA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694868989; x=1695473789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2hisrb5M2OaIII+/jPDv8VLTJMCGUaurez8TH0LybA=;
        b=h44HpxIm2ej/PMLpTgWOT6Ga6IsLPGNqzu4FNz1ZVv9Bu/EknUCIhdewGfi5EWCsCO
         t+grfX5/R50yAbyXsfVoHqDeqOsLY5QmzlCp/visyCo0lDMBjFYIN2Ye3SxRJb6O0t7W
         pKdXniu5o96Wo1+5gcRpkUK1/AsrrnCYmquiW0tcdTQA0uuCfTkiNe2qJYuFa4Cgg27i
         z1J4zrPm55ISthlQ2DWPKrj/GFOTgpik+Tbo8z/ziBb+ILO7PD+2qjKEvCPhrp2tiEkx
         1ljtLQqn94MexRf/unx+bx8IqdXv9vgrEnxz5hsksB69a3zbk0vF55bCnVyDvHWAL6Ao
         5Evw==
X-Gm-Message-State: AOJu0YxzSDLc6D8iAUNFMnRCxHehPWCsrF9IBweJb7/3FrZYDzDZ/Q7R
        zxV/ubXK+J2cMIOI8BrSYno=
X-Google-Smtp-Source: AGHT+IHcq6xEm22tOo1pxb3kyORoP30B3vG8rrWJYALy+JFFYxohPVuDDl1/BlPNlQMUB/9OABI0NA==
X-Received: by 2002:a05:6214:908:b0:655:fac7:19c0 with SMTP id dj8-20020a056214090800b00655fac719c0mr3794224qvb.19.1694868988836;
        Sat, 16 Sep 2023 05:56:28 -0700 (PDT)
Received: from ?IPV6:2600:4040:266f:b900::387? ([2600:4040:266f:b900::387])
        by smtp.gmail.com with ESMTPSA id x8-20020a0ce0c8000000b0064733ac9a9dsm1253961qvk.122.2023.09.16.05.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 05:56:28 -0700 (PDT)
Message-ID: <ffd5e1dc-bad7-2b1d-3344-76ffeb2858f5@gmail.com>
Date:   Sat, 16 Sep 2023 08:56:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: BUG: git-gui no longer executes hook scripts
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        me@yadavpratyush.com
References: <bd510f6d-6613-413b-6d64-c3d2fd01d8a9@gmail.com>
 <xmqqa5tngynh.fsf@gitster.g> <xmqq5y4bgxy1.fsf@gitster.g>
 <454d8b7b-96df-ec8f-2285-e022de66c66c@gmail.com> <xmqqil8ad8un.fsf@gitster.g>
From:   Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <xmqqil8ad8un.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 9/16/23 00:45, Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>> I think a simpler fix is just to examine the number of path components
>> - more than one means a relative or absolute command (/foo splits into
>> two parts). The below works for me on Linux.
> That is clever, but I cannot convince myself that it is not too
> clever for its own sake.  The "pathtype" thing Dscho used in his
> original is documented to be aware of things like "C:\path\name",
> but I didn't re-read the Tcl manual page too carefully to know what
> "file split" does for such pathname to be certain.
>

The manual does not talk about Windows explicitly. From 
https://www.tcl.tk/man/tcl/TclCmd/file.html#M35

*file split */name/
    Returns a list whose elements are the path components in /name/. The
    first element of the list will have the same path type as /name/.
    All other elements will be relative. Path separators will be
    discarded unless they are needed to ensure that an element is
    unambiguously relative. For example, under Unix

    *file split*  /foo/~bar/baz

    returns “*/ foo ./~bar baz*” to ensure that later commands that use
    the third component do not attempt to perform tilde substitution.

So, there is hope c:\foo will split into c: foo, or c:\ foo, but testing 
on Windows is needed. Really need Dscho or someone else from g4w to help 
out here.


