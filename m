From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 5.5/22] Add documentation for the index api
Date: Thu, 11 Jul 2013 13:30:10 +0200
Message-ID: <87ppupcp19.fsf@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-6-git-send-email-t.gummerer@gmail.com> <CACsJy8C0F+v3g+gPon6Y8+z7ObN1Jv8Ln==RNrVsRp7aya74hw@mail.gmail.com> <87pputqowr.fsf@gmail.com> <CACsJy8CtOWjpxKuNhQXYjPAv8MU0U6yTBEuQeqm0kxqVne6NjQ@mail.gmail.com> <871u78rcw0.fsf@gmail.com> <CACsJy8A9+1O_em=FtV_TUKags4FrSggV76dd1h6gsJ+JHfjZKw@mail.gmail.com> <87wqozpk9s.fsf@gmail.com> <CACsJy8BRw6jqB1XBzDcCr3UXNGG1wRPjwnMrh+EksFf7VsQysg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 13:30:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxF4o-0001xZ-3Q
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 13:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593Ab3GKLaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 07:30:16 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:44360 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab3GKLaP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 07:30:15 -0400
Received: by mail-ee0-f42.google.com with SMTP id c4so5472469eek.29
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 04:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=ARPwsE/JrcZPUCqrsX5xIauTdTB9NKrBlUMGgu9A5qM=;
        b=ckkOW+eChTAeN+SpPLlONh3f+AJMhXKjfG1zqN3RkHzS3jOYDZulmKZJqa7p4bNzbC
         i3XpyOgYy9c+MKNqgNG2imGmU/VvAEBQEvLTy5p3Nra7E9Ib9jLPmybyXkTjSlzAH+Ab
         Q/PK8YOAcbVmWHJiV3RIdR/H6DRSQo+tSKXCFYyubUn9dy+036q14iqj7Nudt2QzELlR
         XaD3p+TyqS8jLieai/l6XZGG7t9qa6divo+2L4sc1m1wA+yu/dGXZM/v4RERHTkKzfT/
         /pPTtVmrK4XoFYhqWZN5xBg9qUdFpx7sg32cQuDRUGwKc3BodueIOl+m8eUMhyjbAB+6
         oU3w==
X-Received: by 10.14.47.196 with SMTP id t44mr30213918eeb.18.1373542213483;
        Thu, 11 Jul 2013 04:30:13 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id e44sm68260476eeh.11.2013.07.11.04.30.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 04:30:12 -0700 (PDT)
In-Reply-To: <CACsJy8BRw6jqB1XBzDcCr3UXNGG1wRPjwnMrh+EksFf7VsQysg@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230090>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jul 10, 2013 at 3:10 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>> If you happen to know that certain entries match the given pathspec,
>>> you could help the caller avoid match_pathspec'ing again by set a bit
>>> in ce_flags.
>>
>> I currently don't know which entries do match the pathspec from just
>> reading the index file, additional calls would be needed.  I don't think
>> that would be worth the overhead.
>
> Yeah I now see that you select what to load in v5 with the adjusted
> pathspec, not the input pathspec. Originally I thought you match the
> input pathspec against every file entry in the index :P Your adjusted
> pathspec looks like what common_prefix is for. It's cheaper than
> creating adjusted_pathspec from match_pathspec and reduces loading in
> major cases, where glob is not used.
>
> Still, creating an adjusted pathspec this way looks iffy. You need to
> understand pathspec in order to strip the filename part out to match
> the directory match only. An alternative is use
> tree_entry_interesting. It goes along well with tree traversal and can
> be used to match directories with original pathspec. Once you see it
> matches an entry in a directory, you could skip matching the rest of
> the files and load the whole directory. read_index_filtered_v5 and
> read_entries may need some tweaking though. I'll try it and post a
> patch later if I succeed.

Hrm, I played around a bit with this idea, but I couldn't figure out how
to make it work.  For it to work we would still have to load some
entries in a directory at least?  Or is there a way to match the
directories, which I just haven't figured out yet?

>>> To know which entry exists in the index and which is
>>> new, use another flag. Most reader code won't change if we do it this
>>> way, all match_pathspec() remain where they are.
>>
>> Hrm you mean to know which cache entries are added (or changed) in the
>> in-memory index and will have to be written later?  I'm not sure I
>> understand correctly what you mean here.
>
> Oh.. The "to know.." sentence was nonsense. We probably don't need to
> know. We may track changed entries for partial writing, but let's
> leave that out for now.

Ok, makes sense.

>>>> +`index_change_filter_opts(opts)`::
>>>> +       This function again has a slightly different functionality for
>>>> +       index-v2 and index-v5.
>>>> +
>>>> +       For index-v2 it simply changes the filter_opts, so
>>>> +       for_each_index_entry uses the changed index_opts, to iterate
>>>> +       over a different set of cache entries.
>>>> +
>>>> +       For index-v5 it refreshes the index if the filter_opts have
>>>> +       changed and sets the new filter_opts in the index state, again
>>>> +       to iterate over a different set of cache entries as with
>>>> +       index-v2.
>>>> +
>>>> +       This has some optimization potential, in the case that the
>>>> +       opts get stricter (less of the index should be read) it
>>>> +       doesn't have to reload anything, but currently does.
>>>
>>> The only use case I see so far is converting a partial index_state
>>> back to a full one. Apart from doing so in order to write the new
>>> index, I think some operation (like rename tracking in diff or
>>> unpack-trees) may expect full index. I think we should support that. I
>>> doubt we need to change pathspec to something different than the one
>>> we used to load the index. When a user passes a pathspec to a command,
>>> the user expects the command to operate on that set only, not outside.
>>
>> One application was in ls-files, where we strip the trailing slash from
>> the pathspecs for submodules.  But when we let the caller filter the
>> rest out it's not needed anymore.  We load all entries without the
>> trailing slash anyway.
>
> That submodule trailing slash stripping code will be moved away soon
> (I've been working on it for some time now). There's similar code in
> pathspec.c. I hope by the time this series becomes a candidate for
> 'next', those pathspec manipulation is already gone. For
> strip_trailing_slash_from_submodules, peeking in index file for a few
> entries is probably ok. For check_path_for_gitlink, full index is
> loaded until we figure out a clever way.

Ah great, for now I'll just not use the for_each_index_entry function in
ls-files, and then change the code later once the stripping code is
moved away.

>>> Some thoughts about the writing api.
>>>
>>> In think we should avoid automatically converting partial index into a
>>> full one before writing. Push that back to the caller and die() when
>>> asked to update partial index. They know at what point the index may
>>> be updated and even what part of it may be updated. I think all
>>> commands fall into two categories, tree-wide updates (merge,
>>> checkout...) and limited by the user-given pathspec. "what part to be
>>> updated" is not so hard to determine.
>>
>> Hrm this is only true if index entries are added or removed, not if they
>> are only changed.  If they are only changed we can write a partially
>> read index once we have partial writing.
>
> Yep. We can detect if changes are updates only, no additions nor
> removals. If so do partial write, else full write. These little
> details are hidden from the user, as long as they keep their promise
> about read/write regions.
>
>> For now it would make sense to just die() though, until we have that in place.
>
> Agreed.
> --
> Duy
