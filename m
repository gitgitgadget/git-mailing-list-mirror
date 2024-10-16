Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45EF20E018
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091565; cv=none; b=eXcXhA36fkmVs8UR0VVjMyVLkLKumsuP0MJuf80W5ec/DmUtvHzaKGmKaVsNLG4qdONQXZl+VeJPKcO5UU8SfaFE7E3Y4t6PxyBGrSyRXwxG39+CtAsWcndzB4oxcIh2FCOWai+Qq5cfSchRSdwbN2s1+9bK+zuhJ6SVZwAnY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091565; c=relaxed/simple;
	bh=F5GMhc6BQ+nCsc1gUSeW6jLzgRAoIiwezr8nTxyvlDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFZooZxUp4tdFEwbJz7GqHrAoKgDdg5a9W8vhodJ3Iy/+P27O9DL6gCypGtdZCepmklfbAVPvp3Bf8BdYhoT1R1wSGMSgxCrPnmwAstSpFiPAURwiW03blGD2Aja2OQqxYJFbfou2d/0K0ABS9rQ4r4PF3W5x0kYEv8VF3ItSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=MRhv6b6i; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="MRhv6b6i"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 15hOtwTjox2dS15hQtzc90; Wed, 16 Oct 2024 16:12:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1729091553; bh=5CQ23U4Ft1VMS9iIwls368VGt3hLtq55eWwUOau4BkQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MRhv6b6i9ZpMANJd1+QS2cbuGcG1o7gqeUrbZ0NcsjShaMHgOeV2FKTPUwiu2LVfY
	 h/N+QiwqnoaghBn2duy5RKWmCBuqduefCDBT0SwTT5BjJ7Q9SMUuVveV4LeN1x4sYN
	 zaobVlo7MfUoFCDYqr0WHswSdxpdpNdyqKyEnpUwpkmBJd8FIbevkDiM9+MAbvAyiq
	 Q1pQiIbGRZGN9/njqZnm45xPszbxWMFewvVZf1ZtR3w5oeDY/dVAQGwXv3HNEwd7bX
	 lat9zYIGWnw4TpSUuH3s7Na9vKZ/deB4TYdzSMN9t38a/XpM493lhcXP8YAz88DC2I
	 gphyTFw23G/Gw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=GMarEfNK c=1 sm=1 tr=0 ts=670fd7e1
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8
 a=CmTBIp71Sxw5NT-zW54A:9 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <8dafcaf1-9de6-4f37-89e9-0f71fdc1012b@ramsayjones.plus.com>
Date: Wed, 16 Oct 2024 16:12:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/credential-cache--daemon: fix error when
 "exit"ing on Cygwin
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfA9DieTb3gVQXZM81EnDEE+bpkQkXbJXq70YciOyFwUkoLAmmS2Wd4fDyVa6cCc5w/cIYYNfJfjcWxiKm+70qoZA08pVWtt2kcqQvbzBq4Fx8JN4WH+a
 cT8Jw8tFJcB8PJ1ewpdGHCkxdb8wg9tVnNc2uvPuonuXH7WMcx0ph+2HJw9GxzaSTE5qejHp4L17MXQVQ+ICMRog/A/Reh8Luxg=



On 16/10/2024 15:21, Patrick Steinhardt wrote:
> Clients can signal the git-credential-cache(1) daemon that it is
> supposed to exit by sending it an "exit" command. The details around
> how exactly the daemon exits seem to be rather intricate as spelt out by
> a comment surrounding our call to exit(3p), as we need to be mindful
> around closing the client streams before we signal the client.
> 
> The logic is broken on Cygwin though: when a client asks the daemon to
> exit, they won't see the EOF and will instead get an error message:
> 
>   fatal: read error from cache daemon: Software caused connection abort
> 
> This issue is known in Cygwin, see for example [1], but the exact root
> cause is not known.
> 
> As it turns out, we can avoid the issue by explicitly closing the client
> streams via fclose(3p). I'm not sure at all where the claimed atexit(3p)
> handler mentioned in the comment is supposed to live, but from all I can
> see we do not have any installed that would close the sockets for us. So
> this leaves me with a bit of a sour taste overall.
> 
> That being said, I couldn't spot anything obviously wrong with closing
> the streams ourselves, and it does fix the issue on Cygwin without any
> regressions on other platforms as far as I can see. So let's go for this
> fix, even though I cannot properly explain it.
> 
> [1]: https://github.com/cygporter/git/issues/51
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> 
> I've Cc'd Adam, who is the maintainer of the Git package in Cygwin, as
> well as Peff, who is the original author of the below comment. I'd be
> really happy if one of you could enlighten me here :)
> 
> Patrick
> 
>  builtin/credential-cache--daemon.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> index bc22f5c6d24..5a09df5c167 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -156,13 +156,11 @@ static void serve_one_client(FILE *in, FILE *out)
>  	}
>  	else if (!strcmp(action.buf, "exit")) {
>  		/*
> -		 * It's important that we clean up our socket first, and then
> -		 * signal the client only once we have finished the cleanup.
> -		 * Calling exit() directly does this, because we clean up in
> -		 * our atexit() handler, and then signal the client when our
> -		 * process actually ends, which closes the socket and gives
> -		 * them EOF.
> +		 * We must close our file handles before we exit such that the
> +		 * client will receive an EOF.
>  		 */
> +		fclose(in);
> +		fclose(out);
>  		exit(0);
>  	}
>  	else if (!strcmp(action.buf, "erase"))

Heh, this is very familiar! :)

See, for example, the mailing list discussion here[1].

If memory serves, Jeff was against this solution. For what it is worth, my
recommended solution is '[RFC PATCH 1A] credential-cache: also handle
ECONNABORTED connection closure'. I still have those patches in my local
cygwin repo. Ah, let me just add the patch below (this was last rebased
onto v2.46.0, but it should (hopefully) be fine to apply to master - famous
last words).

ATB,
Ramsay Jones

[1] https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/

-------->8--------
From 89526b2b87e39985dc8cd80661662ff087dc1078 Mon Sep 17 00:00:00 2001
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Date: Wed, 22 Jun 2022 19:24:44 +0100
Subject: [PATCH] credential-cache: also handle ECONNABORTED connection closure

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 builtin/credential-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 3db8df70a9..defbcc845c 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -30,7 +30,7 @@ static int connection_fatally_broken(int error)
 
 static int connection_closed(int error)
 {
-	return (error == ECONNRESET);
+	return (error == ECONNRESET) || (error == ECONNABORTED);
 }
 
 static int connection_fatally_broken(int error)
-- 
2.47.0

