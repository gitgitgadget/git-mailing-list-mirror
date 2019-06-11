Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4982C1F462
	for <e@80x24.org>; Tue, 11 Jun 2019 15:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404352AbfFKPJq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 11:09:46 -0400
Received: from mx.mylinuxtime.de ([195.201.174.144]:53800 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404326AbfFKPJq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 11:09:46 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 11:09:44 EDT
Received: from leda (unknown [IPv6:2001:470:99c1:714:e078:5e8f:bc9c:af22])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id B276C149B69;
        Tue, 11 Jun 2019 17:04:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de B276C149B69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1560265448; bh=Dy7aS7t1lu9yl7tu8WTIHql+efBKvjdoD5OV52bH1aA=;
        h=Date:From:To:Cc:Subject;
        b=Y1B2jEBuVG3kKyR50PG8RW8GGAhsLMWMBa3K/rngdtYlNTCpZRq+q2Lk6Y/3RRZax
         MelHN9dx0De7OKddKxDnNWrtxJozxG5WKHZeb0S8scmm2HAT0dLatmPywAPjp0UXB2
         yJkeMHdluj/cDYgdNAT7PMH0oOkfsrQRCZ5TS+qs=
Date:   Tue, 11 Jun 2019 17:04:01 +0200
From:   Christian Hesse <mail@eworm.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: cgit and global configuration
Message-ID: <20190611170401.15d43623@leda>
X-Mailer: Claws Mail 3.17.3git183 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vw7hqCFLj/daaVn21ZMVdgV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=mail@eworm.de
X-Rspamd-Server: mx
X-Stat-Signature: my6pfe3uojjdtdb3gifra6dtedt4a3qe
X-Rspamd-Queue-Id: B276C149B69
X-Spamd-Result: default: False [-4.55 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         TO_DN_ALL(0.00)[];
         NEURAL_HAM(-2.85)[-0.949,0];
         SIGNED_PGP(-2.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         ASN(0.00)[asn:6939, ipnet:2001:470::/32, country:US];
         RCVD_TLS_ALL(0.00)[]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/Vw7hqCFLj/daaVn21ZMVdgV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Jeff, dear Junio,

for cgit we use the static git library built into the executable. This used
to work well, but breaks with latest release v2.22.0: Our code unsets HOME
and XDG_CONFIG_HOME to mitigate loading arbitrary configuration.
We have tests that use strace to check for access to directories given by
environment variables.

With the new trace2 code in place at least tracing configuration is loaded
before cmd_main() kicks in. This happens in trace2_initialize_fl() ->
tr2_sysenv_load() -> read_very_early_config(). The offending commit is
bce9db6d ("trace2: use system/global config for default trace2 settings") [=
0].

I had thought about adding a new option to struct config_options and making
xdg_config_home() and expand_user_path() conditional in
do_git_config_sequence() when called from read_very_early_config(). However
this breaks the test suite as ptrace2 tests with global configuration depend
on HOME being set to a trash directory. Any hint about how to properly solve
this?
Or can we be sure configuration read at this point can not do any harm and
updating out tests is sufficient? I guess no as file paths can be specified.

[0] https://github.com/git/git/commit/bce9db6de97c95882a7c46836bb6cc90acf0f=
ef0
--=20
Best regards,
Christian Hesse

--Sig_/Vw7hqCFLj/daaVn21ZMVdgV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvYTecfST32gUsBZyVO3JFgm8kYMFAlz/wuIACgkQVO3JFgm8
kYP1/A//Z3ycl3IcqZnygQGGeSo/yjSBY7ziXf2sTu3phdhhfXzDXnGEaLlS70tZ
F5yrQYNLPXNC1lzhsHOX3NCZdIzerbHLVllU/ltstN1vT8O/itWUyCKsSVzjEStY
Uchpf8IBjYMsmaqHtlTBmuicQ5JQjCTxXYaU5F7tWQGsJ8EfJ7G8N6bvJcwDB0xs
HjMYjOwehxKN/RiS2+RUnelP+4OucL59cADOZUYShcAzdTVlIsnOipHKYSozL7uh
y6BWsgt+wovSvM4xuTf/ZR4yMhBYBlPZLXhKPywul2EHl1t/yoHDmcsSDNoJxXVR
3/zcW2CDSpV/d+acizeOH6xxWNqrXK/TZBBooMGSU4O7tl01aufntH2WG07bYEqj
7eAI2jIqTVB4mr1dSVJ40WFaS3bBGK+whNBT1EOy+T0lRnq4oW+OVQu5Fn68zDdH
Ksgdzle+r+NVXFMjvnFvNMq5Z3AL6ZHnAmY+UcJzi7Ipk3F/GfhItdUrg/91Dlcp
O6PDgBINNRsGO3ygfGX/KXzR2DGPSDB7BHbKsoFjNI+ZrNss2vqaEBUvCevyfePF
WmdyVHAtG8OB8jX5nFMU26eBa3wmUZvQ0YjpibixqCg5AX7N0ikyTK3FiWBnK+/Q
zbc6FR2ItYp2JwbQb+9A3xMw24XYmRJ2sSJDKmT38bcNhHpP2i8=
=umii
-----END PGP SIGNATURE-----

--Sig_/Vw7hqCFLj/daaVn21ZMVdgV--
