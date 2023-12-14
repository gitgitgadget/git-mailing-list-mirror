Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WLzf83VA"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E733B121
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 08:54:02 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 96C4E1CC36;
	Thu, 14 Dec 2023 11:54:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tGRRZ4xJa+SEQRaLOf1MvJqRUJpx3xh/4WQyWl
	ohCa4=; b=WLzf83VA2Xy1bKS65YI+9gaBTeCsnrl1b3URXNE9h0xTJDWLR8JdgV
	cFG7COqbbUT9wXn2l4+CR40p+pgob9/YkRt08oBWfVJMVpjEMnxxa0OFDz4zVewz
	d9mq1pMNR6fhS2Tk4Iyv0+jV87ycUwkdbD32u+gysAXGBL12hdKlY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F9821CC35;
	Thu, 14 Dec 2023 11:54:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3630D1CC31;
	Thu, 14 Dec 2023 11:53:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff Hostetler <git@jeffhostetler.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2023, #01; Sat, 9)
In-Reply-To: <e5295dbe-94d2-3186-5663-2466eba4bdde@jeffhostetler.com> (Jeff
	Hostetler's message of "Thu, 14 Dec 2023 10:19:19 -0500")
References: <xmqqa5qknnej.fsf@gitster.g>
	<e5295dbe-94d2-3186-5663-2466eba4bdde@jeffhostetler.com>
Date: Thu, 14 Dec 2023 08:53:57 -0800
Message-ID: <xmqqjzpgohcq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 605FD73C-9AA1-11EE-B9D9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff Hostetler <git@jeffhostetler.com> writes:

>> * jc/diff-cached-fsmonitor-fix (2023-09-15) 3 commits
>> * jc/fake-lstat (2023-09-15) 1 commit
>
> I think these look good.  And yes, it is better to insure that the
> stat struct is always well-defined rather than sometimes uninitialized.

Thanks.

> FWIW, in
> f954c7b8ff3 (fsmonitor: never set CE_FSMONITOR_VALID on submodules,
> 2022-05-26)
> we try to never set the CE_FSMONITOR_VALID bit on submodules (because
> status on a submodule is much more than just an lstat check on the
> submodule root directory and we always should recursively ask Git to
> compute the submodule's status).
>
> I haven't had time to investigate, but I wonder if the original
> complaint on `diff-lib` was due to another code path that allowed
> the CE_FSMONITOR_VALID bit to get set on a submodule entry.
