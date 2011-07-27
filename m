From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 14/18] revert: Introduce --reset to remove sequencer state
Date: Wed, 27 Jul 2011 16:28:15 +0200
Message-ID: <20110727142815.GC24785@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-15-git-send-email-artagnon@gmail.com>
 <20110727051115.GI18470@elie>
 <CALkWK0k7SvjJ8duNscnwjn4JOjSDqfHN1qH9rnoz5w8TjHgKgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 16:28:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm568-00071Q-SO
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 16:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564Ab1G0O22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 10:28:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46830 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab1G0O21 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 10:28:27 -0400
Received: by fxh19 with SMTP id 19so460896fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LlNWDTEuqBooGJV+OIxN9w8f6sz73+PaubWrNi/WuaQ=;
        b=ZwgrYDvhdSZhYAUHdNGszzbmvQFydPXh/2t7Am0ek1MQLP/M/YzZ14yZod7Vq7W+gp
         XnGyNPTZAJkjnvz293Rh7qjqOVQm4kZs4wGzTvTaQSTzVvaenlPwT0PpTPP0AmqOtyho
         tE0g+g7UDRN+tqT3y9i5Nl7NS8G8ZKQMcLQIQ=
Received: by 10.223.43.1 with SMTP id u1mr146961fae.38.1311776906005;
        Wed, 27 Jul 2011 07:28:26 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id e10sm95239fak.18.2011.07.27.07.28.23
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 07:28:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0k7SvjJ8duNscnwjn4JOjSDqfHN1qH9rnoz5w8TjHgKgA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177966>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:
>> Ramkumar Ramachandra wrote:

>>> + =C2=A0 =C2=A0 if (opts->subcommand =3D=3D REPLAY_RESET) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remove_sequencer_state(=
1);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>>> + =C2=A0 =C2=A0 } else {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Start a new cherry-p=
ick/ revert sequence */
>>
>> Can un-indent by dropping the "else":
>
> Actually this was intentional; if we un-indent this now, there'll be =
a
> diff indenting it when '--reset' and '--continue' are introduced whic=
h
> turns out to be especially ugly :)

Why couldn't it look like this at the end, for example?  (As always,
this is just an example; I am not saying "please make it look like
this".)

	if (opts->subcommand =3D=3D REPLAY_RESET) {
		remove_sequencer_state(1);
		return 0;
	}

	if (opts->subcommand =3D=3D REPLAY_CONTINUE) {
		... prepare todo list for continue ...
	} else {
		... prepare todo list for a new cherry-pick ...
	}
	pick the chosen commits

>> This is not about this patch, but ideally the cleanup would come at
>> the beginning of the next test, so if one test fails it does not tak=
e
>> down all the tests that come after it.
>
> Good point.  Fixed all, thanks.

Thanks for looking into it.
