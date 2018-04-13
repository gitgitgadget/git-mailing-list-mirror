Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7011F404
	for <e@80x24.org>; Fri, 13 Apr 2018 15:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750928AbeDMPnr (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 11:43:47 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:44543 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeDMPnp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 11:43:45 -0400
Received: from [192.168.2.240] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 70rWfYaJcLjjA70rWfURlm; Fri, 13 Apr 2018 16:43:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1523634224;
        bh=t9aJP8BvrSwrxvbWNv2l76FBt2Qm2yJlQdMYxAvURQs=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=d/JVoD8zCdcUGKESeU6IqOYucknbcpfsFROM/KD/kpA9GGMqtVT/EroV6/1l9nrc2
         TVEnJWLhHu2gRl196CAFukYLyrivyebKpjHY+3d9HrK6b29XrsNW4h73HNFirYjb8e
         Hb5eeYtsqgqydrfD6fTPTc2XU8Ekab4qRdLfy98k=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=LZYSFAXi c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=AkmPnPzE2atkMmSiarsA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de> <87tvsj6rn2.fsf@javad.com>
 <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <871sfm737e.fsf@javad.com>
 <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87h8oh51jm.fsf@javad.com>
 <CA+P7+xq8KJKJ0d1unW3btUhKVjOZM3EdTSKdDs96pn5J3WwSKA@mail.gmail.com>
 <87sh810ym4.fsf@javad.com>
 <CA+P7+xq8LOUZxVd832cOQFi4V=2YvydxtT6_y4NLKvFkki4QdA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804130002090.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <5d522cc9-3922-9f24-3a1e-0c121c47ca96@talktalk.net>
Date:   Fri, 13 Apr 2018 16:43:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1804130002090.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKCDzH043NLx8AvRsVrtrLKKELXHg4GLVArfKBSEOrBANLBmNUsGsIQp7WyETgthjE8U2Exk27/Kci7Qw13cDXOuU/tLz6sdjQRbN1520DGXkSP3XnQT
 YuTFa1hDtjV13NGXONzwTn1hRO0w/5uToBGBF7fL8bTUPsoyOqTZ+oW83/mByB4+0zfz7WXGRFcIQ0wn97cDym+u+U+hcRhgR4nqarr5P83z8UH/9etn+Vo5
 dGrrgft1GefF0LXBDxMPB3xEjzaTDqTvTpe/2XEp9totHTISawmb3SiCYq+bdNAy8v1YI0O81QSC1ZCm1FYvswrJ6Ufy2qH/O8I5nR7WL62ZfgP8LMvF9e0h
 qkcpz5buob9Mqh31QcL5sVMbbrM6E6EfZ4Iy3GyL8CpkzLh8C6GAl+SZ9WyudHSkP3zz9K9xaTtnvLEHJNWjrhck2g0dhDEiqXAEFpxQo77PloBWGMkizlAb
 bGTSMuMgdkPkdwg0lxhCCxF5D/11bHmQPUSMig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/04/18 23:02, Johannes Schindelin wrote:
> Hi Jake,
> 
> On Thu, 12 Apr 2018, Jacob Keller wrote:
> 
>> On Wed, Apr 11, 2018 at 10:42 PM, Sergey Organov <sorganov@gmail.com> wrote:
>>>
>>> Jacob Keller <jacob.keller@gmail.com> writes:
>>>> On Wed, Apr 11, 2018 at 6:13 AM, Sergey Organov <sorganov@gmail.com> wrote:
>>>>> It was rather --recreate-merges just a few weeks ago, and I've seen
>>>>> nobody actually commented either in favor or against the
>>>>> --rebase-merges.
>>>>>
>>>>> git rebase --rebase-merges
>>>>
>>>> I'm going to jump in here and say that *I* prefer --rebase-merges, as
>>>> it clearly mentions merge commits (which is the thing that changes).
>>>
>>> OK, thanks, it's fair and the first argument in favor of
>>> --rebase-merges I see.
>>
>> I'd be ok with "--keep-merges" also.
> 
> My main argument against --keep-merges is that there is no good short
> option for it: -k and -m are already taken. And I really like my `git
> rebase -kir` now...
> 
> A minor argument in favor of `--rebase-merges` vs `--keep-merges` is that
> we do not really keep the merge commits, we rewrite them. In the version
> as per this here patch series, we really create recursive merges from
> scratch.
> 
> In the later patch series on which I am working, we use a variation of
> Phillip's strategy which can be construed as a generalization of the
> cherry-pick to include merges: for a cherry-pick, we perform a 3-way merge
> between the commit and HEAD, with the commit's parent commit as merge
> base. With Phillip's strategy, we perform a 3-way merge between the merge
> commit and HEAD (i.e. the rebased first parent), with the merge commit's
> first parent as merge base, followed by a 3-way merge with the rebased
> 2nd parent (with the original 2nd parent as merge base), etc
> 
> However. This strategy, while it performed well in my initial tests (and
> in Buga's initial tests, too), *does* involve more than one 3-way merge,
> and therefore it risks something very, very nasty: *nested* merge
> conflicts.
> 
> Now, I did see nested merge conflicts in the past, very rarely, but that
> can happen, when two developers criss-cross merge each others' `master`
> branch and are really happy to perform invasive changes that our merge
> does not deal well with, such as indentation changes.
> 
> When rebasing a merge conflict, however, such nested conflicts can happen
> relatively easily. Not rare at all.
> 
> I found out about this by doing what I keep preaching in this thred:
> theory is often very nice *right* until the point where it hits reality,
> and then frequently turns really useless, real quickly. Theoretical
> musings can therefore be an utter waste of time, unless accompanied by
> concrete examples.

Exactly (that's one reason I've been keeping a low profile on this 
thread since my initial suggestion - I haven't had time to test out any 
examples). Thanks for taking the time to test out the theory

> To start, I built on the example for an "evil merge" that I gave already
> in the very beginning of this insanely chatty thread: if one branch
> changes the signature of a function, and a second branch adds a caller to
> that function, then by necessity a merge between those two branches has to
> change the caller to accommodate the signature change. Otherwise it would
> end up in a broken state.
> 
> In my `sequencer-shears` branch at https://github.com/dscho/git, I added
> this as a test case, where I start out with a main.c containing a single
> function called core(). I then create one branch where this function is
> renamed to hi(), and another branch where the function caller() is added
> that calls core(). Then I merge both, amending the merge commit so that
> caller() now calls hi(). So this is the main.c after merging:
> 
> 	int hi(void) {
> 		printf("Hello, world!\n");
> 	}
> 	/* caller */
> 	void caller(void) {
> 		hi();
> 	}
> 
> To create the kind of problems that are all too common in my daily work
> (seemingly every time some stable patch in Git for Windows gets
> upstreamed, it changes into an incompatible version, causing merge
> conflicts, and sometimes not only that... but I digress...), I then added
> an "upstream" where some maintainer decided that core() is better called
> greeting(), and also that a placeholder function for an event loop should
> be added. So in upstream, main.c looks like this:
> 
> 	int greeting(void) {
> 		printf("Hello, world!\n");
> 	}
> 	/* main event loop */
> 	void event_loop(void) {
> 		/* TODO: place holder for now */
> 	}
> 
> Keep in mind: while this is a minimal example of disagreeing changes that
> may look unrealistic, in practice this is the exact type of problem I am
> dealing with on a daily basis, in Git for Windows as well as in GVFS Git
> (which adds a thicket of branches on top of Git for Windows) and with the
> MSYS2 runtime (where Git for Windows stacks patches on top of MSYs2, which
> in turn maintains their set of patches on top of the Cygwin runtime), and
> with BusyBox, and probably other projects I forgot spontaneously. This
> makes me convinced that this is the exact type of problem that will
> challenge whatever --rebase-merges has to deal with, or better put: what
> the user of --rebase-merges will have to deal with.
> 
> (If I got a penny for every merge conflict I resolved, where test cases
> were appended to files in t/, I'd probably be rich by now. Likewise, the
> `const char *` -> `struct object_oid *` conflicts have gotten to a point
> where I can resolve them while chatting to somebody.)
> 
> Now, rebasing the original patches above (renaming core() to hi(), and
> adding caller()) will obviously conflict with those upstream patches
> (renaming core() to greeting(), and adding event_loop()). That cannot be
> avoided. In the example above, I decided to override upstream's decision
> by insisting on the name hi(), and resolving the other merge conflict by
> adding *both* event_loop() and caller().
> 
> The big trick, now, is to avoid forcing the user to resolve the same
> conflicts *again* when the merge commit is rebased. The better we can help
> the user here, the more powerful will this mode be.
> 
> But here, Phillip's strategy (as implemented by yours truly) runs this
> problem:
> 
> 	int hi(void) {
> 		printf("Hello, world!\n");
> 	}
> 	<<<<<<< intermediate merge
> 	<<<<<<< HEAD
> 	/* main event loop */
> 	void event_loop(void) {
> 		/* TODO: place holder for now */
> 	=======
> 	=======
> 	}
> 	>>>>>>> <HASH>... merge head #1
> 	/* caller */
> 	void caller(void) {
> 		hi();
> 	>>>>>>> <HASH>... original merge
> 	}
> 
> Now, no matter who I ask, everybody so far agreed with me that this looks
> bad. Like, really bad. There are two merge conflicts, obviously, but it is
> not even clear which conflict markers belong together!
> 
> It gets a little better when I take a page out of recursive merge's
> playbook, which uses different marker sizes for nested merge conflicts
> (which I of course implemented and pushed to `sequencer-shears`, currently
> still in an unpolished state):
> 
> 	int hi(void) {
> 		printf("Hello, world!\n");
> 	}
> 	<<<<<<< intermediate merge
> 	<<<<<<<< HEAD
> 	/* main event loop */
> 	void event_loop(void) {
> 		/* TODO: place holder for now */
> 	========
> 	=======
> 	}
> 	>>>>>>> <HASH>... merge head #1
> 	/* caller */
> 	void caller(void) {
> 		hi();
> 	>>>>>>>> <HASH>... original merge
> 	}
> 
> At least now we understand which conflict markers belong together. But I
> still needed to inspect the intermediate states to understand what is
> going on:
> 
> After the first 3-way merge (the one between the original merge commit and
> HEAD), we have the conflict markers around event_loop() and caller(),
> because they had been added into the same spot.
> 
> The second 3-way merge would also want to add the event_loop(), but not
> caller(), so ideally it should see that event_loop() is already there and
> not add any conflict markers. But that is not the case: event_loop() was
> added *with conflict markers*.
> 
> So those conflict markers in the first 3-way merge *cause* the conflicts
> in the second 3-way merge!
> 
> And indeed, if we merge the other way round (original merge with 2nd
> parent, then with 1st parent), the result looks much better:
> 
> 	int hi(void) {
> 		printf("Hello, world!\n");
> 	}
> 	/* main event loop */
> 	void event_loop(void) {
> 		/* TODO: place holder for now */
> 	}
> 	<<<<<<<< HEAD
> 	========
> 	/* caller */
> 	void caller(void) {
> 		hi();
> 	}
> 	>>>>>>>> <HASH>... intermediate merge
> 
> So: the order of the 3-way merges does matter.
> 
> I did implement this, too, in the `sequencer_shears` branch: if the first
> 3-way merge causes conflicts, attempt the second one, and if that one is
> clean, try merging that merge result into HEAD (forgetting about the first
> attempted 3-way merge).
> 
> That is still unsatisfying, though, as it is easy to come up with a
> main2.c in the above example that requires the *opposite* merge order to
> avoid nested conflicts.
> 
> The only way out I can see is to implement some sort of "W merge" or
> "chandelier merge" that can perform an N-way merge between one revision
> and N-1 other revisions (each of the N-1 bringing its own merge base). I
> call them "W" or "chandelier" because such a merge can be visualized by
> the original merge commit being the center of a chandelier, and each arm
> representing one of the N-1 merge heads with their own merge bases.
> 
> Similar to the 3-way merge we have implemented in xdiff/xmerge.c, this
> "chandelier merge" would then generate the two diffs between merge base
> and both merge heads, except not only one time, but N-1 times. It would
> then iterate through all hunks ordered by file name and line range. Any
> hunk without conflicting changes would be applied as-is, and the remaining
> ones be turned into conflicts (handling those chandelier arms first where
> both diffs' hunks look identical).
> 
> Have I missed any simpler alternative?

Those conflicts certainly look intimidating (and the ones in your later 
reply with the N way merge example still look quite complicated). One 
option would be just to stop and have the user resolve the conflicts 
after each conflicting 3-way merge rather than at the end of all the 
merges. There are some downsides: there would need to be a way to 
explain to the user that this is an intermediate step (and what that 
step was); the code would have to do some book keeping to know where it 
had got to; and it would stop and prompt the user to resolve conflicts 
more often which could be annoying but hopefully they'd be clearer to 
resolve because they weren't nested.

Best Wishes

Phillip

> 
> Ciao,
> Johannes
> 

