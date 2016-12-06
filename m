Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD3D1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 23:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbcLFXUl (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 18:20:41 -0500
Received: from mout.gmx.net ([212.227.15.19]:50053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbcLFXUj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 18:20:39 -0500
Received: from [192.168.178.43] ([188.108.240.182]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWk3f-1cBMlT3F9f-00XvYY; Wed, 07
 Dec 2016 00:20:36 +0100
Subject: Re: [PATCH v15 23/27] bisect--helper: `bisect_replay` shell function
 in C
To:     Pranit Bauva <pranit.bauva@gmail.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1b29-65f79716-42c6-4327-acda-8c8d0fe05471-000000@eu-west-1.amazonses.com>
 <1816d5b4-a4c1-7c97-09ff-b11001501423@gmx.net>
 <CAFZEwPNmB7rYvUTPy6dvfqfbUsjDeEcteLBBH5Wk-G_suE+YTw@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <9da43af2-bd34-5cb6-66d5-01db6f27cdde@gmx.net>
Date:   Wed, 7 Dec 2016 00:20:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <CAFZEwPNmB7rYvUTPy6dvfqfbUsjDeEcteLBBH5Wk-G_suE+YTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:7dLEul49QZDulyz58w3IlfxrkkmPd8VH3fHvuYh09YmaEI/Llph
 R6KZ4v2AXQoRHhOfFmnZL6Wdo3EWr8IC4s66YUmgxMLVvEA8xQvtIap+3mOBRIqdHuUIuBk
 scyouoJjD+yqIVSblh0M15JBbURhzVmbf7kYh+t2/NKQ1woXXqumGdVItXUhVVpUd9vqnjq
 t0dUI+YAsbSdT2WnnelRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iv8uvG00FNQ=:u6ffuy56ZjEMcicn9GLShZ
 l3qI8ZJqsEri9C0rqimmxepXUiMcy4vNJ87uf4o2kgAsDh577iTAl3vbbiTFr3xo45+wmP2tw
 Nx5BFI/4ukufKKL5wmitr1i+Z7uelg3ULpcusLo4c1bbLDW6W/ujf423UGuI+lMgA5a1Uxloj
 EJQ3QkMSuf+gLV6rD1D8NkVBBMOdlmTOO2y6ETH83qgdUJf83BzPXMbYLHU52lPA8KTWKVet5
 KFt5+QpOqg1sFxALNNCShjUAIEn1m/pkMD1OYWHFlORsPt14ebZLUXHuo/9luhMk8KW0yCnU0
 7k83Xys8d7i/IBuhd5m5LytoawdThAXdtvpFQNn5Jh3tCygtrjuSbIG3+apuhL++TEYMOe/T4
 HFwKYO7ZRt9wo/5/XEmmJPxgaXbjDgpQypM2E/2pQyRf5U+gwZy6bRCrXhAz4mIeJWE/e9trg
 dCO5KUwyiaujqfXR2w1AXW1N3PkyqdLBgFpGJgj30R1QPHa3JtTFxeYgKAHFKhPqWVHxN94jE
 UA1HfBgcBywb0zLzqboX/lenvibJ2hS5gq/7LN0EAg5529cLp12gcT8RAjOnENWWVfYKqbdCt
 I1rqb7h/G0Jd8PLXy70JBFs7xecKIXK/vbWvXzzIRW6KqYueaiTpOAwQG39tPlbDA6cTWUnIJ
 3pyksHN/p+JUvbv+RjCeBZVLF0TKRiXcQHZym9mEecvY79WYdZGdAfh+YwhtD+pt/rbwQZUf5
 BxdCB4Dl1m8wiBA0QbP1NSWHUW/ZEfxvKXLYKRCUClY662vehIrnrtpgsr3fO8jeEkQDbbvHW
 x+AX7NF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Pranit,

On 12/07/2016 12:02 AM, Pranit Bauva wrote:
>>> +static int bisect_replay(struct bisect_terms *terms, const char *filename)
>>> +{
>>> +     struct strbuf line = STRBUF_INIT;
>>> +     struct strbuf word = STRBUF_INIT;
>>> +     FILE *fp = NULL;
>>
>> (The initialization is not necessary here.)
> 
> Um. I think it is. Otherwise if it goes to the finish block before you
> try to operate on fp, it will cause a seg fault.

You are right, thanks!

>>> +     while (strbuf_getline(&line, fp) != EOF) {
>>> +             int pos = 0;
>>> +             while (pos < line.len) {
>>> +                     pos = get_next_word(line.buf, pos, &word);
>>> +
>>> +                     if (!strcmp(word.buf, "git")) {
>>> +                             continue;
>>> +                     } else if (!strcmp(word.buf, "git-bisect")) {
>>> +                             continue;
>>> +                     } else if (!strcmp(word.buf, "bisect")) {
>>> +                             continue;
>>> +                     } else if (!strcmp(word.buf, "#")) {
>>> +                             break;
>>
>> Maybe it is more robust to check whether word.buf begins with #
> 
> Assuming that you meant "# ", yes.

No, if I get it right "# " can never occur because the word.buf never
contains a space.
What I meant was that you are currently ignoring everything after a
"# ", so comments like

# foo

are ignored.
However, imagine a user changes the file by hand (he probably should not
do it but, hey, it's git: unixy, hacky ... and he thinks he knows what
he does) and then we have in the file something like

#foo

which makes perfectly sense when you are used to programming languages
with # as comment-till-eol marker. The problem is that your current code
does expect "#" as a single word and would hence not recognize #foo as a
comment.

I hope I made it clear why I suggested to test if the word *begins* with
"#" (not "# ").

~Stephan
