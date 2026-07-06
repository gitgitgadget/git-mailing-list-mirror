Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49214371D0A
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367061; cv=none; b=Kq7xiuiwAUTxCzCDhn9RvZ381W7J/G5BR9Y7t8LgGf/bgsvVCXFgpghZmfYYaiFr3ascO3m1p9Pjx/2SELwXKQbGvvReITm4cEPoMWxIEZ42A0ltN3fCUZUKxh+iYJxgPaAqgYxCe5qxTBC7KFpRUq7Xz8GUIGivoKyBEv9G3vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367061; c=relaxed/simple;
	bh=pYxYD8DTQ80kjdFVlaNJ8/i3xwcVmQFnuABWLoX69H4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UuC+lBeX0oXfQoiI9UG4KejpCosxRBST3Ukz02QiEoOw4kq0w/gjjXsREjgHHn4eM1EO4fZyV6W/3I737Z2eJ4e72cbIr3Kf5y51HUJOrC1vNxwXTlsHldp+WJHym8JK2j7g0TDxHBtIf5n72HctfKq7pGxcuamhUb8cMOxdGxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hRrRJzqq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IbN/a6Gy; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hRrRJzqq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IbN/a6Gy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E278EC0114;
	Mon,  6 Jul 2026 15:44:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jul 2026 15:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783367059; x=1783453459; bh=050S6QzYDZ
	ejHj0vODaN37MQsJIPN56M61InW+/68Gc=; b=hRrRJzqqtYz8AxbB3bxRwK0smD
	7mRwCpbBrxNgOZxsJuZhtgOHTFry41EF2Cw7L3jfNLdINAa971sid2Nhv8Ko3sKW
	BiyfbjpcXpJCk0nl5EkAIlgshxZzLz6fj4j6nwrnEppVlDNgmr7rfDwFYmwRn7eC
	x97qKctTJp7R/b/vvz358pQQKshMUx11QTKrzA+Yba7piyfgmLDJ63EuVDij7Dsl
	F7U+clu/AC7PG2+B7XNzdG1wCZllq9JV0lXA/u5Be9yNqtqTMZd2NLA3HDDi1XSu
	5TwCyEeQjjh1rORxrN8bB7zm47Y6wrVK1GXOIcP3WBp/6fMvwtWzzP7Cqj/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783367059; x=1783453459; bh=050S6QzYDZejHj0vODaN37MQsJIPN56M61I
	nW+/68Gc=; b=IbN/a6GymM7dqLuhxvUsaGroo9TOnGjQ0TlBC5Edgy3g/4Vh9DP
	bAaW6A3+MfkkVbYKU1kxX7/xUvjZ4mExBm0AyMsthnRJjRaxthpJ5hPE21JMMncz
	occIn8yiwvATArhWns8zUmsQZHU5iVs5FfJl+JcdcoEu4BmnxowDbG5cVMAieLKE
	Wi4Qfr0POAOfCQef6deZKFpiQ/XXY+f7MpIlDVX00LVf25AT4xC8EoJmYhizznhW
	JDBFuO/EF1CKf5FQj29wqxySgSpv79BME9YmtGUzVlJx/Qbxls3xNl8msQHEBKp6
	62sg3JL5QS2F0ZXKTdIRkG5y7e3oKVv6olw==
X-ME-Sender: <xms:kwVMagNT8mOGKjsnKjscAEL1ZaqPXBhky3UKB2xMeyxUFK0O5I6EwQ>
    <xme:kwVMaqMSBJojX1qYrkUao-JKQcweLuSn8qNm-lCPm8EIcrOOMNnbwR6uNU6jCTjow
    gDlQLdvSzLjVbcZpWgpp-9uZCEJ8rI3oL2TZsqbnVL9HM4juPdrTw>
X-ME-Received: <xmr:kwVMagvliK23FrorGQ5FPStKYsOPFJ3ppTTuKABwAXKZewniLZRSTBpKdVSFNpQaGmCWkr_gyAzjRUKkOXRLLY5-WZFIlGyEb6n0Low>
X-ME-Proxy-Cause: dmFkZTGqq7+52GD61cHa1bhv3gRAwbIGM6ZdOzdDF3qvOF2PvyAs57FsxcCNyyTFna4KJQ
    xhJZK5Nx/RqjA6CcK+3ejsiqnWZII8Ay09+rwgJ1Q2wxyUZYcNkvVtoqDvwzuVWyGCQOYn
    /2XKidZVgz4HZ+K95aUZMet/EyY2ZeGaaljiVS8Ho/wJKHQO3NeT4C26krZBjuR26AK7Jf
    RlRAakkC9oHGP4Fgqkyc/9RwAgzaNrhjdtbYYrvyLsP0WEQaiWujaBdwjZgQED0jjLOCY3
    Hf8qAT+YIpYPdalTHQvPKOYztJfgitzgwvSLhS40/O00lV2Y8HnfNRjwwp8QaXVXB+2Nko
    f6XdGFt5aB4a3/BljFotaZb/8056jHMHU2BPfBgiDeFsbFzAyCguP8y1FcBi6dbGo8/0ML
    m+MvtZp8LnpbBfTm4DzRLgy+9jvwohKQRNazkEmSu8tLqlwtLPZ562J4v/lTaII2gl//j/
    kG1d2IJxHO7Ctf9j8I6SF0V6NlkvfUG/xMqA+jdbjB2Y6cUf+LqY1EiC22t9OZUvAOI4qO
    ACTpOlALIEybSnXdOAsMxh7EMWtZRCSt5rUojQgemeELHF0kPBrYhC+WtFc3arsLwGPwS+
    KECG2s/MIC/nyUJlxCbFcycBPvF1ett23Gd4qcwuTcm5OQNnatvXxxY1b8Rg
X-ME-Proxy: <xmx:kwVMakXjlvtAbz9GmWZ9Tk3C3gU2P-HCPY04uakRv-N7h7fl7sxyhg>
    <xmx:kwVMaotDnBPAS3Xd0bxffqZKKX8AW4tbuPhXnwo4ekfR-_V32Af7Jg>
    <xmx:kwVMagWuLvq5WTq-grUzHDrChkaOvNmOgIakllQieEjX9SNIREoXng>
    <xmx:kwVMarlWA5waJ6F8A_rDEDqwoRmlJJfepa7GmnIbnfUVRrWCwLh68Q>
    <xmx:kwVMau0QCrMI56vCTabO1y2QVUY4EWIL2_qjmzgUkxDHm2Z_IHi2A0bz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 15:44:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/rm.c: use die_errno() when system call fails
In-Reply-To: <20260706191024.93788-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Tue, 7 Jul 2026 00:40:24 +0530")
References: <20260706191024.93788-1-gatlavishweshwarreddy26@gmail.com>
Date: Mon, 06 Jul 2026 12:44:17 -0700
Message-ID: <xmqqy0fnaooe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> When remove_file_from_index() fails, the errno value contains the
> reason for the failure.

Is that true?

Together with the subject that mentions "system call", I think the
above is not quite right.  Offhand I do not think of any system call
or library call we make, whose failure that sets errnor would cause
the callchain to return an error back to this caller.

Please show us a call graph that originates at this location that
calls remove_file_from_index(), and identify which system/library
call sets errno to cause this function return non-zero.

Otherwise, we would end up feeding an irrelevant garbage value in
error and have die_errno() pick it up.

> Using die() instead of die_errno() loses
> this information, making it harder to diagnose failures. Switch to
> die_errno() to include the system error message in the output.
>
> Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
> ---
>  builtin/rm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 081d0bc375..3f5e6e232d 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -396,7 +396,7 @@ int cmd_rm(int argc,
>  			printf("rm '%s'\n", path);
>  
>  		if (remove_file_from_index(the_repository->index, path))
> -			die(_("git rm: unable to remove %s"), path);
> +			die_errno(_("git rm: unable to remove %s"), path);
>  	}
>  
>  	if (show_only)
