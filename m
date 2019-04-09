Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9659320248
	for <e@80x24.org>; Tue,  9 Apr 2019 09:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDIJ6P (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 05:58:15 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44474 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIJ6P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 05:58:15 -0400
Received: by mail-wr1-f49.google.com with SMTP id y7so4438747wrn.11
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 02:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sNGKHNTjlu4Hlsc1ooSuFJ7AeAqj5KkH4LCgiOP7Z94=;
        b=YBBWwQpL8hnl4Kw0Z94CM4ZyTrbqVKwEZqlPnWc7EFN1wUWIYJWsbpK3kyOGyz0eE9
         TyOM4qII5q96dkb95fv2UXH6NhBkHHiye50M35y0puxJPLev7S1mLbZZbqWdA1fgdlen
         4t+ALTcfNF+D5mZPX/QdBaHHwtBszyiElfxC8hq8i5vZv3ZbSQyJOu+VN9i24Gvxdc9X
         8d90a9zRf0F3LCF19PhYKDIw8YmW3+A6c/2F4gQoACpF9Yh7kdw4/6HqU3GaHK1rxn19
         p4eF3W2r7LJ6G0emcBPuOlyr0I4w5yHxAkT+buCv59ST2rkS2QN9j4tVhHPEggnuFX7D
         Wa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sNGKHNTjlu4Hlsc1ooSuFJ7AeAqj5KkH4LCgiOP7Z94=;
        b=VlUb7JWDT13v9iIujpxju57omBHH5RBJtxYYTJersXH8T7DRpz2QYtWPcXV2VIAnI0
         WdT7GbMUasTpG7YgSrMroHVYtZ0V2MgoJJDBeS+NZhJnMco7DqSRc5WABVtJj3wDc89W
         8BTHx2X7k46e3C3ixkVD8vowS7Tl2/oLHFT77xw3PechGRDxw7eP4HVxRQg0Qc31VXKK
         kYm2++JLOZ4pJThA+HZ+vxFZxDXeABNDyci3VkYT5mFLWQf0/6W1dadVUHckdAIAXZWD
         KryFdKzF3+wVidg85aJzDe6oHJpB10v9qj/r3ZeYg+taAEA9Lf+gky/IoOKOJszDkXSP
         Xu0w==
X-Gm-Message-State: APjAAAUmNtMZ5eWkD9iFuhuDvyGXxCYUMJsyLDVMpwhVNHwehZuFntW4
        RxwjTDoZ8ZTTrhKPL+MD+rc=
X-Google-Smtp-Source: APXvYqwFZltrCLUO9Xji1iVLmO4Qi8DdpSk0teL+kfsXTWGjuFRqEmVS4ycKmvY6zrwF9ux5veDf9Q==
X-Received: by 2002:a5d:4a4d:: with SMTP id v13mr22913279wrs.169.1554803892416;
        Tue, 09 Apr 2019 02:58:12 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c2sm23197755wrr.13.2019.04.09.02.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 02:58:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: git push --atomic and HTTP(S) vs SSH
References: <CAGyf7-Fr3AE1cWXnAtpKU5quu9RciwfM9o9j0uw8sijr3cFMhQ@mail.gmail.com>
Date:   Tue, 09 Apr 2019 18:58:11 +0900
In-Reply-To: <CAGyf7-Fr3AE1cWXnAtpKU5quu9RciwfM9o9j0uw8sijr3cFMhQ@mail.gmail.com>
        (Bryan Turner's message of "Mon, 8 Apr 2019 23:11:47 -0700")
Message-ID: <xmqq1s2b7b64.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bryan Turner <bturner@atlassian.com> writes:

> A question came up on Stack Overflow[1], and then again through our
> support channels, about "git push --atomic" and a behavior mismatch
> between HTTP(S) and SSH. I'm easily able to reproduce the behavior,
> but I don't see anything Bitbucket Server-related about how this works
> (and I get exactly the same mismatched behavior against GitHub; but
> that's not really a surprise given what I see in the wire protocol.
>
> First, a setup: 2 commits, with the second commit then amended to make
> a 3rd commit.
>
> git init foo
> cd foo
> echo 'Hello, World' > file.txt
> git add file.txt
> git commit -m "Initial commit"
> echo 'Goodbye, World' > file.txt
> git commit -am "Second commit"
> git tag original-message
> echo 'Goodbye, Cruel World' > file.txt
> git commit -a --amend --no-edit
> git tag amended-message
>
> Now, given an HTTP remote: (Assume "atomic-pushes" is an empty,
> just-created repository)
>
> git remote add http https://github.com/bturner/atomic-pushes.git
> git push http original-message:refs/heads/master
> git push --atomic http amended-message:refs/heads/master
> amended-message:refs/heads/branch-1
>
> So we push the original message commit to master first, and then we
> try to push (without --force) the amended commit to both master and a
> new branch. That'll produce this:
>
> Total 0 (delta 0), reused 0 (delta 0)
> remote:
> remote: Create a pull request for 'branch-1' on GitHub by visiting:
> remote:      https://github.com/bturner/atomic-pushes/pull/new/branch-1
> remote:
> To https://github.com/bturner/atomic-pushes.git
>  * [new branch]      HEAD -> branch-1
>  ! [rejected]        HEAD -> master (non-fast-forward)
> error: failed to push some refs to
> 'https://github.com/bturner/atomic-pushes.git'
> hint: Updates were rejected because the tip of your current branch is behind
> hint: its remote counterpart. Integrate the remote changes (e.g.
> hint: 'git pull ...') before pushing again.
> hint: See the 'Note about fast-forwards' in 'git push --help' for details.
>
> Now let's try it with SSH: (Using a different branch because the HTTP
> push created branch-1)
>
> git remote add ssh git@github.com:bturner/atomic-pushes.git
> git push --atomic ssh amended-message:refs/heads/master
> amended-message:refs/heads/branch-2
>
> Now we see:
>
> error: atomic push failed for ref refs/heads/master. status: 2
>
> To git@github.com:bturner/atomic-pushes.git
>  ! [rejected]        HEAD -> master (non-fast-forward)
> error: failed to push some refs to 'git@github.com:bturner/atomic-pushes.git'
> hint: Updates were rejected because the tip of your current branch is behind
> hint: its remote counterpart. Integrate the remote changes (e.g.
> hint: 'git pull ...') before pushing again.
> hint: See the 'Note about fast-forwards' in 'git push --help' for details.
>
> No mention of branch-2 at all, but if I do a "git ls-remote ssh" I see:
>
> fe86a3eae65e18787040499c17a567096159b9ce HEAD
> 1b9c21b7aeb6ad03957cc8a023b2406d3ccee319 refs/heads/branch-1
> fe86a3eae65e18787040499c17a567096159b9ce refs/heads/master
>
> So branch-2 didn't get created.
>
> Looking at the wire protocol with GIT_TRACE_PACKET, I see this
> conversation for HTTP: (At this point I've done several tests, which
> have created various branches, so I'm now trying to push master and
> branch-4)
>
> 22:16:06.562939 pkt-line.c:46           packet:          git< #
> service=git-receive-pack
> 22:16:06.562990 pkt-line.c:46           packet:          git< 0000
> 22:16:06.562994 pkt-line.c:46           packet:          git<
> 1b9c21b7aeb6ad03957cc8a023b2406d3ccee319
> refs/heads/branch-1\0report-status delete-refs side-band-64k quiet
> atomic ofs-delta agent=git/github-g4f6c801f9475
> 22:16:06.563013 pkt-line.c:46           packet:          git<
> 1b9c21b7aeb6ad03957cc8a023b2406d3ccee319 refs/heads/branch-2
> 22:16:06.563016 pkt-line.c:46           packet:          git<
> 1b9c21b7aeb6ad03957cc8a023b2406d3ccee319 refs/heads/branch-3
> 22:16:06.563019 pkt-line.c:46           packet:          git<
> fe86a3eae65e18787040499c17a567096159b9ce refs/heads/master
> 22:16:06.563024 pkt-line.c:46           packet:          git< 0000
> 22:16:06.563329 pkt-line.c:46           packet:          git>
> HEAD:refs/heads/branch-4
> 22:16:06.563346 pkt-line.c:46           packet:          git> 0000
> 22:16:06.563357 run-command.c:347       trace: run_command:
> 'send-pack' '--stateless-rpc' '--helper-status' '--thin' '--progress'
> 'https://github.com/bturner/atomic-pushes.git/' '--stdin'
> 22:16:06.563765 exec_cmd.c:129          trace: exec: 'git' 'send-pack'
> '--stateless-rpc' '--helper-status' '--thin' '--progress'
> 'https://github.com/bturner/atomic-pushes.git/' '--stdin'
> 22:16:06.564691 git.c:348               trace: built-in: git
> 'send-pack' '--stateless-rpc' '--helper-status' '--thin' '--progress'
> 'https://github.com/bturner/atomic-pushes.git/' '--stdin'
> 22:16:06.564788 pkt-line.c:46           packet:          git<
> HEAD:refs/heads/branch-4
> 22:16:06.564793 pkt-line.c:46           packet:          git< 0000
> 22:16:06.564797 pkt-line.c:46           packet:          git<
> 1b9c21b7aeb6ad03957cc8a023b2406d3ccee319
> refs/heads/branch-1\0report-status delete-refs side-band-64k quiet
> atomic ofs-delta agent=git/github-g4f6c801f9475
> 22:16:06.564805 pkt-line.c:46           packet:          git<
> 1b9c21b7aeb6ad03957cc8a023b2406d3ccee319 refs/heads/branch-2
> 22:16:06.564826 pkt-line.c:46           packet:          git<
> 1b9c21b7aeb6ad03957cc8a023b2406d3ccee319 refs/heads/branch-3
> 22:16:06.564830 pkt-line.c:46           packet:          git<
> fe86a3eae65e18787040499c17a567096159b9ce refs/heads/master
> 22:16:06.564834 pkt-line.c:46           packet:          git< 0000
> 22:16:06.564970 pkt-line.c:46           packet:          git>
> 0000000000000000000000000000000000000000
> 6925c65344e87c65e5cd2b56d392cd06ef96ca71 refs/heads/branch-4\0
> report-status side-band-64k agent=git/2.4.0
> 22:16:06.564989 pkt-line.c:46           packet:          git> 0000
> 22:16:06.565027 pkt-line.c:46           packet:          git<
> 00960000000000000000000000000000000000000000
> 6925c65344e87c65e5cd2b56d392cd06ef96ca71 refs/heads/branch-4\0
> report-status side-band-64k agent=git/2.4.00000
>
> Based on that, I see that the server advertises the existing refs, and
> "atomic" support, and then the client _only_ sends branch-4; it
> doesn't send anything for master at all. That implies the
> non-fast-forward rejection for master is actually being done locally,
> not on the server. Only one ref change gets sent to the server, which
> applies without issue.
>
> Looking at SSH shows very different output: (branch-4 now exists
> because of the HTTP test above, so now I'm pushing master and
> branch-5)
>
> 22:56:08.609608 pkt-line.c:46           packet:         push<
> 1b9c21b7aeb6ad03957cc8a023b2406d3ccee319
> refs/heads/branch-1\0report-status delete-refs side-band-64k quiet
> atomic ofs-delta agent=git/github-g4f6c801f9475
> 22:56:08.609774 pkt-line.c:46           packet:         push<
> 1b9c21b7aeb6ad03957cc8a023b2406d3ccee319 refs/heads/branch-2
> 22:56:08.609798 pkt-line.c:46           packet:         push<
> 1b9c21b7aeb6ad03957cc8a023b2406d3ccee319 refs/heads/branch-3
> 22:56:08.609801 pkt-line.c:46           packet:         push<
> 6925c65344e87c65e5cd2b56d392cd06ef96ca71 refs/heads/branch-4
> 22:56:08.609825 pkt-line.c:46           packet:         push<
> fe86a3eae65e18787040499c17a567096159b9ce refs/heads/master
> 22:56:08.609831 pkt-line.c:46           packet:         push< 0000
>
> There are no "push>" lines at all. The server sends its ref
> advertisement, and then it seems like the non-fast-forward rejection
> for master happens locally, similar to HTTPS, but then, unlike HTTPS,
> the SSH push is simply aborted without ever sending anything to the
> server at all.

That sounds correct.  Behaviour you saw on the smart-http side seems
utterly broken.

FWIW, I think the client-side rejection is merely an optimization,
and if you changed the ref at the receiving end between the time the
receiver advertised its refs and the sender finished the push, the
receiver should notice non-fast-forward-ness and reject the whole
operation (this is probably very hard to write an automated test
for).
