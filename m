Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6C20127B
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265788; cv=none; b=mp33rWKC1pqThXNJKNYmxWv1EfvIyr5NQdyJVSTscU4cZjqOqMM+YxDzWXwVnQxQOr1PG7GorB8Z6B2CArnZB0P1H8So9ASHqajoVcLYNCZMYs5Bc0VD//TTHj150csOWCF1aV0PAcyP/vG7wagid+NYtasswymXXJcdt9Q9BrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265788; c=relaxed/simple;
	bh=+11LyjyQdwPDuQMdIkKL+uprneCF0ferDJ34JOImr04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IM7jtQML3CHXLypzirGoydosqz4keYRLh9oUglKEZRaxTwuVZVJCJrP8wD1/7Prd6nL+6kT3EXoH7FEObA7kRMs2g/r9JgLJU4KUyAadAdVFvLoyg4nLBADRMLdriRs48hRuA63ExZiaUk+qvtmBU/rxywwTVdQCyy8CxpQsSKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=mIAPLaeI; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="mIAPLaeI"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 1oyXtaaMpvENU1oyYtE23H; Fri, 18 Oct 2024 16:33:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1729265595; bh=UjGBpcLTs0MWr4z3W58RE2qgGLvDxE8xQqzyxUp8b24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mIAPLaeISqxPEZuBHDIGmtaVxYvizWfw87lpMuRB39GrJgY8xrkOSbxYJcOR5+FUm
	 EjAo/x9RbMZGvN0Zqb+dTC5Vpt8+fdHUZ8c0uwmOoiwroCunPdHjvWgd2mRY1rtswG
	 Jeb2O7IMnq27NbqZtIJhjkLQ+S1kSXBw2yXm9/UlrtSW2JKdtwJMFWbyT3mW7RhD0F
	 olrxgy2sD7uMUk5VRLugovr/tby1u1spIPEft7lp8GZahZO4qgz8hiR24o22Ah0Fri
	 aWg4MWSg3woHY/RbJ46GtQciRbvDs76H/0a+lhQAoMeD87ShGkCH4O1PoD7IJX8ADU
	 oRG7BZmnRSGDw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=T9svTOKQ c=1 sm=1 tr=0 ts=67127fbb
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=VwQbUJbxAAAA:8 a=PKzvZo6CAAAA:8
 a=R86V0CzZHKND08OJCBIA:9 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Message-ID: <8c4b513a-aa6e-4015-a6c2-e153b6c94491@ramsayjones.plus.com>
Date: Fri, 18 Oct 2024 16:33:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] credential-cache: treat ECONNABORTED like ECONNRESET
To: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
 Taylor Blau <me@ttaylorr.com>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <658fe4fa540a0a5316e11ed43f9139d5ef818ee5.1729226155.git.ps@pks.im>
 <20241018052952.GE2408674@coredump.intra.peff.net>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20241018052952.GE2408674@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfM2XuBVCqZhITRzXsIp1ke6Up5cW/J4jSFPkRbz5LP9M0K6ma/9oiwWmbW2+Bvb5IbJUkoK6vCsx4vTfAELl4Rm9DdCe1bAVn5UgnakFmjs8gwxBnTu1
 z/lUjd7dGu1+qCN/3dYdAFVYi9I04BDcvCyoI+gbAIK2zvEGx+/5fc6BGXOiyS+Sn5x6UpxRcy3D1zqxKH+G6zyV4aGzUj3HGEc=



On 18/10/2024 06:29, Jeff King wrote:
> On Fri, Oct 18, 2024 at 06:36:11AM +0200, Patrick Steinhardt wrote:
> 
>> Subject: builtin/credential-cache--daemon: fix error when "exit"ing on Cygwin
> 
> I think this commit message has a few unclear or inaccurate bits,
> because it's based on the earlier attempt. E.g., the change is now on
> the client side, not in credential-cache--daemon.
> 
> And I think rather than say "the daemon exit rules are intricate", we
> can actually outline the rules. :)
> 
> So here's what I had written after reading through the old thread. It
> would preferably get Ramsay's Signed-off-by before being applied.

Oh Wow, this is (no surprise) a masterpiece! :)

I would very happily add:

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>

(I don't think I could have produced anything half as good in
several weekends!)

Thanks!

ATB,
Ramsay Jones

> 
> -- >8 --
> From: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Subject: [PATCH] credential-cache: treat ECONNABORTED like ECONNRESET
> 
> On Cygwin, t0301 fails because "git credential-cache exit" returns a
> non-zero exit code. What's supposed to happen here is:
> 
>   1. The client (the "credential-cache" invocation above) connects to a
>      previously-spawned credential-cache--daemon.
> 
>   2. The client sends an "exit" command to the daemon.
> 
>   3. The daemon unlinks the socket and then exits, closing the
>      descriptor back to the client.
> 
>   4. The client sees EOF on the descriptor and exits successfully.
> 
> That works on most platforms, and even _used_ to work on Cygwin. But
> that changed in Cygwin's ef95c03522 (Cygwin: select: Fix FD_CLOSE
> handling, 2021-04-06). After that commit, the client sees a read error
> with errno set to ECONNABORTED, and it reports the error and dies.
> 
> It's not entirely clear if this is a Cygwin bug. It seems that calling
> fclose() on the filehandles pointing to the sockets is sufficient to
> avoid this error return, even though exiting should in general look the
> same from the client's perspective.
> 
> However, we can't just call fclose() here. It's important in step 3
> above to unlink the socket before closing the descriptor to avoid the
> race mentioned by 7d5e9c9849 (credential-cache--daemon: clarify "exit"
> action semantics, 2016-03-18). The client will exit as soon as it sees
> the descriptor close, and the daemon may or may not have actually
> unlinked the socket by then. That makes test code like this:
> 
>   git credential exit &&
>   test_path_is_missing .git-credential-cache
> 
> racy.
> 
> So we probably _could_ fix this by calling:
> 
>   delete_tempfile(&socket_file);
>   fclose(in);
>   fclose(out);
> 
> before we exit(). Or by replacing the exit() with a return up the stack,
> in which case the fclose() happens as we unwind. But in that case we'd
> still need to call delete_tempfile() here to avoid the race.
> 
> But simpler still is that we can notice that we already special-case
> ECONNRESET on the client side, courtesy of 1f180e5eb9 (credential-cache:
> interpret an ECONNRESET as an EOF, 2017-07-27). We can just do the same
> thing here (I suspect that prior to the Cygwin commit that introduced
> this problem, we were really just seeing ECONNRESET instead of
> ECONNABORTED, so the "new" problem is just the switch of the errno
> values).
> 
> There's loads more debugging in this thread:
> 
>   https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/
> 
> but I've tried to summarize the useful bits in this commit message.
> 
> [jk: commit message]
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/credential-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
> index 5de8b9123b..7789d57d3e 100644
> --- a/builtin/credential-cache.c
> +++ b/builtin/credential-cache.c
> @@ -30,7 +30,7 @@ static int connection_fatally_broken(int error)
>  
>  static int connection_closed(int error)
>  {
> -	return (error == ECONNRESET);
> +	return error == ECONNRESET || error == ECONNABORTED;
>  }
>  
>  static int connection_fatally_broken(int error)

