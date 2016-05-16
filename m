From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/1] CRLF-Handling: bug fix around ce_compare_data()
Date: Mon, 16 May 2016 09:13:03 -0700
Message-ID: <xmqqshxi2d80.fsf@gitster.mtv.corp.google.com>
References: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
	<1463413889-12490-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Mon May 16 18:13:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2L8s-00071S-5f
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 18:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbcEPQNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2016 12:13:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754262AbcEPQNI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2016 12:13:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 650061CC8E;
	Mon, 16 May 2016 12:13:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KeYwrUgYjTZU
	wDmkfHGhUldjqrE=; b=S9YQauBXLW07rdz5du4PA88bjgljPjdRtYpuisAlIJaS
	+rw/J5TBs26BeewzfqiF+NWmvTwywXhS1OWbriFmCBb2P+l4vbKP4mXar2a1H2eE
	WpHUczitBkhb7d1/rXad/i/g6aTY7XbFE6Q5ZvynCykLPQJdnvKa8n4gK6rIlfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Oen+yI
	k8MJT3SrgrPjzEMe7QAGgnuTjI6jozDSMC6sMeVO8xhi8ghLPMIQHW9QtucTyiKO
	BbUb8DmEhonf5EZvp9opQ/tvc44aH0EUz2t7UtJLNUf9CQfRLQN8+2DE9cSjEVmb
	bAei/gB/mpaBvT+JrCBaY3GodgYcaV7Lo37c4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DACF1CC8C;
	Mon, 16 May 2016 12:13:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7CBE1CC88;
	Mon, 16 May 2016 12:13:05 -0400 (EDT)
In-Reply-To: <1463413889-12490-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Mon, 16 May 2016 17:51:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 12A5550A-1B81-11E6-8B1F-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294750>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Changes since v2:
>
> - Only 1 patch, the t6038 needs to go as a separate "series"
>
> has_cr_in_index() uses either
> 	data =3D read_sha1_file(sha1, &type, &sz);
> or
> 	data =3D read_blob_data_from_cache(path, &sz);
>
> (I like v2 better, since there is a single code to get a sha object
> into memory, which later will be replaced by a streaming object)

Wait a minute, please.  I only asked the reason why you did it that
way and mentioned that the end result seemed equivalent.  "The end
result seems equivalent" does not automatically mean "therefore you
must avoid changing the code."

If you still prefer the original code, and your preference is backed
by a solid reasoning, don't change the code to a less preferrable
version.  You may have to explain what you wrote in () above clearly
in an updated log message to save other readers from asking the same
question as I asked, though.

Thanks.
