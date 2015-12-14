From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-p4: fix for handling of multiple depot paths
Date: Mon, 14 Dec 2015 11:16:38 -0800
Message-ID: <xmqqio40kfhl.fsf@gitster.mtv.corp.google.com>
References: <1450037234-15344-1-git-send-email-luke@diamand.org>
	<CAE5ih7_T1xC9AyO41T4ktJmj6tENaEGbAG556WLyfsYz-jawsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>,
	James Farwell <jfarwell@vmware.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Sam Hocevar <sam@hocevar.net>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 20:16:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Yc1-0005t7-DL
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbbLNTQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:16:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932122AbbLNTQk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:16:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDC7931CDC;
	Mon, 14 Dec 2015 14:16:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SWFHkWOdu4DLSFjOLIN//8oj1WE=; b=ua9+xk
	qH7wuC8Q0vib0Zf+Cl8EqCxZto6kFg0SFuHccU0yecW/Rsyc0hEHmxHlp0yjLXJC
	1SC4UWHKIZBMmm5CKkcoYKISi91YXM+f7hZjfZ+N9FvsVpwkt6z7B+PSWiP7tcR7
	ukjsP4VctkBbXKziQXfGkbONdxQchGpBZ3MqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E2Ufs7ErtiEtJ3PoX2z+xcGwaJGsygeA
	5WeoieN9pRhGmxum3I7O3tkcmy4kYGZspNLl08xI4+ZMto/Dd8l/UK6PNycxi6LI
	EaBkK14d4Xd6ygZX8hROL9dJa53iCFjVgt6KV3x7g3jxLCjpbdyGkI+l5T+sb/Qf
	EDhA0JNRzLs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E609731CDB;
	Mon, 14 Dec 2015 14:16:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C36E31CD9;
	Mon, 14 Dec 2015 14:16:39 -0500 (EST)
In-Reply-To: <CAE5ih7_T1xC9AyO41T4ktJmj6tENaEGbAG556WLyfsYz-jawsw@mail.gmail.com>
	(Luke Diamand's message of "Sun, 13 Dec 2015 20:19:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 33964E9E-A297-11E5-9515-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282381>

Luke Diamand <luke@diamand.org> writes:

> Having just fixed this, I've now just spotted that Sam Hocevar's fix
> to reduce the number of P4 transactions also fixes it:
>
> https://www.mail-archive.com/git%40vger.kernel.org/msg81880.html
>
> That seems like a cleaner fix.

Hmm, do you mean I should ignore this series and take the other one,
take only 1/2 from this for tests and then both patches in the other
one, or something else?

Thanks.

>
> Luke
>
>
> On 13 December 2015 at 20:07, Luke Diamand <luke@diamand.org> wrote:
>> James Farwell reported a bug I introduced into git-p4 with
>> handling of multiple depot paths:
>>
>> http://article.gmane.org/gmane.comp.version-control.git/282297
>>
>> This patch series adds a failing test case, and a fix for this
>> problem.
>>
>> Luke
>>
>> Luke Diamand (2):
>>   git-p4: failing test case for skipping changes with multiple depots
>>   git-p4: fix handling of multiple depot paths
>>
>>  git-p4.py               |  8 +++++---
>>  t/t9818-git-p4-block.sh | 28 +++++++++++++++++++++++++++-
>>  2 files changed, 32 insertions(+), 4 deletions(-)
>>
>> --
>> 2.6.2.474.g3eb3291
>>
