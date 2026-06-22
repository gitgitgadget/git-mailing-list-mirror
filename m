Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90962316197
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782151285; cv=none; b=nAcMOYwCq0nLXTltbZdVMMcgdawbMf2zkGjUuClhvG/oFg4D311i1uy/Kd7SLpcW0zdkIVvsW/S+Uwc0zCBDWmX+WhP3fIyY+lW+asC7xGPBEqqkz4iJQGvMxqfx7El7VXiAbzoDLhFHLrWsVUwcSyj7LcFVwMczKuYUAE1TzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782151285; c=relaxed/simple;
	bh=ghAPNp24nw6W2q6LKYrN+aYMRfNzbDo4WXGHvtyDPg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jbP9mr+WGrjPppcJt5M6tyHo9x8zshDOhM2D3vB+ESGNhuQzXTJHi4XWbbLHbUpw1xVpJyvI4/hVLopF8UIlvQIEPos5R3gL/MG7NqzM1drlIWCy3kt5D/elpt6uhrCcIZGfVxngRj1M8gJ+Ok7paDKHZCPj8RWlLHAyHo/DJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FxRBiXSt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K8MCgMGA; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FxRBiXSt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K8MCgMGA"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 220EC7A00B0;
	Mon, 22 Jun 2026 14:01:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 22 Jun 2026 14:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782151282;
	 x=1782237682; bh=TvOeUa+R0opcr+Zb7N2v5KcseQxEOI4pD4Q9v8rtACE=; b=
	FxRBiXStBXyEZ4oWGDUM/ylmyGHYQAFtvaFssi+G3U3U8TdXWL4lAdAfbyvFsxf7
	qN6Yz0WUO4j3DK+gk3Y35qaVVrurggb24oe8J7NvMWVUQLrzSz1IyxRMNbEbtZ+X
	g+0E7ID+ipfBZANbTa7DLbHOBS2ebMFr7CZCXd0tpwvLMNzQ1dBQAryNQYV6Pmg1
	f1lhX3zVOdwUWHO37txKeHuU7MQ+MnUB8m5QhWy4Bf0HnwtY5CSXi4lsh4gZ08BG
	hy94UkrWj64RiFeTzd1UhF7QAJ3Y8cFpp5YySPo/h7iii53xInANCc2ywsrlkwFV
	kB/sHrsJduet5Xe5L92+GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782151282; x=
	1782237682; bh=TvOeUa+R0opcr+Zb7N2v5KcseQxEOI4pD4Q9v8rtACE=; b=K
	8MCgMGA37Iw8NMbif7DvYU/2p/7mg22ZaZ4Wo04i/Mp5oUBsGgxkBNvnVLXq0G+S
	OMx+tKwIS10HzH7Kt0Z02MEXCBmPBYJ6bmqu3ObX1nJnpQAvN+/Ln/6wMNkq8Tod
	EIzgXdn5YVaRN/YmdQ27lN/UXNt2r88lJwOKO4O9goEKz7mQHlFmn8xCyBq1GcEd
	u/0+zV4SJPDSgrE6/hZgy1wac5H/Z4VfBkFGrA1XLrM8wL3XNUZUmj8VMNK+kj+Y
	imMWEjbovHLa2IdH645PHrSZ+AsgrdCmlToISP0NZhm74OjmNzOLwrAt2IbNjFvD
	sBfxAZGqchV0MADQ0TK8Q==
X-ME-Sender: <xms:cng5ajqUnxEhyRvlDlV50DLvsLT_JdcUx1G8-4Gy1bGniQbnrxrM1A>
    <xme:cng5av48ZND2oa35pfjxUHBWSxRjG3IyZFLzHOOFBpB6y5FQpf5SdwwJSBvSAWprT
    3L64DBM2zMaAiLe190ERTTOWeDxauyYtoGNczdxAEQEhyQxfmneUR4>
X-ME-Received: <xmr:cng5aicI5jKcCqSSWgRc5-dsAm43tyLhAln54eJLDxHC_jk0JPcFLLaBXiqmoffe_jrqs3N3i7JBjVhmbRrtPo1LeCJStc0d15oLNdI>
X-ME-Proxy-Cause: dmFkZTFBxIyjEUVemVwQi06v9RZpbcMJmsoJzugjjVdlmd6atymFlEAEk6BA8a7Q3yf0N4
    VmpPXJbGzDxDxhpOLc2GDblFNyzXtGgntG/lq0GJr2ZuH1wglbgF8gF2iKoYF7k1QjWeHE
    wZgg2/TgpKwYsOZNVUKWu3kezfC78WB43Myb4BxrQzolF89we8uyCgIs4WPpb94iYGqh5V
    VjbXR5h8U8eGj7J2207hr1l206CVYsuucEhoW9wu75gJ8zflfD2edh0bvG1umpVxjZrJG9
    FLcZQZIJOO8xGU39qptwL6mVQ3ojMQMBwjHRDv3vQ3sdxNMNeaVRniIyTeemnuehxE7BO7
    JbFw9L/1vCpXLmrwd8lX1ddHkKxvQPkvqFMAiuCKApfgFE7uR0dPL00pyNtoqixAJPlgF9
    AeUqd7hhGDZQxZ3gz21x3jUOb8Leb+1kOpzZBvPTJR7nTW+Wzh6ryDInhfS8YrRIHfh4Bg
    /QZDPo6kI0yJXOLIXdoyAvSoCQSm5oLjRliVd1UAt8ZIvJPAb5GPaHwHR6fx8VJ6nbtrRh
    hsEbQhTJ+LjGqk7XVh9Q4BqR+BS3nH8U2CLRuTPVn/mRr/Lf0YOX6465vdfUAQiJ0YnV+D
    G2Pc9H2x4lPdibDKOGl6nWQ4PujhIKVz9HQmdcE9YIo/741ZRkoydqtOxl/Q
X-ME-Proxy: <xmx:cng5as7w5zvXX3PTZo8w--t0HME7eI3am_YqO0QdosgD3qqh_PGxsw>
    <xmx:cng5ahtwt81dNhSTUPgPLkOaNFB2PReHmkLkEYHF4IyCFv5SotOdEA>
    <xmx:cng5akhdBHsjd7zj86RVl3efKf51n1D1Mr_nXwdgrpqrDL68imptMQ>
    <xmx:cng5akrD5C6lLeYCQKZPSS467EV1jxo4dQnI8oHnFW0XuFtrN0ehKQ>
    <xmx:cng5ajKQLypUyP-o1xVoEtJ0So-fx28_89RnYITMiVd9zCo8qI0h2RCF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 14:01:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood123@gmail.com,
  johannes.schindelin@gmx.de,  stolee@gmail.com
Subject: Re: [PATCH v3 0/2] environment: move ignore_case into
 repo_config_values
In-Reply-To: <b5a9115a-c909-405f-b150-f956d866b1eb@malon.dev> (Tian Yuchen's
	message of "Tue, 23 Jun 2026 00:45:46 +0800")
References: <20260618114207.605211-1-cat@malon.dev>
	<20260619155152.642760-1-cat@malon.dev> <xmqqjyrr7ipf.fsf@gitster.g>
	<b5a9115a-c909-405f-b150-f956d866b1eb@malon.dev>
Date: Mon, 22 Jun 2026 11:01:20 -0700
Message-ID: <xmqqzf0mzc7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tian Yuchen <cat@malon.dev> writes:

> On 6/22/26 04:16, Junio C Hamano wrote:
>> As the compat/ layer is not meant as a general purpose POSIX
>> emulation wrapper that is generally reusable to projects other than
>> us, if we have a knob settable by end users to affect behaviours of
>> lower layer in compat/, it is natural to make repo-settings
>> available to them.
>
> I see.
>
>> What is the perceived problem you have in mind, and what are your
>> proposed alternatives?
>
> Actually, my reason for showing this question wasn’t because I thought 
> there were any architectural problem, but because I felt that for a file 
> in compat/win32, which is more on the _downstream_ side (is that 
> correct?), we need to exercise extra caution and confirm with its 
> maintainer whether the changes are appropriate. That’s why I CC'd 
> Johannes Schindelin on this.
>
> Was that the right thing to do?

Yup, Dscho is the right person to decide on the design issues on
Windows build.
