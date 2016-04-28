From: =?UTF-8?Q?Guido_Mart=C3=ADnez?= <mtzguido@gmail.com>
Subject: Re: [RFC/PATCH] Ordering of remotes for fetch --all
Date: Thu, 28 Apr 2016 17:24:20 +0200
Message-ID: <CA++DQUnWnVfCWHZ1Jhzxr2BpdmXj2aChez+ozxW7FUPkpQuoNw@mail.gmail.com>
References: <20160425211506.8421-1-mtzguido@gmail.com> <20160425213720.GB11227@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:24:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avno5-0003BZ-N8
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbcD1PYl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2016 11:24:41 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36508 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbcD1PYk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2016 11:24:40 -0400
Received: by mail-vk0-f51.google.com with SMTP id o133so35576282vka.3
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u0mZQZP+6cTN2bg+obOlM5N5flCd3lfRlvyNmXQghIA=;
        b=Q5S1UdeqyT/wEKDNaZnDokZqUVnLFa/RnAbGy/7Aogeg7KRDTYJmlWGutD452xuojf
         9rzt2CXIwOb5OFLESI3y6g0LLPDa0vi72V+3LoaqU4egIIlpXfOQzCvZeO29pta/uhDY
         pjEBR4+L91DNsBGKQ/6WwKMmq3/SzVoJDw3jTOkZxxEirltgGVbVUbbyxz7mKK1oKwNC
         3SmRzrXIbXJaRYXlNtKpCyBv8mlt4yNV/u5uO+q98e1eBfnFaJu6QQ6OFvP9sK696N2Y
         rAfF/L8lSv9liToCkNIJIetdSCR+V+m4Uwm87OAe0d4NXdbXBa2x+8LqIcxF9F3iJNbE
         CXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u0mZQZP+6cTN2bg+obOlM5N5flCd3lfRlvyNmXQghIA=;
        b=F9hZJy74uaZB7S3rjm/L96MGwStWNlNr2gy9rKtl+Zv3oTQSgyMIDzsnX0HJTBJL8Z
         sMDqeIb/3/ma4Oqe31DMWBbidHnxOM0ZtRwwj9+xyrI601QBmx9iHgI8TU0/KB56A4xx
         Ka5xRCquMz7bm/cT3TzcrMQ9bkOeQb2L4pvPPils6jyByxJo/jQLgq8OTOwrUN8peQwJ
         2It7Py062ZFWUKEa8/RKRIsuPUVtTWGuGPM4mmEdfQJNXxLFYrvltVV1oQ76uvAdsHqp
         7SYLG7425iMcJCvGfcB7NH8zSNVZEdAX7Tl13kOmYIb4097dnhJxWz4PC1u17WMo/Trx
         pkgw==
X-Gm-Message-State: AOPr4FUq6V+hWso5Re/okQym94sktUxzj8CvHJYQbx6r7TMVMWTcRtZBJZ/TVtJ1RSDdcI+D7HkFncJ6IX7igw==
X-Received: by 10.159.35.226 with SMTP id 89mr8333829uao.27.1461857079690;
 Thu, 28 Apr 2016 08:24:39 -0700 (PDT)
Received: by 10.159.55.143 with HTTP; Thu, 28 Apr 2016 08:24:20 -0700 (PDT)
In-Reply-To: <20160425213720.GB11227@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292895>

Hi Jeff, thanks for your comments.

On Mon, Apr 25, 2016 at 11:37 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 25, 2016 at 11:15:05PM +0200, Guido Mart=C3=ADnez wrote:
>
>> I run a server with several git mirrors, that are updated every hour=
=2E On
>> that same server, users clone those projects and work on them. We us=
e
>> the local mirrors to reduce network load: the users can fetch from t=
he
>> mirror first (to get most of the objects with zero network cost) and
>> then fetch the real remote (to make sure they're completely up to da=
te).
>>
>> I would like this to be configurable in each git working directory,
>> so users can just configure the order they want and then just do "gi=
t
>> remote update".
>>
>> I'm aware one can get this behavior by editing .git/config and
>> ordering the remotes as one wishes, but I find that very hacky and n=
ot
>> scripting-friendly.
>
> You can also define your own ordered groups, like:
>
>   $ git config remotes.foo "one two three"
>   $ git fetch foo 2>&1 | grep ^Fetching
>   Fetching one
>   Fetching two
>   Fetching three
>
> That's not _exactly_ the same, because you can't give a partial order=
ing
> of one high-priority remote and then say "all the rest, in whatever
> order you want", because there's no way to say "all the rest".
>
> You _can_ say:
>
>   git config remotes.foo "high-priority --all"
>
> but the final "--all" will fetch from high-priority again. An
> alternative feature would be to teach remotes.* groups to cull
> duplicates, if that's not acceptable.
These are good, but my main drive was to be able to just "git remote
update" without any more information. In your cases I need to call
update "foo". Also as you mention you either need to edit foo when
adding a repo, or duplicating the pull from the high-prio one.

Another approach would be to add a "fetchdep" pointing to another
remote, and then do a topological sort on fetch --all. This can also
be used on "git pull", to first pull from the mirror without any extra
command.

Maybe it's not such a big deal, but I think it's a nice feature to
have. It allows for a stupidly simple mirroring/prefetch scheme,
without any proxy or anything fancy.

Not sure if it suits the needs of anyone else, though... Would there
be interest in me implementing the "fetchdep" alternative?

Thanks!
Guido

>
> I don't have a strong opinion against your approach, though. Just
> exploring alternatives.
>
> -Peff
