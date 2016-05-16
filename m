From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] modernize t1500
Date: Mon, 16 May 2016 11:52:32 -0700
Message-ID: <xmqq4m9x3ken.fsf@gitster.mtv.corp.google.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
	<xmqqfutqsaxn.fsf@gitster.mtv.corp.google.com>
	<xmqqmvnxpyw6.fsf@gitster.mtv.corp.google.com>
	<xmqqeg99py5j.fsf@gitster.mtv.corp.google.com>
	<CAPig+cTPsya6_3D2wx=k3pVaDJ2PokUvK4muM7nz-eV+Ss5+tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 16 20:52:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2NdA-00032F-Oq
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 20:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbcEPSwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 14:52:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753736AbcEPSwg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 14:52:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 756401CF0B;
	Mon, 16 May 2016 14:52:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U5QUUjoh+U9w7TvFm+dokRs+S/o=; b=Jobo83
	aHg041OiN54ZGcWEGPG6CJ2rNs5+oykY3skxA9uUQO7VfLYE87ykSZB9ZNePLPJQ
	roi2HD9n1ex+0FXZrVEyZYrEDGobJW9mKBt6+XdA7zV5gEA9IrYeaOXVtbRIAKP8
	pKax4G+S/i4ViWimMuuZHfnQj+l7QbIVRUkLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J2cUkESAnhnqoBVYIkKL7MuEN6A/Ptm8
	Tik2DKttyXb7uRY4OzxVqQgsrlMvUWjbN5xSskVpYTWUEjCFOHK7vdO3Fw6pWt+Q
	NRWsBubrXUDpK1D3qIau6CBm9cKMAtxIv3P7SLCdVegkD086jzBzaKN06Oakc5lh
	fh7+LH+Kmns=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D1FD1CF0A;
	Mon, 16 May 2016 14:52:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9FDF1CF09;
	Mon, 16 May 2016 14:52:34 -0400 (EDT)
In-Reply-To: <CAPig+cTPsya6_3D2wx=k3pVaDJ2PokUvK4muM7nz-eV+Ss5+tw@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 16 May 2016 13:39:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5A398204-1B97-11E6-BDF3-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294777>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, May 10, 2016 at 2:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>> Subject: [PATCH 7/6] t1500: finish preparation upfront
>>>
>>> The earlier tests do not attempt to modify the contents of .git (by
>>> creating objects or refs, for example), which means that even if
>>> some earlier tests before "cp -R" fail, the tests in repo.git will
>>> run in an environment that we can expect them to succeed in.
>>>
>>> Make it clear that tests in repo.git will be independent from the
>>> results of earlier tests done in .git by moving its initialization
>>> "cp -R .git repo.git" much higher in the test sequence.
>>>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> ---
>>
>> I think the same logic applies to other preparatory things like
>> creation of sub/dir in the working tree etc.
>
> Hmm, so are you suggesting a single 'setup' test at the start of
> script which does the 'cp -R' and creates those other directories
> needed by later tests?

Exactly.
