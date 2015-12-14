From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-p4: fix for handling of multiple depot paths
Date: Mon, 14 Dec 2015 14:06:55 -0800
Message-ID: <xmqqtwnkhegw.fsf@gitster.mtv.corp.google.com>
References: <1450037234-15344-1-git-send-email-luke@diamand.org>
	<CAE5ih7_T1xC9AyO41T4ktJmj6tENaEGbAG556WLyfsYz-jawsw@mail.gmail.com>
	<xmqqio40kfhl.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7_9m8kw=sVj8Sv5mAfT_22-g0vdTb78FvLTrNUkJO0M0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>,
	James Farwell <jfarwell@vmware.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Sam Hocevar <sam@hocevar.net>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 23:07:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8bGs-000794-VO
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 23:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbbLNWHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 17:07:03 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57796 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932292AbbLNWG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 17:06:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 86EF73485B;
	Mon, 14 Dec 2015 17:06:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QI9lSbb/3zdUHtdLlrJX3F5crLs=; b=AEi5OX
	ZEKBwzqmG0qVne7IdgMq4ZZAOibrEVONIK+ISPDoTVzDYn7jhaaoMTgrdQhEiO7I
	KNu5l37+es53Sx3R1ESq5w3a+u1PWd5tNqnO0r1qiPhYkpIJ2ypFY8XU6FcgHOYn
	K4SJc92rFu9l65A2vZp80Qi6lO+YS/swTL1/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VQXQ8B/PBiWZ0TKmBUEF2o+0IMU5n6dE
	riw4POR/ejCBBhiP3f6JXj5gUh4ZriySw3g4F9AZuZgIU0n46aEOelIKcqwN5l8H
	7sJy78ZTWrwYARCVGjOaxCQIGoRoR0Vy51Zb5K5HIU4PDEx9XyK8blwp1fIjKXZf
	PKcT6KrbmPQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7CA5C3485A;
	Mon, 14 Dec 2015 17:06:58 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BF8BD34856;
	Mon, 14 Dec 2015 17:06:57 -0500 (EST)
In-Reply-To: <CAE5ih7_9m8kw=sVj8Sv5mAfT_22-g0vdTb78FvLTrNUkJO0M0g@mail.gmail.com>
	(Luke Diamand's message of "Mon, 14 Dec 2015 20:58:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE3BE2AA-A2AE-11E5-A78A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282428>

Luke Diamand <luke@diamand.org> writes:

> On 14 December 2015 at 19:16, Junio C Hamano <gitster@pobox.com> wrote:
>> Luke Diamand <luke@diamand.org> writes:
>>
>>> Having just fixed this, I've now just spotted that Sam Hocevar's fix
>>> to reduce the number of P4 transactions also fixes it:
>>>
>>> https://www.mail-archive.com/git%40vger.kernel.org/msg81880.html
>>>
>>> That seems like a cleaner fix.
>>
>> Hmm, do you mean I should ignore this series and take the other one,
>> take only 1/2 from this for tests and then both patches in the other
>> one, or something else?
>
> The second of those (take only 1/2 from this for tests, and then both
> from the other) seems like the way to go.

OK.  Should I consider the two patches from Sam "Reviewed-by" you?
