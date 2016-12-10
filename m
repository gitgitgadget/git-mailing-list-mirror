Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65BBA203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 10:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbcLJKqe (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 05:46:34 -0500
Received: from tschil.ethgen.ch ([5.9.7.51]:41117 "EHLO tschil.ethgen.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752070AbcLJKqe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 05:46:34 -0500
Received: from home.ethgen.de ([94.247.217.2] helo=ikki.ket)
        by tschil.ethgen.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <klaus@ethgen.de>)
        id 1cFfAk-0004jL-OG
        for git@vger.kernel.org; Sat, 10 Dec 2016 11:46:31 +0100
Received: from klaus by ikki.ket with local (Exim 4.88)
        (envelope-from <klaus@ikki.ethgen.ch>)
        id 1cFfAf-00080e-KT
        for git@vger.kernel.org; Sat, 10 Dec 2016 11:46:25 +0100
Date:   Sat, 10 Dec 2016 11:46:18 +0100
From:   Klaus Ethgen <Klaus@Ethgen.ch>
To:     git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
Message-ID: <20161210104615.koit4zyu6fioaehm@ikki.ethgen.ch>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
 <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
 <xmqqwpf8rkeq.fsf@gitster.mtv.corp.google.com>
 <20161210092928.jkaf2rwxhicafmxr@ikki.ethgen.ch>
 <20161210102446.2sf3dxy7yj7sifcd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
In-Reply-To: <20161210102446.2sf3dxy7yj7sifcd@sigill.intra.peff.net>
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi,

Am Sa den 10. Dez 2016 um 11:24 schrieb Jeff King:
> > A colon a perfectly allowed character in POSIX filesystems.
> 
> Sure, it's allowed, but it will cause problems due to other syntactic
> conventions.  Try putting "/usr/path:with:colons" into your $PATH
> variable, for instance.

True.

> Try rsyncing "xxx:yyy.git" somewhere.

Only a problem when the part before the colon has no directory limiter
(/) in it. And even then there is ways to work around that limitation.

And in this case, it is pretty good documented. As I told, I never
heared of such limitation in git commands.

> Git does have heuristics for figuring out the difference between
> "host:repo.git" as an SSH remote versus a local path, but they're not
> foolproof.

Well, that is the reason why I first tried to solve it via file://...

Note, I have no problem with it, if that char has to be qouted somehow;
if it is clearly documented. But also then, the handling should be
consistent. In git (in this version) it is not. Pull works without
problems but push dosn't.

> > Moreover, it was no problem before and was introduced as a problem just
> > in that version. Even more, a pull (and so a clone I believe) of such a
> > path is absolutely ok. Just the push fails.
> 
> Sort of. This has always been a problem with the variables Junio
> mentioned. The change in v2.11 is that the alternates subsystem is being
> used in some cases where it wasn't before, which is surfacing this
> limitation in more places.

- -v please. I didn't get it with that alternate stuff in push.

A link to some man page is ok too.

> > > directory, i.e. GIT_OBJECT_QUARANTINE_DIRECTORY, whose value is
> > > added without splitting to the list of alternate object stores, and
> > > the quarantine codepath can export that instead.
> > 
> > I didn't get it, why is there a need to split? I mean, it is not
> > possible to push to two locations at the same time, so why is there
> > splitting at all?
> 
> Because the new quarantine feature[1] is built on top of the existing
> alternates mechanism, which can have several sources.

I'll clone the repo and read about, thanks for the pointer.

I even have to find out about that alternates mechanism and what it has
to do with push but not with pull.

Regards
   Klaus
- -- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C
-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAEBCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAlhL3PIACgkQpnwKsYAZ
9qwVXAv/VQPtAfete9ZwVUqjdiALVv6n6Cyy+AyTNyLsj56/83ibl5OIBJyr1qDb
e1QueLKEH6qyln+rC5vgejjq4AHk5aPhAx1IpJaaKJKh298c+IImIMxy+84m8xt5
x39u8Kwuz3oGQNshlTed3/qVUR/zzLzPhbFuvHKk3wXDcIJHjDBmBJ4CWyvmyNOh
OfOnXaqu4ohNJpwlCNsJvojjstdcpl6Uj7UM5BIdmw1JFuZClw0ljWLHDqC1YIma
2QbcJ7eY29E+uR6sJKbXuWLgVDE+RrhbBn/GVBATxP5giBLa2z7+gLSMwxcZjTmv
2gd5nhjBL0aIWrr7IIsgcW9I0P/PTazMGSSBsgupjXqA+/pEBL1ePFoK930F/Hdx
Bqh28jT5OYDoaIQHHDm3z6eZzqysdT2tc+uvBBa+g9NA/D6RzEw1qeRmNvvd4UeS
r8rENu7+nLibUE4JjQqDWKwF6FsZkwVH5xXZZ/VQoZHfFQep73ZnQGz3PcfKXGkl
5BMLh24Y
=FX+B
-----END PGP SIGNATURE-----
