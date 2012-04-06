From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [GSoC] Designing a faster index format
Date: Fri, 6 Apr 2012 10:56:38 -0700
Message-ID: <CAJo=hJu_6zW3X8WtHVC6P5k14muGM_t4w_cU7Em+Y_ogJm91eA@mail.gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
 <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
 <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
 <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
 <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
 <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com>
 <7vk423qfps.fsf@alter.siamese.dyndns.org> <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com>
 <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com> <4F7ABA19.7040408@alum.mit.edu>
 <C15BAB9A-EAFA-4EA4-85B2-0E0C5FF473E9@gmail.com> <alpine.DEB.2.02.1204031313170.10782@asgard.lang.hm>
 <D97085E6-2B9F-42C5-A06D-B53422034071@gmail.com> <87r4w1vofu.fsf@thomas.inf.ethz.ch>
 <CAJo=hJssfTvGqzQtaAj+Dk_R2oU5BwY=sQQuH3=SFTf+Zcp=3A@mail.gmail.com>
 <CACsJy8DaBxCtU7UQcc510J71zk95DMMsWdr9S3eYTupdRLjWBg@mail.gmail.com>
 <878vi8sx1x.fsf@thomas.inf.ethz.ch> <CACsJy8AkFiiaKnqqyLEZfa+DJsRyKd6dGEN71c3q=6j3fo8jww@mail.gmail.com>
 <CAJo=hJsfXd8J3ndLTMSUFRaH4FG+4YDXdnfFZ13bC+hoA3GE8g@mail.gmail.com> <CACsJy8A2AKApvWJ4JqQn0e=KE1-bx_A9cmCCLxG4A7VkeOrRsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Thomas Gummerer <italyhockeyfeed@gmail.com>, david@lang.hm,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 19:57:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGDPJ-0006iT-9J
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 19:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab2DFR5B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 13:57:01 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:58713 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab2DFR5A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 13:57:00 -0400
Received: by dake40 with SMTP id e40so2996784dak.11
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9HFcIE2UsaJsIqJuMkyST+r/Ufx82bPFaQII/a+YPWY=;
        b=IGwAlJVkjg3KMUnz37/AmVN88XSWCffR3xY1zPtrPDVqMYts84INdN2U5DCTZgP8OR
         zE46CkKInF7AK/E42ydbgREjaeQlBjXzIGW7vZmuqLD2LWNeN8iDZeJvnq9JFGurFnfO
         NzQEqDpSd4AQl0eygoWphMnOPqIrXtkM2FL30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=9HFcIE2UsaJsIqJuMkyST+r/Ufx82bPFaQII/a+YPWY=;
        b=jYmzC/CTXevVi2Q52rMwduqz1N/iU97OmRyAXfNkGocZJm5tilQeV+d9+2zzgLz7/2
         jghyBERgm3AHcpt63lPCX2yxyN7Us4gst2Ln8u0JOI0zSbc/MuAPM++QBYQPxijPZbXr
         ZIz/bOuhwD36bPD88o3TDL8g5WqNQ+kCTN9llvd1yJ3s7cbhuNQoHM/KoUNgjYb2sisH
         5jnlJtYMthBrfc6lfiylHQcVdEeVg0VERPuY4Lq3oXGFRM/G/V5CmKZoxeMFWlhsUtJN
         aOlEonu0uYoG1QdNHYs3F1u4zddlFnDRVCCjWNs0+m8t2xqsaumydJZOC4f2tJ1YoZGb
         NL8w==
Received: by 10.68.194.227 with SMTP id hz3mr18137305pbc.23.1333735019379;
 Fri, 06 Apr 2012 10:56:59 -0700 (PDT)
Received: by 10.68.55.68 with HTTP; Fri, 6 Apr 2012 10:56:38 -0700 (PDT)
In-Reply-To: <CACsJy8A2AKApvWJ4JqQn0e=KE1-bx_A9cmCCLxG4A7VkeOrRsg@mail.gmail.com>
X-Gm-Message-State: ALoCoQniqATtfqQ7zEGHs44zF/JktVeWU53Y0j4bU2RiorST3nSbSf3WONGHRshgj5dgJQSyZd+B
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194887>

On Fri, Apr 6, 2012 at 10:23, Nguyen Thai Ngoc Duy <pclouds@gmail.com> =
wrote:
> On Sat, Apr 7, 2012 at 12:13 AM, Shawn Pearce <spearce@spearce.org> w=
rote:
>> On Fri, Apr 6, 2012 at 08:44, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
>>> On Fri, Apr 6, 2012 at 10:24 PM, Thomas Rast <trast@student.ethz.ch=
> wrote:
>>>> But even so: do we make any promises that (say) git-add is atomic =
in the
>>>> sense that a reader always gets the before-update results or the
>>>> after-update results? =A0Non-builtins (e.g. git add -p) may make s=
mall
>>>> incremental updates to the index, so they wouldn't be atomic anywa=
y.
>>>
>>> Take git-checkout. I'm ok with it writing to worktree all old entri=
es,
>>> or all new ones, but please not a mix.
>>
>> Why, what is the big deal? git-checkout has already written the file
>> to the local working tree. Its now just reflecting the updated stat
>> information in the index. If it does that after each file was touche=
d,
>> and it aborts, you still have a partially updated working tree and t=
he
>> index will show some updated files as stat clean, but staged relativ=
e
>> to HEAD. I don't think that is any better or worse than the current
>> situation where the working tree is shown as locally dirty but the
>> index has no staged files. Either way you have an aborted checkout t=
o
>> recover from by retrying, or git reset --hard HEAD.
>>
>> In the retry case, checkout actually has less to do because the file=
s
>> it already cleanly updated match where its going, and thus it doesn'=
t
>> have to touch them again.
>
> OK, what about git-commit? If I read your description correctly, you
> can update entry sha-1 in place =A0too.

Yes.

> Running cache-tree on half old
> half new index definitely creates a broken commit.

How is that possible? Each tree also has its own SHA-1 field. A
process trying to update a tree's SHA-1 will have to snapshot the
tree's contents from the index by copying the data into its own memory
buffer so it can compute the canonical tree data buffer, write the
object to the repository, and get the tree's SHA-1. It writes that
tree's SHA-1 back to the index as of that snapshot. If there were
concurrent updates at the same time as git commit running, its the
same race condition that already exists. You don't know exactly where
in the execution of `git commit` it takes the snapshot of the index
that it uses to make the commit by opening the file. Allowing in place
updates means the snapshot time within git commit expands to be a
larger portion of its running time.

Basically I would argue it is already not safe to be modifying the
index while git commit is running. You don't know if git commit has
already opened the index file, or will open it after the edit. The
only way to be sure right now is to make your own copy of the index
and use GIT_INDEX_FILE environment variable to make sure git commit
uses the exact index you want.

> A command can also read (which does not require lock), update its
> internal index, then lock and write. At that time, it may accidentall=
y
> overwrite whatever another command wrote while it was still preparing
> the index in memory.

This hypothetical command already has the bug you mention. It should
be fixed no matter what we do with regards to the index format.

The *only* safe way to update the index and prevent losing
modifications made by another process is to lock the index *then* read
it, update, write back out. If you read before you take the write
lock, you can discard edits made by another process. This is
preciously the reason why the JGit library always opens, reads, then
closes the index anytime the process wants to access an entry. We need
to make sure we are viewing the correct current version. Its even more
critical when the process wants to update the index, it *must* discard
any in-memory cached data it has and re-read the index *after* the
write lock has been successfully acquired.


IMHO the risks to the update in place approach is a few things, but
none of them really are a problem:

*  Readers *must* use the retry algorithm when looking at each record
anytime the CRC-32 on an individual entry doesn't match. Retry
requires using some form of backoff, because the concurrent writer
needs to be given time to finish the writes to the storage file. If a
reader doesn't correctly implement a retry, they could see corruption.

*  Readers *must* check the CRC-32 of any entry. In fact the best way
to read an entry is memcpy() the entry's stat/SHA-1/CRC-32 from the
index into another memory buffer, compute the checksum there, and
compare. This way the reader can be certain the entry isn't mutated
after it checked the CRC-32 but before it examined a particular stat
field. Again a buggy implementation reading from the index might not
implement this strategy and complain about corruption, or silently
process data with corruption.

*  A partial write will leave a corrupted index. E.g. a process
writing a record is killed before it has a chance to fully write out
the record's data. Nobody can read that record until it is repaired.
Repair should be possible with a combination of git reset --soft to
copy the SHA-1 from HEAD and recomputing the working tree's SHA-1 to
see if the file is really clean or not. It probably isn't, and the
stat data will reflect it as dirty after the repair. We may have to
put this sort of repair logic into `git status` and `git diff` as part
of the normal "fix clean stat" pass.

*  Appending conflicting stage information to the end of the file
during a merge can be risky. The append might be partial. This can be
fixed by the user by `git reset --hard HEAD` to abort the merge. A
partial append is probably only likely when the git merge aborted
anyway and hasn't even really left you with a sane state to try and
resolve conflicts in.

*  Truncating away the conflicting stage information on the end of the
file can be risky, if the file system doesn't truncate back correctly.
But I think we can detect this and repair. If every record has a
"conflict" bit set to 0 and all records CRC-32s are valid, and we hold
the write lock, we know any conflict data on the end is bogus and
should be truncated away, so we truncate again. If truncation isn't
working correctly on this filesystem, we rewrite the entire index
file.
