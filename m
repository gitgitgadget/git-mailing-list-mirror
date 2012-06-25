From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Add C_LOCALE_OUTPUT prereq to test cases that
 require English text matching
Date: Mon, 25 Jun 2012 06:39:56 -0500
Message-ID: <20120625113956.GB9270@burratino>
References: <1340541692-10834-1-git-send-email-pclouds@gmail.com>
 <1340541692-10834-2-git-send-email-pclouds@gmail.com>
 <20120624162807.GB18791@burratino>
 <CACsJy8DpOL+V=sVZt3B-7OQ=POHtu1bovFB-sQ9HwPpmdKmN-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 13:40:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj7eM-0007jO-VQ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 13:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988Ab2FYLkD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 07:40:03 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:38503 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572Ab2FYLkC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 07:40:02 -0400
Received: by ghrr11 with SMTP id r11so2673831ghr.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AP03rXlXQ+dONq9VebqDGNbPtTUrLPhtY2ODJo4BOwY=;
        b=Eor/e2slTwId5KAujc0CZpnu5BJJXzC4tlgAPlsYfmG+Rl92dP2ftG2wDByo3N+ipu
         v5qLP+5duzWCqo74QGFCjD72tWZ6rylAWze7wPfkqhOw/uhOZcXWWWf1BuBVhsITWhCj
         lIRq05t7B/fUUbJzmiuGfNMO7SpvKQmbszK4L33gfR1cRl4gyBiWHgbAI7UvNiTy92Qz
         bSnymQX4PIveT5Od3FI/vLGk95HEXi6oH886rKI6JjdInA0ORh1KxiZnK0GYsDjew6By
         d0kqQrAS+f3b73TOCrgQbXJrRrxX2+8vdb9MaJt0AhAMiqHagZdFLJ9mHZUCZCyrqKjH
         mK3A==
Received: by 10.50.216.167 with SMTP id or7mr7684784igc.32.1340624401392;
        Mon, 25 Jun 2012 04:40:01 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id y5sm16018958igb.11.2012.06.25.04.40.00
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 04:40:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8DpOL+V=sVZt3B-7OQ=POHtu1bovFB-sQ9HwPpmdKmN-A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200570>

Nguyen Thai Ngoc Duy wrote:
> On Sun, Jun 24, 2012 at 11:28 PM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>>> - =C2=A0 =C2=A0 test_expect_${3:-success} "relative date ($2)" "
>>> + =C2=A0 =C2=A0 test_expect_${3:-success} C_LOCALE_OUTPUT "relative=
 date ($2)" "
>>> =C2=A0 =C2=A0 =C2=A0 test-date show $t >actual &&
>>> =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
>>> =C2=A0 =C2=A0 =C2=A0 "
>>
>> Could use test_i18ncmp so we catch if test-date crashes, but anyway,
>> yeah, we can't expect to be able to meaningfully test date formattin=
g
>> in another language.
>
> This reminds me of an inkscape crash I encountered long ago because o=
f
> a mistake in Vietnamese translation. Too bad we can't test all locale=
s
> for similar bugs (or we would need to i18n-ize expected results in th=
e
> test suite too)

Sure we can. :)  We just need to make sure we are using test_i18ncmp
where appropriate so the tests run and check as much as they can
without relying on details that are left to the translators'
disgression.

But yes, the test harness doesn't know how to do that yet.  I'm hoping
that soon-ish there will be an option to run tests in your chosen
language, so the test result can more closely reflect bugs one is
likely to run into in practice (and so developers can more easily test
the edge cases such as Turkic locales where tolower('I') !=3D 'i').
Sorry I haven't had enough time to bring this kind of thing into
reality, and thanks for stepping in with the partial work in that
direction before.

Jonathan
