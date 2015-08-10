From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] send-email: provide whitelist of SMTP AUTH mechanisms
Date: Mon, 10 Aug 2015 19:43:24 -0400
Message-ID: <CAPig+cSU_rgRvfETfY7TiY6X0B6Tt6N0+GMVgSsYH-6zMteAgg@mail.gmail.com>
References: <1438533769-17460-1-git-send-email-viktorin@rehivetech.com>
	<CAPig+cQwFxVtO1C_RAumGP6_et21ggORB4jhpcUtBYNznNH1qA@mail.gmail.com>
	<20150805091747.242e8fa1@jvn>
	<CAPig+cQ0fSc+rjzgDyaw4xvCPCswJLDcQSmbxXnxG-uc6zB0qA@mail.gmail.com>
	<20150810120642.2a0baac2@jvn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jan Viktorin <viktorin@rehivetech.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 01:43:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOwjH-0007xp-Uu
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 01:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbbHJXn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 19:43:26 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:32791 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbbHJXnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 19:43:25 -0400
Received: by ykaz130 with SMTP id z130so46140212yka.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 16:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=s1Z73cFVT/pSNvByiITOUrndko5DXmI38QVqKMuNxYE=;
        b=igRSl1YtrwmFyywCpfs00T8SaKr5eJL8WeWMet+7cjTumw+KTSWPZLSXo3wXUPpvkq
         pFvAMVC6ALPN1l7SmHSasyiW2UFuUngQXNAtUVkf6BFqbNuv0MZz/32f2dGsgcZWqXks
         LYjsjinV2lGR/G0ZSgKAbrMDVVQxOWoNaK53/LqeE4QcSsAqUveNfFQi5ESXNhjiVyWR
         SXjhJF2uFmVSnTH+X5hSjj4h+Vy1GDcYRYL1WKSBllWj+0kO99nWd5JGGuNC8cTpB35n
         4uy4XiGvIbmWw1rRFyLOsz4Jp+K7hWQjLnhlhwJwE7PBx4QjrzbgRxbwGJwi7QyIgpv7
         RJxw==
X-Received: by 10.129.91.87 with SMTP id p84mr25018666ywb.95.1439250204890;
 Mon, 10 Aug 2015 16:43:24 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 10 Aug 2015 16:43:24 -0700 (PDT)
In-Reply-To: <20150810120642.2a0baac2@jvn>
X-Google-Sender-Auth: UIj5E95ouc2UfTrVo-Zdrt_eqfo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275664>

On Mon, Aug 10, 2015 at 6:06 AM, Jan Viktorin <viktorin@rehivetech.com> wrote:
> On Sun, 9 Aug 2015 14:13:33 -0400
> Eric Sunshine <sunshine@sunshineco.com> wrote:
>> One possibility which comes to mind is to create a fake
>> Authen::SASL::Perl which merely dumps its input mechanisms to a file,
>> and arrange for the Perl search path to find the fake one instead. You
>> could then check the output file to see if it reflects your
>> expectations. However, this may be overkill and perhaps not worth the
>> effort (especially if you're not a Perl programmer).
>
> I think that Authen::SASL::Perl mock would not help. I wanted to create
> some fake sendmail (but this is impossible as stated above because
> then the perl modules are not used). So the only way would be to
> provide some fake socket with a static content on the other side. This
> is really an overkill to just test the few lines of code.

Agreed.

> So, what more can I do for this feature?

I don't have any further suggestions. Other than the unwanted
"Supported:" line in the documentation and the couple style issues[1],
the patch seems sufficiently complete, as-is. The validation regex
gets a "meh" from me merely because it's not clear how beneficial it
will be in practice, but that's not an outright objection; I don't
feel strongly about it either way.

[1]: http://article.gmane.org/gmane.comp.version-control.git/275150

> I think that the basic regex test is OK. It can accept lowercase
> letters and do an explicit uppercase call. I do not like to rely on
> internals of the SASL library. As you could see, the SASL::Perl does
> not check its inputs in a very good way and its code is quite unclear
> (strange for a library providing security features).
