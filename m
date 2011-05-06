From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH for maint] git-completion: fix zsh support
Date: Fri, 6 May 2011 12:34:59 +0300
Message-ID: <BANLkTim8=D3ivFoOsbAvDBSRbAu+0us-2g@mail.gmail.com>
References: <20110505185907.GD1377@goldbirke>
	<1304625144-5206-1-git-send-email-felipe.contreras@gmail.com>
	<20110505232503.GA7507@elie>
	<7v7ha44ej8.fsf@alter.siamese.dyndns.org>
	<20110506052744.GA15132@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 11:35:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIHRF-0004UF-Aa
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 11:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403Ab1EFJfB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 05:35:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41980 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347Ab1EFJfA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 05:35:00 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so2122491fxm.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0Bg3hvGZbHKCdaGZLt2FHgT46wO8Cn4bpUbn4ajiF6I=;
        b=irfS1t2CV6mi1DqIEcj59k9iEVx93ntoWg2uJenemzo+15n0gjjuLXIn+RGArfR/DP
         z8wlqzNQBYSHtuLGJAZRwBFzYHNfKRoWiA67i/MYl0dzropNLJkPGK3dvLactRohn9gL
         t5H3Qi4Nphn9iQn3lRknNpnl/qC/ZNlDiCqMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p9X7jdTFB8KHEr/QeBVXabGqgs8ccGvV7UBRAHQWAN/uiCI1pH+6ECLyP0+ekVP0jF
         SWWALgf+2kCEnZjOEzJzv+Jk/xxYlPty06PxdFBz4C+uAAtWJpn2MkMGT3VyRaOKRGam
         4Lz36Hi84gGoV0o13CfaJKENuwTmfAfTtRljs=
Received: by 10.223.87.215 with SMTP id x23mr2729403fal.32.1304674500000; Fri,
 06 May 2011 02:35:00 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Fri, 6 May 2011 02:34:59 -0700 (PDT)
In-Reply-To: <20110506052744.GA15132@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172964>

On Fri, May 6, 2011 at 8:27 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> Maybe simplest would be to use Szeder's fix + make the zsh version =
of
>>> _get_comp_words_by_ref not overwrite "words" at all?
>>
>> I do not use zsh myself, but it appears to me that these three-patch
>> series can graduate and if real zsh users find problems after using =
it
>> they can be fixed independenty in-tree.
>>
>> Would that risk too many patch ping-pong among zsh users on 'master'=
?
>> The "don't declare 'local words' in zsh" patch seems to be the right
>> work-around for the peculiar semantics of "words" array, at least to=
 me.
>
> G=C3=A1bor's patches already work. =C2=A0I don't think they will caus=
e breakage
> or patch ping-pong.
>
> I was trying to imagine Felipe's objection and all I could think of
> was that it is not so appealing that _get_comp_words_by_ref is not
> actually writing to "words". =C2=A0For example, the following on top =
of
> sg/completion-updates (=3D 3bee6a4) will print a greeting and the wor=
ds
> being completed when you press tab, rather than <foo> <bar> <baz>:

[...]

> In practice it works great since "words" already has the right
> content, but maybe the "typeset -h" suggestion was motivated by a
> desire to have something easier to explain.
>
> I don't think that's a very strong reason to prevent the fix from
> graduating, though I suppose I would be happy to see something like
> the following on top at some point.
>
> -- 8< --
> Subject: completion: do not pretend to assign to special variable $wo=
rds on zsh
>
> The special variable $words already has essentially the same meaning
> as bash's COMP_WORDS on zsh. =C2=A0While assigning one to the other a=
ppears
> to work okay, as a no-op, that is actually an illusion --- the value
> of $words can be changed in the _get_comp_words_by_ref function where
> it is assigned, but after that function returns, $words is back to
> normal.
>
> Guard against future breakage by adding a comment mentioning this and
> removing the redundant assignment.

I don't really object to G=C3=A1bor's patches. The third one actually f=
ixes
the issue.

The thing is that it's a *workaround*, and I prefer to keep
workarounds to the minimal. So I prefer my patch that introduces only
2 new lines and doesn't change the semantics of the rest of the code.
Moreover, it's already fixed in zsh's master, so at some point we
might want to remove it, and it's easier to remove 2 non-intrusive
lines.

But anyway, my end goal is to get this into the 'maint' branch. It's
up to Junio how to get the fix there (if at all), but I think it's
easier to just apply my patch there.

Cheers.

--=20
=46elipe Contreras
