From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v2 2/2] t/t3308-notes-merge.sh: succeed with relaxed notes refs
Date: Tue, 6 Jan 2015 04:27:34 -0800
Message-ID: <F6072C48-FA50-4F9D-AD26-0B4C4DD64B91@gmail.com>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c> <e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c> <xmqq8uhgqkge.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 13:29:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8TEf-0002Zo-AS
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 13:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbbAFM1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 07:27:39 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:38024 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172AbbAFM1i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 07:27:38 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so30343590pdi.21
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 04:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=XP96/Gtuc140Wv/hQdhomINDsDnNz0SJ6XWtWUr46P0=;
        b=d604kTh8zldltmGOaliNzWFh/mQPYTYJJZbmJF4TKRULLm1gTJLFQko5fd9Hy4VuFP
         ozxMDXwXG3za4EWayvSdm4nOrW/iaPpu3iX1CW49xlARVpodpcIZfv/U0XS/WzSyVWIY
         iorbu5j6lPVCq6L77pYUWziYdZExW59HnVlw41q8wHu0KgZbjtHcKIffRyeSIkTHW5UO
         1EoVuJhM8bvClnww1RJqjc88KJXitQ+4Cwy8ZGJFD9Q4e7m5nzUqmgIgcevCITzQjNDB
         RkRdNiUPQ7tPhXIn9vzO08qRkNj0rIGxFAgBW+XePOatDMDY0o71xLwyk8tmycNGC4JD
         pAtQ==
X-Received: by 10.66.175.205 with SMTP id cc13mr81421272pac.14.1420547257719;
        Tue, 06 Jan 2015 04:27:37 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id nt6sm56965373pdb.26.2015.01.06.04.27.36
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 04:27:37 -0800 (PST)
In-Reply-To: <xmqq8uhgqkge.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262061>

On Jan 6, 2015, at 02:20, Junio C Hamano wrote:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> Now, however, since refs/heads/master exists and the new,
>> more relaxed notes refs rules leave it unchanged, the merge
>> succeeds. ...
>> ...
>> diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
>> index 24d82b49..f0feb64b 100755
>> --- a/t/t3308-notes-merge.sh
>> +++ b/t/t3308-notes-merge.sh
>> @@ -90,7 +90,6 @@ test_expect_success 'fail to merge various non- 
>> note-trees' '
>> 	test_must_fail git notes merge refs/notes/ &&
>> 	test_must_fail git notes merge refs/notes/dir &&
>> 	test_must_fail git notes merge refs/notes/dir/ &&
>> -	test_must_fail git notes merge refs/heads/master &&
>> 	test_must_fail git notes merge x: &&
>> 	test_must_fail git notes merge x:foo &&
>> 	test_must_fail git notes merge foo^{bar
>
> The test title reads "fail to merge non-note trees", and I am
> assuming that the tree-ish refs/heads/master (aka 'master' branch)
> represents does not look anything like a typical note tree where
> pathnames are 40-hex with fan-out.

In fact it looks like this:

100644 blob 2a5d0158a25a97e8ebf4158d9187acb124da50ea	1st.t
100644 blob 3f514b8c0d8e9345bda64de1664eb43d7d38d12a	2nd.t
100644 blob e5404b81e697da4f0c99aac167b5e63bcce4b78b	3rd.t
100644 blob c950fbad52232390031696035ad79c670ee3bd7b	4th.t
100644 blob ba96e617c4d2741ac7693ca7eb20f9dddf4754f6	5th.t

so you are correct.

> The fact that "git notes merge refs/heads/master" fails is a very
> good prevention of end-user mistakes, and this removal of test
> demonstrates that we are dropping a valuable safety.

At the point the dropped line runs, core.notesRef has been set to refs/ 
notes/y which does not exist.

All of the tests in the 'fail to merge various non-note-trees' section  
fail with one of these errors:

   1) Failed to resolve remote notes ref '<ref-being-tested>'

   2) Cannot merge empty notes ref (<ref-being-tested>) into empty  
notes ref (refs/notes/y)

   3) error: object 6c99d48c9905deea5d59d723468862362918626a is a  
tree, not a commit

The 3rd error comes from the "git notes merge x:" attempt.

So despite the name of the test, the actual tree contents do not seem  
to be examined.

When the notes ref checking is relaxed to leave refs/heads/master  
alone rather than turning it into refs/notes/refs/heads/master, the  
previous error (#2 in this case) goes away and since refs/notes/y does  
not exist, it is simply updated to the value of refs/heads/master  
without any checks.  Of course that refs/heads/master tree doesn't  
look like a notes tree.

And if we do this:

   git update-ref refs/notes/refs/heads/master master

Then "git notes merge refs/heads/master" also succeeds without  
complaining that the refs/notes/refs/heads/master tree does not look  
like a notes tree and we didn't need to relax the refs/notes  
restriction and, as you point out, the name of the test seems to imply  
that would be rejected.

Interestingly, if we then attempt to merge refs/notes/x into this non- 
notes refs/notes/y tree, it also succeeds and even keeps the things  
that do not look like notes.  The reverse merge (y into x) succeeds as  
well, but the non-notes stuff in y is not merged in in that case.

> Arguably, not being able to save notes tree anywhere outside of
> refs/notes/ hierarchy may be too high a price to pay in order to
> prevent refs/heads/master from being considered (hence to avoid such
> end-user mistakes), but at the same time, losing this safetly may
> also be too high a price to pay in order to allow people to store
> their notes in somewhere outside e.g. refs/remote-notes/origin/foo.
> "Somewhere outside" does not mean "Including other hierarchies like
> refs/heads and refs/tags that have long established meaning".

If we relax the refs/notes restriction, putting a notes ref in refs/ 
heads/<whatever> doesn't necessarily seem like that's a terrible thing  
as long as it's really a notes tree if used with the notes machinery.   
AIUI, the refs/heads convention only requires the ref to point to the  
tip of a commit chain which all of the refs under refs/notes satisfy.   
The refs/heads convention AIUI does not impose any requirement about  
the contents of the tree(s) those commits in the chain refer to.  But  
at the same time I can't think of any particular reason I'd want to  
store notes refs in there either.

> Although I am not fundamentally against allowing to store notes
> outside refs/notes/, it is different from "anywhere is fine".
> Can't we do this widening in a less damaging way?

Without arbitrarily restricting where notes can be stored it seems to  
me the only option would be to have the notes machinery actually  
inspect the tree of any existing notes ref it's passed.  That would  
also catch the case where "git update-ref refs/notes/refs/heads/master  
master" was run as well.  It also seems like a good check to have in  
place to help catch user errors.

I'm not all that familiar with the notes code, perhaps there's already  
a function that does the tree check to make sure the tree actually  
looks like a notes tree that can easily be called?  Maybe Johan has  
some thoughts on this?

-Kyle
