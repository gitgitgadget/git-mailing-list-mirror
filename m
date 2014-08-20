From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] git update-index --cacheinfo can be used to select a stage when there are merged and unmerged entries
Date: Wed, 20 Aug 2014 14:08:53 -0700
Message-ID: <xmqq38cquavu.fsf@gitster.dls.corp.google.com>
References: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
	<cover.1408533065.git.jsorianopastor@gmail.com>
	<af54b2b3e80a6ff76b07ea129ead43079ef06a7a.1408533065.git.jsorianopastor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:09:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKD87-0004Eu-9U
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 23:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbaHTVJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 17:09:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61082 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753649AbaHTVJH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 17:09:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3063B32506;
	Wed, 20 Aug 2014 17:09:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sVOE3QenllHKQU/3Hj1+aM00mRY=; b=yVVtNJ
	PZ67/1GPosDSwJrU2J3p5AxSikjgH3x/M4m0vQtNCVrOFxsPGLGU/BvZew1SD/Bt
	ns/4rCO+6t4WwHcMgUSXLEwZE8QKovF4CDX0o2Epjaen2R9AruzekvrmngZL/bEH
	IZqAttMi+PfEN5T5BXDBGh3bniPYykyTdYI70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RmhyioUQ6TDvHMmNglaPRyjV4G+CHUsz
	RplbSuhi8zZu5Xl4/QeueRAQktYtvZxi2AlHUCB8Kn2ysYVGDnfmj4pLJC+TE1yX
	Z6Fy/JyKLY63t5CxEPOXBBk3H2t9hqZHAyJZHF43MHKcNr4ElqITh94gXWN5d2qm
	y31gH+hUlII=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 25C7632504;
	Wed, 20 Aug 2014 17:09:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 45073324F7;
	Wed, 20 Aug 2014 17:08:55 -0400 (EDT)
In-Reply-To: <af54b2b3e80a6ff76b07ea129ead43079ef06a7a.1408533065.git.jsorianopastor@gmail.com>
	(Jaime Soriano Pastor's message of "Wed, 20 Aug 2014 13:26:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 31CD6FCA-28AE-11E4-8A4A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255587>

Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:

> Subject: Re: [PATCH 4/4] git update-index --cacheinfo can be used to select
>  a stage when there are merged and unmerged entries

Hmph, what does it even mean?  Shared with your [1/4] is that it is
unclear if you are stating an existing problem to be fixed or
describing the desired end result.

Also "update-index --cacheinfo" is not about "selecting" but is
about stuffing an entry to the index, so "can be used to select"
is doubly puzzling...

>   ...
> +test_expect_success 'git update-index --cacheinfo to select a stage to use' '
> +	setup_stage_state &&
> +	git cat-file blob :1:conflict > conflict &&

Style: no SP between redirection and its target.

> +	git update-index --cacheinfo 100644,`git hash-object conflict`,conflict

Style: we prefer $() over ``

> +	git ls-files -s conflict > output &&
> +	test_line_count = 1 output

Is "we have only one line" the only thing we care about?  Don't we
want to check which stage the entry is at?

> +'
> +
>  test_done
