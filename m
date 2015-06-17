From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] strbuf: stop out-of-boundary warnings from Coverity
Date: Wed, 17 Jun 2015 13:03:03 -0700
Message-ID: <CAGZ79kZCGck24KZBhVa9TGtR4U6Moz-vHNrBMk0HLTz6YeHhsg@mail.gmail.com>
References: <1434536209-31350-1-git-send-email-pclouds@gmail.com>
	<CAGZ79kYRfjeXGkYAv-Kn2Bk-pp2ZSzpKGHDhqMpw03scdRZAmQ@mail.gmail.com>
	<CAGZ79kbZpiz2rMbhJReFG=uRiQdj7a5qxLbRiPQQCFqcfBhikw@mail.gmail.com>
	<20150617191235.GB25304@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 22:03:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5JYE-0005a9-NI
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 22:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbbFQUDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 16:03:06 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:33862 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbbFQUDE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 16:03:04 -0400
Received: by yhnv31 with SMTP id v31so15835759yhn.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vvBsyFR2ZHEABw9Kw5G+wIv24MNqcNfyBulA99gr52s=;
        b=EcYIKJjqqFCfQheRDOWsDDQUjF0jEDRbqUDRQ9K+MVZLO9xbpPZKMqnKiAN4CO1xUw
         bELiSLZ0VmQ5s1YuCXjnUdhdop1HKQ8lSqHshmHO9i0e5myZojC9h9gGgZP9ZS1I2CSb
         rtsBtEb9KroFPwzFs04kMX6nIf9d6fiTjz/ntJexpeTpjjXhTHmM7CccSWFLqrTnc9Xt
         vg2f4iShocnLpYB9jFechn7NAq7oVUNcFkskSDF0HpvZE0DhkFzg2biNwfTrgzJpX1Nx
         v3rZcFTHp5HqV6CM9nuz/Pl5ogCLm1IKPxBgq3b9qMy/Ck3jF/2/eEfMwkZInDBLWe3/
         5new==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vvBsyFR2ZHEABw9Kw5G+wIv24MNqcNfyBulA99gr52s=;
        b=fLAqm6clkXofiUgcLybxMzIS92NGxYrdpfMl4waRs8/b6FBneUJJ/P3Rv29/q8UBbn
         wiMILMIP+g0Sil1hw7ejz5V98iADfkQLLCD2qBY71jr2k8Lg2tuoD6v7w2YtDjzNi76I
         uI/Y8XUnzqgwLUaFMY9/1utf7UOPX3OW0RJ2hsJwuQlOhl3RIWtxkq+tqYcc7UhzQy85
         DAXVG4x9JxraE4s7eFFPPxo/u31HZrxs1La2dMH5CHW+WiyF5uCxJwrZvAfltQQR5efR
         FdVr3dZWfQYZ6ziNZY6bhCj0EMcQjVG8FUS9xW/5KI7RCAYt4ejkiioeqgEQ/S+vB+ID
         ocrw==
X-Gm-Message-State: ALoCoQkCqNUG0YbrtkdNZ8b21LBS07HpaDnoPQ1QnQoewZYdRw/ALlHjPGk0t+5ayU1uJTQitzHJ
X-Received: by 10.129.46.1 with SMTP id u1mr9128790ywu.1.1434571383246; Wed,
 17 Jun 2015 13:03:03 -0700 (PDT)
Received: by 10.37.26.213 with HTTP; Wed, 17 Jun 2015 13:03:03 -0700 (PDT)
In-Reply-To: <20150617191235.GB25304@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271904>

On Wed, Jun 17, 2015 at 12:12 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 17, 2015 at 10:58:10AM -0700, Stefan Beller wrote:
>
>> > Just make strbuf_slopbuf[] large enough to keep Coverity happy. If it's
>> > happy, we'll have cleaner defect list
>>
>> It's down 31 defects, roughly 10% of all things coverity detected as
>> problematic.
>> YAY!
>
> That's a good thing.  I do find the solution a little gross, though. I
> wonder if there is a way we can tell coverity more about how strbuf
> works.

I always thought the problem was a combination of both having a custom
strcmp (like skip_prefix, starts_with) and a custom data structure (strbuf,
string_list). So I am not sure if it is sufficient to tell coverity

> I've noticed similar problems with string_list, where it
> complains that we are touching list->items, which was assigned to NULL
> (of course it was, but then after that we did string_list_append!).
>
> I know literally nothing about coverity's annotations and what's
> possible with them. So I may be barking up a wrong tree completely.

I have searched for the exact annotations for a while, but all I found
were examples in other open source projects, no official documentation
with all its features. I may be missing something though (there must be
some official documentation, I'd assume).

>
> -Peff
