Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892C241F34B
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832632; cv=none; b=Y3XDkL2OvEg+Wr6d+5ZjhK6MPSoCuVvnhi9l6xtb9WlgEzCK8qdgw25h8UaWI7t/r2yyvoQ40ZyY/9CoRFFl+tbmGuQB5Le3uB2QMzybmAnvIn+pnuxIvdqwICoytUtDmsyTdhaBTQ/EwW9UbV856B4ebaGJGCMY7ngQyxUqQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832632; c=relaxed/simple;
	bh=/0WUC9ekGzvACXb5n/0eVVearLzGMjxosQFYgEUGrY8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V/gVkkJDc3T/ySRYglwhE2m3CFH9ca6huatn1J+bztqEjZpnmoa5/h6MEljw8dwqh6rReARTxN+CxlwIijXUXA8cAsqs0A9TCyzUfemOXYPPl2LM86awA+lFT8P23sN4jzlLpinUdpVZ9yPNevWXUQO76UrwEjqZ5EIYZikFMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Sk5Byr7N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmdZ0Kee; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Sk5Byr7N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmdZ0Kee"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4CDB4140008B;
	Tue,  4 Aug 2026 04:37:09 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 04 Aug 2026 04:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785832628;
	 x=1785919028; bh=/0WUC9ekGzvACXb5n/0eVVearLzGMjxosQFYgEUGrY8=; b=
	Sk5Byr7N1MfklOAaZVhik6XXO5NkJ5pvi7u2RCLrWTRcEOroQQbWpdM9ksN0Fsq8
	7MZZ+xamZCA1tbaM8Sfei5u0Zj7d115SMYv0gMbfFumQqXclH1wO9ASGyl6Iu3l4
	qfmc82BZajDRPnsC9elNJrfmQ6Mxx3KtSJ/hhiTZ/yMaTsOBiBBM/+PzsjHBt0/7
	jCQ1BbVqVzeqRJ9B9IU/MmWqdBGQ7f9YkwkHOrYOcHe4bMNA66cGOuuhF/dZstuE
	IHWqGf3Rk8pZbTLv10vTLceRBlFna4o9yMVn85O6elV89AGTKziwrwqlSwp73lH3
	GNSlGTQP5+Wr4Jzs7kCupA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785832628; x=
	1785919028; bh=/0WUC9ekGzvACXb5n/0eVVearLzGMjxosQFYgEUGrY8=; b=H
	mdZ0Keec6Fr6TYDW7hPz/uPucL9zKWxhUq6moItaBsV5QPdtyxO63CUGNqB/hzrC
	5goEmq+9+KrFIYX39qNhjKY9a9nWsAbMPK7p8gbtUOqmVSaTfccJCJ/3hqKGJhtm
	uIov/fWKXTSJs1j56T4zFEr5f7+zVDtMcy37UvtGYp+/P7dTRXb+Z5cASLZlqmdY
	5muIzXqHbGJG5zfTC5xeXfdz+yqbUngy3cedZldnaecGmgtWh77Aft/HuyXSNo8P
	lNbO/Fpg44KxneWUJ/oRJIfrSZeFnCAJn/2t5NhBXi3VKLXwq4TaacKNUhEDNs6u
	nN5M5lWWOLpXoqe6Duvdw==
X-ME-Sender: <xms:saRxaj6OzlLW6dF1vsy4vhpjhcxIfJGT0kWX_KnG1TQXQs_btvyGje4>
    <xme:saRxajsYdZa_kZMmN7LjtNcy2rPxQzVuH0TJaevhd9xkahTlPZvNDvFbUsm-WTHmu
    l5Y8t46O3sNus00aaDJkuLb83U940PDN05QEHjSasn59Bp_SxGgFg>
X-ME-Proxy-Cause: dmFkZTGkxISwAqmxtETVVgBPoICxzpPjFkciX7u/9JXlL5l/6D2Q0qhU6cOHKXnhPW34H2
    HgYemeF37JvcMeA3PbXvwCvvthoQXe+4Zrib98B9rNjwuJTuS8n4CTWSdI4u3fY34RthJ/
    bESbAbwgK2LuYfstdcaa6ZwUe/XL1eel3ovEM2fNkA3yV8zT81vCjXTwtQ5tTIf0KLth8e
    cYFrRfRlv3/ssh1wq1X5nDYBEzOAZjd9IeePpj+IjtXm62lNimbs2nm4Z+WtnKyKVg6NeS
    Uzq7lvgOWEgEAkUaBeUGJSRNOOiYLRlsLwmI+Oj7uynGVVkzp9aXZKMHrYneZ/dbMuPtt3
    4GanxSuSgeDzPXeiEKHjLnMbV8v7HIH88zl5zZg+q4BWYwVInrmZNQMPnZCxa08n9ztIsj
    c4t0c0bH3VIttAPK+dnxpBw0yMug/UYEYu2CjClrVs2Dtkdm1xFJJMABY0nnEpHay4oe8g
    4NQ0tfdIQI2cDwiY2/o5CC/6JOw35KkH6rUpppPLkqsQdseJ16UJopilQy9dWHm2PH5uuj
    uSRG1/UXASSg03HTCqXtstFW7LdEYZTnllvOzzbjOOHLgFEB+LqkfLUCjgyFSs5C7Bo9uK
    3L6UQoiu09OcxjwdYESHMVGb2frSS3CSAqZtEeFhVa5Y5HFMtIQo8a5QykjQ
X-ME-Proxy: <xmx:sqRxaiXp6KFC9OPf3lIfCGIW25uuCUxDPVcPDcXntshQT8qG5S6dgg>
    <xmx:sqRxamUGiR7g9tPYm_FK4Y0Yh5Gj7IH7F-QLKND4xnUYFznRwpqYnA>
    <xmx:sqRxapfykwHV5Thfr-2BpgX4Vavf8-9zta5yUoh6o3yjUJu7Ft4ElA>
    <xmx:sqRxanV1tzeT40gQZwixBpc0gaDXA-e9_G6XjF3hOu5P11EBJgcoWQ>
    <xmx:tKRxau2p3U93IAxKSn8w10GHjqBBcV87LElTy69gSzmJyjr2zRvVp6Yi>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5691122C0062; Tue,  4 Aug 2026 04:37:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Amoin9sslaaw
Date: Tue, 04 Aug 2026 10:35:58 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Michael Montalbo" <mmontalbo@gmail.com>, shrimech <eddinen77@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <0240dcad-ef4d-4beb-ac52-10728c7463e5@app.fastmail.com>
In-Reply-To: <am9Vy9vMsixhaR9E@nixos>
References: <20260802032549.50389-1-eddinen77@gmail.com>
 <am9Vy9vMsixhaR9E@nixos>
Subject: Re: [PATCH] interactive: add interactive command helper
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Aug 2, 2026, at 16:46, Michael Montalbo wrote:
>[snip]
>> diff --git a/git-interactive b/git-interactive
>> new file mode 100755
>> index 0000000000000000000000000000000000000000..980a21c967d02ab121a54ee586cc9de4a98aa725
>> GIT binary patch
>>
>
> I think including this binary patch was a mistake?

@shrimech your two next versions of this patch have also included this
binary patch. `git-interactive` is a compiled artifact and should not be
version controlled.

I am replying to this email because replying to the latest patch in my
email webapp was too difficult.
