Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCE25A796
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677548; cv=none; b=rNNEQgECSXBjS4Uhld2dCzqg+JaO7x6wx8OGQy2+v/I26VlO+xaTNPmGQqV1rKORIC3+h7U65TI94kuUIsmCgphpC+tnZCFYVUd53nrQ0xXKnIDxQMY98f/5LrrSvs3PlEvvF3+dJTrhiviJdoyeySnPpYjSZoNip1AofMPE/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677548; c=relaxed/simple;
	bh=awL3ZYf+y49cbzFn8MmxQE2GoRDVhJKkJqwFzXvlvOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XqDFVpEQ1KxI4vwh9+abSMkaKoqALN6DaRdKI9Hg/qEXeQcNoOh7ObgHKrLK82plySPdBbMhp2s7PTuGyp4jh5fKoBc/TuBFtKyEwWgYw+E2cu46COlWtD3Q/5Kj/eY+XFv+NKaLHOUAhGjGVdiIqd+CJ5/vGu98qWLCch9G7aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XU/PJUma; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XU/PJUma"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BB441DC4DF;
	Tue,  5 Mar 2024 17:25:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=awL3ZYf+y49cbzFn8MmxQE2GoRDVhJKkJqwFzX
	vlvOg=; b=XU/PJUma8onOqfCnZPQjSBza0IIDPtaYaN5Sm9Lh3O14/3xR5wrLxl
	vWxIaDVfXaqzFq0T0okz3h/vv26n50mecheX3j55ZkNjRw4lhGlc5usln7kfczrv
	kicUEG9tkwfBJilBPifxhP7DWMBObpjM86I2fBfQ0kA/getjijWhY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 120921DC4DE;
	Tue,  5 Mar 2024 17:25:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FEE31DC4DD;
	Tue,  5 Mar 2024 17:25:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 02/22] contrib/subtree/t: avoid redundant use of cat
In-Reply-To: <20240305212533.12947-3-dev+git@drbeat.li> (Beat Bolli's message
	of "Tue, 5 Mar 2024 22:25:01 +0100")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240305212533.12947-3-dev+git@drbeat.li>
Date: Tue, 05 Mar 2024 14:25:43 -0800
Message-ID: <xmqqy1awxqmw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4EA7F6D0-DB3F-11EE-B845-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  contrib/subtree/t/t7900-subtree.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index ca4df5be8324..c3bd2a58b941 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -63,7 +63,7 @@ test_create_pre2_32_repo () {
>  	git -C "$1" log -1 --format=%B HEAD^2 >msg &&
>  	test_commit -C "$1-sub" --annotate sub2 &&
>  	git clone --no-local "$1" "$1-clone" &&
> -	new_commit=$(cat msg | sed -e "s/$commit/$tag/" | git -C "$1-clone" commit-tree HEAD^2^{tree}) &&
> +	new_commit=$(sed -e "s/$commit/$tag/" msg | git -C "$1-clone" commit-tree HEAD^2^{tree}) &&
>  	git -C "$1-clone" replace HEAD^2 $new_commit
>  }

Obviously correct.
