Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32FB2B9DA
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710088959; cv=none; b=AVTWZ7+NOQqzMVnT8czE8VrutBw1i9bJCFVNkYuCHuvyC4MTMs4Autemp/GP6o7aCJah+wzIwed1DztSKZ2tp9nrFkI9G+mumcxf61zVcDMwd8BOAjAL+m7c8k4dwDUkMBRf/YWGij61dOnm88lGt4BoFsPmdKVhBcu4AwOBZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710088959; c=relaxed/simple;
	bh=Oz2XrdbvBSrHbqXCu5Av/r+FoonK6MXBnXStLKQHTqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c04+zK++ImTwFlrlA7X2VLxGmuGB8+ahpE3Jt8c4+iqTB1/M6/z2bQ6LEL6qaYSs+lJu4KfXLduv3vI4uv7lvtwsDSXynT+KdKyF8z3XqE8Jt/JuTzf8ZwDESNyE8E0MKb6fA806FSTX1xfrHGvNWojMOsMOY14b4esHWzk2meA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lvfeX7Ei; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yOU9A+o3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lvfeX7Ei; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yOU9A+o3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lvfeX7Ei";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yOU9A+o3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lvfeX7Ei";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yOU9A+o3"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C482020ED3;
	Sun, 10 Mar 2024 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710088955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhaEGJlPp+TEIpl5Gfc82RQVKWecVvGcm66YoXOEjZ0=;
	b=lvfeX7Eia3etpc8b/0M0j9WwiwK/plT87y1XVUz5Fr+XkY2uOL+Y/DNWyefpZYHUJL7g4u
	uTJNK4tSPATjcbFa/Evs66LRU0Z42NVbgL17EO3s+XzS8V3pbI/Rg8n0+3CW3b0ObvC7Z0
	wdFAXpFfc+63aac6Awe3tdKbO8MMIgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710088955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhaEGJlPp+TEIpl5Gfc82RQVKWecVvGcm66YoXOEjZ0=;
	b=yOU9A+o3IP9QymWw6ciNFAJP7pY1ioiWlWo56bWdLN9TMOYKszGRC7vtSHWkZCQCLl+R1B
	Dg+Ac1NP9tLuZvBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710088955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhaEGJlPp+TEIpl5Gfc82RQVKWecVvGcm66YoXOEjZ0=;
	b=lvfeX7Eia3etpc8b/0M0j9WwiwK/plT87y1XVUz5Fr+XkY2uOL+Y/DNWyefpZYHUJL7g4u
	uTJNK4tSPATjcbFa/Evs66LRU0Z42NVbgL17EO3s+XzS8V3pbI/Rg8n0+3CW3b0ObvC7Z0
	wdFAXpFfc+63aac6Awe3tdKbO8MMIgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710088955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhaEGJlPp+TEIpl5Gfc82RQVKWecVvGcm66YoXOEjZ0=;
	b=yOU9A+o3IP9QymWw6ciNFAJP7pY1ioiWlWo56bWdLN9TMOYKszGRC7vtSHWkZCQCLl+R1B
	Dg+Ac1NP9tLuZvBw==
Date: Sun, 10 Mar 2024 17:42:34 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
Cc: git@vger.kernel.org
Subject: Re: unintelligible error fatal: empty ident name (for <>) not allowed
Message-ID: <20240310164234.GG23839@kitsune.suse.cz>
References: <20240310151533.GF23839@kitsune.suse.cz>
 <20240310160338.GA7953@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240310160338.GA7953@tb-raspi4>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[web.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	 HAS_ATTACHMENT(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FREEMAIL_TO(0.00)[web.de];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:+];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 BAYES_HAM(-0.00)[13.77%]
X-Spam-Flag: NO


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Mar 10, 2024 at 05:03:38PM +0100, Torsten Bögershausen wrote:
> On Sun, Mar 10, 2024 at 04:15:33PM +0100, Michal Suchánek wrote:
> > git version 2.44.0
> >
> > git am -3
> > ../linux-6.8~rc1/debian/patches/rk3588/dw-hdmi-rockchip-avoid-tmds-spam.patch
> > Applying: dw-hdmi-rockchip: avoid spamming 'use tmds mode' in dmesg
> > fatal: empty ident name (for <>) not allowed
> >
> >
> > What's wrong with that patch, specifically?
> >
> > Can you tell?
> 
> The message seems to come from ident.c
> 
> Is there any chance to get a copy of that very file ?

Sure, I can get a file that reproduces the problem.

> Or more details ?

I would like to know more details as well.

When gcc gives an error it tells me exactly on what line and what
character the error is, giving the errorneous text in question.

Here I have absolutely no idea what the problem is.

Thanks

Michal

--rwEMma7ioTxnRzrJ
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="dw-hdmi-rockchip-avoid-tmds-spam.patch"

From f3b68d2a91d3f443a8b86173c9cac01897075b84
Author: Lukas F. Hartmann <lukas@mntre.com>
Date:   Tue Mar 5 21:07:08 2024 +0100
Subject: dw-hdmi-rockchip: avoid spamming 'use tmds mode' in dmesg

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index dd154855a38a..b10a70870a10 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -737,7 +737,7 @@ static void hdmi_select_link_config(struct rockchip_hdmi *hdmi,
 	hdmi->link_cfg.rate_per_lane = max_rate_per_lane;
 
 	if (!max_frl_rate || (tmdsclk < HDMI20_MAX_RATE && mode.clock < HDMI20_MAX_RATE)) {
-		dev_info(hdmi->dev, "use tmds mode\n");
+		//dev_info(hdmi->dev, "use tmds mode\n");
 		hdmi->link_cfg.frl_mode = false;
 		return;
 	}

--rwEMma7ioTxnRzrJ--
