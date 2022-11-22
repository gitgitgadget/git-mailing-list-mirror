Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DE5C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 13:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiKVNBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 08:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiKVNA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 08:00:58 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD8461BAE
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 05:00:57 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id k15so14308629pfg.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 05:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n3gO8EaJTXjqw3r1xkjf1xfo+4tGYPfXWLAcPNqGbXo=;
        b=os3wkX3N+TxwMO+OMM3ORznn7QZ0Oo4MJx8WD6PWwlU/93kj9slzQE/crAcC+XdOfo
         7UsSydvw6o6eQ6oCog5fppLyOoAJzGmidpqHH0UsrDPU+zIi8sQp0IYA4UmLG4qX+G+I
         MavpIkRhEir/bFf8eUSJ/MbNHX1R8bnD1KmI0VQXz9lC1K4AzJAcY05X5Rnr7u4NYCYv
         gdOBLVcZ9TAE9t3j9PTpmKg4m/7njElIKVppeOf9q9vCcBWKME9Ra2huN//5vaZZVslt
         5pt8dy5oKCIHcTk3rMVYyLAGUipvK7H9rpOo/7+L/3/I7FCVpOTB9suRgB5uPzR00aSC
         gZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3gO8EaJTXjqw3r1xkjf1xfo+4tGYPfXWLAcPNqGbXo=;
        b=prLCoyb7L+A1SeIzwpV9MhpXY0Kxf0kcjPOPZnjVMLH1huP92LMyg2vmHA+aPsmNPu
         6cjlAGXNuI3OBW/v7QXMzBdNfwsGPaqMuUdKQEE8zmmXf/qYFRPDgJwYFZOCn0NtxNuf
         We9mQ37fn7dxV17cLKucbb08LxRwjOvmBJza1tbKLGPkatnQkST0ikNNfJCoy9IpzQh4
         tm00LMr2mkt3HniWALTfr9IKidpVhNEa2rvvm5OrS3vBZk1/fi+LxxfU03x85fegDh8i
         b9Z6xdfk7DVeZ0Z3qMQkzmKU/Rmlex/QiqNnYlefRGHEbsEWTiEvrhBIUVIGrK9Oojyx
         90Eg==
X-Gm-Message-State: ANoB5pmBqGdPjjc1h9EgUq9lpbax2AhRdkJHfY1lF3RI7NwWufLQU6La
        MLOeBoPF0b1KCeA4Q3WaEyaKRAO6N1HYLqdcV2QJ/whz7cEYYw==
X-Google-Smtp-Source: AA0mqf7voHy3sBb7vYTkhYL01ZU3vrB92jnU6y1W3G4ExCmaR78tRtwaL9OJXinQgb7JYjx0Dls1Ju2UROgF2CPpDJ4=
X-Received: by 2002:a63:c51:0:b0:470:4522:f64a with SMTP id
 17-20020a630c51000000b004704522f64amr4482642pgm.348.1669122057018; Tue, 22
 Nov 2022 05:00:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
 <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com> <ccfea26de333ac5a08a5df4c9b790811067bd437.1669033620.git.gitgitgadget@gmail.com>
 <Y3vFpNbWswu/8gjb@coredump.intra.peff.net> <xmqq35abvpxm.fsf@gitster.g>
In-Reply-To: <xmqq35abvpxm.fsf@gitster.g>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Tue, 22 Nov 2022 22:00:45 +0900
Message-ID: <CAF5D8-uQ633azqUfCv0vyQzFUaQdDhOwzEc8GOGnFrgmh-c9pQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] git-jump: add an optional argument '--stdout'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 8:38 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > On Mon, Nov 21, 2022 at 12:26:59PM +0000, Yoichi Nakayama via GitGitGadget wrote:
> >
> >> From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
> >> +--------------------------------------------------
> >> +# In Emacs, M-x grep and invoke "git jump --stdout <mode>"
> >> +Run grep (like this): git jump --stdout diff
> >> +--------------------------------------------------
> >
> > This example confused me because it says "run grep", but then runs a
> > diff jump. But maybe this is because it means to run the emacs grep
> > command? I don't use emacs, so it may make more sense to somebody who
> > does.
>
> Yes.  "M-x" gives Emacs users a command line prompt to type (and tab
> complete) an Emacs command, and in the above explanation, the user
> is running the "grep" command of Emacs, which in turn prompts for a
> shell command that produces series of <filename>:<lineno>:<cruft> to
> jump around [*].
>
> "M-x grep<RET>git jump --stdout diff<RET>" is what I would have
> written on the second line instead of "Run grep (like this)...".

I think Junio's suggestion of  "M-x grep<RET>git jump --stdout diff<RET>"
is concise and understandable to most Emacs users, so I'd like to adopt it.

Below are the details of what I thought:

By M-x grep<RET>, Emacs displays
      Run grep (like this): grep --color=auto -nH --null -e
where
- "Run grep (like this): " is a prompt (like "$ " in bash).
- "grep --color=auto -nH --null -e " is a part of search command (missing
  keyword part). We can supply "keyword<RET>" to execute the search.
  We can also remove the whole command and replace it with the command
  like "git jump --stdout diff".

So "M-x grep<RET>git jump --stdout diff<RET>" does not represent the
complete procedure. It lacks the operation to remove the default command
(controlled by the grep-command setting). For example, adding C-a C-k
after "M-x grep<RET>" is more accurate, but it feels a bit redundant.
-- 
Yoichi NAKAYAMA
