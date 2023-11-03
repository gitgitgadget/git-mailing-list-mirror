Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34AE224DE
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="VvykHjwx"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0933BD
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 11:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1699036689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJ6LtOmLPgw+LW/89GuRdboENWVYqavD3tJCAEWaqWg=;
	b=VvykHjwxoqE3EFazmHfrLSCRPYy5KsjYxhspgem3PVTpTbkCkczAdAQ6eptEnUx44ZmbNU
	jon6xqV52l+YfabSEI2u4JTuA2Vka3tf7HJx0uKgip+eLxErWIzlSu9xABKpfrWWCJ2fol
	tT4GCFlTBvYRheVjbQycbhTG6syjQF2fMH5zdjRcKBYOYddAoMum44y+k/YBq+myOXyGVR
	ezt6o77SIoPKhyXBACYp254CnQan1WB1g9iB6twTKQxiAtqrDmWQuysiQI/GewarrvRHSf
	2BlJ1KHMEcbVfA5c44F6FeQVNJCodFrJPlcRmnbqz0QvGRagUl2z+HeIqUxrZg==
Date: Fri, 03 Nov 2023 19:38:09 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: Thomas Guyot <tguyot@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, Christoph Anton Mitterer <calestyo@scientia.org>,
 git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <CAHWeT-aftfawZ9DhqC1NkQrJAuArJZC65ZDr4FyPwEc7aXGVuA@mail.gmail.com>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <20231012000416.GA520855@coredump.intra.peff.net>
 <xmqqh6mwipqi.fsf@gitster.g> <3946c06e90604a92ad0dddf787729668@manjaro.org>
 <xmqqr0lzhkzk.fsf@gitster.g> <a831af51b6fb46b5d6fcd9768a7fb52d@manjaro.org>
 <cfbe174f-23ac-4a35-8db4-66bdfdfdc14e@gmail.com>
 <8022dae27797bf1e1770f099ed37f5d3@manjaro.org>
 <d54eedf0-7825-44f5-908c-a51541345872@gmail.com>
 <79cf1bf35ba6c9348735685b01e0f2f9@manjaro.org>
 <24c46f25-6b31-437d-9f89-1e8eb74136c8@gmail.com>
 <CAHWeT-aftfawZ9DhqC1NkQrJAuArJZC65ZDr4FyPwEc7aXGVuA@mail.gmail.com>
Message-ID: <db923ad4f3fba79e2a2e279f6d5aff16@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-11-03 16:28, Andy Koppe wrote:
> Thomas Guyot wrote:
>> >> I actually have one major issue with it, it's that displaying anything
>> >> less than a full page will fill the screen with ~ on the bottom, just
>> >> like when scrolling up on a partial page  without -F.
> 
> 'less' has the '-~' (or --tilde) option to suppress that.

Good to know, thanks.  However, with the "-F" option in place, the 
situation in which less than a full page is displayed within less(1) 
shouldn't be encountered.

> For what it's worth, the 'mintty' terminal used by default for Git for
> Windows as well as MSYS and Cygwin has another approach to the whole
> problem. Its rather flippantly named 'Flip Screen' context menu
> command with Alt+F12 or Ctrl+Shift+S shortcut lets users temporarily
> look at the alternate screen buffer while the main screen buffer is
> active, and vice versa.

This is a rather neat feature.  Though, I wonder how many users are 
actually aware of this feature, and how frequently is it used.  I wasn't 
aware of it, and I used Git CLI on Windows for some time.

> If 'less' is invoked without the -X option, it will switch to the
> alternate screen, where mousewheel scrolling works by sending cursor
> up/down keycodes. While in 'less', you can temporarily flip to the
> main screen to look up something in the shell session there or copy
> something for searching in 'less'. While looking at the main screen,
> the mousewheel will scroll the scrollback buffer. Keyboard input
> that's sent to 'less' will flip back to the alternate screen.

To me, this is another confirmation that (ab)using the "-X" option is 
something that we need to get rid of, as I already described earlier in 
this email thread.

> Quitting 'less' switches back to the main screen, so the 'less' output
> disappears and you're back in the shell session with the command that
> invoked 'less' as the last thing shown. But again, the 'Flip Screen'
> command or shortcuts can be used to temporarily look at or copy from
> the alternate screen, which will contain the last page displayed by
> 'less'. (The alternate screen does not have a scrollback buffer.)
> 
> The 'Flip Screen' feature of course also works with other
> alternate-screen applications, for example editors.
> 
> Apparently the Mac terminal has such a feature as well:
> https://support.apple.com/en-ie/guide/terminal/trmld1f46097/mac

Maybe there is some data available about how frequently this neat 
feature is used?  It would be really good to know how much is it 
actually used.

> (Full disclosure: I originally made mintty, from PuTTY.)

Thanks for your work!
