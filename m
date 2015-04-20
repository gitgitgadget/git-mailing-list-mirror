From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I resolve conflict after popping stash without adding the file to index?
Date: Mon, 20 Apr 2015 14:11:22 -0700
Message-ID: <xmqqsibujyit.fsf@gitster.dls.corp.google.com>
References: <5535697E.2030204@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dmitry Gutov <dgutov@yandex.ru>
X-From: git-owner@vger.kernel.org Mon Apr 20 23:11:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkIyX-00057g-KZ
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 23:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494AbbDTVLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 17:11:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754530AbbDTVLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 17:11:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE5D6490F7;
	Mon, 20 Apr 2015 17:11:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0KJKNrFeCAWwerNd2LAHi+WMnwE=; b=IuC50N
	0Y6Prr6n6lo5ynJY0FSxdN/n5c6Y1MXfEM816xzfXoFPtvFuuWRJqpaR7q5ysbYj
	t8sepYqQnJh4rXHYrRyJDAD2pKvJf8rJBgEdUQsFsWsdtHRNaOxWGK9hw3qqxnSK
	y1f7ns70K53L3beJSJbKlUeR4isnHiT0tvopo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jQGbgxGWnFbh1YvPVawvLQW1qJ+bfW8r
	aZqQo+G6AMMcmBukGeBLZBEcw6JQdpqKuZBWIn4fdmowKkModNrbLyi4aC3DS+5X
	G0XsHrB5FE2AozHqOrjKI9uMWt4GCrDK+pyT8hFPyfC8K72GZ5eiS1ueg+2ktxnP
	GyyRo0iDZMU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E72C2490F6;
	Mon, 20 Apr 2015 17:11:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F99B490F5;
	Mon, 20 Apr 2015 17:11:23 -0400 (EDT)
In-Reply-To: <5535697E.2030204@yandex.ru> (Dmitry Gutov's message of "Tue, 21
	Apr 2015 00:02:54 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CC8098F0-E7A1-11E4-AB3E-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267501>

Dmitry Gutov <dgutov@yandex.ru> writes:

> Either will reset already-staged changes from the said file, which is
> an irreversible operation.

But the said file, if it had conflicted, would have had only the
conflicted higher stage entries in the index, no?  That is, the
failed merge wouldn't have touched the index for the path if it
already had changes there in the first place.

If you want to keep them then you do not have to reset, but your
question is about resolving conflict only in the working tree and
leave the index clean, so I do not think "git reset -- $path" would
not lose anything "irreversibly".
