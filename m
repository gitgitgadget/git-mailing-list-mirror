Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7FCC0015E
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 14:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjHEOdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHEOdP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 10:33:15 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D204F10DC
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691245988; x=1691850788; i=l.s.r@web.de;
 bh=7rDE2yRaIzQ0+43GeeFqVY725w3zZi2Ig+p3cYffsOk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=UiHVhJnIV5Vxbzls21NcvrrQtHXYFbg92ULmapugqa1GhBtTKxf47V2KyX/DnO3UsQggmjf
 QY/9XF+xi/kQuCX82wy9AF2qqzrR0zuUiOyLr3pUM9aGFBWDLSOAUK0pAJ5h7Pn7xIYhiEFLT
 glYjkWnUkVMqtzU75GYm5jibJZoShH61X1cuqXOL+Ya1bIZDkN5zvQ5kMLxxzSXkfbATSp+C/
 WMWcrfNgyp3UeSDaMgqCsWTUS6dIufyNu9VgkW25NPQSjUeBDDpUeJ80Bx9Ywj/DOvIMqZF1O
 9FOkQCH47R39ygkn+ZRqQ0AxGXpNAGrH3H2NyO11PAPs2UITftng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVJRb-1qI5Ct111j-00S6gp; Sat, 05
 Aug 2023 16:33:08 +0200
Message-ID: <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>
Date:   Sat, 5 Aug 2023 16:33:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: [PATCH v3 0/8] show negatability of options in short help
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq4jlxuiuu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3i+rJjIcv+UeWTmd3LG47qO1/f7jsauhWIX50+s2W5PYc7iRgmF
 ngd4sS5S1jcWigYawEmNq/qqwdY4dWaFfJHhwcP8uh0042459BPR5X37cd1ObIZxXcvvAzH
 +5VVUOTDF5yI8NI4y+DJBqngICEcpIQi2+Oo7bLNYilmh2K/CGLn5ZzkFdTQ21vUfJEGjrn
 j8s4FeJAC3K6N7dJWTYXg==
UI-OutboundReport: notjunk:1;M01:P0:h5DOzpmfaHc=;DL793A2qFeDSTOa4POJkE70XxaW
 OQlx8dZCLFulDrq3KCZwzqygO2N1wS31Z42MWPWh9DCop7LPd9+d5ZE4M4HEWbaKOf5fL5eeS
 ZRUL+dfU3tn82cSeKkDBkqVBIrRgJhfL9X9aZqhpC745CecH1mUgblCnLAjc0xiJU0RbkWmGL
 q7MwYuxC4Rd1/h/KMuhUVB4ka9bWI9w5iW+bf5eRfspg4NxTrdNSdiEA54EOEtAxnErKejyHQ
 T+y2b/7HO18ASIbIAXUhzzqNhFDDVkypOQW3ZNSDVQupyt2dQDxO/bv99y5MRJJfUPqFikHHz
 Wde2Bn0b6SEEa9HbfKQIb+0eDMsICFY887wpcbi496ZfQc5SvgpDHHSO7lenAkHqQBn9y50bj
 YIIqqN20rgrDUooSCN/MHA5zFCPnz59TFrpDXdLvELOheWTQjYwCxWbxH1Ifd0zzGy+8fpncM
 vB5DsZuifZcuvsQWHTROUV0qdJHPgl/JktMhQKO8V6UtjVuRxNiC9DdAk5rUP9FfYBgAYLxWK
 yz8p0DmRqE3v67ZSggLcJkmqyOJu1ZRFFhWw1VEnKnYsL5u4GYLJt5h0UzZL3BTL8SK1xYXTW
 v4E+ePESAps1IBaXLWSGRApj6EXOyEy7LAEfw+q11icV3j6Xg/ZwZjdrsFrx9urvcaVpvzAoo
 m/m8Vcfmzydxw4v1zZYBnKWGV0XRxyUzQaf5hou5NIrQEeT8WVUZqDoB85nsx0evxDJwFgZ38
 piPX7kZ//5oLd712fuojYqplezX1RdVXHAJqVH7B7YFRDLIMARtZluYkMgSYBfwUL+QpSbsN1
 BmxtMWa25WfE+W0UtI78FlDGreloZYQQZMnbQwDAnTB3FTjEYSe+kIYbFgrhNTKNVr0CKaIZ+
 61f4IpRaMox5BZk5S8mYFhB+RFFKLEEUuMyWWW23UTSxKo9uXAOLkD6OSwgYvLtPSPjrYIkPa
 z/fY8JhRkhDj2XF4n8IsDIvsuRY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:
- Rebase, affects only patch 5.
- Add patch 7 for documenting negative options on their own line.
- Add preparatory patch 6.
- Add bonus patch 8.

  subtree: disallow --no-{help,quiet,debug,branch,message}
  t1502, docs: disallow --no-help
  t1502: move optionspec help output to a file
  t1502: test option negation
  parse-options: show negatability of options in short help
  parse-options: factor out usage_indent() and usage_padding()
  parse-options: no --[no-]no-...
  parse-options: simplify usage_padding()

 Documentation/git-rev-parse.txt    |  10 +--
 contrib/subtree/git-subtree.sh     |  10 +--
 contrib/subtree/t/t7900-subtree.sh |   2 +-
 parse-options.c                    |  70 ++++++++++-----
 t/t0040-parse-options.sh           |  44 +++++-----
 t/t1502-rev-parse-parseopt.sh      | 131 ++++++++++++-----------------
 t/t1502/.gitattributes             |   1 +
 t/t1502/optionspec-neg             |   8 ++
 t/t1502/optionspec-neg.help        |  12 +++
 t/t1502/optionspec.help            |  36 ++++++++
 10 files changed, 199 insertions(+), 125 deletions(-)
 create mode 100644 t/t1502/.gitattributes
 create mode 100644 t/t1502/optionspec-neg
 create mode 100644 t/t1502/optionspec-neg.help
 create mode 100755 t/t1502/optionspec.help

Range-Diff gegen v2:
1:  26c03bd70c =3D 1:  ee280b3484 subtree: disallow --no-{help,quiet,debug=
,branch,message}
2:  ad9e7d1393 =3D 2:  556e79ce55 t1502, docs: disallow --no-help
3:  1bb68a4a40 =3D 3:  274e65ec1c t1502: move optionspec help output to a =
file
4:  47ab167d1c =3D 4:  89b0455305 t1502: test option negation
5:  961c5dfcf7 ! 5:  7cd3abcff7 parse-options: show negatability of option=
s in short help
    @@ t/t0040-parse-options.sh: usage: test-tool parse-options <options>
     +                          set file to <file>

      String options
    --    -s, --string <string>
    -+    -s, --[no-]string <string>
    -                           get a string
    +-    -s, --string <string> get a string
     -    --string2 <str>       get another string
     -    --st <st>             get another string (pervert ordering)
    ++    -s, --[no-]string <string>
    ++                          get a string
     +    --[no-]string2 <str>  get another string
     +    --[no-]st <st>        get another string (pervert ordering)
          -o <str>              get another string
    +     --longhelp            help text of this entry
    +                           spans multiple lines
     -    --list <str>          add str to list
     +    --[no-]list <str>     add str to list

    @@ t/t1502/optionspec.help: usage: some-command [options] <args>...
      An option group Header
          -C[...]               option C with an optional argument
     -    -d, --data[=3D...]      short and long option with an optional a=
rgument
    -+    -d, --[no-]data[=3D...]
    -+                          short and long option with an optional arg=
ument
    ++    -d, --[no-]data[=3D...] short and long option with an optional a=
rgument

      Argument hints
          -B <arg>              short option required argument
    @@ t/t1502/optionspec.help: usage: some-command [options] <args>...
     +    --[no-]pair <key=3Dvalue>
     +                          with an equals sign in the hint
     +    --[no-]aswitch        help te=3Dt contains? fl*g characters!`
    -+    --[no-]bswitch <hint>
    -+                          hint has trailing tab character
    ++    --[no-]bswitch <hint> hint has trailing tab character
     +    --[no-]cswitch        switch has trailing tab character
    -+    --[no-]short-hint <a>
    -+                          with a one symbol hint
    ++    --[no-]short-hint <a> with a one symbol hint

      Extras
     -    --extra1              line above used to cause a segfault but no=
 longer does
-:  ---------- > 6:  46dcdb902d parse-options: factor out usage_indent() a=
nd usage_padding()
-:  ---------- > 7:  fdeca0d6d2 parse-options: no --[no-]no-...
-:  ---------- > 8:  08b2d1e861 parse-options: simplify usage_padding()
=2D-
2.41.0
