Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53603207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 22:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031916AbdD0Wwb (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 18:52:31 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:4117 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755557AbdD0Ww0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 18:52:26 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 3sGtd1uTmcpsk3sGtdbFxx; Thu, 27 Apr 2017 23:52:24 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8
 a=5rxgeBVgAAAA:8 a=pGLkceISAAAA:8 a=twYXc-rVnlJW9wIlBxQA:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22 a=PwKx63F5tFurRwaNxrlG:22 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <B12D69ADE0C84BBBB9A35C50F1C74A01@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jeff King" <peff@peff.net>, "Stefan Beller" <sbeller@google.com>
Cc:     "Orgad Shaneh" <orgads@gmail.com>,
        "Dakota Hawkins" <dakotahawkins@gmail.com>,
        "git" <git@vger.kernel.org>
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com> <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com> <4BF0A1BFFFFD421EB8C5F7E6FEF14357@PhilipOakley> <CAGZ79kZDzuSHw4siSkiekw73bBq9R8gg_R+a7NyNUG6bYxc2Og@mail.gmail.com> <20170425032242.wlmqrkgkeg3ytfle@sigill.intra.peff.net>
Subject: Re: Submodule/contents conflict
Date:   Thu, 27 Apr 2017 23:52:24 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfBHgbB8+KxQti86cSnjmrVB+ZxnMDPA5XCGvSsI97c/bxfxtBrrkuPm7yIoYiyIVVFfoaPZ2kBJ7tOVtVUd3GvmiK+mN2OEfO7QcekUKyATkjPAb8EHi
 JcA/cEPOUpLLcqoBEX1SpKZ6DHMH/L2pNLMu3xr3MjTqdnkt7oBEg5gSyNfXePKExvOesru8GHcU02FY5pxAZgB60rsoJobYIBQBkygj3TnIRsTIAVYB3oD8
 zgR3cn1uebIydjASOrKktFn7aQJPkIGlbbSM74xNEKf+Pw9TOgiab/vGtsFxBbH3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeff King" <peff@peff.net> Sent: Tuesday, April 25, 2017 4:22 AM

Just catching up - sorry it's late..
> On Mon, Apr 24, 2017 at 04:43:28PM -0700, Stefan Beller wrote:
>
>> >> On the main list thare is a similar "issue" [1] regarding the 
>> >> expectation for `git checkout`,
>> >> and importantly (for me) these collected views regarding the "Git Data 
>> >> Protection and
>> >> Management Principles" is not within the Git documentation.
>> >
>> > Yes, that's an interesting point. What concerns me is that the commit
>> > c5326bd62b7e168ba1339dacb7ee812d0fe98c7c which introduced this
>> > into checkout isn't consistent with reset. Seems that nobody noticed 
>> > this before.
>>
>> It seems as if we'd want to see the code from
>> c5326bd62b7e168ba1339dacb7ee812d0fe98c7c
>> to be part of any worktree touching command, specifically reset?
>
> Note that that commit is just about "git checkout <commit> -- <paths>".
> The matching reset command, "git reset <commit> -- <paths>" does handle
> this the same way. Or at least I claimed so here:
>
>  http://public-inbox.org/git/20141107081324.GA19845@peff.net/
>
> and that is what I modeled the code in c5326bd62b after.
>
> But note that none of that should ever affect _what_ gets checked out at
> a file or content level. It may only affect the timestamps on the
> resulting files. And I think those timestamps are not something Git
> makes any promises about.

It's not actually clear to users what Git promises in cases like this which 
confuses user expectations - the make file issue does appear to come up 
quite often.
>
> So if Git can elide a write and keep a timestamp up to date, that is a
> great optimization and we should do that. But from an outside viewer's
> perspective, we guarantee nothing. We might choose to rewrite a
> stat-dirty file (updating its timestamp) rather than read its contents
> to see if it might have the same content that we're about to write. And
> the file may look stat dirty only because of the racy-git file/index
> timestamp problem, even if it wasn't actually modified.

I'm not sure how in this case we would get the stat-dirty state? We should 
be able to determine that the file has existed, as originally checked out, 
for some while (i.e. past the racy FS time) and is unmodified, so that as 
long as the original checkout OID and the required new OID are the same we 
should be able to avoid the file overwrite (or merge).

It would require that the now time be used as a stand-in for the new OID 
file's stat time (given the object store doesn't store date stamps for 
files) to check for the racy-git situation. These negative information 
scenarios can be tricky.
>
>> > It also has a similarity to
>> > https://public-inbox.org/git/1492287435.14812.2.camel@gmail.com/ 
>> > regarding
>> > how checkout operates.
>
> I didn't look too deeply into this one, but it really looks like
> somebody caring too much about when git needs to write (and I'd suspect
> it's impacted by the racy-git thing, too).
>
> -Peff
>
--
Philip 

