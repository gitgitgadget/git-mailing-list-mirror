From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree info
Date: Mon, 22 Feb 2016 22:54:38 -0800
Message-ID: <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
	<1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
	<xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
	<20160223014741.GA21025@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com
To: Fengguang Wu <fengguang.wu@intel.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 07:54:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY6rs-0002l1-NQ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 07:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757233AbcBWGyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 01:54:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757064AbcBWGyk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 01:54:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0241F3E063;
	Tue, 23 Feb 2016 01:54:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WHENuEBQWwcHk2lWVjd3e1TLs0M=; b=HvDWOq
	JR8tQM89EGHhOE3hgkXo1zaDhqEjudQ1/EQ9FrxAfLejsshSlYagtY97wqYoqC7v
	jUcoiHX+4x4j5F8mPfsOBEKwKoFIKnUhovz9LPHG6H7UnuSX4EeWykbf+6Up7r/v
	Aol7uUq5iHxmjri84opLSE6PEr7CsmGI5I7Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pUTQ+pdylKBX/JlJ5RvvWs9lCR+i2iGC
	j9zCHLeouvTqymKS6KhaPimPuc7sYGDWHbQai/WsnWPEKQ937sQMYkgaCJ0eMBuM
	zKlRh6zX1SBIJhsS99Q0iN2jBliCxSugawRRnN3SP8lG1+2x4kZXO5KeqtKFvuv2
	X9+QwQDyZhI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC45D3E061;
	Tue, 23 Feb 2016 01:54:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 674183E060;
	Tue, 23 Feb 2016 01:54:39 -0500 (EST)
In-Reply-To: <20160223014741.GA21025@wfg-t540p.sh.intel.com> (Fengguang Wu's
	message of "Tue, 23 Feb 2016 09:47:41 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4EFF6130-D9FA-11E5-8408-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287026>

Fengguang Wu <fengguang.wu@intel.com> writes:

> Hi Junio,
>
> On Sun, Feb 21, 2016 at 08:19:56PM -0800, Junio C Hamano wrote:
>> Xiaolong Ye <xiaolong.ye@intel.com> writes:
>> 
>> > It would be helpful for maintainers or reviewers to know the base tree
>> > info of the patches created by git format-patch. Teach git format-patch
>> > a --base-tree-info option to record these info.
>> >
>> > Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
>> > ---
>> 
>> I have a mixed feeling about this one, primarily because this was
>> already tried quite early in the life of "format-patch" command.
>> 
>>     http://thread.gmane.org/gmane.comp.version-control.git/9694/focus=9757
>> 
>> Only the name is different (it was called "applies-to" and named a
>> tree object).
>
> Either commit or tree object will work for us. We can use it in
> v2 if you prefer tree object.

Sorry, I think you misunderstood.  By only the name is different, I
didn't mean to say that the tree object name should be shown as the
old proposal did.  What I meant but didn't explicitly say, as I
thought it was sufficient to point at an old discussion thread, was
that this was already tried and rejected.  This round uses different
name but does essentially the same thing as the old proposal, and I
do not think I heard anything new that supports this patch against
earlier rejection by Linus.  That is what gave me a mixed feeling.

>> Is it your goal to insist on one exact commit the patch is applied
>> to?
>
> Right. Our goal is fully automated patch testing, where the base tree
> info is required for *reliably* avoid reporting false positives.
>
> A clean git-apply does not guarantee the resulted code is logically
> consistent and hence testable by 3rd party. For a 3rd party tester to
> provide useful and trustable test reports, he must apply the patch to
> exactly the same base as the patch submitter.

The patch submitter (or you as a third party tester) is not in the
position to dictate the integrator to apply the patch to one
specific commit and use it from there.  The integrator would pick an
appropriate base that would be different from the commit where the
patch was taken from, apply it there, and merge the result to the
tip of the mainline, or apply the patch directly to the tip of the
mainline.  Even if the integrator picked the commit the patch was
taken from, the result would not be used alone without any other
changes, i.e. before getting merged into the integration branch.

So in that sense, any test that is done by the patch submitter and
the third party tester would not be what will be released to the
wild *anyway*.  The resulting code will be exercised in a context
that *is* different from the context the original author had.

I can see that recording the exact commit object name allows you to
claim that you identified the exact commit to apply the patch, and
that you tested the exact tree contents.  It however is unclear what
the value of such a claim would be to the project or to the
integrator.

So I dunno.
