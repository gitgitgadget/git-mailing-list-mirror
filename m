Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911221F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 21:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKLVlV (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 16:41:21 -0500
Received: from mout.web.de ([212.227.17.11]:43607 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfKLVlV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 16:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573594875;
        bh=QsRjCce8/tJHxQtWWDhQLGOHcM55mmQ0GvkvV07Upms=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Jq0+MOvwIMZ4idgw2gMFYDUq0s1OH5+PxkQlqmRrKR7rpgB2iI3epC/zSQBiWLH//
         Vomc16MCdY32BSyKE6Ddmx5QJ3TUq3BSJNSGyu1JLNZK1GbT1ndP8I38CVUQyc8twL
         9WYy7y9pQse6hyZV6D56y8fXJN7yDGGiCvP8byd0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfzxX-1i5kKu2iL5-00pbg1; Tue, 12
 Nov 2019 22:41:15 +0100
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: mingw: use COPY_ARRAY for copying array
Message-ID: <35123410-245b-0e3f-7227-94c293b57182@web.de>
Date:   Tue, 12 Nov 2019 22:41:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7VWwBwZ2gElQCHNKHQGtKuTiXSdcJEe5xitazCytwbettfQNM0m
 Z2WjtAGURQgxAAn64QhTkB6gBnsrXrb455U4JmlP5NIBDpxFVOJImXV08bMSlQjAEU7IxrD
 629r8Ni3+kbXhpJ8MjhJ7MFKUWknxeeO3F806o/flvuoLA7FU1bVl7Kymss0YXXbQbwKDkY
 EXN/i7G73Ho+cZAS0ZKsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rNBpOduHYx8=:ToUemNP/x11Z98tLqs194n
 FoX/+fN5G9AJqrhrauOWE389DowmErwRl3mk7OHa2rfsjDVLSkqNwT3z8YDupgZ99QRa43k1o
 Bxsb3iBk6a3rrGFyZVXsOl8Far8BLGIVdX8qeMNVl6COXHnSB1qc9NjuIuZSre8X4/2s9PMCA
 Ls7ZiFGGJGS9GJrN0oXD7IQn+m6Tkwg+idHzAFaPlNSLAfY60S7jjX28BUrOuqvuLufT9ztXY
 QGwwpe7tqUR9ZURzCZySauPn/BigC9WLKyEzirwwepljPWph1EcKBEbJ2zplPFnU20/rbPDvw
 XsC4HK4DEEHnoRU5gMYu17+wNV2yLVmBvECP5jrt0u8Q7WpUm2iF5dkUT6UtP+f6QFnjHy5MY
 jiKn0l3xpP9ZTiLpAVZ42PFvqfny+qIUjE12CcdKa632mIgjSeXLZtf32SPBh7T/K2LGMZNRx
 90VNfCZ0pWgNhrCILbpNECabIzUVp3ZrLDfBEqswvpat3mlnqNy4YCCgpS9KdoA6rErRSCcgL
 2n+yxfhyZxH+l1zLg7x0qLJzKVzifDBK0B1CpL3TDRA17blHmaK55n64YFXKHxYnuy8rwN0hD
 aIY+KEnmjKfeoWt3MgT+RejpaVQW7IeHEtEborU644qANsgy8aLOgSiSXjIVp8Z665WmoE1AI
 1KE3MjOW+22G+//5olZVVwPvfUl1s4rJyAqGkoYCN34XkEmhj4MLXFv2dQ7fbSMdAsxKD9YDz
 djr7UanijVTXR+7tYoPRa1d8fuemBLJaFs1fFCz8TcF0Fr+pMem8LSKsnr0LY4F4icrLj8A5s
 Fyrhgpbn7sLkRCf4iGnLv3cGDfWorPaT+gWDMpSKpwxFc7ubqQkeMIqXDiUnxjnBKeBl5w1Jq
 ceTMfSaeKVPA1N8wd2ExJGEDvknArWo+qeFgTASwaCmswqlig8LLd5QpZQ8n8zhbAT37OJeik
 E6rszTYfTjzJOaVES3VHIWO+XmocQDJJLeMXqieSWae6QBzLdQDyneWWniB5lKoE+31g0IJDm
 cObOhB15UBuMZXi7WvXLaj9v1f09kIJAvXYKt1/j8IJPn19jSQQtSb+iahEjYahv8YSd6+pep
 GA61tkHH9zTyemOuf3OtJOcJIaKgSx6SkeRX7S7b30mUfGyLEfPidjt5jaqKepiyfaNrfCW9V
 95L9ZRanXudl9siD51F8B3DM3y/+wf9iimBG8ZlHNKsr1Gc8ZyO/BqqbLMUHHx6AjqYnuBKXa
 vHmoh8GLWQoipPZQddZNBcisXTF2bduDArfbT9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the macro COPY_ARRAY to copy array elements.  The result is shorter
and safer, as it infers the element type automatically and does a (very)
basic type compatibility check for its first two arguments.

Coccinelle and contrib/coccinelle/array.cocci did not generate this
conversion due to the offset of 1 at both source and destination and
because the source is a const pointer; the semantic patch cautiously
handles only pure pointers and array references of the same type.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index fe609239dd..2f4654c968 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1566,7 +1566,7 @@ static int try_shell_exec(const char *cmd, char *con=
st *argv)
 		while (argv[argc]) argc++;
 		ALLOC_ARRAY(argv2, argc + 1);
 		argv2[0] =3D (char *)cmd;	/* full path to the script file */
-		memcpy(&argv2[1], &argv[1], sizeof(*argv) * argc);
+		COPY_ARRAY(&argv2[1], &argv[1], argc);
 		exec_id =3D trace2_exec(prog, argv2);
 		pid =3D mingw_spawnv(prog, argv2, 1);
 		if (pid >=3D 0) {
=2D-
2.24.0

