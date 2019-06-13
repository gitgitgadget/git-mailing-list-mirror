Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5680F1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 22:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfFMWkW (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 18:40:22 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:44783 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfFMWkV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 18:40:21 -0400
Received: by mail-io1-f45.google.com with SMTP id s7so1461410iob.11
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IElDEUXT7xwibCnRgx8is5oyJjrgAfVD8aSAaUqEVBs=;
        b=WOjNr/hYGRWgRA8FR/NRySzEk5dw6xcU8cPU28DFy85v+rUhF8KFYf5FjkFGa8VPrv
         CoCXzhGlfwxnJrxd9YF5UQTh2lUp1gdZj011g3LSv7EDtuUZnIj57IWpgI/LGl84pBi5
         70XgvxHr8abzZXxK5u7h6Z9GCgdSQH4T9GjJwS8Rrb9kzdBHlok6qPZzZZQwPG6Lfh/C
         XRs7LDYNMZNnRH3f0lFD0hseK10ngGdmA2ZUoig0JM9D9cHONnSs1jDlRYfriIwY/OM5
         9nPKo97oIlLmQsmTqBZTRI9Ntd+4M2awVww0hU4X6Z129iarXMILe2svgIxYAH+1KSad
         8LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IElDEUXT7xwibCnRgx8is5oyJjrgAfVD8aSAaUqEVBs=;
        b=ieD4QoVmvmJgDeACS7CtQXTRFqkGr16/YgCMOgbT1Ywfb0bdU9NNHAKZltjOVuLp9w
         HnIk00SpZ1OeyglmZPF1wzro2ucPUYOBaLYH6qSJqmLJhqlgUfKS85tk2ATosNhan3+p
         8P+J+tNnJAgDiMcnXtmxUaWmFNCClBhtLQI0itbEs0H5SbwB2RsJTHmSZx1VVbzAfG3X
         +2seB7xx5XNYmr2SScDKOmRp1dq1pWgi1bYcEfB8DEI/UrJKX2zYffJe/rwsWXo5Mo0y
         Kft1rfqbCgjiaKJLWA9dqCEub81Uvp+6SuKjsAic+r4aCiEQKVPCfGKXLATk8VkrIWrB
         JJSg==
X-Gm-Message-State: APjAAAWYABnXU2NIU5m/SBu84AH16dFKQQAojSAtVIubCD0LTwheZANp
        1UfEGw3YtIfvcKnK1E0zkigYN2f9biFJAtVbLN2aYr20
X-Google-Smtp-Source: APXvYqwgSEmDKZJxYfOdT7ZpXyDXrHtLBqUPlvxgyEjbp77eS2qWr39Xhs02JDX0uvC2fNPXmKeMJIXv09ijOebtSw4=
X-Received: by 2002:a6b:7008:: with SMTP id l8mr57426312ioc.292.1560465620943;
 Thu, 13 Jun 2019 15:40:20 -0700 (PDT)
MIME-Version: 1.0
From:   Vincent Legoll <vincent.legoll@gmail.com>
Date:   Fri, 14 Jun 2019 00:40:10 +0200
Message-ID: <CAEwRq=ohKw8o0R3mtcr5E0fAeEX_OMo5qCiVx3EWwp5B3BKU9Q@mail.gmail.com>
Subject: cherry-pick strangeness
To:     git@vger.kernel.org,
        Vincent Legoll - Gmail <vincent.legoll@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000056dc4058b3c377c"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000056dc4058b3c377c
Content-Type: text/plain; charset="UTF-8"

Hello,

I stumbled upon a strange behavior of cherry-pick,
running the attached script yields different results
from running the same command lines manually in
an interactive shell, one after the other.

I searched the man page and found no indications
that that should act in this way. It looks like the CLI
args "--ff" & "--no-ff" or the absence of it are not
doing the same in a script as in an interactive shell.

I  asked in the IRC channel, and was asked to report
it here.

I tried to reproduce it in various environments, I
ran it in Centos 7, debian 9, ubuntu bionic & cosmic,
alpine & fedora, in docker containers, all giving the
same results. The git versions tested range from
1.8.3.1 to 2.21.0.

Trying to reproduce, I created the attached script,
which reports 3 times "SAME", whereas the case
using "--no-ff" should print "DIFF", if I'm not wrong
in reading its manpage description.

What am I missing ?

-- 
Vincent Legoll

--000000000000056dc4058b3c377c
Content-Type: application/x-shellscript; name="repro.sh"
Content-Disposition: attachment; filename="repro.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_jwv8wuok0>
X-Attachment-Id: f_jwv8wuok0

IyEgL2Jpbi9iYXNoCgpXUktESVI9IiQobWt0ZW1wIC1kIC1wIC4pIgpjZCAiJHtXUktESVJ9IgoK
Z2l0IC0tdmVyc2lvbgoKZ2l0IGluaXQgLiA+IC9kZXYvbnVsbCAyPiYxCmdpdCBjb25maWcgLS1n
bG9iYWwgdXNlci5lbWFpbCAieW91QGV4YW1wbGUuY29tIiA+IC9kZXYvbnVsbCAyPiYxCmdpdCBj
b25maWcgLS1nbG9iYWwgdXNlci5uYW1lICJZb3VyIE5hbWUiID4gL2Rldi9udWxsIDI+JjEKCnRv
dWNoIC5naXRpZ25vcmUKZ2l0IGFkZCAuZ2l0aWdub3JlID4gL2Rldi9udWxsIDI+JjEKZ2l0IGNv
bW1pdCAtbSdJbml0JyA+IC9kZXYvbnVsbCAyPiYxCgplY2hvICdhJyA+IGRhdGEudHh0CmdpdCBh
ZGQgZGF0YS50eHQgPiAvZGV2L251bGwgMj4mMQpnaXQgY29tbWl0IC1tJ0ZpcnN0IGNvbW1pdCcg
PiAvZGV2L251bGwgMj4mMQoKZWNobyAnYicgPiBkYXRhLnR4dApnaXQgYWRkIGRhdGEudHh0ID4g
L2Rldi9udWxsIDI+JjEKZ2l0IGNvbW1pdCAtbSdTZWNvbmQgY29tbWl0JyA+IC9kZXYvbnVsbCAy
PiYxCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMKCkJBU0U9J21hc3RlcicKCkJFRk9SRV9CQVNFPSdtYXN0ZXJe
JwojQkVGT1JFX0JBU0U9J21hc3Rlcn4xJwojQkVGT1JFX0JBU0U9J21hc3RlckB7MX0nCgplY2hv
ICJCQVNFOiAke0JBU0V9IgplY2hvICJCRUZPUkVfQkFTRTogJHtCRUZPUkVfQkFTRX0iCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKCkJSQU5DSD1icmFuY2hfMQpnaXQgY2hlY2tvdXQgLWIgIiR7QlJBTkNIfSIg
IiR7QkVGT1JFX0JBU0V9IiA+IC9kZXYvbnVsbCAyPiYxCgojIElkZW50aWNhbCBwYXRjaGVzLCBz
YW1lIGNvbW1pdHMgKGFzIGlmIC0tZmYgd2FzIGdpdmVuKQpnaXQgY2hlcnJ5LXBpY2sgIiR7QkFT
RX0iID4gL2Rldi9udWxsIDI+JjEKCkNJRF9CUkFOQ0g9JChnaXQgc2hvdyAiJHtCUkFOQ0h9IiB8
IGF3ayAnTlIgPT0gMSB7cHJpbnQgJDJ9JykKQ0lEX01BU1RFUj0kKGdpdCBzaG93IG1hc3RlciB8
IGF3ayAnTlIgPT0gMSB7cHJpbnQgJDJ9JykKCiMgU2hvdWxkIGJlIGRpZmZlcmVudCBidXQgYXJl
bid0CmVjaG8gIiR7Q0lEX01BU1RFUn0gPD4gJHtDSURfQlJBTkNIfSIKWyAiJHtDSURfTUFTVEVS
fSIgPSAiJHtDSURfQlJBTkNIfSIgXSAmJiBlY2hvIFNBTUUgfHwgZWNobyBESUZGCgojIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMKCkJSQU5DSD1icmFuY2hfMgpnaXQgY2hlY2tvdXQgLWIgIiR7QlJBTkNIfSIgIiR7
QkVGT1JFX0JBU0V9IiA+IC9kZXYvbnVsbCAyPiYxCgojIElkZW50aWNhbCBwYXRjaGVzIGJ1dCBu
ZXcgY29tbWl0IElEcwpnaXQgY2hlcnJ5LXBpY2sgLS1uby1mZiAiJHtCQVNFfSIgPiAvZGV2L251
bGwgMj4mMQoKQ0lEX0JSQU5DSD0kKGdpdCBzaG93ICIke0JSQU5DSH0iIHwgYXdrICdOUiA9PSAx
IHtwcmludCAkMn0nKQpDSURfTUFTVEVSPSQoZ2l0IHNob3cgbWFzdGVyIHwgYXdrICdOUiA9PSAx
IHtwcmludCAkMn0nKQoKIyBUaG9zZSBhcmUgZGlmZmVyZW50CmVjaG8gIiR7Q0lEX01BU1RFUn0g
PD4gJHtDSURfQlJBTkNIfSIKWyAiJHtDSURfTUFTVEVSfSIgPSAiJHtDSURfQlJBTkNIfSIgXSAm
JiBlY2hvIFNBTUUgfHwgZWNobyBESUZGCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKCkJSQU5DSD1icmFuY2hf
MwpnaXQgY2hlY2tvdXQgLWIgIiR7QlJBTkNIfSIgIiR7QkVGT1JFX0JBU0V9IiA+IC9kZXYvbnVs
bCAyPiYxCgojIElkZW50aWNhbCBwYXRjaGVzLCBzYW1lIGNvbW1pdHMKZ2l0IGNoZXJyeS1waWNr
IC0tZmYgIiR7QkFTRX0iID4gL2Rldi9udWxsIDI+JjEKCkNJRF9CUkFOQ0g9JChnaXQgc2hvdyAi
JHtCUkFOQ0h9IiB8IGF3ayAnTlIgPT0gMSB7cHJpbnQgJDJ9JykKQ0lEX01BU1RFUj0kKGdpdCBz
aG93IG1hc3RlciB8IGF3ayAnTlIgPT0gMSB7cHJpbnQgJDJ9JykKCiMgVGhvc2UgYXJlIGRpZmZl
cmVudAplY2hvICIke0NJRF9NQVNURVJ9IDw+ICR7Q0lEX0JSQU5DSH0iClsgIiR7Q0lEX01BU1RF
Un0iID0gIiR7Q0lEX0JSQU5DSH0iIF0gJiYgZWNobyBTQU1FIHx8IGVjaG8gRElGRgoKIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjCg==
--000000000000056dc4058b3c377c--
