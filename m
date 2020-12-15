Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B394C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 15:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F1222509
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 15:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgLOPxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 10:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbgLOPx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 10:53:26 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157C9C06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 07:52:46 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id dk8so21572840edb.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 07:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BTVno+zVAMuDb+ApFQenpoAo1Dzvp+Lz9jFLpwCYIko=;
        b=KKkHgzfOPJeP+EJJwpcIJig9QQIgvYJaNXR+UI30aPLKHBirCjyeYyPmfyyA1enBsi
         yIkSO3mYzzxr9tAMUQni5Nekd0Ok8YACdYv/GL12bqtSpH+4btBrcl/Z2dYaEUSUTeFH
         mCH1dBc2IMejrjbDh2m5+8PdMreuSKrqHaBW0w2vo5UJgrOsL8GF3f3NtCiWb0eIKnTJ
         yHfqli/n+J9DZTglyVf2eSsMg4ek5ml9jyZSbrV69G8NIBxT3e0uqLQTCD5ELYYqczCg
         bor2dV8dA8jcOYUHAdfcGMel526Syy/VZOKAXtmhq3d7zMbL9AiTf65L8WOOlXiRilOy
         hZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BTVno+zVAMuDb+ApFQenpoAo1Dzvp+Lz9jFLpwCYIko=;
        b=Ud4AMpIuwzqg8FzcoTKvbBe0+UPqAMhb47cMQrgPMhbyB5AIEWHzxr/EVY+WZbFkvX
         0dPJRa9/8aPMZC3jUp8BcZvIn+X006w1OxdfghxLAhaTtohdiY9BTRaiNBMc9Z7Mz5oV
         w3qS/fEJZkRhFxZPYPlpp30nkiBkXBprwuWZaIHHDx+MlgQrxxB5YrtgOW0ogJ7rLV32
         3ykqCVYHD3u+cnUit+tBeOzCSAihKZ2KlvPu8DxufpXJMv+HIDphKdXd0AckRHi25vd7
         bxXolhIHQfvb4/jK01ftOIQ14q/fJmy2TP81+qqxnQHDz2cItRbxUUmtCUkOv+lWx2nE
         ozIg==
X-Gm-Message-State: AOAM533ctA58eTuai7ihCgOYrKWVxETEqxJ0Z4pyLSxHoYzr7BlBxytU
        XSBBjL8vlbnKtHx+LwJO9Yi+6Uk8/pgCBtN6bMaeFOZURgA=
X-Google-Smtp-Source: ABdhPJwc7IsCN4p3ZC46q9+y3txTq2Yyix9gkH9da9ih+0NmGl4P5tSfdWwWAW8oCB0vYjzj+IWNQCXo5EpYaYao3S0=
X-Received: by 2002:a05:6402:8da:: with SMTP id d26mr2929744edz.157.1608047564570;
 Tue, 15 Dec 2020 07:52:44 -0800 (PST)
MIME-Version: 1.0
From:   Stuart MacDonald <stuartm.coding@gmail.com>
Date:   Tue, 15 Dec 2020 10:52:35 -0500
Message-ID: <CAPQE4+qq11W9VzftJ6y+cbdJ1x64c8Astjwd4z4M-oc5hv1jeA@mail.gmail.com>
Subject: [Bug report] includeIf config is not displayed in normal directories
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000de826605b682bfa3"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000de826605b682bfa3
Content-Type: text/plain; charset="UTF-8"

Hello,

I've seen this thread:
https://public-inbox.org/git/F55DC360-9C1E-45B9-B8BA-39E1001BD620@gmail.com/t/#u

and respectfully disagree with the conclusion. Conditionally included
configuration can contain items like core.sshCommand that are required
for git clone while in a normal non-git directory. These should be
displayed properly so users know what configuration they are operating
with.

Also, conditionally included config is acted upon despite not being
displayed. This makes tracking down problems much more difficult.

Further, most complaints online are about user.name and user.email not
being displayed correctly. If those items are in ~/.gitconfig, then
they are displayed in a normal non-git directory by normal git config
commands. This makes conditionally included configuration display
inconsistent with regular configuration display. Inconsistency is bad
and should be fixed.

See 'git bugreport' attached for further information, reproduction steps, etc.

Thanks,
...Stu

--000000000000de826605b682bfa3
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2020-12-15-0946.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2020-12-15-0946.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kiq5x9630>
X-Attachment-Id: f_kiq5x9630

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCgpTZXQgdXAgYSBjb25kaXRpb25hbCBpbmNsdWRlOgp2dnZ2dnZ2
dnZ2IFsgfi8uZ2l0Y29uZmlnIF0gdnZ2dnZ2dnZ2dgpbaW5jbHVkZUlmICJnaXRkaXI6fi93b3Jr
LyJdCglwYXRoID0gfi8uZ2l0Y29uZmlnLXdvcmsKXl5eXl5eXl5eXiBbIH4vLmdpdGNvbmZpZyBd
IF5eXl5eXl5eXl4KCnZ2dnZ2dnZ2dnYgWyB+Ly5naXRjb25maWctd29yayBdIHZ2dnZ2dnZ2dnYK
W3VzZXJdCgluYW1lID0gU3R1YXJ0IE1hY0RvbmFsZAoJZW1haWwgPSBzdHVhcnRtLmNvZGluZ0Bn
bWFpbC5jb20KW2NvcmVdCglzc2hDb21tYW5kID0gInNzaCAtaSB+Ly5zc2gvaWRfcnNhLnN0dWFy
dG1fZ2l0aHViIgpeXl5eXl5eXl5eIFsgfi8uZ2l0Y29uZmlnLXdvcmsgXSBeXl5eXl5eXl5eCgpN
YWtlIHN1cmUgc3NoIGlzIGNvbmZpZ3VyZWQgcHJvcGVybHkgZm9yIGdpdGh1YiBhY2Nlc3M6CnZ2
dnZ2dnZ2dnYgWyB+Ly5zc2gvY29uZmlnIF0gdnZ2dnZ2dnZ2dgpIb3N0IGdpdGh1YiBnaXRodWIu
Y29tCiAgSG9zdG5hbWUgZ2l0aHViLmNvbQogIFVzZXIgZ2l0CiAgSWRlbnRpdGllc09ubHkgeWVz
Cl5eXl5eXl5eXl4gWyB+Ly5zc2gvY29uZmlnIF0gXl5eXl5eXl5eXgoKUnVuIHRoZSBmb2xsb3dp
bmcgY29tbWFuZHMgaW4gYSBHaXQgYmFzaCBzaGVsbDoKJCBta2RpciB+L3dvcmsvZ2l0LWJ1Zy10
ZXN0CiQgY2Qgfi93b3JrL2dpdC1idWctdGVzdAokIGdpdCBjb25maWcgLS1zaG93LW9yaWdpbiAt
LWdldC1hbGwgY29yZS5zc2hDb21tYW5kIApPQlNFUlZFIEE6IFRoZXJlIGlzIG5vIG91dHB1dAok
IGdpdCBjbG9uZSAtLXJlY3Vyc2l2ZSBnaXRAZ2l0aHViLmNvbTpnaXQvZ2l0LmdpdApPQlNFUlZF
IEI6IFRoZSBjbG9uZSBzdWNjZWVkcwokIGNkIGdpdAokIGdpdCBjb25maWcgLS1zaG93LW9yaWdp
biAtLWdldC1hbGwgY29yZS5zc2hDb21tYW5kIApmaWxlOkM6L1VzZXJzL3N0dWFydG0vLmdpdGNv
bmZpZy13b3JrICAgICAgICBzc2ggLWkgfi8uc3NoL2lkX3JzYS5zdHVhcnRtX2dpdGh1YgpPQlNF
UlZFIEM6IFRoZSBjb25maWd1cmF0aW9uIGl0ZW0gaXMgZGlzcGxheWVkCiQgY2QgLi4KJCBnaXQg
Y29uZmlnIC0tc2hvdy1vcmlnaW4gLS1nZXQtYWxsIGNvcmUuc3NoQ29tbWFuZCAKT0JTRVJWRSBE
OiBUaGVyZSBpcyBubyBvdXRwdXQKCk5PVEU6IEluIHRoZSBhYm92ZSByZXByb2R1Y3Rpb24gc3Rl
cHMgSSd2ZSBzdWJzdGl0dXRlZCBteSB3b3JrIGVtYWlsIGFuZAplbXBsb3llcidzIHByaXZhdGUg
cmVzcG9zaXRvcnkgKHdoaWNoIG5lZWRzIHRoZSBhcHByb3JwcmlhdGUgc3NoIGtleSB0byBiZSBh
YmxlCnRvIGNsb25lKSBmb3IgbXkgcHVibGljIGVtYWlsIGFuZCBhIHB1YmxpYyByZXBvc2l0b3J5
LiBUaGlzIG1lYW5zIG15CnJlcHJvZHVjdGlvbiBzdGVwcyBhcmVuJ3QgYW4gZXhhY3QgcmVwcm9k
dWN0aW9uOyBmb3IgYW4gZXhhY3QgcmVwcm9kdWN0aW9uCnBsZWFzZSBzdWJzdGl0dXRlIGFuIGVt
YWlsIGFkZHJlc3MgYW5kIHByaXZhdGUgcmVwb3NpdG9yeSB0aGF0IHJlcXVpcmVzIGEKY29uZmln
dXJlZCBzc2gga2V5IHRvIGNsb25lLgoKV2hhdCBkaWQgeW91IGV4cGVjdCB0byBoYXBwZW4/IChF
eHBlY3RlZCBiZWhhdmlvcikKCkkgZXhwZWN0ZWQgT0JTRVJWRSBBIGFuZCBPQlNFUlZFIEQgdG8g
bWF0Y2ggT0JTRVJWRSBDJ3Mgb3V0cHV0LgoKV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFs
IGJlaGF2aW9yKQoKVGhlcmUgd2FzIG5vIG91dHB1dC4KCldoYXQncyBkaWZmZXJlbnQgYmV0d2Vl
biB3aGF0IHlvdSBleHBlY3RlZCBhbmQgd2hhdCBhY3R1YWxseSBoYXBwZW5lZD8KCk91dHB1dCB2
cyBubyBvdXRwdXQuCgpBbnl0aGluZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoKCkkgc3BlbnQgYSBs
b3Qgb2YgdGltZSB5ZXN0ZXJkYXkgdHJhY2tpbmcgZG93biBhIHByb2JsZW0gd2l0aCBteSBnaXQK
Y29uZmlndXJhdGlvbiB0aGF0IHdhcyBwcmV2ZW50aW5nIG1lIGZyb20gY2hlY2tpbmcgb3V0IHBy
aXZhdGUgcmVwb3NpdG9yaWVzLiBUaGUKaW5jb3JyZWN0ICJubyBvdXRwdXQiIGJ1ZyBjYXVzZWQg
bWUgdG8gdGhpbmsgSSBoYWQgc29tZSBpc3N1ZSB3aXRoIG15CmNvbmRpdGlvbmFsIGNvbmZpZ3Vy
YXRpb24gc2V0dXAgYW5kIEkgd2FzIHRyYXBwZWQgaW4gdGhhdCBkZWFkIGVuZCBmb3IgdG9vIGxv
bmcuCgpJdCBzZWVtcyB0aGF0IGluY2x1ZGVJZiBpcyBub3Qgd2lkZWx5IGRpc2N1c3NlZCBvbmxp
bmUuIFRoaXMgbWFrZXMgaXQgZGlmZmljdWx0CnRvIGZpbmQgaGVscC4gSSBkaWQgZmluZApodHRw
czovL3N0YWNrb3ZlcmZsb3cuY29tL3F1ZXN0aW9ucy80MzkxOTE5MS9naXQtMi0xMy1jb25kaXRp
b25hbC1jb25maWctb24td2luZG93cwp3aGljaCBzYXlzIGluIHBhcnQgIklmIGl0cyBbc2ljXSBu
b3QgZ2l0IGluaXRpYWxpemVkIHRoZW4gdGhlIGluY2x1ZGVJZiBnaXRkaXIKZnVuY3Rpb25hbGl0
eSB3aWxsIG5vdCB3b3JrLiIgd2hpY2ggaXMgYWN0dWFsbHkgaW5hY2N1cmF0ZS4gSXQgZG9lcyBm
dW5jdGlvbjsKY29tbWVudGluZyBvdXQvaW4gdGhlIHNzaENvbW1hbmQgY29uZmlndXJhdGlvbiBs
aW5lIGNhdXNlcyBjbG9uaW5nIHRvIG5vdCB3b3JrIG9yCndvcmsgZnJvbSBhIG5vcm1hbCBkaXJl
Y3RvcnkuCgpBZGRpdGlvbmFsbHksIG1vdmluZyB0aGUgc3NoQ29tbWFuZCBjb25maWcgaXRlbSBp
bnRvIH4vLmdpdGNvbmZpZyB3aWxsIGNhdXNlCk9CU0VSVkUgQSBhbmQgT0JTRVJWRSBEIHRvIHBy
b2R1Y2Ugb3V0cHV0LiBUaGlzIGNsZWFybHkgaW1wbGljYXRlcyBpbmNsdWRlSWYKcHJvY2Vzc2lu
ZyBhcyB0aGUgcHJvYmxlbS4KCkkndmUgc2VlbiB0aGlzIHRocmVhZApodHRwczovL3B1YmxpYy1p
bmJveC5vcmcvZ2l0L0Y1NURDMzYwLTlDMUUtNDVCOS1COEJBLTM5RTEwMDFCRDYyMEBnbWFpbC5j
b20vdC8jdQphbmQgSSB1bmRlcnN0YW5kIHRoYXQgc29tZSBjb25maWcgaXRlbXMgZG9uJ3QgbWFr
ZSBzZW5zZSBpbiBhIG5vcm1hbCBkaXJlY3RvcnkuCkhvd2V2ZXIsIHNvbWUgZG8sIGNyaXRpY2Fs
bHkgY29yZS5zc2hDb21tYW5kLiBBbHNvLCBpZiB1c2VyLm5hbWUgaXMgaW4gdGhlIHRvcApsZXZl
bCAobm9uLWNvbmRpdGlvbmFsKSAuZ2l0Y29uZmlnLCB0aGVuIGl0IGlzIHJlcG9ydGVkIGJ5IGdp
dCBjb25maWcgaW4gYQpub3JtYWwgZGlyZWN0b3J5IHdoZXRoZXIgdGhhdCBtYWtlcyBzZW5zZSBm
b3IgYSBub3JtYWwgZGlyZWN0b3J5IG9yIG5vdC4KClRoZSBtaW5pbXVtIGZpeCBJJ2QgbGlrZSB0
byBzZWU6IGNvbmRpdGlvbmFsIGluY2x1ZGVzIHNob3VsZCBiZSBwcm9jZXNzZWQgYW5kCmFueSBj
b25maWd1cmF0aW9uIGl0ZW1zIGZvciB3aGljaCB1c2UgaW4gYSBub3JtYWwgZGlyZWN0b3J5IG1h
a2VzIHNlbnNlIHNob3VsZApiZSBwcmVzZW50IGFuZCByZXBvcnRlZCBwcm9wZXJseS4gQWdhaW4s
IGNyaXRpY2FsbHksIHRoaXMgaW5jbHVkZXMKY29yZS5zc2hDb21tYW5kLgoKVGhlIGJldHRlciBm
aXggaXMgdG8gaGF2ZSBjb25kaXRpb25hbCBpbmNsdWRlIHByb2Nlc3NpbmcgYmUgYXQgcGFyaXR5
IHdpdGgKZGlyZWN0aW9uIGNvbmZpZ3VyYXRpb247IHdoZXJlIGEgY29uZmlndXJhdGlvbiBpdGVt
IHdvdWxkIGJlIGRpc3BsYXllZCBpZiBpdCB3YXMKaW4gYSB0b3AtbGV2ZWwvZGlyZWN0IC5naXRj
b25maWcgZmlsZSwgdGhlbiBpdCBzaG91bGQgYWxzbyBiZSBkaXNwbGF5ZWQgaWYgaXQncwpjb25k
aXRpb25hbGx5LWluY2x1ZGVkLiBUaGlzIHdvdWxkIG1ha2UgdGhlIGNvbmZpZyBzeXN0ZW0gY29u
c2lzdGVudCwgd2hpY2ggaXMKaW1wb3J0YW50IGZvciBlYXNlIG9mIHVzZS4KSSByZWFsaXNlIHRo
aXMgZ29lcyBhZ2FpbnN0IHRoZSBzZW50aW1lbnQgaW4gdGhlIGdpdCBtYWlsaW5nIGxpc3QgdGhy
ZWFkIEkKbGlua2VkIGFib3ZlLiBJIGJlbGlldmUgdGhhdCB0aHJlYWQgaXMgd3JvbmcgaW4gaXRz
IGNvbmNsdXNpb24gb2YgIndvcmtpbmcgYXMKZGVzaWduZWQiLgoKClBsZWFzZSByZXZpZXcgdGhl
IHJlc3Qgb2YgdGhlIGJ1ZyByZXBvcnQgYmVsb3cuCllvdSBjYW4gZGVsZXRlIGFueSBsaW5lcyB5
b3UgZG9uJ3Qgd2lzaCB0byBzaGFyZS4KCgpbU3lzdGVtIEluZm9dCmdpdCB2ZXJzaW9uOgpnaXQg
dmVyc2lvbiAyLjI5LjIud2luZG93cy4yCmNwdTogeDg2XzY0CmJ1aWx0IGZyb20gY29tbWl0OiAz
NDY0Yjk4Y2U2ODAzYzk4YmY4ZmIzNDM5MGNkMTUwZDY2ZTRhMGQzCnNpemVvZi1sb25nOiA0CnNp
emVvZi1zaXplX3Q6IDgK
--000000000000de826605b682bfa3--
