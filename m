Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6945C07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 01:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiIXBo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 21:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiIXBo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 21:44:26 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C57BE6DDC
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 18:44:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e67so1722656pgc.12
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 18:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=XaUbkqGzoDrJTNR7IS19BQ1tudjZQZuDPC4z+QkmOww=;
        b=Y7q9U2IZtG+Pf87oq6RJVtd+q+9+cZ2YxJwEKdBcNDtECNJxJyxIRqISaFHNO0c3iz
         Zv4naNkcVglDzXepsyd+mKGNg/GkxtR3zsn5yBycv08fXy9Mj/lKpBacv9o3w0oa/1CX
         eNh6VxWNk5X9z92jrXtGN2xJzrDW78ZR2is/qo7enpiPzNCYIeNerd8sESDe9GSXU/rb
         BtZJ6eG5PIK/fLkJyKK+KCLl9u9BlbajNO5e6m0LenMKzSrADxk0rIPIYWpsD03GDj5m
         AVYCyDg+8nFM52PDrb/JAKbf+lotDjEArFdkLrmjUkydEVErt+8PqI1bGVJB5ZhQ7U1Q
         uKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XaUbkqGzoDrJTNR7IS19BQ1tudjZQZuDPC4z+QkmOww=;
        b=WtKbROmZef7tAmXNDhgF+fdRKw4khoyZqBNiVy952c+t06louha4VBRFRLMzgItLVV
         yTZ0VoCMSHtqbvotDF29mzU5H+Cm6rs0/CrxQOrA6Zo5SIheWbuMar5apaQRRgdHCHNG
         aHXB5imo8VUfUeuiXaRa0DXKEZKFBpea4byxQvUJElv1oMbDmtEHham7Kr7cqkZHTv18
         JfDvJMvkbMT66drsMwidPzm/ZD9zig6Vlszt98z8mpZsaR2rN+4vQrRHKA+5knAFqM/Y
         w6gsxP6Sh9R16hDJzHSDI8XjtdJ/ZZLIS/zWI8vk4jGs8d0EG0sEwqTPMMR77zvyTQ5b
         tl1Q==
X-Gm-Message-State: ACrzQf2M3vIgp1RMU3W8MYPzDn3eedHXqRdjzvxn6VLx/KYrxWD7eqzO
        KKYhvOLcxlP+65PSr25R95vDq4HjFzw=
X-Google-Smtp-Source: AMsMyM5qbYiirgjjbidXIWffqqy2O2hPW4+gFCpdZdhqy7D4heRo2uRyp7crX4kDs2Cayi/84JDf1w==
X-Received: by 2002:a63:290:0:b0:43c:20be:9f48 with SMTP id 138-20020a630290000000b0043c20be9f48mr7975531pgc.388.1663983864599;
        Fri, 23 Sep 2022 18:44:24 -0700 (PDT)
Received: from localhost ([2001:ee0:5008:db00:84c8:158c:9494:ee57])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090340cf00b001754a3c5404sm6435608pld.212.2022.09.23.18.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 18:44:24 -0700 (PDT)
Date:   Sat, 24 Sep 2022 08:44:19 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Claus Fischer <claus.fischer@clausfischer.com>
Cc:     git@vger.kernel.org
Subject: Re: Scriptable mode for git bisect
Message-ID: <Yy5g80OtVG4op8L1@danh.dev>
References: <Yy4c6/jHupgThj7j@clausfischer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy4c6/jHupgThj7j@clausfischer.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-09-23 22:54:03+0200, Claus Fischer <claus.fischer@clausfischer.com> wrote:
> 
> Dear Git maintainers,
> 
> I have looked at the manpage of git bisect but have not found
> what I need:
> I would like git bisect not just to report the 'bad' revision
> within a bunch of text but instead either stop at the first
> bad revision (the last good will then be HEAD~1) or report
> it in a scriptable way, i.e.
> 
>   BADHEAD=$(git bisect run --shut-up-and-report-the-bad)
> 
> Have I overlooked anything?

After running "git bisect run"
You can take its revisions with:

	BADHEAD=$(git rev-parse --verify refs/bisect/bad)

> 
> ***
> 
> The pourpose is to keep the source trees of two different
> projects that share a few files synchronous.
> My good/bad-script is a script that checks whether these
> files are similar.
> I want git to stop at the first change in source tree A
> so that I can update source tree B with the same commit
> message, then proceed to the next change in A that
> changes one of those files.
> 
> Regards,
> 
> Cluas

-- 
Danh
