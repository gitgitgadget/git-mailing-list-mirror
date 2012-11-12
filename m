From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange behaviour of git diff branch1 ... branch2
Date: Mon, 12 Nov 2012 09:46:51 -0800
Message-ID: <7vbof2iuic.fsf@alter.siamese.dyndns.org>
References: <20121026212650.GB2612@pug.qqx.org>
 <CACsJy8CX4Wbf3Bqez2kcQ7NGYMkqXC8MK+=hrH4iaev+0ZrQ8Q@mail.gmail.com>
 <4ecbe65e-4b56-4a49-96c3-1ea8b3f0c473@email.android.com>
 <CACsJy8BkKRxp9AQW0M0vDSL8Mb16VGSrZ1OnQpwCrERWKVLSyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Aaron Schrab <aaron@schrab.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:47:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy6G-00070V-UV
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab2KLRq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:46:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43368 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753929Ab2KLRqz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:46:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 014AC971F;
	Mon, 12 Nov 2012 12:46:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=NbH7En/QX0DJs2BCJgA3lGK8ykE=; b=D9mvzW7+4GPnGBqXhsrf
	2NjBhHeCv3MdappjpFp9PmZ0jwkb3+sGgtX51KRtJmf6Ww2xON/myRy3ZdvdsIpt
	VO+mSQ3y2aQTDVu1c6zk176qJ41mPKbNDqP4nuldQQHyjYGNp4KCDCf+NQcHVMvl
	xvpiWuwqGK9ho9nPrfIhbS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=gZKKXLatVXQvXniacU1bM45ftizUInuNcKe0/qBIs8UQ9s
	dkfoUb8D6RhhtLJ4bb0ntJJzqroQMawYUsucDW0e9IGRinu4vFeGvUgs1G8MGtcf
	Bh/BMH56xjE3afbsgt38WfedRoJe6SkfkndclILDgjd6/bbGd6ZmfuwjfWWcg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4809971D;
	Mon, 12 Nov 2012 12:46:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54449971A; Mon, 12 Nov 2012
 12:46:53 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1B5C7DA-2CF0-11E2-ABDD-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209504>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, Oct 27, 2012 at 7:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>>
>>>Notice the --cc in the first line, which is combined diff. Usually
>>>combined-diff is between two points and one parent. Though somehow git
>>>passes 4 parents down combined-diff.c:show_combined_header, as you can
>>>see in the "index" line. I think we should fix rev parsing code as it
>>>does not make sense to pass 4 identical parents this way.
>>
>> The two heads home from HEAD...HEAD the user has on the command line.
>>
>> The user is getting exactly what she asked; there is nothing to fix.
>
> Is there any use case where HEAD...HEAD (or "..." alone) is actually useful?

That is an invalid question, implying a proposal that will introduce
more confusion to the users while hurting the code.

There is no use case where "cat A >>A" is actually useful, either,
but it does not mean "cat A >>A" should be special cased to do
something different from what it happens to do in line with the case
where "cat A >>B" does.  I think "diff ..." or "diff HEAD...HEAD"
are the same as that example.
