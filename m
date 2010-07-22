From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] t/: work around one-shot variable assignment with 
	test_must_fail
Date: Wed, 21 Jul 2010 21:32:01 -0300
Message-ID: <AANLkTin5NPzFwMuQYcdaTaCEqmlrzRyIpEl7btV1LDRS@mail.gmail.com>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil> 
	<iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil> 
	<7v1vawk50n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	avarab@gmail.com, jrnieder@gmail.com, jaredhance@gmail.com,
	drafnel@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 02:32:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obji9-0003IN-8N
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 02:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657Ab0GVAcY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 20:32:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60936 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135Ab0GVAcX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 20:32:23 -0400
Received: by iwn7 with SMTP id 7so7288644iwn.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 17:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=m1vS7qoP794IyeXCzC40eK83FMQO1lsNTJlV3tVDABM=;
        b=OVbL34rFHoByZBBNevA4I4w3B0tV0WYyjHNLkoDbRFs+obyr4SfD9jadZv8LBDveII
         eO07vB7VnIvGpr6+U2xDfc3N8QLWe2ZlrHOaBJa5QR4HoNW9fsmpngreT+2boVrUcSP8
         fzX/HotO83jnnHwZp99BLLQsXEVpE4gIQX1YI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hVtkvJhXk9vXBaPxxrGRwMeAf9EqpMbU8YDZgicxMirR6gvqmy50p4nsEZ7O5+uHGO
         IqNfFlQlsxaFauZj3NygBgOIIZDD3o3Q03eTo0wSl60JdEB1cbxi8xArCQ3346uaURr/
         wVHhgfjqQXq1rFxv/CtDrzxVUGq3zlrz/oqk8=
Received: by 10.231.12.76 with SMTP id w12mr985469ibw.87.1279758741582; Wed, 
	21 Jul 2010 17:32:21 -0700 (PDT)
Received: by 10.231.178.36 with HTTP; Wed, 21 Jul 2010 17:32:01 -0700 (PDT)
In-Reply-To: <7v1vawk50n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151438>

Hi,

2010/7/21 Junio C Hamano <gitster@pobox.com>:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>
>> No time to investigate, but here is an example patch and the
>> results of running the affected tests. =C2=A0Looks like reflog may
>> be creating a reflog when it is not supposed to.
>
> Your later analysis is correct; "git reflog show <branch>" does not
> complain when there is no reflog for <branch>, which might or might n=
ot be
> a bug.

I think is not a bug but almost one.

> Because these tests are not about behaviour of "git reflog show" comm=
and,
> let's do this for now.
>
> Thanks.
>
> -- >8 --
> Subject: tests: correct "does reflog exist" tests
>
> These two tests were not about how "git reflog show <branch>" exits w=
hen
> there is no reflog, but were about whether "checkout" and "branch" cr=
eate
> or not create reflog when creating a new <branch>, update the tests t=
o
> check it in a more direct way, namely using "git rev-parse --verify".
>
> Also lose tests based on "test -f .git/logs/refs/heads/<branch>" from
> nearby, to avoid exposing this particular implementation detail
> unnecessarily.

Quite pretty.  Clean and optimized solution.  Better this way.

Regards
