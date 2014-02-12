From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] More preparatory work for multiparent tree-walker
Date: Wed, 12 Feb 2014 09:25:51 -0800
Message-ID: <xmqqr478nsyo.fsf@gitster.dls.corp.google.com>
References: <cover.1391794688.git.kirr@mns.spb.ru>
	<xmqqeh3aqyq6.fsf@gitster.dls.corp.google.com>
	<20140211081716.GA4455@tugrik.mns.mnsspb.ru>
	<xmqq61olpgjd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Wed Feb 12 18:26:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDdZd-0008RT-3B
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 18:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbaBLR0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 12:26:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471AbaBLR0H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 12:26:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E76D6A1D0;
	Wed, 12 Feb 2014 12:25:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5nTr5w72MFyURzsigsWNY4sGcmk=; b=W7qa6L
	i+x43if5mZve/mLcuLeQnMoZos2+4eodriIW/La3dGXxTizGL341Ppvk8SA+elft
	4DzZY8A8Svmkn6vbieltxR0woGgBYD1W35fk1RCHbcYsI9uewaMWYwLFjv9wEgHA
	S21aJrA5xjEbGYgoVMmbVtOPaPHleK211yX+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o36N0zUFNoPDxYtAJPnRSgiFaHIJcU6J
	VpVZADJm8NzWo019qyXX/UbeEr7n0ZNPMSRk77GFY5G+sgkSVneLO0W0LiTU8iBG
	pBvst5HlZBM75V09Nx8OxQ+cHM0bx0U8CZ0ovb4mu4cppJ0NoPG5Y/QaCgKkYYgz
	5ZDt92KM0QA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51BC26A1CF;
	Wed, 12 Feb 2014 12:25:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 707566A1CA;
	Wed, 12 Feb 2014 12:25:56 -0500 (EST)
In-Reply-To: <xmqq61olpgjd.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 11 Feb 2014 11:59:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BB545EF4-940A-11E3-988B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241998>

Junio C Hamano <gitster@pobox.com> writes:

> Kirill Smelkov <kirr@mns.spb.ru> writes:
>
>> Sorry for the confusion. Could you please do the following:
>>
>> Patches should be applied over to ks/tree-diff-walk
>> (74aa4a18). Before applying the patches, please cherry-pick
>>
>>     c90483d9    (tree-diff: no need to manually verify that there is no
>>                  mode change for a path)
>>
>>     ef4f0928    (tree-diff: no need to pass match to
>>                  skip_uninteresting())
>>
>> into that branch, and drop them from ks/combine-diff - we'll have one
>> branch reworking the diff tree-walker, and the other taking advantage of
>> it for combine-diff.
>
> As long as that does not lose changes to tests and clean-ups, I'm
> fine with that direction.  For example, I do not know if you want to
> lose e3f62d12 (diffcore-order: export generic ordering interface,
> 2014-01-20), which is part of the combine-diff topic.

Ahh, sorry, I misread the "drop" as "salvage these two and drop the
rest".  The new series does apply cleanly on a commit in master..pu
that has both ks/tree-diff-walk and ks/combine-diff, and the latter
is not yet in 'next' so we are free to reorganize.

Let me flip the latter topic around, also queue these updates and
push the result out on 'pu'.

Thanks.
