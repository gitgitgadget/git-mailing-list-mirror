Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A14F31F453
	for <e@80x24.org>; Thu,  7 Feb 2019 20:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfBGUZT (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 15:25:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35860 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfBGUZT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 15:25:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so1257176wmc.1
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 12:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9s1zqUhPb5AywAP+Uv3AgnW3g0XzAsViDuwuDlYC4Gc=;
        b=oZ3DZeYQ+kV8Uo3GgeorvkknIMSXNXaQPdyputBFkfIKmTxEExYdBCSw1aL9SIilf9
         gkaH3U571IIiyCFmBno4XqewGNixX4loU/2oeSEa/cquBmWOqR7Cet/qF0qFNu6bS6w0
         yYtu3dOGQmGk+a3Ve0ym35mWfGKA/U1fH/EAMfi/4dtlDLzakX6FFrgE6n8KAsmvWCaC
         ytemWt7GJtjZ3JVmkElo92NTqyC62phR3OZblxEpsFN5KRWdlKMMeTzD+qrPW9g66UxO
         W9YM7Ahg8gZ2IjHDwkp3ca/acl+UfXt0sW6njG6FZX+sdnL0NB2YkWFjCqfwMWKw13ya
         QU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9s1zqUhPb5AywAP+Uv3AgnW3g0XzAsViDuwuDlYC4Gc=;
        b=KCRvgR/FzVFRGO3MAwWWXd38W3hBzkVHEmFO3/c6JHezxXjGitM/ZfLrIVcneJmtjD
         039Gfl6FBT+gKAs01E8AM9gRP8U2esm7G109zWGVyzuokTUKtkDGkIVcpZLDQx8NTZU7
         bwnYmY/XefQ3pTzpx/V8fuxEUgGNNEsVoHnJzVlaz1GvFd/omQb97jsp5QD71locY+4Q
         68x5013t7Tq3GWsVyGN31h+VF+2/aIVyumVeHycnAwCYf7GkIT8UWMQ0vZew4lQ27RAn
         V8sAd7BE8/FRna19zcd3EkAmH9xo82kl5MYJ/Nsf7qUxZ/hZarfyQtKKwDSswT12NiT3
         ZWYw==
X-Gm-Message-State: AHQUAuZHzJ51hpDT0ImnYUqVkHgaa9SArnwltTVwc7Oqski4Qkx0BaQy
        9ZhlL+g6qkvZSDoXLHuwyfY=
X-Google-Smtp-Source: AHgI3IbOlIR/ggu1AsTWao1H6a20FRxyaU7BCDegXnwTRZwj/Nbn4Mk+tu5wfUgD2kfBs9FuFju6Lw==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr8752905wmb.33.1549571116792;
        Thu, 07 Feb 2019 12:25:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f187sm442293wma.4.2019.02.07.12.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 12:25:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4] log,diff-tree: add --combined-all-names option
References: <20190126221811.20241-1-newren@gmail.com>
        <20190204200754.16413-1-newren@gmail.com>
        <xmqqlg2vtfmo.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGyL5BAejK-P-EdscFdH3C6uR7e6CbgNe-9doy-mkw-vg@mail.gmail.com>
        <xmqqa7jarmvo.fsf@gitster-ct.c.googlers.com>
        <CABPp-BG4WftXZgbzN48zSo1Z5BcWYjdbz+8hGSGBNJbSsYUzAA@mail.gmail.com>
Date:   Thu, 07 Feb 2019 12:25:15 -0800
In-Reply-To: <CABPp-BG4WftXZgbzN48zSo1Z5BcWYjdbz+8hGSGBNJbSsYUzAA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 7 Feb 2019 11:50:15 -0800")
Message-ID: <xmqqimxvny6s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I think "copy from" and "rename from" should be relatively
> straightforward.  However, in a combined diff, we could have both a
> modified status, a renamed status, and a copied status, meaning that
> we'll need an array of both similarity and dissimilarity indexes...and
> trying to present that to the user in a way that makes sense seems
> like a lost cause to me.  Does anyone else know how to represent that?
>  I'm inclined to just leave it out.
>
> Also, I'm afraid "copy to" and "rename to" could be confusing if both
> appeared, since there's only one "to" path.  If there is both a copy
> and a rename involved relative to different parents, should these be
> coalesced into a "copy/rename to" line?

There are three possible labels (i.e. 'in-place modification',
'rename from elsewhere' and 'copy from elsewhere'), and you can say
"this commit created file F by renaming from X (or by copying X)"
only when you know path F did not exist _immediately before_ this
commit.  The distinction between rename and copy is whether the path
X remains in the resulting commit (i.e. if there is no X, the commit
created path F by moving X; if there is X, the commit copied the
contents of X into a new path F).

So telling renames and copies apart is probably straight-forward (if
you have sufficient information---I am not sure if you do in this
codepath offhand); as long as you know what pathname each preimage
(i.e. parent of the perge) tree had and if that pathname is missing
in the postimage (luckily there is only one---the merge result), it
was renamed, and otherwise it was copied.

But telling in-place modification and other two might be
trickier. In one parent path F may be missing but in the other
parent path F may exist, and the result of the merge is made by
merging the contents of path X in the first parent and the contents
of path F in the second parent.  From the view of the transition
between the first parent to the merge result, we moved the path X to
path F and made some modifications (i.e. renamed).  From the view of
the transition from the other branch, we kept the contents in path F
during the transition and there is no renames or copies involved.

Actually what I had in mind when I mentioned the extended headers
the first time in this discussion was that we would have "rename
from", "copy from", etc. separately for each parent, as the contents
may have come from different paths in these parents.  And that was
where my earlier "... might only become waste of the screen real
estate" comes from.

So, again, do not spend too much effort to emit these textual info
that can be easily seen with the N+1 plus/minus header lines.

Thanks.

