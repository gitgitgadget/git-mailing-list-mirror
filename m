From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Fri, 13 Jun 2014 12:05:09 -0700
Message-ID: <CAL=YDWnHubbC3eOUjHtbiddG0HiaNUW13=GRMXKfyxB+Yomq_g@mail.gmail.com>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>
	<xmqqa99h6hbh.fsf@gitster.dls.corp.google.com>
	<CAL=YDW=xn0OG5vu=9fnP0nycKV0F9bDJLrkYiwmL9P9q79LJSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 21:05:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvWnC-0003K1-7K
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 21:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbaFMTFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 15:05:12 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:59366 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbaFMTFK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 15:05:10 -0400
Received: by mail-vc0-f175.google.com with SMTP id hy4so2687347vcb.20
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a/LJ463zuAtZMaDgFaibX0695TL1sjqGUVQXVbRmk6E=;
        b=Txbn6BO9v0co79MHWraivuxYGkL5tObf9wn4V+6Kg112nbVF/VUPXQZ2ZHlELTnzkB
         JPYA8nz2mDZwXSl5hW0SNPH7lLscouNbi8CV1JSkn/hFShoZTfPUq/NWqWSedm9l1Q6C
         Y1Wbr7vt25v24OucNSGB987XChlRXhFrXAVUJ1/eMCBq7N06WsSZlxbr1UiHzqb+dt8s
         SyBxuiQJLoLE2TB6c19DGtETRWFIbxgaEs1DMZiHUWpxjjsfMlUAckFs4ZV9jkfEgIyD
         Oa1wJHlhVmmIMiJjNeXeu/39l9YMN8bwxTXgB+meP80BEkoplmn5R8O9FRiqlgNu5L7O
         Dg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=a/LJ463zuAtZMaDgFaibX0695TL1sjqGUVQXVbRmk6E=;
        b=eMqlt/O0kDFr23+b70D1t9jLW/5tqr+x4hH90jHB76wIFkrK/Z51dghvB+1vlvvlBy
         36q6puk56jC9osUcHtzqbFdaKwhOHRhhmgp6hZenTtDfa3rTS2Ii7gAcoOdK8Kk+Cohf
         ZKyum+CvkpvM+IcosTIoigT/MkQxNOg16d7QvpVaM2sWqxtj2AU0kpQlXmDRTcPdMGQb
         mXlhYkAD1rOPqc7ruQnkNXNyW1tjuARkWZU4Zk+59zfxwVr9TBgyI9ZG6FUJIVpkl+TS
         Pr1Ily36US3QLOt+DeZDZ+JNGcLOaKutl4j2XySRw5+tNfYtdcqVXEaU+6BtOej8V7Tq
         DVqQ==
X-Gm-Message-State: ALoCoQl2x6LXPLe2TLBbjJW67qLxNFLyZKcA5bES3yssZ6EATvp1//QGhKE4JoHS3XSofb432khp
X-Received: by 10.52.241.98 with SMTP id wh2mr2011522vdc.37.1402686309805;
 Fri, 13 Jun 2014 12:05:09 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Fri, 13 Jun 2014 12:05:09 -0700 (PDT)
In-Reply-To: <CAL=YDW=xn0OG5vu=9fnP0nycKV0F9bDJLrkYiwmL9P9q79LJSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251629>

Thinking about it more.

I think we want to wait until the ref transaction API work is
finished. The ref transactions API is in progress and it aims to add
transactions for ref updates as a first step but then it aims to
define a public API for all public ref functions. As part of that I
will also develop support for pluggable ref backends. The first
backend will be the current files based structure but I also will add
an optional backend using a TDB database.

That means that on mac you could just use "core.refs_backend = tdb"
and you would have full support for case sensitive refs. With that
backend "refs/heads/A/foo" would no longer be a file but a key to a
row in the TDB database. I.e. no need to do anything at all, just wait
until my refs work is finished and yourt problem is gone :-)


Alternatively, if you don't want a TDB database and you REALLY want to
keep storing the refs as files, just as they are today, that would be
very easy to do too once the refs work is finished.

Each refs backend will be defined by a set of methods.
struct ref_be refs_files = {
   .transaction_create_sha1 = files_transaction_create_sha1,
   ...

You could then very easily create a new backend, say 'struct refs_be
refs_files_case_insensitive' where the methods would just convert any
refnames to/from a case insensitive encoding before invoking the
default methods from the files backend.
Perhaps something as simple as converting any upper case characters
to/from '%xx' representation when accessing the actual files.



On Fri, Jun 13, 2014 at 11:20 AM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> On Thu, Jun 12, 2014 at 12:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> David Turner <dturner@twopensource.com> writes:
>>
>>> This issue bit us again recently.
>>>
>>> In talking with some colleagues, I realized that the previous version
>>> of this patch, in addition to being potentially slow, was incomplete.
>>> Specifically, it didn't handle the case of refs/heads/case/one vs
>>> refs/heads/CASE/two; these are case clones even though they strcasecmp
>>> different.
>>
>> Good catch to realize that two refs that share leading paths that
>> are the same except for cases are also problematic, but that makes
>> this feature even less about "case clones", doesn't it?
>>
>> Also it somehow feels that the patch attempts to solve the issue at
>> a wrong level.
>>  On a platform that cannot represent two refs like
>> these (e.g. trying to create "FOO" when "foo" already exists, or
>> trying to create "a/c" when "A/b" already exists---ending up with
>> "A/c" instead, which is not what the user wanted to create), would
>> it be more sensible to fail the ref creation without touching the
>> users of ref API such as receive-pack?  That way, you would also
>> catch other uses of refs that are not supported on your system,
>> e.g. "git branch a/c" when there already is a branch called "A/b",
>> no?
>
> It gets even more hairy :
> If the server has A/a and a/b and you clone it it becomes A/a and A/b
> locally. Then you push back to the server and you end up with three
> refs on the server:  A/a A/b and a/b.
> Or what we end up with locally could either be a/a  and a/b or A/a and
> A/b depending on which order the server sends the refs back.
> Since the ordering I think is not formally defined, is it?, this could
> mean that we would end up with something but it would be difficult to
> deteministically decide what the outcome would be.
> As the refs handling is pretty complex as is I think we want to avoid
> adding undeterministic residuals after a clone/fetch/* has failed.
>
> That then IMHO means that we should wait with implementing something
> until we have finished the ref API rewrite. If nothing else, having
> atomic transactions would mean that
> when things fail due to case collissions we would have a deterministic
> outcome : transaction failed so nothing was created locally.
>
>
>
> But I think this is the wrong level to solve this issue at.
> receive-pack.c is only one out of many place where I think this would
> come into effect.
> You also have reflogs, remotes and all sorts of other things that
> would have to be fixed up.
>
> If we want to add this kind check-fails, we should wait until after we
> have ref transactions because then we will have one single path,
> transaction_update_sha1(), through which every ref creation/update
> will have to pass. and thus then we have one single place where such a
> check-fail could cover all cases of ref creations.
>
>
>
>
>>
>> CC'ing those who are more active in the ref API area recently than I
>> am for their inputs.
