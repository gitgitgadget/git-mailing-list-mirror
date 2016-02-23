From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree info
Date: Tue, 23 Feb 2016 11:51:31 -0800
Message-ID: <xmqq1t8319z0.fsf@gitster.mtv.corp.google.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
	<1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
	<xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
	<20160223014741.GA21025@wfg-t540p.sh.intel.com>
	<xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
	<20160223091740.GA3830@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christoph Hellwig <hch@lst.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Feb 23 20:51:45 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYIzo-0003lG-Cs
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Feb 2016 20:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbcBWTvg (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 14:51:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754878AbcBWTve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 14:51:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 76DCD46A1D;
	Tue, 23 Feb 2016 14:51:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=WIwoczLq4TuzdX+XYNoyPMl+oPA=; b=R+xas+qpCK0ZKEhXrelo
	+gxETMvvy2qz9Um+0wgKBgbahWiFQZqZ6f6AQNXGPIaPXKqYEY0tf/bTbnyA3KX3
	lAPoXvNeJSl0eXa7QsZdyh9P5Hi++9gjKE8TtDgkm6G4aJ4WkcdhwD0pDCQaX5w/
	0Bx1qXdj1+4CJ6sMZiu3sns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=R2XvFFh0i0TevqUZjtIOQ9rblT8zeybGjsGz0E9zIuQspX
	D/4MloDNijEOVq82FWfUbzVs9jTNQRFIxAvNF0luwVnSUEDv560frvDkNWFpKLm4
	TL6gqYvOe34a4EH++0Mx7sz/FkQRzmIW5rgQXC8xzHPx5R6x2xhL/MmfJYqDI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D53646A1C;
	Tue, 23 Feb 2016 14:51:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D635846A1B;
	Tue, 23 Feb 2016 14:51:32 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D6C81B68-DA66-11E5-9F03-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287107>

Fengguang Wu <fengguang.wu@intel.com> writes:

>> >> I have a mixed feeling about this one, primarily because this was
>> >> already tried quite early in the life of "format-patch" command.
>> >> 
>> >>     http://thread.gmane.org/gmane.comp.version-control.git/9694/focus=9757
>> >> 
>> >> Only the name is different (it was called "applies-to" and named a
>> >> tree object).
>> >
>> > Either commit or tree object will work for us. We can use it in
>> > v2 if you prefer tree object.
>> 
>> Sorry, I think you misunderstood.  By "only the name is different", I
>> didn't mean to say that the tree object name should be shown as the
>> old proposal did.  What I meant but didn't explicitly say, as I
>> thought it was sufficient to point at an old discussion thread, was
>> that this was already tried and rejected.  This round uses different
>> name but does essentially the same thing as the old proposal, and I
>> do not think I heard anything new that supports this patch against
>> earlier rejection by Linus.  That is what gave me a mixed feeling.
>
> I can understand the rejection by Linus in development process POV.
>
> However we are facing a new situation: in test robot POV, IMHO there
> are values to test exactly the same tree as the patch submitter.
> Otherwise the robot risks
>
> - false negative: failing to apply and test some patches
> - false positive: sending wrong bug reports due to guessed wrong base tree

I always get negatives and positives confused, so let me think aloud
with an example.  Let's say that somebody worked on adding a new
feature based on v4.2 codebase and sent in a patch series.  The
series touched files in quiescent part of the system, these files
are identical between v4.2 and the current codebase at v4.5-rc5, and
the series applies cleanly to a "wrong" base tree at the tip of
'master'.  But it turns out that the series uses an old API that was
removed in the meantime.  The test robot may say "the result of
applying the series does not even build" and the developer would
complain to you saying "You tested with a wrong version".

I've already said that I can see the value this approach has for
you.  By having the developer state which commit the series was
based on, it will shield you from such a complaint, because you
would not use closer-to-tip 'master' as the base, but instead use
v4.2 codebase for the test.

As I said, what is unclear to me is what value this apporach gives
to the project.

>> I can see that recording the exact commit object name allows you to
>> claim that you identified the exact commit to apply the patch, and
>> that you tested the exact tree contents.  It however is unclear what
>> the value of such a claim would be to the project or to the
>> integrator.
>
> The value of base commit info is: providing a solid ground to the
> tester, to reliably avoid false positive/negatives.

It is valuable for a testing organization to say "We tested this
series on top of version X.  We know it works, we have tested on a
lot more hardware than the original developer had, we know this is
good to go."  It is a valuable service.

But that is valuable only if version X is still relevant, isn't it?

Is the relevance of a version something that is decided by a
developer who submits a patch series, or is it more of an attribute
of the project and where the current integration is happening?
Judging from the responses from Dan to this thread, I think the
answer is the latter, and for the purpose of identifying the
relevant version(s), the project does not even care about the exact
commit, but it wants to know more about which branch the series is
targetted to.

With that understanding, I find it hard to believe that it buys the
project much for the "base" commit to be recorded in a patch series
and automated testing is done by applying the patches to that exact
commit, which possibly is no-longer-relevant, even though it may
help shielding the testing machinery from "you tested with a wrong
version" complaints.

Isn't it more valuable for the test robot to say "this may or may
not have worked well with whatever old version the patch series was
based on, but it no longer is useful to the current tip of the
'master'"?  If you consider what benefit the project would gain by
having such a robot, that is the conclusion I have to draw.

So I still am not convinced that this "record base commit" is a
useful thing to do.
