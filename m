Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA093C18E5A
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 19:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1422208E4
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 19:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="hb7rY0IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgCJTh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:37:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41887 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgCJTh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 15:37:26 -0400
Received: by mail-io1-f66.google.com with SMTP id m25so13998367ioo.8
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 12:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FgXt70B51MB3dS73AJE1W0VHPRw9bklvxZRJmM7nmok=;
        b=hb7rY0INImNOR6dzwwJxJuvwPx8r+yOyPr4C9AoWgkqGaZyxfXZ9yd611MfAEfGoMH
         1L5IMofVL7RPEqAzDya1fT6CA4eJuDLaTotmaraOsdXQEThcB+ItU1KdpDykA07kPTqg
         GnsCEat/P+GN/rFGQmVKIbqerRYgpesq7rVqLbTXIA/+H0JQsDQDCSK1oZ9huS8py40k
         LdUfer8uX82ejwN8yig3RugtAfJHQOH0M23wIo8vUvRmmz61PWGqZ9QDDQ3JMVWc6h+L
         gIx/EmpKMpkkwaDuj5NaG5AIQoBZbqLI0CI/Rbn+IipAannjRTkxceSiYDfvztnbJuZ6
         78jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FgXt70B51MB3dS73AJE1W0VHPRw9bklvxZRJmM7nmok=;
        b=ROFY4wcI5blNLhUHipeyCXnwNwlomYOUvRB9anj3nYOhvkWAAPxntd6aG3pqvVVyct
         HmISIg0zSF0T3qx2FrtRF8au2iFwyRaKi52ebvvL/ni9d4O4p/tPPcZCh0IN0Sp7sokN
         MJosCGG2F8FprHexQZEBCouhsK6RSf9X/CUg2YY0NhaxT2TpChgXI4PueVL6r3U5kdG8
         wDdNFM2MM3G0snIr4pThUeOLOEb7CO7qH8U3e1Jkm/Wlpml6ifYquL0qwzBL/Uvlf8Oj
         1Ow/K3H00zh7dKGxgQnrqlY5RutmQVBp7AEYX/aLKbTnQvnHTXdV6yAayuG6zy0C1Azy
         5xQA==
X-Gm-Message-State: ANhLgQ0DS4n5ytUipYNYBFfJyfrIxq0uq3ESYGn/CP+VkMAYPy7BJK3C
        o7DPZCF0C5vUMD0DAvuUpnfsakFZrc0tns707HSgQt/ZR3Milw==
X-Google-Smtp-Source: ADFU+vt7GEnl31f5dHtVj0deWfSVrBhLGOw2/cMvQ/HA5z4fNCSYsPmaSSFdVZ7fkalV+LmLXMjDlQY+ZzEeeTc6bw8=
X-Received: by 2002:a5d:8f96:: with SMTP id l22mr10438251iol.19.1583869045532;
 Tue, 10 Mar 2020 12:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200310184111.GD1443@cork>
In-Reply-To: <20200310184111.GD1443@cork>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 10 Mar 2020 12:37:14 -0700
Message-ID: <CAGyf7-GoJNtdPT=GWG-QcP=J6uu1un5drvPAcNr5jB9Sc_ZLRg@mail.gmail.com>
Subject: Re: new file mode 160000
To:     =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 10, 2020 at 11:41 AM J=C3=B6rn Engel <joern@purestorage.com> wr=
ote:
>
> Something weird happened to us and I have no idea how to reproduce it.
> A developer managed to create a git commit with the following content:
>
> diff --git a/foo b/foo
> new file mode 160000
> index 000000000000..b7e7816c1266
> --- /dev/null
> +++ b/foo
> @@ -0,0 +1 @@
> +one line of content
>
> File name and content obfuscated, the rest is verbatim from the git
> commit.
>
> Now, file mode 160000 doesn't make sense to me.  It doesn't correspond
> to any known file type and I cannot explain how this commit was created
> in the first place.  But whatever the mechanism, the git client should
> have refused it.

Git's file modes aren't (entirely) real. It doesn't actually track
read/write, for example, but it does use the mode to track executable.
That means, for normal files, the possible modes are 0755 and 0644.
Other modes like 0600 or 0750 or similar are not possible.

But Git also uses the mode as a way to track other things. In this
case, 160000 means the file is _intended_ to be a submdule (albeit
with what appears to be invalid content for a submodule, in this
case). Relevant source:
https://github.com/git/git/blob/master/cache.h#L69

>
> Next, the commit was pushed to our git server, which happily accepted
> it.  Again, I would argue that the git server should have refused the
> push.

Since 160000 is a valid mode _to Git_, the push is fine.

>
> Finally, others including myself pulled and checked out a branch with
> this commit.  On checkout, an empty directory is being created and
> caused various mayhem.  I get:
>         error: 'foo' does not have a commit checked out
>         fatal: updating files failed

This indicates, as I mentioned earlier, that the contents of the "foo"
submodule are invalid, so Git couldn't actually check it out. The
content is expected to be the SHA of a commit, paired with a matching
line in a `.gitmodules` file which tells Git where the repository is
so it can check it out.

>
> Not sure what the correct solution would be here.  An empty directory is
> a bad idea, but I cannot think of any "correct" way to handle things
> once the bad commit is in the tree.

It should be straightforward to delete the broken submodule (git rm
foo), commit and push.

Hope this helps!
Bryan
>
> In case it matters, my client is: git version 2.25.0
>
> J=C3=B6rn
