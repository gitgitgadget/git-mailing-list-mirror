Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96BED208B8
	for <e@80x24.org>; Fri, 11 Aug 2017 08:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbdHKIxX (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 04:53:23 -0400
Received: from mout.web.de ([212.227.15.14]:53085 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbdHKIxS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 04:53:18 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MORtt-1dj6Uk1Iv7-005rIL; Fri, 11
 Aug 2017 10:52:55 +0200
Subject: Re: [PATCH] strbuf: clear errno before calling getdelim(3)
To:     Simon Ruderich <simon@ruderich.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Yaroslav Halchenko <yoh@onerussian.com>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
 <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
 <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
 <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
 <cd49ce13-db87-89c1-77e7-998fdb9442c3@web.de>
 <20170811075059.nn6lru7uy6s6vpza@ruderich.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e8e7f028-6e23-368c-484f-9f069bae5dc8@web.de>
Date:   Fri, 11 Aug 2017 10:52:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170811075059.nn6lru7uy6s6vpza@ruderich.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:qYr0DheDiWoNwOtXfpDJtSr7mKgLt8MLAao9d5FQnI+9miq7AuY
 LDnfgZw4pIMM8ZAMTr2MMiAZWU7Zz/aQjL8idhNiDYIXueRUY2hHmkFHCNduwtI5bY4hAZS
 BCwyLejgfUuA9qZCJIHbQ+7LADWK22OJPY+xxuWS/CzH0XDl9KmCVKcRiYKRYlWwm3T372b
 IBnrLWRSry2ugLTqv7z5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QzMpPWdm3WE=:+0JS6TlCtCuopfNfk/3MAJ
 cASgn9BFPWCFE1/oH2STilH+MmCztc+w76Za2z7Nn1mFolNrCo7HhMS04nlGgyJv6OnmIXoiR
 Rxm6SdcYfJx39vN38uIZTfn5n6tbYsvDch1mLWdfZaxXBpNVWU+z3i4nvGc+L0SB/0GwkRFQc
 VXh12zDQdkp45jUsFeBsazKzMGd/142HbvnGjqcxvn8NtCbVzuep5rjSJlQWSkhULe3vjR0eM
 8/QRMYhEN5sl1kuF2Yx4HP4vZzBwr0NKms0J6EBHwHX+TjySgMtfB+STbR2MsTEtAHJkP9YzO
 Zf3sfgGW0O4p3b8JYOw/j/vLWfmIRfwf/RvvUMTUjNZ/ScWIZpCe0GIaCKLJhIKyi9uqLO3lg
 +cr+NtbfYbzNYGoI1vXFCrcHJgfby1/wbab9LdSPPSWPU6kFOUuHjBEGChJSS9D03iZQjVu0o
 Jqeg0mtfefgI4/en2V9DNaeJcTu4fE8dE8Z4Ssx2Z/s0BpTF4BFXOpJO/gZjYuT2wiAhCF5jU
 8sOVuzrDOnFYQ7a4YV287FJTlLazUmO5NrLdVMl36SdzaAFBGVAfd/QFq8Utq/YDdNJCwB6Qw
 34KYRicl2hFmtwdjZCIpJ5kpG29mtUamyOX0LT19OkeCn+5ha17jQu5R5m5JFxwja0v9czxoR
 53rAf7dVZNcLdl6eylyO6qLLJzHOeNfY60FMbbNxnIolwLuQg0EsZGBgvgYGzzfuj9lw0fXHw
 MsEzzhup9NC811bTYBIUea8osAkQa/1PftindFn6quxr/m0r/Tt+OAr7MPkMAUSdhL9RKueg9
 k+akKE202t2C3SJj9p+SuVg5x2o62x87HTdjqcdY2rJpjOYJik=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.2017 um 09:50 schrieb Simon Ruderich:
> On Thu, Aug 10, 2017 at 10:56:40PM +0200, René Scharfe wrote:
>> getdelim(3) returns -1 at the end of the file and if it encounters an
>> error, but sets errno only in the latter case.  Set errno to zero before
>> calling it to avoid misdiagnosing an out-of-memory condition due to a
>> left-over value from some other function call.
> 
> getdelim(3p) doesn't explicitly forbid changing the errno on EOF:
> 
>      If no characters were read, and the end-of-file indicator for
>      the stream is set, or if the stream is at end-of-file, the
>      end-of-file indicator for the stream shall be set and the
>      function shall return −1. If an error occurs, the error
>      indicator for the stream shall be set, and the function shall
>      return −1 and set errno to indicate the error.
> 
> So a valid implementation could still set errno on EOF and also
> on another error (where it's required to set errno).

True, especially the part that other errors are possible.  But we can't
rely on errno being set on EOF because leaving it unchanged is allowed
as well in that
 case.

> I don't think that it matters in practice, but the "most" correct
> way to handle this would be to check if feof(3) is true to check
> for the non-errno case.

Only if errors at EOF are guaranteed to be impossible.  Imagine
getdelim being able to read to the end and then failing to get memory
for the final NUL.  Other scenarios may be possible.

René
