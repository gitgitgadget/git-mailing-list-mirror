Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BFFC7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 06:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDLG0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDLG0l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 02:26:41 -0400
Received: from cressida.uberspace.de (cressida.uberspace.de [185.26.156.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B072DAC
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 23:26:35 -0700 (PDT)
Received: (qmail 17533 invoked by uid 989); 12 Apr 2023 06:26:33 -0000
Authentication-Results: cressida.uberspace.de;
        auth=pass (plain)
From:   Matthias Beyer <mail@beyermatthias.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug with git-config includeIf
Date:   Wed, 12 Apr 2023 08:26:29 +0200
Message-ID: <3613557.iIbC2pHGDl@takeshi>
In-Reply-To: <xmqqr0sq9x0f.fsf@gitster.g>
References: <3352350.44csPzL39Z@takeshi> <xmqqr0sq9x0f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9213427.CDJkKcVGEf"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Rspamd-Bar: ---
X-Rspamd-Report: MIME_GOOD(-0.2) SIGNED_PGP(-2) MID_RHS_NOT_FQDN(0.5) BAYES_HAM(-2.113253)
X-Rspamd-Score: -3.813253
Received: from unknown (HELO unkown) (::1)
        by cressida.uberspace.de (Haraka/3.0.1) with ESMTPSA; Wed, 12 Apr 2023 08:26:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=beyermatthias.de; s=uberspace;
        h=from;
        bh=QtXtoi5gEbueV9mqN9MXb6Y27eMcusekEMOKDAjjxMs=;
        b=SToffoHbxV5IIL817aot+2OLuyCLPwF1bi0zt2B+4WUUyI1ggZSPlOXT+qxGfV6wWDugVEaec6
        z93BuS097F3gkBkGme/WoIbB3E7JCulex/PUPFcFO0UTsK84o869SGv9aP9FkqQ41Cdy9v2S5Zd4
        LB6yB1Qkgl/HA8xsEUcy3BuWhaJmp2Qc2eVLNZ1M50kDpSfUisDnYD7S0sHWVZgMSLDhfuc73WX3
        cN7F38M/8e3s9kKTQ38/HmFhOCTOXLWd7GHzHP9Y2WVfOMCGbXma6Oukv3VCwS0H36v5LR30iHEE
        EOAK7+T7ovKPgaNGtwpvqf+OYWQk4kylq8fe7vsUoCLvcojrohdtDUaDRk0f3dk/TsZFHYBOyc2e
        b5eheePR+cCL9E6wrA0EIIUNx97rnVI2wehFa2ed7HscHQ5K1RoM8tf501kE1+98Do4r2pMIgG8/
        IrDLoHO6yC0z5IrIhyqZsqlcq9H7wahgO8wjKgG1glSDpJW+uUk0qmtrcMUhTYYJ+nt4+Fye/FPm
        NWAm3Y56TBGhWW7IMeKyodix2OKlHu6vjhoZVNNDJ2fVqssR/BYbKteUZbpf8ySmSjpD0GecssGB
        AftbkzxTTj4bIHw5nZeGKEAXP6kqzqKcUe1kkqRK7OAm+sQduQARa+W9Z4yCKspmGlFPiDwoXbik
        s=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart9213427.CDJkKcVGEf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Matthias Beyer <mail@beyermatthias.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Bug with git-config includeIf
Date: Wed, 12 Apr 2023 08:26:29 +0200
Message-ID: <3613557.iIbC2pHGDl@takeshi>
In-Reply-To: <xmqqr0sq9x0f.fsf@gitster.g>
References: <3352350.44csPzL39Z@takeshi> <xmqqr0sq9x0f.fsf@gitster.g>
MIME-Version: 1.0

Hi,

thanks for your reply.

I found the issue. As always, one nastly little detail: ~/dev is actually a 
symlink on my system(s) to ~/archive/development/

git rev-parse --git-dir of course resolves that symlink and thus ~/dev/work/ 
does not actually match ~/archive/development/

Using that path in the includeIf produces the expected results. 

Thanks for your patience.
Matthias

Am Dienstag, 11. April 2023, 18:58:08 CEST schrieb Junio C Hamano:
> Matthias Beyer <mail@beyermatthias.de> writes:
> > [includeIf "gitdir:~/dev/work/"]
> > 
> >     path = ~/config/git/gitconfig_work
> > 
> > ```
> > 
> > That means, from my understanding, that all git repositories in ~/dev/work
> > should now have the work-related email address set.
> > 
> > If I go to ~/dev/work/somerepo and `git config --get user.email` it indeed
> > shows the expected email address.
> 
> The pattern given to "gitdir:" ends with "/" and implicitly "**" is
> added after it.  If "~/dev/work/somerepo" is a repository, going
> there and "git rev-parse --git-dir" would say ".git" or
> "~/dev/work/somerepo/.git", then the includeIf should trigger.
> 
> > But if I go to a subdirectory in that repository, the very same command
> > shows the private email address, and commits get written with that
> > private email address.
> 
> I use exactly the same configuration (not for working on this
> project, though), and your symptom does not reproduce for me, which
> puzzles me.  I go to an equivelent of your ~/dev/work/somerepo/subdir
> and "git rev-parse --git-dir" would still report an equivalent of
> your "~/dev/work/somerepo/.git", and my "git config --show-origin user.name"
> does point at the value of "includeIf.gitdir:~/dev/work/.path".
> 
> I wonder what the difference of the set-up is.
> 
> My ~/dev/work/somerepo/.git equivalent is a directory.  Perhas yours
> is not?  That should not cause any difference and it is merely a
> guess in the dark.

--nextPart9213427.CDJkKcVGEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEUJGUus1GMTrRclzcEKWX9Kitz80FAmQ2TxUACgkQEKWX9Kit
z83eGxAArTFr/mfDC9MksKQq6+9agb58qeIVjdUCw3+JXLRNnc8k/01YFBAfBdrb
JG6mai8kFNg08TwYr7gcx8Mmdvs9akoqq1AiblXUSnSul2nAJp9YE8afw0yHKA+j
+RsCgtWS+ljYydwoHjeI/RdBTQX7TAykWxEwCMAyjj92/T858A/eg8Bm3Uou8s4i
FodRT3Rh2ijjezHpqJzZ0r+f0CIqX7mE7bSN/e11VW9K8gfDIR6TvIPVZmoMxY4G
MfKsoa3NXPEKFAB85n1WMuZZkUH20a1VLm2jHwlKVhg+TuUjyjie7NAdMzYmBfPs
Hoe4pljzS3XrHgFlyIq2sgs3s+PqB7fZq9ROoreD2UMmcde2Kwk9MuakN1OwQJUC
IIftgbih8KVb8v8SJnIqii6ZAj78t+SSVdqSe8VJE49DjRWqWhmwOpzp7bK+EU2H
EA1jbJgjCYT4lIdTbgxaOOhTOC4heYIHxaYboT/FbLNFNH9BEO9zWokJ6DQBIimd
OYdZhzpRNNU437Inn/D8yVDu7gjWx7Fi+GKwxEChYWXrhw6KGAkZhmEo+eq1mgMc
54eCTzgE7UYoW3YoZBIG8NLH7RqplFLRNRWhcvNpyz83Xfqn2FHYAca7wYOV0Y8N
419BVUmH+rVaXgmnbu2iScqsUhYbeb3ELHM5UG/fop8LCePnOu4=
=pVZR
-----END PGP SIGNATURE-----

--nextPart9213427.CDJkKcVGEf--



