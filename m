Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23480182D2
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599861; cv=none; b=J9Yvz/jmcOCrp9w9rSfWzGOIdVW2TFyRiSYbYgFRb/zQHiSzVl96nMny1m1XumvRfpv73Zu1fMiUCl+ZvfcWIcdjAa1QgCRdtfAAF8BqmUGtsbp7s9wSw2v+vwKiEkLhShmrAmxYvi+iC8+8DS3kaASNin1lQD70glSqcSjjRR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599861; c=relaxed/simple;
	bh=OR1xZHPsfrZu1PcnJsg51SNotfNUGsLEcP7RoR0qSDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYIlLXjg4M+ro8Hy/6UM0i1le/LSClA/VpsYI6Ibgldqz01Quf6w76+bKYodBV0Gd5yOwWFpmS77uJKFcTTej2130JGJY9TK/yC32b2vNvGcJTNuHR0jBi3q5N4TY3TH2rM5f4tDkPwRoHeXQHRd6pV4l+S6A7GJs80gMMGpPJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YASttTng; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ASgGMZ+4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YASttTng; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ASgGMZ+4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YASttTng";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ASgGMZ+4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YASttTng";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ASgGMZ+4"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 605C321E42;
	Thu, 22 Feb 2024 11:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708599857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M434wCxxPOlvC2zVyUbme0VMdz0TNt24HgFWcjDw9vw=;
	b=YASttTng8kqe5p2JQEc+nN9KXMA4urFuU0r0nI1NzHPhOVCrcJWka4PvvljB4G1y01HZrg
	PECzyQXTeJYK6zpbhYmKdr8F09qgP1GK64TJnqqJgMZZKVwCXWOjBa9e0AxXB0SRwZhDC0
	gyiVervORsXw+4izpnJLkYNiKWWOrxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708599857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M434wCxxPOlvC2zVyUbme0VMdz0TNt24HgFWcjDw9vw=;
	b=ASgGMZ+4MAVvEIg1pF29A50GG/VxDf2jo+kecyrWgMidNe5CPel1iynBc3dOR/77Tq8/ut
	XB/UsEU7JSE20GDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708599857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M434wCxxPOlvC2zVyUbme0VMdz0TNt24HgFWcjDw9vw=;
	b=YASttTng8kqe5p2JQEc+nN9KXMA4urFuU0r0nI1NzHPhOVCrcJWka4PvvljB4G1y01HZrg
	PECzyQXTeJYK6zpbhYmKdr8F09qgP1GK64TJnqqJgMZZKVwCXWOjBa9e0AxXB0SRwZhDC0
	gyiVervORsXw+4izpnJLkYNiKWWOrxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708599857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M434wCxxPOlvC2zVyUbme0VMdz0TNt24HgFWcjDw9vw=;
	b=ASgGMZ+4MAVvEIg1pF29A50GG/VxDf2jo+kecyrWgMidNe5CPel1iynBc3dOR/77Tq8/ut
	XB/UsEU7JSE20GDA==
Date: Thu, 22 Feb 2024 12:04:16 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: =?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>
Cc: Junio C Hamano <gitster@pobox.com>,
	Harmen Stoppels via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Harmen Stoppels <me@harmenstoppels.nl>
Subject: Re: [PATCH] rebase: make warning less passive aggressive
Message-ID: <20240222110416.GD9696@kitsune.suse.cz>
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
 <2324063.ElGaqSPkdT@cayenne>
 <xmqq4je1mo5p.fsf@gitster.g>
 <7633780.EvYhyI6sBW@cayenne>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7633780.EvYhyI6sBW@cayenne>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.11 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[free.fr,gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FREEMAIL_TO(0.00)[free.fr];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[pobox.com,gmail.com,vger.kernel.org,harmenstoppels.nl];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 BAYES_HAM(-0.01)[48.26%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.11

Hello,

On Thu, Feb 22, 2024 at 11:01:59AM +0100, Jean-Noël AVILA wrote:
> On Wednesday, 21 February 2024 23:46:10 CET Junio C Hamano wrote:
> > Jean-Noël AVILA <jn.avila@free.fr> writes:
> > 
> > > As a translator, I'm less bothered by editing a sentence to remove a 
> question 
> > > mark (maybe enforcing a language style and reformulating the sentence by 
> the 
> > > way), than by translating again and again similar sentences.

Indeed, the style part is the key here.

The message that is changed here was quite stylistically poorly written
which is why only removing the question mark is correct, and it's why
it's changed in the first place, too.

While this is faithfully reflected in multiple language translations
there is no saying that's the case for all languages, at least basic
understanding of the grammar of the language in question is needed to
verify that.

> > But the above assumes that for your language, the ONLY thing to turn
> > such a rhetorical "passive aggressive" question into grammatically
> > correct statement of a fact is to remove the question mark.  It may
> > not be universally true for all languages, and for some language,
> > even after msgmerge did its job correctly, you may need to do more
> > than just removing the question mark to adjust the remaining "foo
> > bar" part.
> > 
> 
> I perfectly agree with you.

Indeed, and that's why per-language review for such change is needed.

Thanks

Michal
