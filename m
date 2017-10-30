Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ED481FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 16:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932486AbdJ3Qv4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 12:51:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:63133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932291AbdJ3Qvz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 12:51:55 -0400
Received: from [192.168.178.43] ([92.76.242.15]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZ8fw-1dsdqH1Jng-00L0sY; Mon, 30
 Oct 2017 17:51:53 +0100
Subject: Re: [PATCH v16 Part II 7/8] bisect--helper: `bisect_start` shell
 function partially in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee2f5-3d106a61-7f79-4973-851f-f55a691a6189-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <c26e1cab-a3d0-8cae-b18b-eaa02ce1240c@gmx.net>
Date:   Mon, 30 Oct 2017 17:51:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0102015f5e5ee2f5-3d106a61-7f79-4973-851f-f55a691a6189-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Z8KO93RhIx5fY1CCsdszJ+ubl542nKL6Jmrzsn02VIVYZHyzwKe
 9WPgTNHb54hQEJ0DWt1KqKpmqol7rSR8l9z7xBVM2adHShZ/srx4BuKNNeevPwQhGIlitzw
 p3YKuf9D3wYpSt0mbwmGrMlePv1mxyichPX2c5UMvWKEqZIJfs5dxiFI4JG1qsc0i1pQpzN
 uvCqDaRcGPX+PucLpNxIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iEvsVPGusjs=:3MKdhCpWutKZkjrH88smCx
 1kpOYiBYiRZGdVMc1w76BrwVhh5hEaLgZspk1Z6Aomf+hf8+c36QDgyhMlx50WbFj+SawTG5i
 mNrG5R03CR/sQwyQgqlWRFx9XYvs2c3AaIx+RPxk6E9mA0ySbj0QmMC3SxutgZHNwczw/uRgd
 QlewgPm6F16jxYenIGpKGTXZrB7SBtzTTBskKzJnVLhTWunrZRct38jwsn7uXeBXdCpephF1Y
 kzV+HCZIyzT2/jzfSz0zyepx0wJz/dQFQQZfXEO/v2ZHa0cUYAGCqw6YDlVpZDlrfmniV+5Yg
 jYxAcodR82Ls/2Og44BCnjvOsGhBXuyagxfdEX5XGqULWz1Wn/uQK4c8FErHofhuSYjIer6qB
 wCjGvCg+vQi/7MvdbyfT/F5ufJxHcSeJgCbM6i8Rw23u6S9+ofq02tBmuYDfAONc2vlG2qXRu
 UMoqzqQuCRE9k1wh/YB+5vmwgqqw1aGa0yTVgQQMeILMw10r3j36t1LocZuaCZiS2cZ4JRLsN
 yCNpU+p60k/8kyqZGOrz5kC8dpMkiKiFucdyI502CAsMOJCzxySC2JeNp/Ui0YeLEvsueslV1
 Jndn6NXbv5ofUTJPIgLPnYkDnoTtX8F+KI4iIwEiOAiRvIZpYxQADPN9qsCyGxIbKPtjAgg8C
 biY49BdqoZxVQ/86Hub0RwIQU1a5aa6H0FLs2WxOyVWaKl/UMn1xSbG1mQTxiDJffk3IlnPpY
 szQf+sf+rLgLlYRIIuFnvlBFEC38XzVewUXpB4F1lDz33dwnADBAn23w6PqGA+jW6GDYm62ma
 8/JtYjSuEfKzrHfzuVMl98Ld+emCjD6Ue1guy87kXsitmb4Xpw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

> +			return error(_("unrecognised option: '%s'"), arg);

Please write "unrecogni_z_ed".

Since the string for translation changed from
	"unrecognised option: '$arg'"
to
	"unrecognised option: '%s'"
anyway, it does not result in further work for the translators to
correct it to
	"unrecognized option: '%s'"

Stephan
