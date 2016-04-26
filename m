From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge: warn --no-commit merge when no new commit is created
Date: Tue, 26 Apr 2016 15:00:08 -0700
Message-ID: <xmqq1t5sdo9j.fsf@gitster.mtv.corp.google.com>
References: <874mb0kkkk.fsf@gmail.com>
	<alpine.DEB.2.20.1604180825170.2967@virtualbox>
	<CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com>
	<87a8krpehl.fsf@gmail.com>
	<CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
	<xmqqy48a6fht.fsf@gitster.mtv.corp.google.com>
	<xmqqtwiy6end.fsf@gitster.mtv.corp.google.com>
	<xmqqd1pcdpb8.fsf_-_@gitster.mtv.corp.google.com>
	<CAGZ79ka-HbB=oCidTtKSa32R9kqd2_c-cG8h+ttAVy=a8UfgFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Christoph Paulik <cpaulik@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 00:00:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avB1o-00009y-EG
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 00:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbcDZWAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 18:00:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752528AbcDZWAM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 18:00:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F007150C7;
	Tue, 26 Apr 2016 18:00:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0SaX1U/wn8UnEsRFqCwhkBXSFho=; b=Y+2uwR
	d91tiz5K+KTlC43P1Xoe41eUYhmCaqniGwY9KOVrDdoJ4OZRerO3iKav8ZueOqwR
	WqeOW1Wu2+4FxFuPxDdfJ5/ovgsj/qqi9yBxj+XItdfOaN13JBOdTLKrggzB60sX
	+Ti2VuMzWS4iKE4Zih6HdUIU40PvYdM0HdpAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jxi8d/kNHJmKw5ouVLnBdbYoWdXxSCmw
	CfHDAwD5LP2d/l/3HNo7qEOgYHkhRvGOC+YixpscKm2kl0Q6yIcHP3SKy2wYm/hd
	0U19TzzlhFIG/bNTmQbA8N9QIAobRwuq/ViJVCflvKFYASuaJxNW9QZPhh6033YM
	mc9p+aftygw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 865AC150C6;
	Tue, 26 Apr 2016 18:00:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECFE9150C5;
	Tue, 26 Apr 2016 18:00:09 -0400 (EDT)
In-Reply-To: <CAGZ79ka-HbB=oCidTtKSa32R9kqd2_c-cG8h+ttAVy=a8UfgFQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 26 Apr 2016 14:53:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3E829FF2-0BFA-11E6-8F06-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292687>

Stefan Beller <sbeller@google.com> writes:

> and later
>
>     if (!option_commit)
>         no_commit_impossible(_("Already up-to-date"));

It would be more legible, but because there are so few callsites in
an already shallow callchain, I do not think it makes that much of a
difference in this codepath either way.

>> +
>>  int cmd_merge(int argc, const char **argv, const char *prefix)
>>  {
>>         unsigned char result_tree[20];
>> @@ -1403,6 +1412,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>>                  * If head can reach all the merge then we are up to date.
>>                  * but first the most common case of merging one remote.
>>                  */
>> +               no_commit_impossible(_("Already up-to-date"));
>>                 finish_up_to_date("Already up-to-date.");
>
> Coming back to this patch, in case of -v given, we'll
> see ("Already up-to-date") twice?

One that explains why --no-commit is impossible in warning, and the
other is the final report of what happened, so yes.

> If --quiet is given, do we want to suppress output
> in no_commit_impossible?

While we are using warning(), we probably do want to.  When we
switch to die() at a major version boundary, we don't.
