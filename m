From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 6/6] upload-pack: provide a hook for running pack-objects
Date: Thu, 19 May 2016 16:54:37 +0200
Message-ID: <CACBZZX7nuy3RYPQ5e_FFqvCTStZka49ZSNNe9q2agffa7fp-EA@mail.gmail.com>
References: <20160518223712.GA18317@sigill.intra.peff.net> <20160518224537.GF22443@sigill.intra.peff.net>
 <CACBZZX5SVJ2CSB0AS3Lj1A8_S+ejGOPUDn6Sc3whotkyFwxEiA@mail.gmail.com> <20160519120848.GC3050@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 19 16:55:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3PLq-0004G6-OB
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 16:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbcESOy6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 10:54:58 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33321 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217AbcESOy6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2016 10:54:58 -0400
Received: by mail-qk0-f179.google.com with SMTP id n63so49386895qkf.0
        for <git@vger.kernel.org>; Thu, 19 May 2016 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0UyR3QQAn1PfHp+1Qj8PW8GeaWmLz2aZpJnODwx9DY0=;
        b=QgwKlEbM1ArCeCWqeAGfxUVBXE0h6YHk0GmQZf4fH0SLEiEUeM/1B66R4kh5uS8axU
         VRLqNOl7tJeMP+6LcEwRuGuWsiLi1orWAjiaLa3rreX8EksSi+C0TFfPnsTdz/yHGo1n
         PAVU5wKGQYghlrQ/apqGICKBSPnxukwwQOcQ/qlPVWtmN5wqdbeC1lcxjMJqPPRydKL6
         CFl0d/F6Gv998MTbvrOGtSHhIsGk/qO6/9CHtgJOI1TcPJlxHSwoaCTxIbd0c6Itm594
         uGHHZ4kU0dqmrwF8UX6JKTUsPJeBmTDp136moAhzI91yx7J4jSocfXS1LUh9Amib1Qri
         AMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0UyR3QQAn1PfHp+1Qj8PW8GeaWmLz2aZpJnODwx9DY0=;
        b=f5c4KQpRuXPOd450UUtw03ytSuXq1dg7MdNeBjrnG+RDUNhpYFEgjg14GJabpHPGU9
         eb6Ds0ONJKCgBhDZX/6RLCHeAyxNsGObmlCSyIf1fwSs2c/JAPt7eb+UbGqQ60y3cf9R
         13+cnQ4bcF2/FE1aI6IdB/ilucBHl/Jk+AGJEamjnVkQNlYT4ezGiIsjGw4SWVAhJy1Z
         ldd6UzGM7s9qdG+wVWP35PyMdct2sufvQxWflBFm+PK7GwKtiAGGBU+zqXhfN96zsuzI
         96BsYs03ti3pyO6isxTN1FOyfXxyEDDymgVpcM0PU4NuAwOWdww1vGrWR8he0Flgc+pt
         gdPg==
X-Gm-Message-State: AOPr4FXwTdz8pilP1MwZanhwsF/dznGi97+2zGJArb/nOn9VmvyWMfRARhp+gJc4Eqzmjux5DhRnENh2TalTjA==
X-Received: by 10.55.145.6 with SMTP id t6mr14585467qkd.206.1463669696985;
 Thu, 19 May 2016 07:54:56 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Thu, 19 May 2016 07:54:37 -0700 (PDT)
In-Reply-To: <20160519120848.GC3050@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295066>

On Thu, May 19, 2016 at 2:08 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 19, 2016 at 12:12:43PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> But as you point out this makes the hook interface a bit unusual.
>> Wouldn't this give us the same security and normalize the hook
>> interface:
>>
>>  * Don't do the uploadpack.packObjectsHook variable, just have a
>> normal "pack-objects" hook that works like any other git hook
>>  * By default we don't run this hook unless core.runDangerousHooks (=
or
>> whatever we call it) is true.
>>  * The core.runDangerousHooks variable cannot be set on a per-repo
>> basis using your new config facility.
>>  * If there's a pack-objects hook and core.runDangerousHooks isn't
>> true we warn "not executing potentially unsafe hook $path_to_hook" a=
nd
>> carry on
>
> This is the "could we just set a bool" option I discussed in the comm=
it
> message. The problem is that it doesn't let the admin say "I don't tr=
ust
> these repositories, but I _do_ want to run just this one hook when
> serving them, and not any other hooks".

Indeed. I wonder if there's really any overlap in practice between
systems administrators on a central Git server that are going to want
this relatively obscure feature *but* have potentially malicious users
/ repos, or enough to warrant this unusual edge case in how this
specific hook is configured, as opposed to reducing the special case
in how the hook is run with something like core.runDangerousHooks.

I'm definitely not saying that these patches should be blocked by
this, but it occurs to me that both your uploadpack.packObjectsHook
implementation and my proposed core.runDangerousHooks which normalizes
it a bit in some ways, but leaves it as a special case in others, are
both stumbling their way toward hacks that we might also solve with
some generally configurable restrictions system that takes advantage
of your earlier patches, e.g.:

    $ cat /etc/gitconfig
    # Not "repository" so hooksPath can't be set per-repo
    [core]
        configRestriction                 =3D "core.hooksPath: system, =
global"
        hooksPath                            =3D "/etc/git/hooks"
        disableHook.pack-objects =3D false # "true" by default
    $ ls /etc/git/hooks/
    # pre-receive, update etc. would just wrap the repository hook,
    # but pack-objects is global
    pre-receive update pack-objects, [...]

Of course those are some rather large hoops to jump through just to
accomplish this particular thing, but it would be more generally
composable and you could e.g. say users can't disable gc.auto or
whatever on their repos if they're hosted on your server. Which of
course assumes that you control the git binary and they can't run
their own.

>> This would allow use-cases that are a bit inconvenient with your pat=
ch
>> (again, if I'm understanding it correctly):
>>
>>  * I can set core.runDangerousHooks=3Dtrue in /etc/gitconfig on my g=
it
>> server because I also control all the repos, and I want to experimen=
t
>> with trying this on a per-repo basis for users that are cloning from
>> me.
>>  * I can similarly play with this locally knowing I'm only cloning
>> repos I trust by setting core.runDangerousHooks=3Dtrue in ~/.gitconf=
ig
>
> Yes, those use cases are not well served by the git config alone. But
> you can do them (and much more) once your trusted hook is running (by
> checking $GIT_DIR, or looking in a database, or whatever you want).

Yeah, the reason I'm prodding you about this is because I want to test
this out at some point, and a *really* nice thing about the Git
configuration facility is that you can test all these sorts of things
on a per-repo basis now due to how all the git-config variables work
now.

With uploadpack.packObjectsHook you *can* do that by defining a global
pass-through hook, but it makes it more of a hassle to test changes
that straddle the divide between testing & production.

I.e. I might test this on one repo on our main git server, or on one
active repo, i.e. I don't have to deal with the case where I make some
silly syntax/logic error in the uploadpack.packObjectsHook dispatch
code (which is only needed for the security consideration) and that
impacts all repositories on the machine.
