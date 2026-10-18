Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B013A168B
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792322342; cv=none; b=m2qrvoRD7tHIwHc5ZrpMIXUPA7AWDmvjssluasLZ9+9cOdFkYFMfpVjVgU2Cu7sG//PNYIb8VIAvoZQc3bmKOeqUZ2pU46rAK0NIbkJHiuAaRGbAihH9gcQTZrrrxQjk0jKWTVxhJgGbFIItNdLGOy2JHLzUCcldNH55SbNLeOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792322342; c=relaxed/simple;
	bh=bfUdTL/K2IqXbWPtsYSYEIm1ioosurMnYXs9ttc+cVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNyriw+04s1yL/3lIVOL/R+YXoK4PZGHsgOdgWjyxsjdw1zxtYCmHzXJj47IHAsdKLvQN+dOQvzFY2pvPF3fUzxuLaVKatcJIJvpAEp13crnWAfzZKOcdT4mBXSYind7HV8GLeOMvPYN01bvISzf7MLqCBLNlqKs8QOuNssa260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=tAkm6UHH; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="tAkm6UHH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792322332; x=1792927132; i=tboegi@web.de;
	bh=9+5biY/f/fUU0S0gaCTQI111Fbl1jrI4kVspnrNN1xk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tAkm6UHH9/7EaaJ6izJrKD2JABQt4vBrMAglkFj50mLMRhOW9m15Yy1rnw7e8iME
	 2NZXN16/pMWwL5i3lN41QUf2uFMcsfUlbM45L1JR1TJeSERRs54RJUxkriP5AiKQg
	 2RczuNlmYh9gCGJafPcewd+pbkendT1QxW2ZPNGrwGWcg9WA4RYOixuq2GrssTdpn
	 zKKB8toQXkBiOv3xvy6hPk20TDz0TYfIRt5kbkxWztaZSdfT0IBtWJMFt2LSkvYJj
	 Jl3rRnbxSMXUQLAICYAlGKfSj9GOnDteu9+se9VXuZwgsTMqMFdncPEf19cHXUm2W
	 9gfQU5qsRi6igSeKbQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoNV4-1wpdjw22um-00omE6; Sun, 18
 Oct 2026 13:18:52 +0200
Date: Sun, 18 Oct 2026 13:18:51 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Curtis Allen Smith <curtis.allen.smith@gmail.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] read-cache: do not trust a size change when
 conversion is active
Message-ID: <20261018111851.GA27528@tb-raspi4>
References: <20261013065915.879-1-curtis.allen.smith@gmail.com>
 <20261013180206.610-1-curtis.allen.smith@gmail.com>
 <xmqq1p9twdhh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1p9twdhh.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:nJtuWOXpScZkEdIYFo5bSvS6CYAxeNqyDRhbZQf47C1o3QrEoMx
 EdqfiPC6lSF0/t/3/dANxCNujn+jp+QQ2H7EmTHvI3ngO2dorwubn+rZ1B0H6MXzxH0EXHK
 ZmoxXctthQK3TRMBRsHXgoLt53SngJeqZRM/+gF1bn17mK8ol5xWRtB7urWCz0N/bYVZmCx
 d1bDRSmWKoeZlpPcl79Mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N5nM0pVwIQs=;zqnU6rqVYmCJEYFGeiTw5SFjSj/
 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
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 01:29:46PM -0700, Junio C Hamano wrote:
> Curtis Allen Smith <curtis.allen.smith@gmail.com> writes:
>=20
> > 	git status --short      # ->  M file.txt
> > 	git diff                # -> empty
> > 	git add file.txt        # -> nothing to commit
>=20
> I do not think "git add" would ever say nothing to commit.
>=20
> 	git commit file.txt
>=20
> may say "nothing added to commit" when there is no modification made
> to file.txt to indicate that there is no change worth comitting.
>=20
> There are code paths that make performance trade-offs (see the
> introductory part of Documentation/technical/racy-git.adoc for
> examples) and are designed to tolerate false positives from
> ie_modified(), filtering them out themselves.  I am somewhat
> hesitant to butcher code paths at this low level to make
> unconditional changes that reduce false positives without thinking
> things through.  For example, we may want to disable this new code
> when the 'CE_MATCH_RACY_IS_DIRTY' bit is set.  But the goal
> nevertheless should be to avoid surfacing these false positives,
> which are deliberately allowed as performance trade-offs, to code
> paths like 'git status' that do not further filter them out (as you
> demonstrated above).
>=20
> There may be other cases where this patch unknowingly breaks
> carefully made performance trade-offs.


Looking at CE_MATCH_RACY_IS_DIRTY it seems as if the call
to would_convert_to_git()may be better done in ie_match_stat() ?


Beside that I was able to test it with a real live repo,
where a clean filter replaces a TAB with 4 spaces: Now
git status no longer claims the file to be modified
(and refuses to stash or other operations))

[snip]
