From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [GSoC update] Sequencer for inclusion
Date: Mon, 11 Jul 2011 15:11:24 -0500
Message-ID: <20110711201124.GA6568@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <20110711171713.GA5963@elie>
 <CALkWK0msdBdXX4oMkd+WAMR8PXTRT3ivjMrf3ZAMfBrsLoM=dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 22:11:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgMpS-0006s9-6s
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 22:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405Ab1GKULh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jul 2011 16:11:37 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42976 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab1GKULg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2011 16:11:36 -0400
Received: by ywe9 with SMTP id 9so1648208ywe.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AOBAVyTyZSeY9xtgvj3iZJFETQoO8174Jk03WXZ4mvo=;
        b=CHEWxDRQqPXbJnuTUpLIpDOwiXsuLZ8sbAk65ubMmJ/FxqlZyDxiveWi/+rehdRedJ
         XNMXvz+cw3shJZfEqYE92Z5U2rD8uzGST+bf/fIvnrtF/qlxQYyh40toKqUPjsOjRXqQ
         c0Guxd47N8BGAfOc00CK3UHSaEGvDQARF9/pY=
Received: by 10.236.153.4 with SMTP id e4mr5695141yhk.263.1310415095728;
        Mon, 11 Jul 2011 13:11:35 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.ameritech.net [69.209.70.6])
        by mx.google.com with ESMTPS id e24sm2174876yhk.23.2011.07.11.13.11.33
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 13:11:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0msdBdXX4oMkd+WAMR8PXTRT3ivjMrf3ZAMfBrsLoM=dQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176891>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:

>> To be precise, the format used includes
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0strategy-option =3D patience | renormaliz=
e
>>
>> to represent the effect of "-Xpatience -Xrenormalize". =C2=A0My only=
 worry
>> about that is that the "|" can sound like "or", which would seem
>> strange to a user that does not necessarily develop software (so is
>> not thinking about bitfields). =C2=A0The format used in config files=
 puts
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0strategy-option =3D patience
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0strategy-option =3D renormalize
>>
>> as separate lines.
>
> Okay, I can change to that if it's desirable.  My rationale for using
> "|" is that lines like "key =3D value1" and "key =3D value2" tend to =
look
> odd -- it's like I'm reassigning the key a different value.

On second thought, I don't think it matters, since this is not meant
for humans anyway, right?

I.e., it could be

	gibberish=3Dpatience renormalize

and that would work just as well.  Feel free to forget I said anything.

>> Once each new feature has been documented and each new feature or
>> fixed bug has an associated test, you've reached the end of this.
>
> It depends on how rigorously you want to document and test things, no=
?
>  For example, I haven't documented the formats of the configuration
> files anywhere but in the commit messages.  Something in
> Documentation/technical would be nice, but I think we should wait
> until the format evolves a bit.  Since I haven't exposed anything lik=
e
> a "--interactive" functionality, the user will never see it and we ca=
n
> change it as and when we like.

Right, I haven't looked through carefully but this didn't look
underdocumented.

I mostly meant about tests:

> Also, for things like the option parser, how far do you want to go
> with testing? How many kinds of malformed instruction sheets do you
> want to test with?  I'll include some more basic tests soon, but I
> don't think we should go too deep, due to time constraints.

There are other reasons not to test too much, too: the longer tests
are, the less pleasant an experience it is to run them or to modify
the testsuite later.  So just the minimum to make sure the feature and
checks you carefully introduced continue to work as later changes are
made is not only enough but ideal.

> I have updated many of the commit messages.  Do let me know what's
> missing where.

Will send relevant links to previous reviews.  Thanks.
