Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072438330A
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168280; cv=none; b=eDg583CsC6rg3aJ8n8d1DlcXjUkEcID5XwjdOv552cylKYwddWRhJCTMnoVGDLE+93VgTMyf+q1dwJkYXIZtWNOBdrEeupF9+yGZ76c1GGSV1AU34j6VPxATXK9PhwrtAr89aMCBODW9NcYh++reJxBE7PVFRZFJGftLpk3pWSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168280; c=relaxed/simple;
	bh=q4MlR3X2ZfRS4orPILlccSc3v92UL0dSqzcdhBEtZEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+yt5Lg++VkkQNVVlzrKjwpxIXF7OHZzXQuZlrlQVibCqf8tI0f/jUg1vcDK66k0c0Vl1IQ7DwuZBbybzILugeo8rrHFVUBA78ytpIUJBcmVTc9j8k3kIqXl0qIZ+yA1LpRnauKV3rK0OySpkK1em/AvMD5ixS+JMUXhiGJGuT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LUNL2FN6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xo+GlIwU; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LUNL2FN6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xo+GlIwU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9EBCB1D0007C;
	Wed, 23 Sep 2026 08:57:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 23 Sep 2026 08:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790168275; x=1790254675; bh=fRo56A/Vzj
	AMoQeQF7KBlcAlh2NVHzFD5GEnjgSuKug=; b=LUNL2FN69tvxW811j1NnzNDjgC
	oOdU6S4jDmUgYVjoi2MuNWQ6pby58fN1csCw0mQ5Y7Mo0bvI1bw65Wrnv82zWEt0
	Qsh40BMjLbI/c7AZwVz+Zybd+j0DQTWcJ1CMwmlB/oTYZMDWI+rJGiWk2JvYsf7h
	zgnCllvP+DWPX+L6iU6eyvEax7g+/+VEtQjkDEycoK+rpF8EY73+2/Wf44xnPvl0
	QgRQvhIywkJ+ZpeH+wEbbvV3G9MdposJz5mswQrk1o8n7WdeTFM6wkuhfYvDjn1O
	+bv8lX5d3Gadf3CB/gO7q82gLpG6YGOKbeAR4XFq9t0nxUk7qbWsRCclmpVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790168275; x=1790254675; bh=fRo56A/VzjAMoQeQF7KBlcAlh2NVHzFD5GE
	njgSuKug=; b=Xo+GlIwUZuSJAa/B4J/MRK9Zt+7biBAekd+3HKa1KgOIf37ffkd
	+XYmLzPqQ3QN17wkVhCf2MwejupZHsUGMo4oiLddrqMZBU7H4dcKm33uZhsjRCVh
	JPmXGxLj32KYhf/lCGJ07KJPWmeqsqmkFSCK+/G1dHOudpBVnaoZAnVNBE+pZHhK
	4tbJMEqysj+CAoYcS5aHj+AQzhbIrJpbQ4FqNIlEVN+YheCXoAUzoSG9Wz/KRltk
	rV+oc1Epc3IrPvxTUEpe+RDaG2mRlcb3T+VxpZlrDJKBV4hE0BvVhnVEuRW7pRfd
	moMUYI+Yh9G7tcGLRMi8t+KKi63IO909F1Q==
X-ME-Sender: <xms:08yzaiL58Kzn3IFysNJ--lskmgSc-ZrhzT95NVVv5S3ILn0sHHboQA>
    <xme:08yzahmXmPsrXtnLZ-LKowhduvjV3D2uwXYqWWY3d9jjSCVx6yRwac7vTtDHBPcsg
    dpH7cLtA23u4txHypz3Em8sQ-QmqjxTb-Qc57JYZwdvYFdqWTfZ_Yc>
X-ME-Received: <xmr:08yzagHUQmXvpYa2j0MTd3wxXdnjR9O1E9m4cbiax0_I_PR64E3j3Q>
X-ME-Proxy-Cause: dmFkZTGncDsSIj9dUBmDJdNHkfWRL9WtZN7vKHbexiaEY9kDtOWMS1CzsoCzFeC+UjiMVA
    LksUT7pzZjDsbltQoiDnb/V+rJzonWB19vBkgedO0mFgvl+PYJzW4wcLhoicHITDAqOCRv
    GzeUDu9o1A4Zx3mRz/tWpxV2mbIIdDkLpYdwH1J3U5F1gCuUKcsbOu2t8+CqX65LVBz1kQ
    wxYnEXX345gOBG5gmrzDL/3T5ouG+2L4yPAs9GkwVuecRLELiGlU1yqHIWk1MVpLyERwgI
    56eJzPgIaoJt8ywoGu1f40FR9cS4tTIosqZsZw85T2YIdtjcSw2K+cH5X/xXDeXmOTKcRo
    ZXMdR9TgkMEC19Lp4dfuc+1jL/2Z0YDtA8XHCaBfqpDDsUWdxlN8AXiMtJgOCukgBYN9V/
    NBiMrurwIQjdWQ8CFbrv0vjx8BEizvXrlcDBPNDEd9iHGZMyXxJxRbatvp36LsvmNPRFUv
    Rxkob6VMRAdIrWBHds9q0Cf7w755uRE6KWs6BMxiX646w9+xTj0CkkhwvzEA6jkAT8zKeW
    LkbIFMPO2/LxwScCe5m15HdIXkcLNMH/VqsA2SSqhwIYeyjpQXAa8BUjc+KVNjsX62tg/7
    JFoa1Ev5knml7XhxaFofZCLN8Zgpkr458p+1Rk6YDEBsCV9DqzDtxOqjdbbg
X-ME-Proxy: <xmx:08yzahGuo18nOEwwT0ckapcJwt2ZwhxkmiiIaCSciPok7ji9k9uWRg>
    <xmx:08yzatPeIWdQehMFzKvyFh8bktwyiEg4lKcvetewXuuFIALrsphcSA>
    <xmx:08yzagHzssaLXWdkpZVCc5Gv-vXosILNA61uaPad8wsTx3FHzKibRg>
    <xmx:08yzakNnQ7Fvk-kR5W1aETNVwQj87wg-nAEJ5sTLDNbwM9V5JPSMpA>
    <xmx:08yzavB4apWe8GssAh3mGV8dGz-dfKyY7FSdGeAfEfnQK-MJ5CX8BL-k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 08:57:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d05d71a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Sep 2026 12:57:53 +0000 (UTC)
Date: Wed, 23 Sep 2026 14:57:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Yoichi Nakayama <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v2] completion: complete 'git worktree repair'
Message-ID: <arPMLIi7FL52CVJk@pks.im>
References: <pull.2218.git.1789171955370.gitgitgadget@gmail.com>
 <pull.2218.v2.git.1789414536838.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2218.v2.git.1789414536838.gitgitgadget@gmail.com>

On Mon, Sep 14, 2026 at 07:35:36PM +0000, Yoichi NAKAYAMA via GitGitGadget wrote:
> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> 
> The completion scripts do not complete the "repair" subcommand for
> git-worktree(1). Add support for it.
> 
> Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Thanks, this looks good to me!

Patrick
