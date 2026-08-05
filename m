Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0113D891
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909988; cv=none; b=Jr0majK5SEYbsAmpI8kJHXXttDRTWZpCffdesuccNdZptj8mO2kteKr0eUtgDvJ5vUw/RVewS3VOWbnqhs8czZjmOo4y2EAUbV2EIvY5wFkfNFfGuHgGdFGLe71e5u9C9jDc2oLg9RCBBk7oLHrM/LyeIB2RXNJKLZSIOg2eae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909988; c=relaxed/simple;
	bh=WyNDKReIe6oHWnwxxkwpeaVdOFQfctyjF+/KoSsfPqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC8xfMGw1JJXqLVAT0LztVyrm8+kkhlqdbsa/8VfcPdhJi5GJIjN964gZuS5RrcRPkCh6wlmd/bzDtACkcpOENF11VDEriVkU1Z6PI4iuwiPBp9pe5PsjybbsGGKupIlvfUuFSlxOkOXAZQX1PrIYj+BSGftaWXU8P3x1wQTyaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H51JtNsg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tb8H8faF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H51JtNsg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tb8H8faF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 14508EC0194;
	Wed,  5 Aug 2026 02:06:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 05 Aug 2026 02:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785909986; x=1785996386; bh=lfTM90F+6e
	7S75Mj2xPxlxRIk4Barsx3n8rxGuviaGI=; b=H51JtNsg2brxqlZC7Rl8fYbIUh
	VeKAJNhIs5V5CnPU+tbpNROl64VS+60BjSnacXuf/Uy09Zs4vXQyaCg1QBu2wpm8
	P61oyAakGAsSxiuMg5+08fcaapO/db1c6a9CQHixCl4fZsq4cCXLT2HyCayh5isk
	Wg+8nOzMAuINTorBFu4cBozXwHxpw1Y6x1Tpxbldf9gEtJWpOFVVsygfrWDpt2pc
	VoQjUhyBsS+KG0bsCzF0taux6StRrZxTmapexIq9DY0pjAg2DoGhWXTST8sGOBws
	m05dUhwpN6glbzt3iiBAYmGQHbWGCUw2ys/ElP8AuE/dMdREiw5o5iaOp7rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785909986; x=1785996386; bh=lfTM90F+6e7S75Mj2xPxlxRIk4Barsx3n8r
	xGuviaGI=; b=Tb8H8faFkpNQkmup8u/XXuz79hKy2InrjRPgG0F4AN+zNEgu2Kg
	k4+fzl0ndmIIWiQOJSsNwu7rUUlhfIQEVkHVrjPbcGF9W+gThyHCcxzRMWZ/ISvk
	KRpHHt3ZSmN/qeI6KZydBSNz4bzWRkoAxaI0hZMnxPRZoiNFeBPtcYINGHqsubf7
	8ypLgHeJTgMyHZh+9Mp2NsJSLwuhznIL8Irjs1DuF+p3/rKmPOLsrr+Au8Y2fXnw
	Z9Gsohy1ZLPUio/oyjQiiORY0Y8rRhrfhprtR0H1AW3lNktACgAMtZK+yPli+Px0
	b63DBRQLrOBzoCirz8vOEDw6bHz2K8Qfehg==
X-ME-Sender: <xms:4dJyauAq2GaAJ_RBkgEMrgRabsAKMU34jEATTFgaKmVSdpwHA2bswQ>
    <xme:4dJyauggo5_6QZspzHSf6K0eX49vb32ZQmDcxTtnJSFr1Qxe53bEhu0MF_qeo_Y5F
    Ntj-ibsxNJbX45_f8okRWro3fbhgPo6wLycUAyvzAAw6ji3QYOtbxY>
X-ME-Received: <xmr:4dJyavNoLkKkuIPXnxoDshIQTajdiK8pNO30GculIjYtcSwNEi7h03yzmKA5famhiM4FL2rk25EsM7OkiWHcVCvMAXC1Lw_roW9tvbJ0Rg>
X-ME-Proxy-Cause: dmFkZTEIZFbnenMqu24mENywfuGN7rf1FlaIFwqJm/7o+oZ1CiNyzIYvteUMQi4eG/xU5P
    Ea1zKoXgxHCOSDFqJS14ML0InlDNHobdsNJEN/6CKdN87BRQ3IgrQnj59u9FEgnLcywPiC
    HzaiuRBKSrM6veX1rSP1dnpVH/jdq9ZwfNyFoLGrNbbewMP+vdiL68Uw2Ewb8/uHaB2nhg
    hSkP6uYBrZVqIiwjXKQu4tAjRAL7tK6LyLjuOQfsFrD1+SfqSVaPRxebyanAvA+9fW37bH
    Hq+7xF9/veuC9RrfXqiDgk2CQROCg0sOUzIZIvzNd2E8Fa1bfQyb8f73O/87UWgOe4PWf8
    sOl8h3CnYFWD7tF8CWvNIHv+b/2FYpjG7bMvtdPh58N4KSpLkhr2Qrhj/BZgWYJHcYOSpF
    iz1DXxLk+7JpnlFj66IyuJ1cLR2yRTPvDTWUUDdn/2347Ul2ZIWEwafxL1HO5M1Ay97ZAh
    l4MHY+g1vTDnORw0WJh8Grm8VHI7H0/SQeT8RNcILkJqnlyUEMRv60F6TC8VUeKsOFMlMT
    B0r8w6VA7WEV6WLMxLoNrFLD4fdtL51OpOjpv2W68LIDrfdLdzwhPlK06IdoDJ6JAynz08
    a9ye/XB9LYSYEAW8ZJzA1SJUSt0s1PVbvh9+d6zoyDGD3LJt5/sCgyP5LHnQ
X-ME-Proxy: <xmx:4dJyan5K64FkQlV_h0Qb8e6GuUsqYsYRI6rsxCAUOIxUzpSzw_WpXw>
    <xmx:4dJyal1pCpAvbYkKu2y1oKiRncFd05V8jJqza7ImbYUmU0ZnT0JDKw>
    <xmx:4dJyagZWbBRSmh_6_qIxmgA3QPBbW4plzSl9xJfLUS9Xg_DiYctUBw>
    <xmx:4dJyalC3hmSVgIVJqS2x_R1sIV4OX1YR2kGx3UF4HnYW0yAj9JFADA>
    <xmx:4tJyatzTLvUF5PYdwL37mUFRkH7FydDIBk4_2NQ4yXdbmmW5tWpKvH8b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 02:06:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1917a2e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 06:06:22 +0000 (UTC)
Date: Wed, 5 Aug 2026 08:06:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/7] odb/streaming: consolidate read and write streams
Message-ID: <anLS27cZglL-tK5s@pks.im>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
 <20260804-pks-odb-stream-unification-v1-5-86d70e82345e@pks.im>
 <anIrtigj0L7PU2hl@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anIrtigj0L7PU2hl@denethor>

On Tue, Aug 04, 2026 at 01:23:42PM -0500, Justin Tobler wrote:
> On 26/08/04 09:25AM, Patrick Steinhardt wrote:
> > diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> > index 7439ec53be..05a2d48011 100644
> > --- a/builtin/unpack-objects.c
> > +++ b/builtin/unpack-objects.c
> > @@ -359,20 +359,21 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
> >  }
> >  
> >  struct input_zstream_data {
> > +	struct odb_stream base;
> >  	git_zstream *zstream;
> >  	int status;
> >  };
> 
> Ok, as mentioned in the commit message, we now embed the stream instead
> storing a pointer to the extra data. Should we also update the struct
> name here now that `input_zstream_data` is really itself a stream?

I intentionally didn't rename anything in this commit here to keep churn
minimal, and deferred the renames into subsequent commits. I should've
noted that in the commit message though.

This one structure I didn't rename though. I'll add a commit.

Patrick
