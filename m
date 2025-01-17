Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775B1AC44D
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737152535; cv=none; b=BbkKMHqCD604epSVGp0DIKAipOYwVuYVMkhM9x3C/Tuyt4hUjiEQBOS2ZqDuHF9GMEz4KgJ4KGaawC4cPgX+aGAZQX+P0YdQSZKqh0iiFQU5CttSCwj+znJ0VIGyfijZTSl22l1zIfxSy/RkodOqB2fB3ZkahGVkYKkKJfJAA00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737152535; c=relaxed/simple;
	bh=UChaH+99OIS3k3WKENFxejdbrnAINbB9onC43eNLNTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mauc83w+VvYnbxK1dcbQmL8am2iv0+9JKa4im4h4X376k+C8Q6nvU/ZOIyen9WaWcE6gnoJNV3Loixj1RaAZ+4iUwZqE4t1iHIjruBiwujNnvbBV2tS2ZaqisfQZnE8Z2OianOyfbIIse3SRzx6N5cMnS/gqO+E0G5YfEJOZZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2gaFoe+2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lk0baYpN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2gaFoe+2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lk0baYpN"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4339E138020F;
	Fri, 17 Jan 2025 17:22:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jan 2025 17:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737152532; x=1737238932; bh=Q5GuI97IhD
	UiFtDxzRCcJm3X1ErIfimrP5gPyDkMV98=; b=2gaFoe+2bUKdZynSz45qeh66DE
	5gNi+iwTa3B4lMH1gvr+Y7W1H/HEKRKTd/SlsHlM/NAnpS17t9+Mr50Wbr9EYjh5
	QYlBHczTu9378ecdWh0IQC4cfr6CsM1FcBwxcw6EULRRoWoM+Xzc9YOLE41kj63w
	FMfr9usL1/vrC2A/8MWLHAoBcraOfjJ5i4Hd7nfzdoN0fPHdF6M8K8MrOfcPPGg1
	h8AY4BHEmo5l5IK63vw9EccHNULGM+TjH8UgeY7Tp5JVnmjSpCw+OtWiwD35NbXQ
	Dqg41EMl8Y7U6Ghvx0i32AMqn+tLCs9dY2CbAmoXSVuEA0uZdrQLLYw/K/+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737152532; x=1737238932; bh=Q5GuI97IhDUiFtDxzRCcJm3X1ErIfimrP5g
	PyDkMV98=; b=Lk0baYpNsdOzjEi2neNc/4N9NtfZUszc+KWCzBS1o2lxf6p1k+5
	ioudFApsSHTls62fmD6Rr4xu6UAmjBhpS3FaPvoXXTlh7EN4WVxZv38h7HqraLy+
	YvhU6ZpFAe4ZOGpPzksq/ereHNg3xwxFsGmb3QmeXHQbq56oFY5h8iDz7QsS6PzQ
	OKFYgoZLjrlhH7S94m6eHUBsJiBqe8Ktwb1SDb7EQJz1eL8kb9JKf46KMeJ201vm
	r/+rrLPQV6kv9FCOlEAQrkEST3aG9ZV12BlQgwxcj3JamKimyvOTOkirah1bbEbj
	B8bPJn1dZVb2HpJK1GV/NZJ9NiWcOu0cmWQ==
X-ME-Sender: <xms:E9iKZ-FnbuKK1Y41IQSCRGz2rslYF4LxoMQEhuSu91oTOP3FdmrepQ>
    <xme:E9iKZ_V8uMMQB1PPd-LMsz8k-xMVaUu3FkZTCSmuuCKcDDA39BEeNHPQZtUQBsgFz
    DVFSavm2G8pOVgFgw>
X-ME-Received: <xmr:E9iKZ4KqDbWGS5wTGRrW7IHSB_aATp_6s1W642bzvZ66Xfp5OI1K9aXnmcysZzsUf_fy3chhg4qUSu_qrOKDY6xOUDo7FtVGi47b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mh
X-ME-Proxy: <xmx:E9iKZ4HRvY7Jo6y_IQUXP89a2FktWEVZ0XHjRoYa8YKcC3HzPxL7lg>
    <xmx:E9iKZ0XeO47ig1e8g9fOowJ5HCFzP7EsNlIWKDH0SrXHv3ADMAsrdA>
    <xmx:E9iKZ7M9spdFbWDCGbvn8e2EvuS-2wMpsq464zEKvRiz3CuAGOLJSA>
    <xmx:E9iKZ72o9Ef5NXliDQjuDhSI4evC90ZTUjWaND1x4REqWlYtRC7VjQ>
    <xmx:FNiKZ1tSwCo-Ajt1mhQP0or0qbNnBGGAnO4TTrszH_6B6qcQWcubpsdM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 17:22:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  sunshine@sunshineco.com,
  rsbecker@nexbridge.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/6] connect: advertise OS version
In-Reply-To: <20250117104639.65608-6-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Fri, 17 Jan 2025 16:16:17 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-6-usmanakinyemi202@gmail.com>
Date: Fri, 17 Jan 2025 14:22:09 -0800
Message-ID: <xmqq4j1xjd2m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> As some issues that can happen with a Git client can be operating system
> specific, it can be useful for a server to know which OS a client is
> using. In the same way it can be useful for a client to know which OS
> a server is using.

Hmph.  The other end may be running different version of Git, and
the version difference of _our_ software is probably more relevant.
For that matter, they may even be running something entirely
different from our software, like Gerrit.  So I am not sure I am
convinced that os-version thing is a good thing to have with that
paragraph.

> Let's introduce a new protocol (`os-version`) allowing Git clients and
> servers to exchange operating system information. The protocol is
> controlled by the new `transfer.advertiseOSVersion` config option.

The last sentence is redundant and can safely removed.  The next
paragraph describes it better than "is controlled by".

> Add the `transfer.advertiseOSVersion` config option to address
> privacy concerns. It defaults to `true` and can be changed to
> `false`. When enabled, this option makes clients and servers send each
> other the OS name (e.g., "Linux" or "Windows"). The information is
> retrieved using the 'sysname' field of the `uname(2)` system call.

Add "or its equivalent" at the end.

macOS may have one, but it probably is not quite correct to say that
Windows have uname system call (otherwise we wouldn't be emulating
it on top of GetVersion ourselves).

> However, there are differences between `uname(1)` (command-line utility)
> and `uname(2)` (system call) outputs on Windows. These discrepancies
> complicate testing on Windows platforms. For example:
>   - `uname(1)` output: MINGW64_NT-10.0-20348.3.4.10-87d57229.x86_64\
>   .2024-02-14.20:17.UTC.x86_64
>   - `uname(2)` output: Windows.10.0.20348
>
> On Windows, uname(2) is not actually system-supplied but is instead
> already faked up by Git itself. We could have overcome the test issue
> on Windows by implementing a new `uname` subcommand in `test-tool`
> using uname(2), but except uname(2), which would be tested against
> itself, there would be nothing platform specific, so it's just simpler
> to disable the tests on Windows.

OK.

> +transfer.advertiseOSVersion::
> +	When `true`, the `os-version` capability is advertised by clients and
> +	servers. It makes clients and servers send to each other a string
> +	representing the operating system name, like "Linux" or "Windows".
> +	This string is retrieved from the `sysname` field of the struct returned
> +	by the uname(2) system call. Defaults to true.

Presumably, both ends of the connection independently choose whether
they enable or disable this variable, so we have 2x2=4 combinations
(here, versions of Git before the os-version capability support is
introduced behave the same way as an installation with this
configuration variable set to false).

And among these four combinations, only one of them results in "send
to each other", but the description above is fuzzy.

> diff --git a/connect.c b/connect.c
> index 10fad43e98..6d5792b63c 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -492,6 +492,9 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
>  	if (server_supports_v2("agent"))
>  		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
>  
> +	if (server_supports_v2("os-version") && advertise_os_version(the_repository))
> +		packet_write_fmt(fd_out, "os-version=%s", os_version_sanitized());

Not a new problem, because the new code is pretty-much a straight
copy from the existing "agent" code, but do we ever use unsanitized
versions of git-user-agent and os-version?  If not, I am wondering
if we should sanitize immediately when we obtain the raw string and
keep it, get rid of _santized() function from the public API, and
make anybody calling git_user_agent() and os_version() to get
sanitized safe-to-use strings.

I see http.c throws git_user_agent() without doing any sanitization
at the cURL library, but it may be a mistake that we may want to fix
(outside the scope of this topic).  Since the contrast between the
os_version() vs the os_version_sanitized() is *new* in this series,
however, we probably would want to get it right from the beginning.

So the question is again, do we ever need to use os_version() that
is a raw string that may require sanitizing?  I do not think of any
offhand.
