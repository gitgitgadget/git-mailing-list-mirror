Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90A720373
	for <e@80x24.org>; Tue, 14 Mar 2017 02:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbdCNCUh (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 22:20:37 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34881 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753642AbdCNCUg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 22:20:36 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so16504125pge.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 19:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6wd+j7BmYgDQnjB9GI+L0l4Ko+3vaeT7MdkaU7baJJY=;
        b=QqhR89lOmALhAdwkp1mPmxIKwjyR6bi/573sGqgTuboCoNR4Gxvemhr8N5P8worhgp
         SClAJ7XHDw+HMrCD7tVBzxg7n1uf9cOy0CDui5z3aSlch347wdunK5AoGyauiYf2E8G1
         IJOH8WX5WtonulJGYtVOx2ZXK+8jD3h4YJtyiiH58RkJAqSIgJzsmSkpHJ1AIoIeR9+O
         nT/JGB+enVKSBLFYJSSxt9ptmk5As8JrKG0EFLskWHlC+z9rOhK0t1dZnJLJZ8PxtBY2
         syqTJlXr0lfl9zOPKE2F5AQQzIAe12jPx9y4TlB75uf44oCPXYnETX70hx3RG23QjJve
         qdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6wd+j7BmYgDQnjB9GI+L0l4Ko+3vaeT7MdkaU7baJJY=;
        b=TJuBK2tYbfTB+X7t5efsEo8/Uuy29bVM1PxDR8WuRmLJuKHGk5ooVfh2OeXp9y53u1
         XravtmH6u6fxitDCTQDG3UWe/GOZuXixP30Se+StvmthrIpw1qTqOPH5Q+JYKMbbpfua
         T0isUAVJhm8oZL6BY/WQiGZK6GIHWX+WZr32GcQ5q67DSYIsZ1X/YRhTLzoj3zipR45A
         n+YrUlbvdqDJNRjcCEL34utdjctp/yvywZ+zYAIxC3ozNjlm6+tWmyVqKbyRS4oNeCR+
         dOnLME7KcTba1sih6n5kNBrV0t8HM1pQ+XmHY6Wbqr71mU9yI+XsShcZ1BUhDqM9E+LF
         8K6Q==
X-Gm-Message-State: AMke39lMVw2J1smjlyvs3b82o/6i+P4OENaMrNVp7ixBBTn3C83SLiYFrp8NlRAYwXPsAA==
X-Received: by 10.99.64.4 with SMTP id n4mr40568078pga.71.1489458034815;
        Mon, 13 Mar 2017 19:20:34 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by smtp.gmail.com with ESMTPSA id d66sm34895138pfe.90.2017.03.13.19.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Mar 2017 19:20:33 -0700 (PDT)
Date:   Mon, 13 Mar 2017 19:20:30 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christophe Macabiau <christophemacabiau@gmail.com>,
        Git ML <git@vger.kernel.org>
Subject: Re: [PATCH] difftool: handle changing symlinks in dir-diff mode
Message-ID: <20170314022030.pqqgtaavttzb7rhq@gmail.com>
References: <alpine.DEB.2.20.1703072332370.3767@virtualbox>
 <20170313175640.14106-1-davvid@gmail.com>
 <xmqqlgs9rprt.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703132204410.3767@virtualbox>
 <xmqqinncrhey.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinncrhey.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 02:33:09PM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > +	if (strbuf_readlink(&link, ce->name, ce_namelen(ce)) == 0) {
> >> > +		strbuf_add(&path, state->base_dir, state->base_dir_len);
> >> > +		strbuf_add(&path, ce->name, ce_namelen(ce));
> >> > +
> >> > +		write_file_buf(path.buf, link.buf, link.len);
> >> 
> >> This does "write content into symlink stand-in file", but why?
> >
> > From the commit message:
> >
> > 	> Detect the null object ID for symlinks in dir-diff so that
> > 	> difftool can prepare temporary files that matches how git
> > 	> handles symlinks.
> 
> Yes I read what the proposed log message said, and noticed that
> symbolic link is _always_ written as a regular file.
> 
> I was questioning why.  I know Git falls back to such behaviour when
> the filesystem does not support symbolic links.  "Why do so
> unconditionally, even when the filesystem does?" was the question.
> 
> > The obvious connection: when core.symlinks = false, Git already falls back
> > to writing plain files with the link target as contents. This function
> > does the same, for the same motivation: it is the best we can do in this
> > case.
> 
> And that "obvious connection" does not answer the question.

Thanks for the thorough review.

I'll try to answer questions from the various emails in just this
one spot in case it helps.

Dscho wrote:
> Given that we explicitly ask use_wt_file() whether we can use the
> worktree's file, and we get the answer "no" before we enter the modified
> code block, I would really expect us *not* to want to read the link from
> disk at all.

That probably deserves a comment on its own.

The use_wt_file() function really answers the question --
"does the worktree contain content that does is unknown to
 Git, and thus we should symlink to the worktree?"

Since these are symlinks, and symlinks are already used to
point back to the worktree (so that difftools will write
back to the worktree in case the user edited in-tool)
then the meaning of use_wt_file() in this context
can be misleading.

What we're trying to do is handle the case where Git knows it's dealing
with an entry that it wants to checkout into a temporary area
but it has no way to do so.  These entries always have the
0{40} null SHA1 because that is what git diff-files reports
for content that exists in the worktree only.

Dscho wrote:
> I think you are right, we cannot simply call strbuf_readlink(), we would
> have to check the core_symlinks variable to maybe read the file contents
> instead.
>
> But then, it may not be appropriate to read the worktree to begin
> with...
> see my reply to the patch that I will send out in a couple of minutes.

In this case, where the null SHA1 indicates that it is unknown content,
then I believe we must read from the worktree to simulate what Git
would have checked out.  Checking for core.symlinks should probably be
done before calling strbuf_readlink, though.

Junio wrote:
> > > Detect the null object ID for symlinks in dir-diff so that
> > > difftool can prepare temporary files that matches how git
> > > handles symlinks.
>
> Yes I read what the proposed log message said, and noticed that
> symbolic link is _always_ written as a regular file.
>
> I was questioning why.  I know Git falls back to such behaviour when
> the filesystem does not support symbolic links.  "Why do so
> unconditionally, even when the filesystem does?" was the question.

I have to re-read the code to see where this is special-cased, but
it seems that symlinks are always written as raw files by the
dir-diff code for the purposes of full-tree diffing.

I think the "why" is tied up in the implementation details of
the symlink-back-to-the-worktree-to-allow-editing feature.
By special-casing in-tree symlinks and writing them as raw
files we can hijack on-disk symlinks.  We use on-disk symlinks to
link back to the worktree so that external diff tools can write
to the worktree through the symlink.

Junio wrote:
> On this part I didn't comment in my previous message, but what is
> the implication of omitting add-left-or-right and not registering
> this symbolic link modified in the working tree to the symlinks2
> table?
>
> I am wondering if these should be more like
>
>         if (S_ISLNK(lmode) {
>                 char *content = get_symlink(src_path, &loid);
>                 add_left_or_right(&symlinks2, src_path, content, 0);
>                 free(content);
>         }
>
> with get_symlink() helper that does
>
>  - if the object name is not 0{40}, read from the object store
>
>  - if the object name is 0{40}, that means we need to read the real
>    contents from the working tree file, so do the "readlink(2) if
>    symbolic link is supported, otherwise open/read/close the stub
>    file sitting there" thing.
>
> Similary to the right hand side tree.

I'll take a look at trying this out.

Reading the code again, the point of add_left_or_right()
is to populate the worktree (done later in the loop) with
the stuff we read from Git.  Thus, if we changed just this
section to call get_symlink() then we should not even try
to checkout any symlink entries in !use_wt_file(...)
block where checkout_entry() / create_symlink_file() are called.

Since the symlinks2 hashmap already populates the worktree
then that code should instead simply skip symlinks.


Later, once we get to the part where we copy stuff back
into the worktree, it should be noted that we always
skip over symlinks.  We simply do not handle them,
never have, and I don't think we really should.

The use case that we're trying to handle is a common
use case where the user is using dir-diff and uses the
difftool to edit a file with content that exists in the
worktree only.  For that use case, a symlink to the worktree
is created in the temp area, and Git does not need to do
anything special.

I do not think the use case of a user editing a symlink
stand-in file, and then having Git update the worktree
with the updated content, is common or something we
want to support.  I'd prefer to keep the use case simple
since the code is already complicated enough.

I'll take a stab at adding a get_symlink() helper, adjust
the code so that add_left_or_right() is populated, and
special-case the checkout_entry() code path to simply skip
over null SHA1s.

I'll also address the review notes and try to add more
comments to describe what exactly this code does and why
it does it.

Do the tests make sense?

One minor thing I noticed is that I had to use "echo -n"
for the stuff coming out of strbuf_readlink(), and
plain "echo" for entries that come in via read_sha1_file()
content passed to add_left_or_right().

That suggests that maybe I should append a newline to the
output from strbuf_readlink() so that it matches Git.
Does that sound right?  Does Git store symlink entries
with a terminating newline?

Please let me know if I'm missing something.

cheers,
-- 
David
