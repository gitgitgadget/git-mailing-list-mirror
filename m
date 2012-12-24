From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Find the starting point of a local branch
Date: Sun, 23 Dec 2012 22:27:09 -0800
Message-ID: <7vmwx4newy.fsf@alter.siamese.dyndns.org>
References: <20121224035825.GA17203@zuhnb712>
 <201212240409.qBO49wkV020768@no.baka.org>
 <CACsJy8CNd3W_WUMbZ1QZ4ReZ5ziX90QejK9mh1TMs0ig33kGMw@mail.gmail.com>
 <1356327291-ner-6552@calvin>
 <CACsJy8DkA-J+ds1eHBqrRyiZrOigORTtxVeEQpZjGHrBR+QjCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>,
	Seth Robertson <in-gitvger@baka.org>,
	Woody Wu <narkewoody@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 07:27:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn1Vb-0004u4-GB
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 07:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab2LXG1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 01:27:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab2LXG1M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 01:27:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A087174D3;
	Mon, 24 Dec 2012 01:27:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PeRlTzLQnR2r+EpJOwzutrKDHy4=; b=a/bXL/
	UD8a0oL7F+iVzdesPdizNgizI9LLmgMmQUWJwqJ15QUml3pouK4qsQjj8uBvigl0
	fXzWPquHYkhYLBQCyYHlE9+4+HqIvVMlTe994p+lRuicomkiXFf4+EJFe8Nht6iy
	Gq0ruMPD1oFqHQNpKkc/Msktl3kMAFT2tDNzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mUv84Sh21eO34xFc1cCZWI5xZEpAal36
	OvjIobn/EAqjYunuSuZ5fUstu25N5LHpp8SxvM1jFPBhM8tymUZyx+yRxrIMFzvJ
	Fr7Pjmb9TTu8W3smRPCbm5FgFHeh613XIFAEBn2JtsDb40qpHw1uhe40kymue2sK
	ATQFS/ky8Rk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ED9974D2;
	Mon, 24 Dec 2012 01:27:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7E8B74D0; Mon, 24 Dec 2012
 01:27:10 -0500 (EST)
In-Reply-To: <CACsJy8DkA-J+ds1eHBqrRyiZrOigORTtxVeEQpZjGHrBR+QjCQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 24 Dec 2012 12:45:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2DBA806-4D92-11E2-95E2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212102>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Dec 24, 2012 at 12:34 PM, Tomas Carnecky
> <tomas.carnecky@gmail.com> wrote:
>>> Maybe we should store this information. reflog is a perfect place for
>>> this, I think. If this information is reliably available, git rebase
>>> can be told to "rebase my whole branch" instead of my choosing the
>>> base commit for it.
>>
>> What's the starting point of the branch if I type: git branch foo <commit-ish>?
>
> You start working off <commit-ish> so I think the starting point would
> be <commit-ish>.

Yeah, that sounds sensible.  Don't we already have it in the reflog,
though?

What is trickier is when you later transplant it to some other base
(perhaps prepare a topic on 'master', realize it should better apply
to 'maint' and move it there).  If the user did the transplanting by
hand, reflog would probably not have enough information, e.g. after

    $ git checkout maint^0
    $ git log --oneline master..topic
    $ git cherry-pick $one_of_the_commit_names_you_see_in_the_above
    $ git cherry-pick $another_commit_name_you_see_in_the_above
      ...
    $ git branch -f topic

no reflog other than HEAD@{} will tell you that you were at maint^0,
so the reflog of topic wouldn't know it "forked" from there, either.
