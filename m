Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF7E3BBE3
	for <git@vger.kernel.org>; Thu,  9 May 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715268597; cv=none; b=MS7ck3yaMzPlfVNjgGyWYJPElGY2LdxT09Df9qufQ2S/tY2nWdI8IAOhFYLjhrULAGTizObQXy9TG0b5U3qSRY+9eQ+P71P/xsO8u+iISSoeXw3UYbiUJzuwNvmXnVOBRlbmXlnm79EMc8tYjw1tosASDdiH8GDzsXy6DJhAIh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715268597; c=relaxed/simple;
	bh=0wJaRJSJu3fieRgT0jFf8lbFTbfPu4NI4rY/0p9FCf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zr11/UMFnRa5aDG2m4mL5mMe4XpnH+MWHpymHkCzowtdvn39M9qXUrogWb1WrIimgetZklyyzbjgv/edNNZOZCtbTG+sG0uJ2GFR8jPlO1VZohpbLay8msobbwdQC0O4FoSQsdGVHqqzZJWYPl9gpIK4wFA4dabSvGN7nJ2AJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=EsVdYXnq; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="EsVdYXnq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715268577; x=1715873377; i=tboegi@web.de;
	bh=2QHRtg3Zhx6oGt5sUErXsQ0fKGiZmX0IsaKRcFWXYx4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EsVdYXnq61Wvue/NsUspvJ8UmhrvtjX8zerponwMcKtpETl6ZxSCmCO15hd3g8pJ
	 WBRRejghzBYgVDtUDz78amsSypdd0oBlhsxGnwoG3ZQh7iPBXsILasUGIdJetbTLJ
	 8axwkb/q8ChOH9e5ceVdunmiMXZbaghbG7pYeKAACflCab5WVpnKRZdebPclz68fB
	 1oZ2gGaSb16OR1woWL53YTBAU9s10sloAh7h9o5IT9ulFeQAXuFdiagT8pBvMtEV0
	 piiMYTq5OvlNFpHahxLxFwpDqEZOL0AV7Zwrhhd7FTjJxz2IU2+l1Gm6MMBLPYCIC
	 bmnJBiRbw5uwnhXCJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([213.65.201.17]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrww5-1sQ73E0PHp-00ebNm; Thu, 09
 May 2024 17:29:37 +0200
Date: Thu, 9 May 2024 17:29:35 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, takimoto-j@kba.biglobe.ne.jp
Subject: Re: [PATCH v1 2/2] strbuf_getcwd() needs precompse_strbuf_if_needed()
Message-ID: <20240509152935.GA31752@tb-raspi4>
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
 <20240507084431.19797-1-tboegi@web.de>
 <xmqqa5l1pmf9.fsf@gitster.g>
 <xmqqh6f7vwiy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh6f7vwiy.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:qDrSuGNQOa/o1P4C1j+kkxH0L/nfbVrklETNZCQdemqB80vHSuP
 pJoOeRjuV132XxP/vmfAf8USOQph1E//U05iHEDlEjm3A7PkRUkUfwqXw5z+rxE/86BGiF+
 +Mn3B2DZExOAmpDkVjn84WaoIfYOMXokwI6gsSkpOSfbjTQ0N71CPy4/87dXHmPyKOcmn+g
 rAu9CxXmx6NIrVl3Gch8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4unlzywIAJA=;eHlFA4S/b37yay08gCyZNyYaz9A
 IK7spdTQ/oNJaSholmyGdYrqFDrlf5SnfBq8hn+rrDIKQgiSfuHN7UD0lyJtMVuwlrxMNYphO
 sgQQ5X0Hw9frZMMrlOmNEsbu+2WS3I3hMXhS9OffQa1TFS2imr/Ei8S/utYMkfK/Ore0DS2el
 lVns+UpmviTUt9WpbutBRyPa6NTm+iLRP7Z6xieeaQwMKxQqqZJH0uieukoVdlHYqCh3ZRMCD
 vMe/VldxRCAalpFxid6sX+cbx4+3pdOqSyuy/xLhHajG+uv954j8nVwnwRu9jbceAJPulJY6w
 eBO4VsKAqMWph40Vcq+jMxk9kJqFxtaEaFmLQ0gBG4XT7tegsqv/OOGmGyKDVbLamnM+3jaRB
 h4g9ICrbii1IuUr2JMOvemckBCo33oo9Vx3gDjFKv1nl7q7ttxZdl/nMgttXP+VH+HJrI3L5F
 Pm2ZEzTTSrpo7P62le9QOYWpToGd404LOsCu6RAL7fuF+nzJM1+kxFbFFdNsxvP8lunC4blG4
 eBicOIzBwT+MsEmTkANF5MuSSp72Rzlzg3FT5mGGA0zOReJzhaDQhjwQK+H0nvIjowKhPngMS
 e/2QPHVIJsED3zgXHlxlUN6hwZHfL8vIpgx4KxzlXJyNGmG90/ZClRXUHMpyuOSx5RFZS+12r
 PEAG2WqEWUUE8CV+9rAKeTkswhLEghMAsRPeiuc2O+QaTF+ZXP7cLW3tv6jKHyHMUxVzzSmK0
 fbLHJEP8IdjTBpsAbDgZr2+8MfsnvLbx71XYoZewjzttV8k8lnVrhObHlLo3/Wq69D2woRW6O
 NWS9XYB/fkjwDfj0Q6jAaaTP6tejIv0GseykuxpghRhC0=
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 08:24:05AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> Of course, we need to make sure precompose_string_if_needed() will
> leave the strbuf in an consistent state.  I think the implementation
> of that helper function in this patch already does so, so
>
> 		strbuf_grow(sb, guessed_len);
> 		if (getcwd(sb->buf, sb->alloc)) {
> 			strbuf_setlen(sb, strlen(sb->buf));
> 			precompse_strbuf_if_needed(sb);
>

I think that is what I have in mind as well.
Thanks for the review, a V2 should come the next days.
