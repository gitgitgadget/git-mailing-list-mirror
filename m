Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D484D8BF
	for <git@vger.kernel.org>; Thu, 30 May 2024 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717099551; cv=none; b=hlVKTr890eAXYIuESMTCqzKP9MJPd4o65G3ebaDJyrI9+BEG+2GiF3wrXLT7ykKncJpniTkdB5gOyckbEkxaB/M5cfumo706LP9eSoAf9/y2/yNRuEVGD6GrDrHujxuKU3fSc8MhWVV2ZVFk8hZ9P3epzSsd1IfjFXPVIAKZ5n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717099551; c=relaxed/simple;
	bh=nC+PviCeQ5aK1VCr1qe0o1L64qg+gRDzmpG4FUz0X70=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=f9jmy0+M+Q3OGDlifsnHLNhpRi7/0iqQAazZz9JNAKP1oGay+2LnaqfdY4YekOhsaSBXyhZS5OIhishKe2W6WD2+l1pP2vh38e5fM9PKn2ptUwa6OLgFPmdTZRWsCjs22hbkDufG12xXYhk4ElmsuDxxjFt+B4ne+vDpOOkU8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=iKxjV4uX; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="iKxjV4uX"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717099547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQ8McxJHMF3ngemf+rX3TV/PwM7TS5MlDl7vHKCW7Jg=;
	b=iKxjV4uXkSFNCLr6NsYyKXBuh8dy95v5Xw35okSv0hU1e0FrMD/WUH6mshtdt2RrlXhXA4
	xfMTu79AkJg2iwgLjmr16A8qDVhLLXIqe0mx5dqjUsQt7+maBemW/44I2etr08TS6cd69m
	5op3d6t2yGkucsVIcRF5aUHiFAM1i7doZ2lXPw9Q5BDexD8dNa8/JO0QT0FbTIonZiJip4
	LqcDBBZG33DzemgzGZSp0CUWjCEUGdEu85YJc1JJ7W8BFU7woyYHNJ4oSMGiVKo7TYpdWl
	EWrEPLPCnI4TcZ/NJQXtx61ZeNJ8h6/Grv1HsvTFtD676RhY4iER5R3U7gELeQ==
Date: Thu, 30 May 2024 22:05:47 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: move range/inter diff at the end of a
 single patch output
In-Reply-To: <xmqqplt41yk4.fsf@gitster.g>
References: <20240523225007.2871766-1-gitster@pobox.com>
 <20240523225007.2871766-3-gitster@pobox.com> <ZlB2g5bTuBFz5m5_@tanuki>
 <xmqqo78ukhmk.fsf@gitster.g> <ZlQX0FmIsz2eFgsC@tanuki>
 <xmqqsey39mmt.fsf@gitster.g> <ZlXbxzFOJ8gVv7r5@tanuki>
 <xmqqv82x6fto.fsf@gitster.g> <Zla-GJ6NpSNNVDXq@tanuki>
 <xmqqplt41yk4.fsf@gitster.g>
Message-ID: <e01506f4c8129318dbcba553d7c90b13@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-29 16:29, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> On Tue, May 28, 2024 at 09:50:43AM -0700, Junio C Hamano wrote:
>>> Patrick Steinhardt <ps@pks.im> writes:
>>> 
>>> > Yeah, that's definitely better. Whether it's preferable over having it
>>> > after the signature separator I don't know. I personally liked that
>>> > version better, but can totally see why others may not like it.
>>> 
>>> I do not think anybody posted a version that writes inter/range diff
>>> ater the signature mark.
>> 
>> No, I'm talking about the version that you hand crafted initially and
>> that kicked off this topic.
> 
> Ah, https://lore.kernel.org/git/xmqqh6ep1pwz.fsf_-_@gitster.g/ I
> forgot all about it already ;-).
> 
>> ... I just don't have a strong preference between the old and
>> new formats by now. If you or others feel strongly I don't mind at all
>> if this patch lands.
> 
> Let's scrap it then.  I do not think a single-patch topic happens
> all that often anyway.

Hmm.  Actually, I find it logical and I don't think it should be 
scrapped.
As I wrote already, I find range diffs as really long footnotes, and
placing them at the end of "documents" seems like a logical choice to 
me.
