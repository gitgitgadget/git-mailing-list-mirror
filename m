Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682C1C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0A361A51
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352905AbhJAJIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:08:55 -0400
Received: from mout.web.de ([212.227.17.11]:36951 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352896AbhJAJIu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633079222;
        bh=w6HjZ+K/jNEaIES22m+jNUdliTE6sA9zhOo9EhDfDSs=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=GJlL2Nfwdanb+DLWLZsWeQjhhuplTQp3SWlZ6vuGiL0RlpkZ+1ZqqadQHX7xtvig/
         ypmH4kEgxWbIFD0n9iuaqM5OPvXHeJGo7wHQSZLhKZ3RFT/Qn+byGg73Vzp5ri4Tdm
         2/S+uP+65yHubDU18jDTm2noSHIMCZwfCqQzBMMs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MgO8g-1m8WiO0Of8-00Nioc; Fri, 01 Oct 2021 11:07:02 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/9] mergesort: improve tests and performance
Message-ID: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Date:   Fri, 1 Oct 2021 11:07:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cpF4Z0QbSr55bVOI9rkHXazakXDv4cUZCejdAtacU4fw3k1RPc0
 YEoxubZBZsqBWfPwQYRSoKKX1txOPN94YDB9xevIX8/5hCZPoKdVhXSRrxG4Y47GHF9VuaN
 u+cGta9l2LpWOE5KPEmGG6/szBmxIRtGYCL7/jmQKr6TYHTaHK6lkoFNU9UwfCHERviJNe0
 nuctlkpEqULSM1W/Svyhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SdkUn+3jSEo=:gobrS5JisSOODgbJ2YB263
 EWaqj/8G/pNHtzTdgJ+YmCJ+FAwHt6q3U+ixyYk0wo8enH0g+y0KAbfm69HONDpyqcTTlirD0
 +fjhz4yk6kXK+B0vVkmyAW0tf17AW8AD7jQ/gc91Ty7fhZM+D9TxGL+dtyrK6pEZPCRxqgOyg
 VhNNvPaNLap+87sBYVAPBFFOSqVP7PrHQLGWmej4M/vj15r4MR/PPNZaJcTfa5tnhknF/2Lep
 KzZQECvzan+4TUvN/rNn2OKfAj2cSlbSsPnV476HPPhbuV+CwzeQdBSUl+iw31h/csBLNyzCo
 neyOdGyKzYMaHsFlXmoVzyA7vRSOkwgXuxtsc3SOvDzbjbqJoj1izdkLoaN6vLWpZNeNdMY9/
 nHI/keVXcE8L2vHcRkxcDOFiRRT96d5JZLEVZO9HX5GOYEaQnbcJq22AoWYgr0SH6UCaqFQmy
 po11mj7Y/8K7cYiMipTNG+BSL2tNfT5DNZZRVZPm/Jtr4M4VeDYQwlI99SHdg5ZE5Hd6rE4dc
 jJ7lhQaiIZ6Z4+Yq8i9UkkKqi021erUiu7T3YinVIfQ34Vm2VsGqEowPwx9zFVu5dkTc4m6rz
 AYDspppJe1oz+VW1QH8l/6+kAdfofWiIOF5+GYoPiYBRYxjJg5PWh1EkM8ClLMHHSeT2YwDY+
 D7sRcZhnLSrVolTv5QHFULbzcaOIrPHaZHy01WlNCHlvL7KzSnhUnEmjByGbQV5jEPvqNfSPH
 uGK2UJvMEc5wg22kvlrgqo1lL+PkIiyQx/k0kp33GGbNxcDPfh7zElgh6ffK/I02HrAzt8EF1
 4Q5v3h3qauzljeyvL67ioEaLcZ/UAjt4mijwOZrnfxrnckZVWVUu8uy4eNxneG3CSAQIYgkqS
 5Y6urL7iVqMJ+3xDCls8oQFmE2n6XuqP3Lu1csgWbEIEhMuXHWFcUG15YKvhBPom+bODGj2O5
 QTw80SxmKGc+D2kLy0SsLlI9OUKm1pTGDBQ5wI4QuoC1/2hDVmQtxQfnHn0qIGgA8VJO5/+ag
 9RQ988yzNiQHwikH/34QbcIJzzljyZHmw0Qe3pj0BFGvKUV1hAHJWqRHInXd/xxHew==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our mergesort for linked lists doesn't allocate temporary memory, which
is nice.  It is traversing the list multiple times from start to finish,
though.  This series teaches it to avoid that, which speeds it up
considerably.  But first it improves the associated test helper to
exercise the code harder and to make the effect of the changes visible
in terms of saved operations.

  test-mergesort: use strbuf_getline()
  test-mergesort: add sort subcommand
  test-mergesort: add test subcommand
  test-mergesort: add generate subcommand
  test-mergesort: add unriffle mode
  test-mergesort: add unriffle_skewed mode
  p0071: measure sorting of already sorted and reversed files
  p0071: test performance of llist_mergesort()
  mergesort: use ranks stack

 mergesort.c               | 121 +++++++------
 t/helper/test-mergesort.c | 360 +++++++++++++++++++++++++++++++++++++-
 t/perf/p0071-sort.sh      |  40 ++++-
 t/t0071-sort.sh           |  11 ++
 4 files changed, 465 insertions(+), 67 deletions(-)
 create mode 100755 t/t0071-sort.sh

=2D-
2.33.0
