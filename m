From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Find the starting point of a local branch
Date: Mon, 24 Dec 2012 11:10:23 -0800
Message-ID: <7vbodjnu5c.fsf@alter.siamese.dyndns.org>
References: <20121224035825.GA17203@zuhnb712>
 <201212240409.qBO49wkV020768@no.baka.org>
 <CACsJy8CNd3W_WUMbZ1QZ4ReZ5ziX90QejK9mh1TMs0ig33kGMw@mail.gmail.com>
 <1356327291-ner-6552@calvin>
 <CACsJy8DkA-J+ds1eHBqrRyiZrOigORTtxVeEQpZjGHrBR+QjCQ@mail.gmail.com>
 <7vmwx4newy.fsf@alter.siamese.dyndns.org>
 <CACsJy8DMGrHqgY7himfJA-6f5beZ83Pje+-ex62LQOAARWh=Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>,
	Seth Robertson <in-gitvger@baka.org>,
	Woody Wu <narkewoody@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 20:10:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnDQF-0002v4-Tw
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 20:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab2LXTKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 14:10:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129Ab2LXTK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 14:10:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 122C2AFAD;
	Mon, 24 Dec 2012 14:10:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=euHPrgxcTsafqNDBeG7m7NA/6ak=; b=iVkSLm
	PLb8qJkrNoj1BQPNiBIhmFnaTHKqlEt/xfLRJexrQNyvG4fgOmSnhkzlfi2ZWyRO
	Vpwp9b0NADwKPa1pygMqzgSXwcARg9oqDCngIRmlwpnczUeqNgw+tXH9wD+AJJkY
	rRL7s/h0DTKeSGNI5/j6li1j5Q83jmxNuTNvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CI/yQtnrggUTgnx+kXnVew4IEw/bqMER
	VgMIl1V2lB8Men8ptv6X2j71sh0MV/dbAzIGXwJvwgFUy4l4kL4xsyZ1p82C5pNE
	e0QLc0DIn8aCdA6AUzWdsW8V7QMOcLQSAp9H6Sb9pxgBrW8Yyjufqpz1Fq9uk3As
	OTY7LZ/uOEA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3715AFAB;
	Mon, 24 Dec 2012 14:10:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B900AFAA; Mon, 24 Dec 2012
 14:10:25 -0500 (EST)
In-Reply-To: <CACsJy8DMGrHqgY7himfJA-6f5beZ83Pje+-ex62LQOAARWh=Nw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 24 Dec 2012 18:21:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 926C8E3E-4DFD-11E2-8574-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212115>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Dec 24, 2012 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> On Mon, Dec 24, 2012 at 12:34 PM, Tomas Carnecky
>>> <tomas.carnecky@gmail.com> wrote:
>>>>> Maybe we should store this information. reflog is a perfect place for
>>>>> this, I think. If this information is reliably available, git rebase
>>>>> can be told to "rebase my whole branch" instead of my choosing the
>>>>> base commit for it.
>>>>
>>>> What's the starting point of the branch if I type: git branch foo <commit-ish>?
>>>
>>> You start working off <commit-ish> so I think the starting point would
>>> be <commit-ish>.
>>
>> Yeah, that sounds sensible.  Don't we already have it in the reflog,
>> though?
>
> I looked briefly at reflog before writing my previous mail and noticed
> that when I create a new branch (usually using "git checkout -b branch
> ref") it does not record the base commit.

Hmph.  Perhaps you are referring to something different than what I
think "the base commit" with that word.

    $ git reflog mz/pick-unborn | tail -n 1
    b3cf6f3 mz/pick-unborn@{3}: branch: Created from ko/master

>> What is trickier is when you later transplant it to some other base
>> (perhaps prepare a topic on 'master', realize it should better apply
>> to 'maint' and move it there).  If the user did the transplanting by
>> hand, reflog would probably not have enough information, e.g. after
>>
>>     $ git checkout maint^0
>>     $ git log --oneline master..topic
>>     $ git cherry-pick $one_of_the_commit_names_you_see_in_the_above
>>     $ git cherry-pick $another_commit_name_you_see_in_the_above
>>       ...
>>     $ git branch -f topic
>>
>> no reflog other than HEAD@{} will tell you that you were at maint^0,
>> so the reflog of topic wouldn't know it "forked" from there, either.
>
> We could at least invalidate the recorded base in reflog and let user
> define a new one (I hope).

Please do not even think about going back and rewrite to lose
information.  If the records have full information, you should be
able to reconstruct what you want from it without rewriting.

Even more importantly, wish to "invalidate" indicates that you know
at a newer point that you have more authoritative information than
the older reflog entries, so you should be able to do the moral
equivalent by writing the event as establishing a new base at that
point (e.g. "checkout -B"), and stopping at that point in the reflog
when reading, without losing the older reflog entries.
