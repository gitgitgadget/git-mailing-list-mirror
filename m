From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Excessive mmap [was Git server eats all memory]
Date: Wed, 11 Aug 2010 12:35:10 -0400
Message-ID: <AANLkTimi8iS-vdO+=WHEGLQTQuBi75nVUM_eO=oYV+GU@mail.gmail.com>
References: <wesfwyupgrg.fsf@kanis.fr> <AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com> 
	<87ocdhlgbl.fsf@kanis.fr> <AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com> 
	<AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com> 
	<87hbj74pve.fsf@kanis.fr> <AANLkTinyX9cABkEDy3HBZoDVNWos2djNBSaw2Hg_yzAO@mail.gmail.com> 
	<wesy6cgm6wd.fsf_-_@kanis.fr> <AANLkTi=6JcwLuyNWq9oYzE_E+7DSn-sEvR-X3AHvXM6U@mail.gmail.com> 
	<westyn3n3sa.fsf@kanis.fr> <AANLkTiktriuvciNTNPD4941AG3th6rWwUYT4v_UnaAz3@mail.gmail.com> 
	<weshbj1xiav.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	jaredhance@gmail.com, jnareb@gmail.com, git <git@vger.kernel.org>
To: Ivan Kanis <expire-by-2010-08-16@kanis.fr>
X-From: git-owner@vger.kernel.org Wed Aug 11 18:35:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjEHG-0001jp-BN
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 18:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab0HKQfe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 12:35:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54345 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab0HKQfd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 12:35:33 -0400
Received: by wwj40 with SMTP id 40so305620wwj.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vVJ6Ee3i/mGLxqLujT9M3pJXAyraWgyRHXkjqgOwnVY=;
        b=fj0HfQNeh+z6lPmOtBlUuMsDs++L64MAAoSLoOyqWq7zMRQCOSyQBrL8LTDTsOTP+x
         WghEgZLisZ+jURUK0SmaUAs9UJw9+lG3kCt7OFuiMRpLA2RcJGk+gCNerqDHr1JsA7pI
         abm93iqWXVe7IkEmFhZ6HQ2ghlR+fryE1tORE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=PyxthmRtIqAnAt6jpo2llkZGc7xvROgba9xXls5MrWZ29zst1k9O4YDg5liB7ZjqKT
         Iivr5ZJca7elLJNUU6d2jGVk9THUU2HKd0FZoqa7Y/miK4pfcKDXOGEF9X3Ylh6krZDp
         TwZx7ILsszBHoO4Af5AM5eUpxEgEQWDUEwoYQ=
Received: by 10.227.155.70 with SMTP id r6mr16823459wbw.26.1281544531452; Wed, 
	11 Aug 2010 09:35:31 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 11 Aug 2010 09:35:10 -0700 (PDT)
In-Reply-To: <weshbj1xiav.fsf@kanis.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153266>

On Wed, Aug 11, 2010 at 11:47 AM, Ivan Kanis
<expire-by-2010-08-16@kanis.fr> wrote:
> Avery Pennarun <apenwarr@gmail.com> wrote:
>> Now, the kernel is supposed to be smart enough to release old pages
>> out of RSS if you stop using them; it's no different from what the
>> kernel does with any cached file data. =A0So it shouldn't be expensi=
ve
>> to mmap instead of just reading the file.
>
> How can the kernel release old pages? There does not seem to be anywa=
y
> to tell it that it doesn't need a given memory block.

The kernel doesn't care whether you "need" it; it swaps out "needed"
pages all the time.

With a normal dirty memory page (allocated with malloc() or whatever),
the kernel will need to write it out to the swap file before it drops
it from RSS.  Then if the process needs to read/write that page in the
future, it'll have to read it back in from the swap file and increase
RSS again before it can be used.

With mmap'd files it's slightly different.  As long as the page hasn't
been modified (and as far as I know, git never writes to pages of
packfiles) then we already know that page is safe on disk.  So if the
kernel needs to "swap it out", it just drops it immediately from RSS
and doesn't do any I/O.  When/if the process needs to read/write the
page in the future, the kernel can swap it in the way it did in the
first place: from the original file.

If I understand correctly, all this means that the kernel on average
tries to drop mmap'd file pages out of RSS more than other kinds of
dirty pages, because swapping out mmap'd pages is cheaper.

If you think about it, if you do 'cat filename' in a loop, every new
'cat' process needs to load filename into memory. Of course the kernel
doesn't throw away the pages just because cat exits; it keeps a cache
of the file's pages in memory, and just feeds them to the next 'cat'
process when it starts.  So the kernel keeps stuff in memory even if
nobody is currently using it.  The surprising thing (at first) is that
the kernel is also happy to throw away pages even if you *are* using
them, as long as it can get them back.

Swapping is based on how frequently a page is used, not whether that
page is currently mapped into someone's address space.  (Disclaimer: I
haven't read the code.  Maybe it does give higher priority to pages
that are currently mapped.)

>>> Looking some more into it today the bulk of the memory allocation
>>> happens in write_pack_file in the following loop.
>>>
>>> for (; i < nr_objects; i++) {
>>> =A0 =A0if (!write_one(f, objects + i, &offset))
>>> =A0 =A0 =A0 =A0break;
>>> =A0 =A0display_progress(progress_state, written);
>>> }
>>>
>>> This eventually calls write_object, here I am wondering if the
>>> unuse_pack function is doing its job. As far as I can tell it write=
s a
>>> null in memory, that I think is not enough to reclaim memory.
>>
>> What do you mean by the "memory allocation" happens here? =A0How are=
 you
>> measuring it?
>
> I run top and look at the RES column. I put a printf before and after
> the code block and watch the memory go up and up.

Yeah, that's not a very good way to do it.  The problem is that RSS is
*guaranteed* to go up in this location: you've just accessed an mmap'd
page you haven't used before.  That's not a bug.  Furthermore, if
multiple processes are mmap'ing the same pages, *all* those processes
might see their RSS go up, but it's the "same" pages, so that's not
actually taking twice the physical memory.

Unfortunately there are no really reliable ways to track this kind of
memory usage (as far as I know).  The tricks I often use are:

1)  while sleep 1; do free; done

2)  vmstat 1

Command #1 will show you what's happening to your physical RAM.  If
you run one git-repack, do you see the 'free' column decreasing by the
same amount as the RSS increases?  If you run two repacks at once,
does it increase as the sum of the two RSS columns, or just one of
them, or something else?

Command #2 will show you your blocks swapped in and out per second.
The interesting columns are si/so/bi/bo.

>> On the other hand, perhaps a more important question is: why does gi=
t
>> feel like it needs to generate entirely new packs for each person
>> doing a clone on your system? =A0Shouldn't it be reusing existing on=
es
>> and just streaming them straight out to the recipient?
>
> Ah interesting point. Two things make me suspect the mmap is not shar=
ed
> between processes. One is that mmap is done with the MAP_PRIVATE flag
> which according to the man page doesn't share between processes. The
> second is that the mmap is done on a temporary file created by
> odb_mkstemp, I don't believe the name is identical between the two
> processes.

MAP_PRIVATE is a little more complicated than that.  What it means is
that if one of the processes *writes* to one of the pages, the other
process won't see the changes.  But if nobody writes to the pages -
and I'm pretty sure nobody does - then the kernel won't just copy the
data for no reason, because it would be pointlessly inefficient.

That said, you're obviously experiencing bad behaviour, ie. it's not
working like it's supposed to, one way or another.  So you shouldn't
trust that your kernel, or git, or even my explanations are correct :)

Have fun,

Avery
