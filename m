Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9EE31F404
	for <e@80x24.org>; Tue, 28 Aug 2018 22:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeH2B7e (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:59:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38788 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2B7d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:59:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so3474193wmi.3
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 15:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BVfNdnPScV/ivlsbKoAXlFC5f2JKzl8kvZU5DvK0DWA=;
        b=D/zCX44oEWFpztaHcVsZ6UG1THB05ycAUPl9TlNaU1hzBPX2FAo+6Fe92KSHaleTON
         SVULZCUVbb8U/b35FQOLZXgGQJ4FBzlKYRHyyVu/bVD5csWc1uz2AnlpmJlevYeCuHhT
         gQv2dSanSWG+URnespxj5HeBykYN9zt/yTAl8ZSIkjtvwNMaqBfWAS2ISzPee9gr7qpK
         I7gh3S5xneOCNDQFVLRMttkI1JZxZUGt5drJX1vFhC9HM/ougWlHNoxswnmGwNi/TtkK
         Sgt4Lx9z7nM/r6znXrc7qIDh+vi33fThuiIvHoa6Wz+kqcqNEZHB+/o6KdAAHi6YJsMJ
         cCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BVfNdnPScV/ivlsbKoAXlFC5f2JKzl8kvZU5DvK0DWA=;
        b=JH2V5pjCKc+KCfL0wJ5pPI2pCgoiDzh+aHOf0xYq89WNnggA83Zd55Tynr0iwMZ6PO
         /nyLtriMGycYNo8WltrrKeQli7TJ2IpFOtpTJuaBCU7xYlT/qAFDQDXvoJ0kdsMd/n0z
         mB05jLfmjs0oQmXajXqYZ/fWLzYDlNxaUgS0aLlmzY/awwC5y/WoTX/3Rqk0B+ybbqcH
         WCUzP1XtLMnqpJCQMCoYcWnGCF085ISN4/sP9IbCX1EAzPrwZIo9KidqJfR74Vuc0UCU
         cYR+lZQSVoKFy+I4ztmH0zcONkgJqFLndo2hjEI2PIeXhUlMXWUB2jQWQsyghQnF96Om
         On8Q==
X-Gm-Message-State: APzg51AzqXE80VIj6KmGFbzIlzKcfVm/DqhBq6enOwnt0iYGpDiL/bzi
        jmvYFTy7yNo1K5daOqtfvaM=
X-Google-Smtp-Source: ANB0VdZm9Hazg9WF3Jq4Ur+GFKRMCa8Wxsb7WYaZCn3atrntL8LyifxadntQTJLpx2x0hR46PfYB4A==
X-Received: by 2002:a1c:64c:: with SMTP id 73-v6mr2370067wmg.7.1535493952408;
        Tue, 28 Aug 2018 15:05:52 -0700 (PDT)
Received: from localhost ([2.29.27.208])
        by smtp.gmail.com with ESMTPSA id w201-v6sm1371521wmw.39.2018.08.28.15.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 15:05:51 -0700 (PDT)
Date:   Tue, 28 Aug 2018 23:05:50 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 10/11] rerere: teach rerere to handle nested conflicts
Message-ID: <20180828220550.GJ13316@hank.intra.tgummerer.com>
References: <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180805172037.12530-1-t.gummerer@gmail.com>
 <20180805172037.12530-11-t.gummerer@gmail.com>
 <CACBZZX6xvsZ4K86b53ura6zENs2p0SBjwYYG=h0TNem3wnEbuQ@mail.gmail.com>
 <xmqqsh365qt0.fsf@gitster-ct.c.googlers.com>
 <20180822203451.GG13316@hank.intra.tgummerer.com>
 <xmqq4lfmm7pb.fsf@gitster-ct.c.googlers.com>
 <20180824215619.GH13316@hank.intra.tgummerer.com>
 <xmqqk1oblnor.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk1oblnor.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/27, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Agreed.  I think it may be solvable if we'd actually get the
> > information about what belongs to which side from the merge algorithm
> > directly.
> 
> The merge machinery may (eh, rather, "does") know, but we do not
> have a way to express that in the working tree file that becomes the
> input to the rerere algorithm, without making backward-incompatible
> changes to the output format.

Right, I was more thinking along the lines of using the stages in the
index to redo the merge and get the information that way.  But that
may not work as well with using 'git rerere' from the command line,
and have other backwards compatibility woes, that I didn't quite think
through yet :)

> In a sense, that is already a solved problem, even though the
> solution was done a bit differently ;-) If the end users need to
> commit a half-resolved result with conflict markers (perhaps they
> want to share it among themselves and work on resolving further),
> what they can do is to also say that these are now part of contents,
> not conflict markers, with conflict-marker-size attribute.  Perhaps
> they prepare such a half-resolved result with unusual value of the
> attribute, so that later merge of these with standard conflict
> marker size will not get confused.

Right, I wasn't aware of the conflict-marker-size attribute.  Thanks
for mentioning it!

> That reminds me of another thing.  I've been running with these in
> my $GIT_DIR/info/attributes file for the past few years.  Perhaps we
> should add them to Documentation/.gitattributes and t/.gitattributes
> so that project participants would all benefit?
> 
> Documentation/git-merge.txt	conflict-marker-size=32
> Documentation/user-manual.txt	conflict-marker-size=32
> t/t????-*.sh			conflict-marker-size=32

I do think that would be a good idea.  I am wondering what the right
value is though.  Seeing such a long conflict marker before I knew
about this setting would have struck me as odd, and probably made me
try and track down where it is coming from.  But on the other hand it
makes the conflict markers very easy to tell apart from the rest of
the lines that kind of look like conflict markers.

I think these tradeoffs probably make it worth setting them to a value
this large.

One other file that I see needs such a treatment is
Documentation/gitk.txt, where the first header is 7 "="s, and
therefore could confuse 'git rerere' as well.  Arguably that's less
important, as there's unlikely to be a conflict containing that line,
but it may be worth including for completeness sake.

Maybe something like this?  Though it may be good for others to chime
in if they find this helpful or whether they find the long conflict
markers distracting.

--- >8 ---
Subject: [PATCH] .gitattributes: add conflict-marker-size for relevant files

Some files in git.git contain lines that look like conflict markers,
either in examples or tests, or in the case of Documentation/gitk.txt
because of the asciidoc heading.

Having conflict markers the same length as the actual content can be
confusing for humans, and is impossible to handle for tools like 'git
rerere'.  Work around that by setting the 'conflict-marker-size'
attribute for those files to 32, which makes the conflict markers
unambiguous.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 .gitattributes | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitattributes b/.gitattributes
index 1bdc91e282..49b3051641 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -9,3 +9,7 @@
 /command-list.txt eol=lf
 /GIT-VERSION-GEN eol=lf
 /mergetools/* eol=lf
+/Documentation/git-merge.txt conflict-marker-size=32
+/Documentation/gitk.txt conflict-marker-size=32
+/Documentation/user-manual.txt conflict-marker-size=32
+/t/t????-*.sh conflict-marker-size=32
-- 
2.18.0.1088.ge017bf2cd1
