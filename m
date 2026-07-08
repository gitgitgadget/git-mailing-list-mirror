Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452943E9C05
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497332; cv=none; b=u8mk3Ize8BvjXnQ1EGNSUCkYxRcovE0joa6U6Gn1yeP4Fd3pNVajxFbMU+AqE8c3Aj09QU44pKa/Xz8ordcysDYCpYey9R/0NkuWSaDm1K6Y8qRHhQ5z/KU9cINm/rfA4kb/KLNoMERuxi4KzDSx4K3fLYZDO0u4zeJOk1lJH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497332; c=relaxed/simple;
	bh=c46jIIQViKFqL5jW5plU34c66CqbW4saTIToMzNIORg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyMMcShobRUMHUYPplZGjMyJ0DvvOdw42epJyyvaVuGdnCxq2/+cn+nJ9Gi8fM246RNh5dNgWJKLnHwQgRw0FIya0ob9f9m+FuK40vTktN02zSf68Vfk6KjmABaoSH8FbIVAfnknfJgAszrN9/TGTWit/FYd6n/SMWtiXY17fRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V3A0jGKs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iMM0JuYp; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V3A0jGKs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMM0JuYp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 02B8A14000FF;
	Wed,  8 Jul 2026 03:55:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 03:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783497321; x=1783583721; bh=M+wEQI7Gr5
	7g6wzLArp3a8Vm7EzTPW57uN0fH0IURfU=; b=V3A0jGKs2DzaAqVdSbX0e+ce1L
	VIl556rlWt9QEczZwTEGk+nmo080YiodBkOG3aYt0fCR52+56pSX0QMj0TMrKBxC
	t85IvDOOb0IuINxy6Ohau8zrTqBbxu8Cgp2nesJQfpVqZZDwuli26M3eBlbw0tux
	7xj1l+1D/keVE8AZcuoV4vBdS19Bd4Q66slyr8fNJZMFx7rnzaQAM+FRP8HuP8yb
	PAuK62jtdiDQQN8knZF6lFdmj2F6gxDaE7LDqUYEbRjQmXJGruM/7TIM70b2ciw+
	454tih2DOeVUnz2bCs0u6rifZ6JIkZAw8U7mxeId/hEpVFC9Ld2Mt/uCJfCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783497321; x=1783583721; bh=M+wEQI7Gr57g6wzLArp3a8Vm7EzTPW57uN0
	fH0IURfU=; b=iMM0JuYp6WroJfDvCXVUDt/l2Unp+2YGfJLRW29Z1IVkl1Aui5v
	LeGk3w31oGF624i35jf7jdx9j424WOZ0wasjJcXnAEpOLKbLcbnpLHl2kqngbskA
	FH0El+dt+C7+pg9qtxMEKWNlryRI4QA9TtDLvs9Lr/Pi9UqjOZVnRmN2dhgd0Pf5
	+NHqleZHLH1HLD9nkH6dBjHJwF+j3FaGaMteJVRqgT2op6ORRlYptajbDyA917Gw
	UPrv6PWz05yf/RaxKmzOOMH8eMwG/RwWyOPzOhgdW9smRyTSMtliSQ/h4ysXp767
	sHzE0M6rEnjvvL8bzXZHc/gCtiHfJ6qdO+Q==
X-ME-Sender: <xms:aQJOapT59lbhKPD_jV4NIeC9b81nd3KtU2MB_KaF4A_dRTVsHJxz3Q>
    <xme:aQJOaozbZjC0sqX2Snke8W_cuyRbeNIqkj7tRUVP-MZC_GForqHRperVRrwKYZqVe
    8p9NclyoP6z-Te9kn_DlQXRwHJRwtgkia5sXEob4wZNF3Ke3mmofgA>
X-ME-Received: <xmr:aQJOasc4ZAZgbqQafqueyImBZ9jse26VTIx2qhap5qhLgriR6-EtjHZ1m5-Tv-BFOilRLVcD7y61slfBjW9EJbYRl1R8WhP0t75i4IqO>
X-ME-Proxy-Cause: dmFkZTFsSy0LHgfgGKBuXQSum/x25oNl/apA/bNk6FvTVQrGy9inFyz/K/mkIrtXQN4/Sq
    JKJvMs98CnxMPuUvZrmsbRX2eWc0uBu45329VVph5Kp0r2c7e/CXDvxtYp1AM2fGnBGBWl
    hKO0h4UtG/v2nqspVeDnkUdMxcobeJBA86VkRl6KerVthy1Yxe56IwsPlrxLbPpDCQluLu
    SeoQuA5k3cqk0yQ3SJ9bZxkOV0CxJoMa4QOMhxda8L0bRxCxImLVohNiZZJbdvacV/1NxU
    ADR2Q5CGzA+IVDzYUDTHxpQ6bDt7tnZMapmyWQ1NUG5aoP16XvRPjFM3X8BSpavo6cS4MJ
    tbUGJkcoSk7dnDb2gafbUeDsAkca9hgfoW/BhzYV/c/UZAMusB+brNP1asV7aL5QHCZxfO
    5etVoo3tv3N9TFFkC7FOtXT2oOo93JPqov1vSfg1l3+WC/YeOhAwr3oW/yynFAhTkkO8hb
    Ug76TagCrqzonQZ+3OtTcTEy9zUNhGmjGi61T547XZeHrRSAHQTNsocLkGTOabiUZDc57Y
    prHLCQCvkEpZxOn5yBsW+I9WNRO4Ik1rqQZKvVCneV4R2kvwik/aM/8R/Dwa89SNp4d4pu
    Ly0SIfQwoVk/17LixhR7yF/2hPa0MWsG9ZKF4M9Munn7QAYr0K3evUC78AzA
X-ME-Proxy: <xmx:aQJOasI__dTpGVWWVcVhrpquPGCr1Lw6j7vkVhlYwK5W1m-233PrNQ>
    <xmx:aQJOalHvuiPUSxgmJV9gGUmostjduSLQhvF5Ojz4ZAacFZfeT4LHkQ>
    <xmx:aQJOauqW3qO_i6spXVjttpch4X9IJ9PmsC8aeOtwhLnONZ4CWsN_dQ>
    <xmx:aQJOamQwqah2nULj9q0-tpnvmpPoXBpqAOIzWZGYDiFxZ0OVSLq8WQ>
    <xmx:aQJOasphTJp-Q-7CEI54yW2Clb0_FxsZpMa81LeKPIa9AOfOSXc2cws1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 03:55:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 858b4fd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jul 2026 07:55:19 +0000 (UTC)
Date: Wed, 8 Jul 2026 09:55:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/11] odb: run "pre-auto-gc" hook for all maintenance
 tasks
Message-ID: <ak4CHGpIhVIT9sd2@pks.im>
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
 <20260707-b4-pks-odb-optimize-v1-1-aae607667be4@pks.im>
 <xmqqo6gi1sng.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6gi1sng.fsf@gitster.g>

On Tue, Jul 07, 2026 at 12:55:31PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > index d7f82e1bec..1212b306b6 100755
> > --- a/t/t7900-maintenance.sh
> > +++ b/t/t7900-maintenance.sh
> > @@ -740,6 +740,127 @@ test_expect_success 'geometric repacking honors configured split factor' '
> >  	)
> >  '
> >  
> > +test_expect_success 'pre-auto-gc hook runs exactly once' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		write_script .git/hooks/pre-auto-gc <<-\EOF &&
> > +		echo hook >>hook.log
> > +		EOF
> > +
> > +		# Satisfy the auto condition for multiple tasks, both in the
> > +		# foreground and in the background phase.
> > +		git config set maintenance.reflog-expire.auto -1 &&
> > +		git config set maintenance.geometric-repack.auto -1 &&
> > +		git config set maintenance.rerere-gc.auto -1 &&
> > +
> > +		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
> > +			git maintenance run --auto 2>/dev/null &&
> > +
> > +		# The successful hook does not inhibit any of the tasks...
> > +		test_subcommand git reflog expire --all <trace2.txt &&
> > +		test_subcommand_flex git repack <trace2.txt &&
> > +		test_subcommand git rerere gc <trace2.txt &&
> > +		# ... but it must only have been executed a single time.
> > +		test_line_count = 1 hook.log
> > +	)
> > +'
> 
> Somehow I'd feel better if the hook used a full path to the append
> only log file, but it is reasonably clear that these three commands
> are unlikely to chdir around, so it may be OK.
> 
> Obviously not in scope of this topic, but I wonder if we have a
> better way to test these three "housekeeping tasks" have run, than
> casting in stone the current implementation that spawns these three
> external command as subprocesses.

Yeah, this is awfully fragile indeed. Since 25914c4fde (maintenance: add
trace2 regions for task execution, 2020-09-17) we already have trace2
markers for each task that's running, so that may indeed be a much
better way to figure out whether the task is running or not.

I've made some local changes, but will hold back with sending a v2 until
there's more feedback.

Thanks!

Patrick
