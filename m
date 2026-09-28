Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C3736A341
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581302; cv=none; b=CNeUNg8PoniIXd4oFASL9jHWBzCVFQGcHVNKH+E467am/QwSxVRCiRP1ku10IxUfbbGTJNbTnMoXTHHHLVQroe9rud1Kj8p7AKW8QyY/nFLECHh1EaxkQiAniMyg6ESaySi7RCfFZ0OprLJW4sc7dqSbRb/X3G8bsFM74cgjxxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581302; c=relaxed/simple;
	bh=MHkpbQ+IlNd3Mja/sRQH96u02lMsbxeM8STOZbnTzgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5tXrElRui4oSBX5L37wXvxUpNXA0YYH8J1cidVuMI0gN2o+JVpD+1bimC/9H1PGyoxpsHtBKqSJpgsQh8ssb61jpHAjTKAiuvGWvXPMlv2+UYlSRbxJR1dvtqSLP2IUXW7XyW1P07ppJHllLFb8qBWBUAEMzdU3ctFJucBX+MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GNxNQyS7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HwJpbSZe; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GNxNQyS7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HwJpbSZe"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F319D14000D4;
	Mon, 28 Sep 2026 03:41:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 28 Sep 2026 03:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790581299; x=1790667699; bh=LUP6e+Wai1
	//x9PuEIkUEhF/UZyOE8O2tDOMdOm32bM=; b=GNxNQyS7IMDPQKntTNQJvS06iV
	eJk4lc7LjkJPUdyCigfVgfCIsyJ1IF+6KuIqZOFl7mXr+O9tntABosmJUIsWa9+z
	Eh7fsafzwKh6dL2FwUxCpf4Wt0indBrissUzMTK6ZXx5smsULE8yutjdCmMcIHEv
	OTc35tRizrDSB8MP5ofqKt5DzbyEn3i9wFqA92N7C4I7p16kwIv5p8SXP/ZVpL1d
	AmpgZHPeFKDKiLEpGLpn7yGS9cZRT7cGWE8IsZHhX7d9aB8wf4a1FbRSDZxsswnT
	EChD4w5Z0WzJN11uZXjHMZIIICTqwoFYAoG176YKO4WQN2PMR/GRwAmAubMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790581299; x=1790667699; bh=LUP6e+Wai1//x9PuEIkUEhF/UZyOE8O2tDO
	MdOm32bM=; b=HwJpbSZemr9YvKbBTkkLraqT9D6lp13a53mrWdwnIZQaddZG9MJ
	jfLhJDBwIzvU+lir7m8u4kAXQVMZcLei3EJorYZ3/Joeicf/n2ShBKTw4yyv06zG
	HFz8j++4HmgQ8sDytLiYPTtrocifkCGwH0I4baetmhgQXRrCzU8Z1xHEKdNt3d8O
	tJR08S+HUE1FGYzylQX1YsrMMXA6er8ogZkH307XNmUREPM6Emz0BKZeaXGIJE8e
	W99WVXs8FGnTKd17qdzxlcPVxQ7IWzHelUeEaZwIkmL6CZ6Of/DX/iMl/DsPK9vS
	JYgbJL+DBJpUnTpBnr0+eQ7Po39fsu08UWA==
X-ME-Sender: <xms:Mxq6akMHdiOKsNXbMUzBE_-3iCeflYwl7Amc-uY5fAB7-S_gbDFKZg>
    <xme:Mxq6ah8KulIUj9tkalnTNCtn0BLP_rjJ8YukVTFBsjxNwJ8Ufmo8C0iAKbIJILXk_
    p6MuYFncUUlIFedt7JbtAsRKe13IgsZPdgDsnrQ47TrcOFvHyaNhHk>
X-ME-Received: <xmr:Mxq6agQ3zAIHxiSIKQ8t54fBl3dUPiUUcxCLZNnVSuA-htWrNroKvw>
X-ME-Proxy-Cause: dmFkZTFoRkS1T90Bxcjs0RAQBC9cOzO6furnyIpBYI2fV48fJ43dm1zZhRk7Z+PnWhimcH
    ebZ3eQdIrHEZADlY9bYxTd1k5uht4oU08BTZ/HP89Qjw+T0IrHmODcRPRL3RJ32d0J1yOQ
    PBi2K1CzaC8tW2ODme/VPV51XrLVs1GbuWgrOTcyCRElZ0qMyZUeG0LOPZZH2zn87HOqXy
    /TK9haBIFRJHIWVlOZTuR1f+ofJLKQQGj9CtvpNZIWpWFYqJeQnH2FBvI8tCXpgrwcHoJI
    +aq0GNHdsjllU8A6iHQQdG1B/4jsbEKYE2+Y1hY2PrG7Uo2YmMDNHl1dfkprxZTn/NJUfC
    /w8Gbvv/M7u3/MAieZAtIOX1RZukeWQ9+elCCYsODcHK9gT5u10/oZuZLXw99ukuVaS0xW
    3tDLYVVy+SKp2dqirG0JiVzyJbKkxd6SRetYEWu+JVaUoqQJis1TqSkLZzraS655urz/nX
    ba6CAsQgsfqD2aTbZx4l4PivxdnAXr1zU637mDzaEHd+fcAemfJIVAvcmBDvESSehECc9o
    0+9fY3RQATuxusDmmFvruPLrAvzXcK2/CqD0Pvb3ZNaU61K5RjWTFwIrT4+GmItInP2vWy
    PMOZ8zt0xROGC8O3Ot0U5RsMXDoTAFqWDQ7uHBc7sD/Iv75UXmoyD7sRgysA
X-ME-Proxy: <xmx:Mxq6arkSMbOiSpx4vEBSnL26IJ3Bu_1uVtF1JFq_qX-1TWc1hYONvQ>
    <xmx:Mxq6aoRkhMDSeB1Hkq8urebN3ksQw0yWLnJC0AQL5YgFvK6zhCHMAg>
    <xmx:Mxq6ahOy81oQWH8w9TilFAQThB_OCyAzjznpLK-M_APFyqGi-JnDUg>
    <xmx:Mxq6apX3Ltej269s_xHr-7iepBdXjzcxcKI9B5mziAQomeB5Vpx0Pg>
    <xmx:Mxq6aiBEgD8su2odRwHvAOhkikARLXSRilXSwV4s7RJVygoQTMCwOElG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 03:41:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 455fe305 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 07:41:37 +0000 (UTC)
Date: Mon, 28 Sep 2026 09:41:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Patrick Monette <pmonette@google.com>
Cc: git@vger.kernel.org, newren@gmail.com, toon@iotcl.com
Subject: Re: [PATCH 1/2] replay: handle failure to create commits
Message-ID: <aroaLu02NQ65Y2Ju@pks.im>
References: <20260925205348.1210154-1-pmonette@google.com>
 <20260925205348.1210154-2-pmonette@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925205348.1210154-2-pmonette@google.com>

On Fri, Sep 25, 2026 at 04:53:47PM -0400, Patrick Monette wrote:
> When pick_regular_commit() returns NULL, the caller relies on
> `result->clean` to figure out what happened. 1 means success, 0 means a
> conflict, and a negative value means an error.
> 
> Right now, if the commit creation fails, `result->clean` stays at 1. The
> caller doesn't expect the combination of NULL + clean == 1, so it breaks
> out of the loop, but the rest of the function treats this as a success.
> 
> The next commit will add a failure mode (signing) to the commit
> creation, so this needs to be handled correctly. Set `result->clean`
> to -1 when the commit creation fails.

True, this is something we should fix indeed.

> diff --git a/replay.c b/replay.c
> index f415103023..ad87863565 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -361,7 +362,11 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  		}
>  	}
>  
> -	return create_commit(repo, result->tree, pickme, replayed_base, mode);
> +	new_commit = create_commit(repo, result->tree, pickme, replayed_base,
> +				   mode);
> +	if (!new_commit)
> +		result->clean = -1;
> +	return new_commit;
>  }

Other error paths end up printing an error message. But we don't have to
because `create_commit()` already knows to do that for us.

Patrick
