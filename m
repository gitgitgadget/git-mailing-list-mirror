Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1CA7E
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="eB9T7lXT"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB0EDE
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 18:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698109825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaSFh4zNuEEkfPVO6/RGPAtBBDqfY8H78UYPQp5Vaik=;
	b=eB9T7lXTcf4z+nSWtvn1HjvUiwpvZXcg2DlsWHqOYwJZwMQHGpnCrJbfQoGfq17R8qqBQ+
	QiKqeunRc6G668t2crnHxScUs9089PW+SkBhrFlXGHpES7Lp1rdqoqvnw+g18YyVIWXXo/
	Vt27wKO8u4P6YQezTfVkgtpmT2C12Wk1wiVhpSF4zEFE4EBWCVNX42v9MIIgWI9vy9pE68
	PQUs6ksOybRP/37wY+BW3bCmJmGf/l43nR6YZPPGlcq7BXr1q+jAKNoJgbWZJvaN0s+G+P
	+xPHYkxha+jzOLlO/bWccXTr+puzCzIudjKw9m/rFhdXo+ToWgFBzfF9Pb9NmQ==
Date: Tue, 24 Oct 2023 03:10:25 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <ZTb/HeILRHnZjaz6.jacob@initialcommit.io>
References: <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org> <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org> <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io> <ZTa4iqe0lqn/Yg5L@ugly>
 <ZTbJiIkIyXwWK8JP.jacob@initialcommit.io> <ZTbVY7Nf+DTYqHky@ugly>
 <ZTb/HeILRHnZjaz6.jacob@initialcommit.io>
Message-ID: <62164acf4a787042dbb6e5abe212559b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-24 01:17, Jacob Stopak wrote:
> That's true, it would be just as easy to report the results of a 
> command
> (and even easier in some cases) than forecasting the result in a 
> dry-run.
> The question is how to decide which one? Do you report the results of
> certain commands by default while hints are enabled? And only as a dry 
> run
> when the --dry-run / -n flag is added? That actually would make sense 
> as
> it wouldn't add "special" behavior to the dry run. The dry run would 
> just
> report the exact same default output as the normal command, but omit 
> the action.

IMHO, it would be the best to simply implement support for 
"<command>.verbose = table" in the git configuration, similarly to how 
we already have "commit.verbose = true".  That way tables could be 
enabled per command, according to the user's preferences, regardless of 
performing dry runs or not.

The new hint would be placed somewhere, which should be decided 
separately, but having the hint enabled or disabled wouldn't affect 
anything else.  Just like with the other hints.
