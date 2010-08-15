From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Silent maintenance
Date: Sun, 15 Aug 2010 00:21:18 +0000
Message-ID: <AANLkTim1HL_WH_ShxNYXmsSnbMNq7=C7oj46qav2OQe1@mail.gmail.com>
References: <20100814131156.GA24769@nibiru.local>
	<20100814210556.GB2372@burratino>
	<AANLkTimLHand0g965TJmk=Y4Q+0uTFovZZRZXf9Fx4UB@mail.gmail.com>
	<20100814220410.GA16592@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 15 02:21:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkQym-0000bu-UK
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 02:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584Ab0HOAVU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 20:21:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44667 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756258Ab0HOAVT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 20:21:19 -0400
Received: by iwn7 with SMTP id 7so283508iwn.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 17:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LLxnK7AveHrfRIyGwSyQre4OjB87oA3cHOoitpINYlU=;
        b=W210dBcxmaxoQt/poClUBCpQVO4lp5xvN1mrFIeAknVydiyzGU8iKZWXJ2Gu0HeE3T
         9KsK4PKDguj3bqQ8u1Ra0fR4O7houDF/KDwBgJ9OYbvB1U6GizEAhukA/o4UDD7duiS3
         tMVdo3/a404V8iluLnIseHVCLqR0HUflGzN9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QdZfgT2snF2GWXigXm6nnLQOqRrlzftOswUCiXP3bX90AKlYtlP9lwp2EXQgoLOQzo
         8RZxvGB12AP+FewP3w7WUCJPBmXiMF7+c2Mhu/t7oerhPlaiVRTo4SijZPv+cUEsbWXj
         qmxG9YFTJhmNMlJgy0mX8iQrJWFYi8oiecVlo=
Received: by 10.231.161.68 with SMTP id q4mr3620801ibx.79.1281831678763; Sat,
 14 Aug 2010 17:21:18 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 14 Aug 2010 17:21:18 -0700 (PDT)
In-Reply-To: <20100814220410.GA16592@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153587>

On Sat, Aug 14, 2010 at 22:04, Jeff King <peff@peff.net> wrote:
> On Sat, Aug 14, 2010 at 09:41:44PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> On Sat, Aug 14, 2010 at 21:05, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>> > Enrico Weigelt wrote:
>> >
>> >> are there some flags to make the maintenance commands like
>> >> git-repack and git-gc silent, so they only output errors ?
>> >
>> > Does --quiet work? =C2=A0If not, patches would be welcome.
>>
>> I intentionally neglected to mention that. That inevitably leads to
>> cases where something fails, but you didn't record the output.
>
> I'm confused. Isn't the point of quiet to silence all of the cruft, a=
nd
> leave only actual errors?
>
> =C2=A0$ git gc
> =C2=A0Counting objects: 128, done.
> =C2=A0Compressing objects: 100% (49/49), done.
> =C2=A0Writing objects: 100% (128/128), done.
> =C2=A0Total 128 (delta 71), reused 121 (delta 68)
>
> =C2=A0$ git gc --quiet
>
> =C2=A0$ chmod -w .git/objects/pack
> =C2=A0$ git gc --quiet
> =C2=A0fatal: Unable to create temporary file: Permission denied
> =C2=A0error: failed to run repack
>
> Isn't that what the OP wanted?

Maybe, personally I prefer to get all or nothing. If you specify
--quiet you'll only get errors, so it doesn't give you much
context. But if you use cronjob(1) you can see at a glance the normal
output of all the successfully executed commands that led up to your
failure.

E.g. the output of a successful "cherry-pick" right before a failing
merge can be really helpful to see the state of the failing program.
