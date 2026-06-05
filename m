Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F802773D3
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 04:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780634848; cv=none; b=mmyoruNpg/G6Zco2d22KCood2qayOLDkRslTvO7xO7uPZF39trEvRHikyFZe1S+qPw5+4jD5NEiyUfnEPV3+ZwEIQXnisoitI7+B/NLbi9peV536CnHHyv8lyHyXsy/SHPfaPME97bZoDArFjTRzcfH9y5eZviVA37BcHGQy9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780634848; c=relaxed/simple;
	bh=AyaKEs6NyqSGV3Ci1M+CrCbGuVEaL2PoUNNw7YIZ7xY=;
	h=From:To:Cc:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qWNcPzpeCDS7IcYPWM3WYpmoSTVG/ty19az4oWUn+C/kAMAREnFrZ6YKilhdlNid5jwsHgWsdqDVvOotScM0dsuKvlAFTJdBy5ROYp1xBw+iMIMiExYvzcyVvByPrIJOJIzUQl3NuveKNYah/gg0AIOqkLEtrl+MAOtBvJA3xU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emailplus.org; spf=pass smtp.mailfrom=emailplus.org; dkim=pass (2048-bit key) header.d=emailplus.org header.i=@emailplus.org header.b=jWQj9GzN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WcqU5gt3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emailplus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emailplus.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailplus.org header.i=@emailplus.org header.b="jWQj9GzN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WcqU5gt3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D0E3140013C;
	Fri,  5 Jun 2026 00:47:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 05 Jun 2026 00:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emailplus.org;
	 h=cc:cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780634846; x=
	1780721246; bh=jC6nEojnUkhY6/FBLfSBhtvc7DRRde1ch3soLgJrLMU=; b=j
	WQj9GzNGTZ8poeLvufz4mRxT+WoqwEGCGWoiOTWTk0Hot2RKOwt2Nf8Hq5rflFFV
	NSlgvCMTPfHFAjIeTFE8bXJ6GGTZJUWDPb+2V46AK1PqloY1bXCaAwdlBIWEITqO
	hQJanrKMr+yStFAbFUgnuqU7apcXwsaHf8UUkdjnBecFfRNAOksuYVQpMYR7C5jf
	B59bS8lsoFcKgyp2V6gZyFeD0l4rz9gfPcOw+qMjQLoQSmj38WzOAJK+cqRslzjY
	joEdUw7PwVktu/mvzrBTqw4hqbX0u3hvWAQGhUfFVuzKTVpZAExgqI4CITINKYW2
	LDSia0TmpGdNoxc7v9mvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:cc:content-type:content-type:date
	:date:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780634846; x=1780721246; bh=jC6nEojnUkhY6/FBLfSBhtvc7DRRde1ch3s
	oLgJrLMU=; b=WcqU5gt3z9w4bQ7KiPXyk2JeP5GAFOJy4xg590Ghf6tkQjdofy4
	MawRQzS6rkSCIoLfvFSZcCn50ne+YvjGGfjCi9CVKxIbwnFlvYONLfzGqokK7428
	aBKlcuHiMLv+0ACVaMaUxJn49wWzxAzhmYGGssePzLsSjsZry8LKQFoy+qq7v+Pd
	jYUL1ziHi9hPnGUodXhGI2LzPg8iQNTnIg8r1lL6okT3GtWDDnPUfUpnhnCZYov7
	nlaO6SkDgOFS8wIp9wl1yUuOJm6k+pRkaRmq7rPzD5xO30J06eNFyTjgHRbV83Ai
	s+LJKdSAfddd9h2ZBKM+fX9ip8n1SX7I7Ew==
X-ME-Sender: <xms:3VQiapFBbVCjdvkuWr0osiJwNXvBys4qoAvS30Pq7nKZ7aeCREfmWA>
    <xme:3VQialwo60jvDVPv64lXAnQP7vWs8aEHDXbMssA5VMbdsVc7hw5Sw9LP07DqekRRD
    dBQBbvNnChQQMWNBEGe785kONto3EZ4TldLb60C8tuuLAUz-O13>
X-ME-Received: <xmr:3VQiaojfsIMzcfyZHSebToSBzqZkleelPU_BwWuxZzI2On9PiBfzrkM>
X-ME-Proxy-Cause: dmFkZTFH2Xbgw5u7gNKHNlynG8QwY6T6qqAQSpFYBfnNEjz/N3t9gIX56nf9c44FTCLVnu
    NllY7vbeBlez0Ut29v7aG2ShVsP7mtBmhAwM0BppVQ2Mx8pTcmGb9eOn1AeElQEPaK2c2I
    +yWfFx6yl0Yox+EFjw/GFrsyMxiBGTxXTtKEd+OBS6nVtHQXnL7k8c72yDAFEo6FUHZSNf
    tSCBnOz8kCiOEpQOPnKRLrF1e5vkSJnHF2mVuoxtpYWH8ryywxAZbOOeLAyWeHEeXCffdF
    394FnxIIU0lePi/qGV4+rhGK4wCD2au9ONNItzGmxit7b1aCXUiGOdFfiqLuHRspxKH0TG
    JByaCNBZfL3M4SKPrJOn/zcW/0qjTs8MW2SE2+idwTwPBjQqhaoMBANIdFz3KRCy+5UHFD
    mVoLkNiVHSCEukDWpOhtUmT/kd7HJc6UFRnaD6HtBCQIkx3sKEWriv/lGX7FjCvYs8F+CX
    XWqYKq5NG2aIeYm0PEgL4vHHg7rXQi169ZYyFNO+Nfp7i0whQ3JxiLrAE7+TUabkTxm5uA
    fnPcuvaDq53btpDh8lG8sxK3pOe94Dur/VKYENdMDUJVIWsup/JP9FKVCWsCn/OLZdhBZ4
    B43CWQoMcb2dDpWvbeRPu5aqM9hATmDAS6nEgiO12BChklC8ikA+ux+s5BmA
X-ME-Proxy: <xmx:3VQiaozgTeVHo8L9H9rIo_nDAMVWIq8cDasCIeb5K8AD8nPKfRnZXQ>
    <xmx:3VQiajLfV22DbB4q-HhCHTk7yW7zwwL-QyzF0cz-roGpJrFK4BElIQ>
    <xmx:3VQianR1mqlB_4DmVo8P84lIUmnFam0GWtVu6i219yS8_r9Ec9uz7g>
    <xmx:3VQiajpEDUmJ93wgpwMgkNma_o8KSN4RZSVBO2M0HXQpRkQN0YGidQ>
    <xmx:3lQiajcDWzjRhULt6I6awUj-_t55XMRZjY0Gy3LBOCHfvG2MiRg6F9KW>
Feedback-ID: ic1e8415a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 00:47:23 -0400 (EDT)
From: Benson Muite <benson_muite@emailplus.org>
To: Simon Richter <Simon.Richter@hogyros.de>, Junio C Hamano
 <gitster@pobox.com>
Cc: git@vger.kernel.org
Cc: 
Subject: Re: Mirror repositories for submodules
In-Reply-To: <d64e7f31-4e00-478c-ab31-b671242865fb@hogyros.de>
References: <875x42vlgv.fsf@emailplus.org> <xmqqcxy7qfgk.fsf@gitster.g>
 <d64e7f31-4e00-478c-ab31-b671242865fb@hogyros.de>
Date: Fri, 05 Jun 2026 07:47:20 +0300
Message-ID: <87pl25r3tz.fsf@emailplus.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Richter <Simon.Richter@hogyros.de> writes:

> Hi,
>
> On 6/4/26 10:09 AM, Junio C Hamano wrote:
>
>> So, no, I do not think a contribution to add mirror repositories as
>> alternate submodule sources should be considered for inclusion, as
>> it artificially limits usefulness of the feature.  A feature to add
>> mirror repositories as alternate sources might be worth considering,
>> though.
>
> This is relevant to the Debian use case: we run a git server that 
> archives git trees for Debian packages, and ideally the objects on this 
> server should be identical to what you get from upstream projects.
>
> This is a big problem for archiving projects that use submodules, 
> because we cannot alter the reference URLs.
>
> Cloning from our server will, depending on what upstream uses, either a 
> relative URL (which will go to our server, but we have little control 
> over what the name part of the repository base URL is going to be), or 
> an absolute URL that instructs clients to pull from another place, which 
> conflicts with our goal to have a self-contained archive.
>
> The idea posited earlier, to have a "repository identity" that remains 
> the same across forks and clones, is somewhat appealing, but the best 
> idea I can come up with is generating some kind of repository UUID, and 
> adding a symlink -- not a great design because it pollutes outside the repo:
>
>      $ mkdir myproject
>      $ cd myproject
>      $ git init
>      $ ls -l ..
>      lrwxrwxrwx 1 simon simon   9 Jun  4 14:05 
> 12345678-9abc-def0-1234-56789abcdef0.git -> myproject
>      drwxrwxr-x 2 simon simon  40 Jun  4 14:04 myproject
>
> On the other hand, this can be used to construct a stable relative 
> submodule URL.
>
> Making the symlinks optional would require keeping a list of local 
> clones and their UUIDs, and resolving them.
>
> I don't like that design, but as I said it's the best idea I have for now.
>
> I also fully expect that Debian's servers will be used by a lot of 
> people outside the project as soon as it becomes a convenient fallback, 
> in the same way people are pulling .orig.tar.gz archives from Debian 
> mirrors, so we need to make it easy to set up a mirror, to allow this to 
> scale.
>

For submodules, the metadata consists of the url of the repository to
clone from.  One could have a list of absolute URLs.  The default would
be to assume that the URLs are tried in order, and if a URL times out,
the next one would be tried.  One may want to change the default
ordering as a user setting, or do a ping test to get obtain content from
the closest repository.

As an example, for linphone-desktop, the first part of the .gitmodules
file contains:

[submodule "linphone-sdk"]
path = external/linphone-sdk
	url = https://gitlab.linphone.org/BC/public/linphone-sdk.git
[submodule "external/google/gn"]

This could be updated to

[submodule "linphone-sdk"]
path = external/linphone-sdk
	url = https://gitlab.linphone.org/BC/public/linphone-sdk.git
        url = https://github.com/BelledonneCommunications/linphone-sdk.git
[submodule "external/google/gn"]
        

