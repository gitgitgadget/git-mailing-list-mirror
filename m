Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="dOuxLuR3"
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Dec 2023 15:35:42 PST
Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2DCB3
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 15:35:42 -0800 (PST)
Received: from [10.0.2.15] ([146.198.40.91])
	by smtp with ESMTPA
	id DCEvrCN69hCx7DCExrO9N2; Tue, 12 Dec 2023 23:32:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1702423959; bh=pQ4kpKFgFpUUxvEiasNoAumqL4LUJAMwopHI0VLTGbM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dOuxLuR3QtOM9uJSyLCw+iq8P2kIj+ru9VH90OQS+gJ/yI2his2fQUTvrBvTq9x42
	 mcMwYJJGn/rkviWw5VptBc/gQafJ8Cf8rJ2YsTX7VUTjcwMkOiPiuy0N9Q1CEb42f2
	 046Ts3u9q74vYpcphHO/Mbmw0ULkUJ0LP9z46tWKKhVn9Cigrk+O/AZMhp3W3tBqie
	 rbnwbGqLXwgHGsSAXkiNcLpGJDP7io+HuGIOByCzSiX5ZCcbNANxAThTpMfsgv08gI
	 f96SoXM8l3OeHWVyRUVqTvXAaFT3V4SoS8BqmYWI4f2cZ+pHy3NleXMMXHQkuEZ5P5
	 TZOBUz5IkbExg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=WPRs41gR c=1 sm=1 tr=0 ts=6578ed97
 a=KA9ncW3+NP+rNtcBcdh9kA==:117 a=KA9ncW3+NP+rNtcBcdh9kA==:17
 a=IkcTkHD0fZMA:10 a=UKRohDYpd0TQNoytAM0A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <ac84b1b9-2381-406a-b459-6728bf9f8704@ramsayjones.plus.com>
Date: Tue, 12 Dec 2023 23:32:37 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] wt-status: read HEAD and ORIG_HEAD via the refdb
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
 Phillip Wood <phillip.wood123@gmail.com>
References: <cover.1701243201.git.ps@pks.im> <cover.1702365291.git.ps@pks.im>
 <1db3eb3945432964aabe1c559db4c3ac251e83fd.1702365291.git.ps@pks.im>
 <xmqqle9zqidj.fsf@gitster.g>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqle9zqidj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMbiW5gS1Z97h3sFfSBWjKCb9TKs0Lm/dOqp59PWFhhgzTkVykYhoMBsHgWv6bzgMapF0A28CaPLjEiNywrq50MbyxnXlM+hpQXYgJi3zQ8MaJRU2nOj
 OMEe3JCmeo+feIITlGlQbYhk3GmXbQH4ir7zv/ilH04FddwB8e5qzgcshYw8qgBnIV2Od9e1805LgiToAzMADcEAm8gqXSoKCAs=



On 12/12/2023 20:24, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> The current code only works by chance because we only have a single
>> reference backend implementation. Refactor it to instead read both refs
>> via the refdb layer so that we'll also be compatible with alternate
>> reference backends.
> 
> "via the refdb" -> "via the refs API" or something here and on the
> title, and possibly elsewhere in the proposed log messages and
> in-code comments in patches in this series, as I've never seen a
> word "refdb" used in the context of this project.
> 
> I agree it is bad manners to be intimate with the implementation
> details of the how files-backend stores HEAD and ORIG_HEAD.

Hmm, I have never thought of the 'pseudo-refs' as being a part of
the 'reference database' at all. ;)

We seem to have pseudo-refs, special pseudo-refs and (recently)
ex-pseudo-refs!

This patch (well series) changes the 'status' of some, *but not all*,
pseudo-refs; some graduate to full-blown refs stored as part of *a*
reference database (ie reftable).

As far as I recall, this has not been discussed on the ML. Why are
only some chosen to become 'full' refs and others not? This is not
discussed in any of the commit messages.

The '.invalid' HEAD hack featured in a recent completion patch as well.
[If this is because the JAVA implementation does it this way, I think
it needs some thought before including it in the Git project].

Anyway, I haven't had the time to study the details here, so please
ignore my uninformed ramblings!

ATB,
Ramsay Jones

