Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7EFC636CD
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 00:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjBHAEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 19:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBHAEd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 19:04:33 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A4E227B6
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 16:04:32 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a10so11289139edu.9
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 16:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JHzaDV1t8GJm+GQRBIUGYOCKzRnl1l8IMZcevxCaHyM=;
        b=YzJn/w8vNkaSqS3Cqv5lcpyI4hfp5471D5J1skbkZJepNrza6Ax71w2TTilC6LmA5i
         qODMv5YlTWPBqcHxH8TB6g4E8/Cx/9ILp7CuASamldM9tcaasweO4Z2e7A09lM02+gHq
         WPFb/RVUPwt3swMV0fWkLk/XYdqKC9NKRLNJtbU3SkGs686FMq4WjB9Et8dmm6dfp6tN
         0aNbiHot3N3TWeh8zCPjYtQvyf7pjQ/XYROocwprmwCYH2adqxq3WXqMl+hTO6EAltwQ
         w6JkF/b41BDncAXkr39F2XBjqydhiR8blU0LO/wuiWsOJM3+/QrteEUgAOd/YlRgV3fO
         e/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHzaDV1t8GJm+GQRBIUGYOCKzRnl1l8IMZcevxCaHyM=;
        b=Dc3PoroSgQRU6xMo1xAWYX8zuOhVFylxeDlNeJpRuWb7GWIqdwZRJbvFYznSWPC2qG
         9Nnjv2Lk86rg6JqkMJIqOA8jb59wBk4HrynZ/oVmU85bigzWI2GkKLdmcKn3qGjxY+Nb
         v4M/+vyy+gq/kBAWqyNcwmEWH1OQ0cLeDBIy00k8Hor/wFUOmbwbeFZC1kdrcbsgmd6k
         w01gd5ouPs4iUGgzpEIuVNjmeMx5td80UkKW7mu9C9RwG8ra5sm+QO0qKpT5qZC4452E
         c+G1yeRkPcREpPGoBpkhyUZ6PjMmuo/vDklw8zFTLftwlf8PCeNmWS8sdtnr5jPq8AEN
         ovcw==
X-Gm-Message-State: AO0yUKUAB0znCpTkxsnKcBBYxZ8H6jOQ+VORDb0LpDoKA8DAOQJxVBxm
        WZikGTQ2htc8+jN/ZBHjsnY=
X-Google-Smtp-Source: AK7set9qft0bBRpnweFgoPchJZrqEo0DsfajruuUT3ff4xpjzG41xGtapdnVYyHtZ7HWy01mmZuwuQ==
X-Received: by 2002:a50:a451:0:b0:4aa:c186:56e1 with SMTP id v17-20020a50a451000000b004aac18656e1mr5835516edb.14.1675814670589;
        Tue, 07 Feb 2023 16:04:30 -0800 (PST)
Received: from [10.16.18.213] ([181.214.173.18])
        by smtp.gmail.com with ESMTPSA id y22-20020a1709064b1600b008786675d086sm7487592eju.29.2023.02.07.16.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 16:04:30 -0800 (PST)
Message-ID: <152251b7-79a1-9ea9-01de-61a68b729196@gmail.com>
Date:   Wed, 8 Feb 2023 01:04:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 1/3] userdiff: support Java type parameters
To:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        Tassilo Horn <tsdh@gnu.org>
References: <64601c4b-9ced-672f-a5fd-9a9b3b65859d@kdbg.org>
 <20230207234259.452141-1-rybak.a.v@gmail.com>
 <20230207234259.452141-2-rybak.a.v@gmail.com>
Content-Language: en-US
In-Reply-To: <20230207234259.452141-2-rybak.a.v@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-08T00:42, Andrei Rybak wrote:
> A class or interface in Java can have type parameters following the name
> in the declared type, surrounded by angle brackets (paired less than and
> greater than signs).[2]   The type parameters -- `A` and `B` in the
> examples -- may follow the class name immediately:
> 
>      public class ParameterizedClass<A, B> {
>      }
> 
> or may be separated by whitespace:
> 
>      public class SpaceBeforeTypeParameters <A, B> {
>      }
> 
> A part of the builtin userdiff pattern for Java matches declarations of
> classes, enums, and interfaces.  The regular expression requires at
> least one whitespace character after the name of the declared type.
> This disallows matching for opening angle bracket of type parameters
> immediately after the name of the type.  Mandatory whitespace after the
> name of the type also disallows using the pattern in repositories with a
> fairly common code style that puts braces for the body of a class on
> separate lines:
> 
>      class WithLineBreakBeforeOpeningBrace
>      {
>      }
> 
> Support matching Java code in more diverse code styles and declarations
> of classes and interfaces with type parameters immediately following the
> name of the type in the builtin userdiff pattern for Java.  Do so by
> just matching anything until the end of the line after the keywords for
> the kind of type being declared.

The above explains why removing the mandatory matching for whitespace
after the class name is needed, but it doesn't explain why removing
the part of the regex that matches the class name itself is OK.
Perhaps, something like this could be added:

     An possible approach could be to keep matching the name of the
     type: "...[ \t]+[A-Za-z][A-Za-z0-9_$]*.*)$\n", but without matching
     mandatory whitespace after the name of the type, matching the name
     itself separately isn't useful for our purposes.

?

> [1] Since Java 5 released in 2004.
> [2] Detailed description is available in the Java Language
>      Specification, sections "Type Variables" and "Parameterized Types":
>      https://docs.oracle.com/javase/specs/jls/se17/html/jls-4.html#jls-4.4
> 
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---

[...]

> diff --git a/userdiff.c b/userdiff.c
> index d71b82feb7..bc5f3ed4c3 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -171,7 +171,7 @@ PATTERNS("html",
>   PATTERNS("java",
>   	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
>   	 /* Class, enum, and interface declarations */
> -	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)$\n"
> +	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+.*)$\n"
>   	 /* Method definitions; note that constructor signatures are not */
>   	 /* matched because they are indistinguishable from method calls. */
>   	 "^[ \t]*(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
