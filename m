Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CF4C433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 01:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1C3610FC
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 01:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhKCBWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 21:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhKCBWn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 21:22:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4983C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 18:20:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u11so1421803plf.3
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 18:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=gmHwHgsZf8eKLr6bgliPEBcJSPLH5Q/TbRG43yVMpr4=;
        b=dN7JgvusEIaFoQPveRBgaFacHdWuEc7+NzGhxcz78lZ7H0zKafTBqAQxD20ASjfWql
         itX6PeLW4uOXl6ickXTamMShULD4wKIoK5+WBQAlM/nHKkYb69deICYis/EPZ96ptKBN
         CwmIZp08fOSvPsM6RDOuKHY62L3LKEq6RHi+lp4DNBBMZPUdX4acZpjIJOrO0kElS/Bf
         r2ogpHev9yY/m6EAedINB5pjHFSbuSSK+1WUgxtSw0SPOusqH5kBtC1v5icrjCuUPBYl
         s5E5oY5Ri9mG2w9SMJXoUTPTgyC92kIF4qf4aSC5hQ4lQQAOSKn/9wVAZeBg+2w+J6qz
         nzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=gmHwHgsZf8eKLr6bgliPEBcJSPLH5Q/TbRG43yVMpr4=;
        b=18YbP23Gr6YVifDH3HdFkGjX2WN1hc2o1HiOa7/DfUu+vo2VNTNWVjKky7k4yErsEd
         N5gZiVkA6lzAhpV0C3kTiV2ypiu7YVq6Oe8h8oKCJBEtzcPK+IA3sdF/r73QPxV3zbra
         WWGnjFz6p8+Tg89vjMwXVJBxhNaIL/3H9KbTzy8ylXJlMIJQWwDYWzGVPKjVvtGE77rd
         1Ommevo5Lk5VNhBSWs1I+d0F4H/y6rwrAKa8y70qR9w1SZQleLCf5r8lKV4Lr/BO9LbF
         jPgc5766zQeNm993vJG++/U/5tCT75hXJkcf4j6ZuSNQvANz2mzWIk0NavgJ9q/EOeEs
         mz9Q==
X-Gm-Message-State: AOAM533CyXqgNCtLI5McfaDJ/qnZ7SrgaJ5lyB57/2YUW34yf0/DZKq0
        RPMfx2ICBZyJBqRv03oxvfw2PExdDbhEWi5utG02AYYvWee54ZQg
X-Google-Smtp-Source: ABdhPJwD1LHzpK2VPt0qk4Ci4VFzlDyY6KjQ8BHj7hXovMi9Ohh44VbgZcTc4G0E6+/d1mht0Qh+auesUF+R9UZcjEA=
X-Received: by 2002:a17:902:758c:b0:141:4c99:22b3 with SMTP id
 j12-20020a170902758c00b001414c9922b3mr35095813pll.40.1635902406976; Tue, 02
 Nov 2021 18:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8dQmu6Dfo4KBsVk+6xeR6=+S8bOKk-kbc3ub7c0jAsH61-cg@mail.gmail.com>
In-Reply-To: <CAP8dQmu6Dfo4KBsVk+6xeR6=+S8bOKk-kbc3ub7c0jAsH61-cg@mail.gmail.com>
From:   Steven Penny <srpen6@gmail.com>
Date:   Tue, 2 Nov 2021 20:19:56 -0500
Message-ID: <CAP8dQmvguqPXy6Rg_RkuFmf4+LPh79HM_EBM+Wi9dYn3N+vrcQ@mail.gmail.com>
Subject: Re: credential-store get: No such file or directory
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 2, 2021 at 7:27 PM Steven Penny wrote:
> fatal: cannot run git credential-store get: No such file or directory

I came up with a workaround. I wrote my own AskPass program using Go language.
Here it is:

package main

import (
   "bytes"
   "fmt"
   "net/url"
   "os"
)

func main() {
   cache, err := os.UserCacheDir()
   if err != nil {
      panic(err)
   }
   buf, err := os.ReadFile(cache + "/git/credentials")
   if err != nil {
      panic(err)
   }
   buf = bytes.TrimSpace(buf)
   addr, err := url.Parse(string(buf))
   if err != nil {
      panic(err)
   }
   if len(os.Args) != 2 {
      return
   }
   prompt := os.Args[1]
   if len(prompt) < 8 {
      return
   }
   switch prompt[:8] {
   case "Username":
      fmt.Fprintln(os.Stderr, "Username")
      fmt.Println(addr.User.Username())
   case "Password":
      fmt.Fprintln(os.Stderr, "Password")
      pass, ok := addr.User.Password()
      if ok {
         fmt.Println(pass)
      }
   }
}
