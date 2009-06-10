From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Wed, 10 Jun 2009 10:14:22 +0200
Message-ID: <c07716ae0906100114n61ca5553k2f54918dd32afbb4@mail.gmail.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
	 <4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>
	 <4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>
	 <c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com>
	 <c07716ae0906090526i714bb6c9g4e3d8cf61021af77@mail.gmail.com>
	 <4A2E7EEC.2050807@zytor.com>
	 <c07716ae0906091228s708058d4vea986239a6b458de@mail.gmail.com>
	 <4A2EB8E9.5040207@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 10:14:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEIx9-0002qH-5F
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 10:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529AbZFJIOY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 04:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754459AbZFJIOX
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 04:14:23 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:62173 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbZFJIOW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 04:14:22 -0400
Received: by fxm9 with SMTP id 9so562246fxm.37
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 01:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xNACYCET1A50415eTWF5lRi1M4uhlTzrw4qANwfBBs4=;
        b=MNKAYeY0su65Td3S8yM1PD8K4J1cA8j919gF5CVZW+vlNDFsamH96p6JGsk8v/aAtm
         SPVjuUXheyQjh6AXj8etXLxIs/gsW1Y9cBUygUUONkldpCQoOIpfZ1va9LK0DNRvJxd7
         iEchg9IXpe1MBIL/GzHBjOzHN5X1YuJTmoE7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RzUyHUm5FgNYQoS/KWwUS0En/CDx16oBk+0yL/tjc5Ful5V71643mm+IlKgLNO7yoK
         4d3juxDFkWYfB9oTYg0Vew8LWAT2Gb+fDwAsjAgMZ2zdpoxqBeUwB1vgmcUPtnu2AknD
         LsuhbCg7NKNIggb5ODV4SoME4gOrevoyuCqeQ=
Received: by 10.103.221.14 with SMTP id y14mr598417muq.111.1244621663001; Wed, 
	10 Jun 2009 01:14:23 -0700 (PDT)
In-Reply-To: <4A2EB8E9.5040207@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121264>

On Tue, Jun 9, 2009 at 9:32 PM, H. Peter Anvin<hpa@zytor.com> wrote:
> Christian Couder wrote:
>>>>
>>> Sort-of-kind-of. =A0I doubt most users will be able to recover from=
 a
>>> stuck situation, and unless we have extremely high cost of testing
>>> (which is true for some applications) then expecting the user to
>>> optimizing manually is really bad user design.
>>
>> My opinion is that we should not penalize all the people working on
>> "quite clean" projects and also people working on "not clean" projec=
ts
>> who are able to recover, on the pretence that there are other people
>> on these "not clean" projects who are not.

By the way, if for example you have a project with 10% chance to land
in a "stuck area" of the graph, then with my algorithm the chance to
get stuck when you hit an untestable commit is 0.1^3 that is 0.1%. So
in this kind of projects the chance that the first bad commit is near
a lot untestable commits is much higher than that.

In fact I think that it's probably very hard to find a kind of project
where the chance to get stuck when using my algorithm is not dwarfed
by the chance of the first bad commit to be near or among many
untestable commits.

>> I think it's the projects maintainers' responsibility to keep their
>> projects graphs quite clean (and they have the right to ask git
>> developers for the tools to do that).
>
> No, it's not. =A0This is saying "it's the user's responsibility to ma=
ke up
> for shortcomings in the tools", which is completely bass-ackwards.

I think that what I said is just the opposite that. If you find
shortcomings in the tools then you are welcome to ask us to fix them.

And if users find shortcomings in the cleanliness of the project
graph, they should be welcome to ask the maintainers to provide them
with ways to work around them, like for example a file that contains
many commits and range of commits that should always be skipped and
that can be used like for example:

$ git bisect start
$ git bisect skip $(cat always_skipped_file)
$ git bisect good ...
$ git bisect bad ...
=2E..

Or the maintainers can in turn ask git developers what's going on with
"git replace" if they would prefer using that instead of such a
file...

>> If they don't do so, then their
>> users will suffer anyway. So it's not a big deal to ask them to teac=
h
>> their users to add a "--prng" option to "git bisect start" for examp=
le
>> or something like that to try to work around the "not cleanliness" o=
f
>> their graphs.
>
> Let's see... we can penalize the default user by 19% (the amount of
> difference) if and only if they have skip points (at which point your
> "project manager's responsibility" has already failed) or we can risk=
 an
> inexperienced user getting stuck?

I am not sure I understand you very well but as I said above I think
with a "reasonably clean" graph the risk of the inexperienced user
getting stuck because of my algorithm is very low compared to the risk
of getting stuck because the first bad commit happens to be near many
untestable ones.

Best regards,
Christian.
