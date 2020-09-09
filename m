Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9D0C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 01:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388D620C09
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 01:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="HUecwOGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgIIBby (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 21:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgIIBbw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 21:31:52 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0200C061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 18:31:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i1so991602edv.2
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 18:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkUWbIve89hFWv0GT71Wqw3gQ5BOJyHT+M8u1zcnM4A=;
        b=HUecwOGVSzOyvAgiZP2pJmtZJYfzbAxZ6E2h6W3eDJRQLBOjgF3ll+0H+6WuCwRZAE
         oU+i+JN52eFNmxeXs9QJepl1w7ZXM0ed5WavScr1L6zFQzrI+c/wqjzSkP7l3AFfmYYT
         HE4XPJV7RwqiQ2hceB1pZg2HYRpKtwwJIquZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkUWbIve89hFWv0GT71Wqw3gQ5BOJyHT+M8u1zcnM4A=;
        b=aTEvTgGMVVsnJ+w8huADFytWoQyln/8HpYwLsDKN7V/J6dT6cuWXEpcrNFs/iKezUH
         UFNVJIyzl/T049QfUQjZvwsEgKGSpEDZzarJeMU31EIORtKcHQhli5EkeE6LrAsvb5ub
         31iGMUmWsBSU2O95ZYLdJVno86yNSPro7EIrXMsKmFH5udx80iJD9mNoEPsJXCAPSC4c
         c5+Hld80JvdRgC2KnvFR72GyWjiraAuT10e3QQBvHWoRb+5QO9mdUdIMeHL+mL8cY7C1
         BL0NoFUclKoM+Sk210y64j8z8yRZ0gt6H+IVRRjndvBdijnMnY6R/vxs8t2jBYQJnzsp
         +ovQ==
X-Gm-Message-State: AOAM533moU8fRVqrduxGXAZsonCG+A5hHIjVtaPGBf8NozIxPYwjLhG6
        Aflnd/o4EZIca1+elH68Y+35v/nY8aJ0gP7ni/30CVWbDMtV7a0lIXtB84CYyQ7ooFZFGS1UiyV
        dLCo41Ukk4f90WM6JhERElWc2ALfplcX0F3palZtBFPxAZj8JJwOfv0RBuSLNqimSXhyrPxKWj9
        +7DGyO34hS
X-Google-Smtp-Source: ABdhPJwxCU6XclCXLRwD93OHmkpSEH+8UpFoZr22IswFWLoT0uJAn+OPZYdBz55soheyXfHsu8RlQIhW6TxQGsMFTfk=
X-Received: by 2002:aa7:da89:: with SMTP id q9mr1737438eds.111.1599615108992;
 Tue, 08 Sep 2020 18:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.781.v16.git.git.1594544903477.gitgitgadget@gmail.com>
 <pull.781.v17.git.git.1594596738929.gitgitgadget@gmail.com>
 <xmqqv9idn2yr.fsf@gitster.c.googlers.com> <xmqq4koe8rav.fsf@gitster.c.googlers.com>
 <C35AC799-B4F6-4A5E-92FA-21065310B379@hxcore.ol>
In-Reply-To: <C35AC799-B4F6-4A5E-92FA-21065310B379@hxcore.ol>
From:   Lin Sun <lin.sun@zoom.us>
Date:   Wed, 9 Sep 2020 09:31:38 +0800
Message-ID: <CAKu6+JEctLopX2O2MmPNnSxqMPXjAqeXjpMPdrtY0J8AWd9L_A@mail.gmail.com>
Subject: Re: [PATCH v17] Support auto-merge for meld to follow the vim-diff behavior
To:     Junio C Hamano <gitster@pobox.com>,
        sunlin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        sunlin <sunlin7@yahoo.com>
Content-Type: multipart/mixed; boundary="0000000000005987f505aed76a61"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000005987f505aed76a61
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Sorry again, I have to re-send this mail in plain text mode for the
mail system rejecting it with " <git@vger.kernel.org> Content-Policy
reject msg: The message contains HTML subpart, therefore we
    consider it SPAM or Outlook Virus."
--------------------------------------------------------
I tried to send an update to you in the morning but now the mail
missed from my drafts and =E2=80=9Csend box=E2=80=9D, I=E2=80=99m not sure =
if the mail already
sent or not.
So I sent this mail with
=E2=80=9C0001-Support-auto-merge-for-meld-to-follow-the-vim-diff-b.patch=E2=
=80=9D for
assurement.
If you already received this patch before, please ignore current mail.
--------------------------------------------------------
After applying the changes with your SQUASH??? Commit, I test the
cases with useAutoMerge flag None/true/false/auto, it works like a
charm.
So I sent out the last patch (no changes since your SQUASH commit),
please review it. Thank you.

Best Regards
Lin Sun

--0000000000005987f505aed76a61
Content-Type: application/octet-stream; 
	name="0001-Support-auto-merge-for-meld-to-follow-the-vim-diff-b.patch"
Content-Disposition: attachment; 
	filename="0001-Support-auto-merge-for-meld-to-follow-the-vim-diff-b.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_keupigj50>
X-Attachment-Id: f_keupigj50

RnJvbSAxYjkzMWU2MTBkZGZjMDJkYzJlODgyMzRiMTA2ZTNkM2ZmODQxYjAxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW4gU3VuIDxsaW4uc3VuQHpvb20udXM+CkRhdGU6IFRodSwg
NyBNYXkgMjAyMCAwNzozMToxNCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIFN1cHBvcnQgYXV0by1t
ZXJnZSBmb3IgbWVsZCB0byBmb2xsb3cgdGhlIHZpbS1kaWZmIGJlaGF2aW9yCk1JTUUtVmVyc2lv
bjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRy
YW5zZmVyLUVuY29kaW5nOiA4Yml0CgpNYWtlIHRoZSBtZXJnZXRvb2wgdXNlZCB3aXRoICJtZWxk
IiBiYWNrZW5kIGJlaGF2ZSBzaW1pbGFybHkgdG8gInZpbWRpZmYiIGJ5CnRlbGxpbmcgaXQgdG8g
YXV0by1tZXJnZSBub24tY29uZmxpY3RpbmcgcGFydHMgYW5kIGhpZ2hsaWdodCB0aGUgY29uZmxp
Y3RpbmcKcGFydHMgd2hlbiBgbWVyZ2V0b29sLm1lbGQudXNlQXV0b01lcmdlYCBpcyBjb25maWd1
cmVkIHdpdGggYHRydWVgLCBvciBgYXV0b2AKZm9yIGRldGVjdGluZyB0aGUgYC0tYXV0by1tZXJn
ZWAgb3B0aW9uIGF1dG9tYXRpY2FsbHkuCgpIZWxwZWQtYnk6IMSQb8OgbiBUcuG6p24gQ8O0bmcg
RGFuaCA8Y29uZ2RhbmhxeEBnbWFpbC5jb20+CkhlbHBlZC1ieTogRGF2aWQgQWd1aWxhciA8ZGF2
dmlkQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogTGluIFN1biA8bGluLnN1bkB6b29tLnVzPgpT
aWduZWQtb2ZmLWJ5OiBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+Ci0tLQogRG9j
dW1lbnRhdGlvbi9jb25maWcvbWVyZ2V0b29sLnR4dCB8IDEwICsrKysrCiBidWlsdGluL2NvbmZp
Zy5jICAgICAgICAgICAgICAgICAgIHwgMTcgKysrKysrKysKIG1lcmdldG9vbHMvbWVsZCAgICAg
ICAgICAgICAgICAgICAgfCA4NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LQogMyBmaWxlcyBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2NvbmZpZy9tZXJnZXRvb2wudHh0IGIvRG9jdW1lbnRh
dGlvbi9jb25maWcvbWVyZ2V0b29sLnR4dAppbmRleCAwOWVkMzFkLi4xNmEyNzQ0IDEwMDY0NAot
LS0gYS9Eb2N1bWVudGF0aW9uL2NvbmZpZy9tZXJnZXRvb2wudHh0CisrKyBiL0RvY3VtZW50YXRp
b24vY29uZmlnL21lcmdldG9vbC50eHQKQEAgLTMwLDYgKzMwLDE2IEBAIG1lcmdldG9vbC5tZWxk
Lmhhc091dHB1dDo6CiAJdG8gYHRydWVgIHRlbGxzIEdpdCB0byB1bmNvbmRpdGlvbmFsbHkgdXNl
IHRoZSBgLS1vdXRwdXRgIG9wdGlvbiwKIAlhbmQgYGZhbHNlYCBhdm9pZHMgdXNpbmcgYC0tb3V0
cHV0YC4KIAorbWVyZ2V0b29sLm1lbGQudXNlQXV0b01lcmdlOjoKKwlXaGVuIHRoZSBgLS1hdXRv
LW1lcmdlYCBpcyBnaXZlbiwgbWVsZCB3aWxsIG1lcmdlIGFsbCBub24tY29uZmxpY3RpbmcKKwlw
YXJ0cyBhdXRvbWF0aWNhbGx5LCBoaWdobGlnaHQgdGhlIGNvbmZsaWN0aW5nIHBhcnRzIGFuZCB3
YWl0IGZvcgorCXVzZXIgZGVjaXNpb24uICBTZXR0aW5nIGBtZXJnZXRvb2wubWVsZC51c2VBdXRv
TWVyZ2VgIHRvIGB0cnVlYCB0ZWxscworCUdpdCB0byB1bmNvbmRpdGlvbmFsbHkgdXNlIHRoZSBg
LS1hdXRvLW1lcmdlYCBvcHRpb24gd2l0aCBgbWVsZGAuCisJU2V0dGluZyB0aGlzIHZhbHVlIHRv
IGBhdXRvYCBtYWtlcyBnaXQgZGV0ZWN0IHdoZXRoZXIgYC0tYXV0by1tZXJnZWAKKwlpcyBzdXBw
b3J0ZWQgYW5kIHdpbGwgb25seSB1c2UgYC0tYXV0by1tZXJnZWAgd2hlbiBhdmFpbGFibGUuICBB
CisJdmFsdWUgb2YgYGZhbHNlYCBhdm9pZHMgdXNpbmcgYC0tYXV0by1tZXJnZWAgYWx0b2dldGhl
ciwgYW5kIGlzIHRoZQorCWRlZmF1bHQgdmFsdWUuCisKIG1lcmdldG9vbC5rZWVwQmFja3VwOjoK
IAlBZnRlciBwZXJmb3JtaW5nIGEgbWVyZ2UsIHRoZSBvcmlnaW5hbCBmaWxlIHdpdGggY29uZmxp
Y3QgbWFya2VycwogCWNhbiBiZSBzYXZlZCBhcyBhIGZpbGUgd2l0aCBhIGAub3JpZ2AgZXh0ZW5z
aW9uLiAgSWYgdGhpcyB2YXJpYWJsZQpkaWZmIC0tZ2l0IGEvYnVpbHRpbi9jb25maWcuYyBiL2J1
aWx0aW4vY29uZmlnLmMKaW5kZXggNWUzOWY2MS4uYWUwNzdjOSAxMDA2NDQKLS0tIGEvYnVpbHRp
bi9jb25maWcuYworKysgYi9idWlsdGluL2NvbmZpZy5jCkBAIC02NSw2ICs2NSw3IEBAIHN0YXRp
YyBpbnQgc2hvd19zY29wZTsKICNkZWZpbmUgVFlQRV9QQVRICQk0CiAjZGVmaW5lIFRZUEVfRVhQ
SVJZX0RBVEUJNQogI2RlZmluZSBUWVBFX0NPTE9SCQk2CisjZGVmaW5lIFRZUEVfQk9PTF9PUl9T
VFIJNwogCiAjZGVmaW5lIE9QVF9DQUxMQkFDS19WQUxVRShzLCBsLCB2LCBoLCBpKSBcCiAJeyBP
UFRJT05fQ0FMTEJBQ0ssIChzKSwgKGwpLCAodiksIE5VTEwsIChoKSwgUEFSU0VfT1BUX05PQVJH
IHwgXApAQCAtOTQsNiArOTUsOCBAQCBzdGF0aWMgaW50IG9wdGlvbl9wYXJzZV90eXBlKGNvbnN0
IHN0cnVjdCBvcHRpb24gKm9wdCwgY29uc3QgY2hhciAqYXJnLAogCQkJbmV3X3R5cGUgPSBUWVBF
X0lOVDsKIAkJZWxzZSBpZiAoIXN0cmNtcChhcmcsICJib29sLW9yLWludCIpKQogCQkJbmV3X3R5
cGUgPSBUWVBFX0JPT0xfT1JfSU5UOworCQllbHNlIGlmICghc3RyY21wKGFyZywgImJvb2wtb3It
c3RyIikpCisJCQluZXdfdHlwZSA9IFRZUEVfQk9PTF9PUl9TVFI7CiAJCWVsc2UgaWYgKCFzdHJj
bXAoYXJnLCAicGF0aCIpKQogCQkJbmV3X3R5cGUgPSBUWVBFX1BBVEg7CiAJCWVsc2UgaWYgKCFz
dHJjbXAoYXJnLCAiZXhwaXJ5LWRhdGUiKSkKQEAgLTE0OSw2ICsxNTIsNyBAQCBzdGF0aWMgc3Ry
dWN0IG9wdGlvbiBidWlsdGluX2NvbmZpZ19vcHRpb25zW10gPSB7CiAJT1BUX0NBTExCQUNLX1ZB
TFVFKDAsICJib29sIiwgJnR5cGUsIE5fKCJ2YWx1ZSBpcyBcInRydWVcIiBvciBcImZhbHNlXCIi
KSwgVFlQRV9CT09MKSwKIAlPUFRfQ0FMTEJBQ0tfVkFMVUUoMCwgImludCIsICZ0eXBlLCBOXygi
dmFsdWUgaXMgZGVjaW1hbCBudW1iZXIiKSwgVFlQRV9JTlQpLAogCU9QVF9DQUxMQkFDS19WQUxV
RSgwLCAiYm9vbC1vci1pbnQiLCAmdHlwZSwgTl8oInZhbHVlIGlzIC0tYm9vbCBvciAtLWludCIp
LCBUWVBFX0JPT0xfT1JfSU5UKSwKKwlPUFRfQ0FMTEJBQ0tfVkFMVUUoMCwgImJvb2wtb3Itc3Ry
IiwgJnR5cGUsIE5fKCJ2YWx1ZSBpcyAtLWJvb2wgb3Igc3RyaW5nIiksIFRZUEVfQk9PTF9PUl9T
VFIpLAogCU9QVF9DQUxMQkFDS19WQUxVRSgwLCAicGF0aCIsICZ0eXBlLCBOXygidmFsdWUgaXMg
YSBwYXRoIChmaWxlIG9yIGRpcmVjdG9yeSBuYW1lKSIpLCBUWVBFX1BBVEgpLAogCU9QVF9DQUxM
QkFDS19WQUxVRSgwLCAiZXhwaXJ5LWRhdGUiLCAmdHlwZSwgTl8oInZhbHVlIGlzIGFuIGV4cGly
eSBkYXRlIiksIFRZUEVfRVhQSVJZX0RBVEUpLAogCU9QVF9HUk9VUChOXygiT3RoZXIiKSksCkBA
IC0yNTAsNiArMjU0LDEyIEBAIHN0YXRpYyBpbnQgZm9ybWF0X2NvbmZpZyhzdHJ1Y3Qgc3RyYnVm
ICpidWYsIGNvbnN0IGNoYXIgKmtleV8sIGNvbnN0IGNoYXIgKnZhbHVlCiAJCQkJc3RyYnVmX2Fk
ZHN0cihidWYsIHYgPyAidHJ1ZSIgOiAiZmFsc2UiKTsKIAkJCWVsc2UKIAkJCQlzdHJidWZfYWRk
ZihidWYsICIlZCIsIHYpOworCQl9IGVsc2UgaWYgKHR5cGUgPT0gVFlQRV9CT09MX09SX1NUUikg
eworCQkJaW50IHYgPSBnaXRfcGFyc2VfbWF5YmVfYm9vbCh2YWx1ZV8pOworCQkJaWYgKHYgPCAw
KQorCQkJCXN0cmJ1Zl9hZGRzdHIoYnVmLCB2YWx1ZV8pOworCQkJZWxzZQorCQkJCXN0cmJ1Zl9h
ZGRzdHIoYnVmLCB2ID8gInRydWUiIDogImZhbHNlIik7CiAJCX0gZWxzZSBpZiAodHlwZSA9PSBU
WVBFX1BBVEgpIHsKIAkJCWNvbnN0IGNoYXIgKnY7CiAJCQlpZiAoZ2l0X2NvbmZpZ19wYXRobmFt
ZSgmdiwga2V5XywgdmFsdWVfKSA8IDApCkBAIC00MTEsNiArNDIxLDEzIEBAIHN0YXRpYyBjaGFy
ICpub3JtYWxpemVfdmFsdWUoY29uc3QgY2hhciAqa2V5LCBjb25zdCBjaGFyICp2YWx1ZSkKIAkJ
ZWxzZQogCQkJcmV0dXJuIHhzdHJkdXAodiA/ICJ0cnVlIiA6ICJmYWxzZSIpOwogCX0KKwlpZiAo
dHlwZSA9PSBUWVBFX0JPT0xfT1JfU1RSKSB7CisJCWludCB2ID0gZ2l0X3BhcnNlX21heWJlX2Jv
b2wodmFsdWUpOworCQlpZiAodiA8IDApCisJCQlyZXR1cm4geHN0cmR1cCh2YWx1ZSk7CisJCWVs
c2UKKwkJCXJldHVybiB4c3RyZHVwKHYgPyAidHJ1ZSIgOiAiZmFsc2UiKTsKKwl9CiAJaWYgKHR5
cGUgPT0gVFlQRV9DT0xPUikgewogCQljaGFyIHZbQ09MT1JfTUFYTEVOXTsKIAkJaWYgKGdpdF9j
b25maWdfY29sb3Iodiwga2V5LCB2YWx1ZSkpCmRpZmYgLS1naXQgYS9tZXJnZXRvb2xzL21lbGQg
Yi9tZXJnZXRvb2xzL21lbGQKaW5kZXggN2EwODQ3MC4uYWFiNGViYiAxMDA2NDQKLS0tIGEvbWVy
Z2V0b29scy9tZWxkCisrKyBiL21lcmdldG9vbHMvbWVsZApAQCAtMywzNCArMyw4NyBAQCBkaWZm
X2NtZCAoKSB7CiB9CiAKIG1lcmdlX2NtZCAoKSB7Ci0JaWYgdGVzdCAteiAiJHttZWxkX2hhc19v
dXRwdXRfb3B0aW9uOitzZXR9IgorCWNoZWNrX21lbGRfZm9yX2ZlYXR1cmVzCisKKwlvcHRpb25f
YXV0b19tZXJnZT0KKwlpZiB0ZXN0ICIkbWVsZF91c2VfYXV0b19tZXJnZV9vcHRpb24iID0gdHJ1
ZQogCXRoZW4KLQkJY2hlY2tfbWVsZF9mb3Jfb3V0cHV0X3ZlcnNpb24KKwkJb3B0aW9uX2F1dG9f
bWVyZ2U9Ii0tYXV0by1tZXJnZSIKIAlmaQogCiAJaWYgdGVzdCAiJG1lbGRfaGFzX291dHB1dF9v
cHRpb24iID0gdHJ1ZQogCXRoZW4KLQkJIiRtZXJnZV90b29sX3BhdGgiIC0tb3V0cHV0PSIkTUVS
R0VEIiBcCisJCSIkbWVyZ2VfdG9vbF9wYXRoIiAkb3B0aW9uX2F1dG9fbWVyZ2UgLS1vdXRwdXQ9
IiRNRVJHRUQiIFwKIAkJCSIkTE9DQUwiICIkQkFTRSIgIiRSRU1PVEUiCiAJZWxzZQotCQkiJG1l
cmdlX3Rvb2xfcGF0aCIgIiRMT0NBTCIgIiRNRVJHRUQiICIkUkVNT1RFIgorCQkiJG1lcmdlX3Rv
b2xfcGF0aCIgJG9wdGlvbl9hdXRvX21lcmdlICIkTE9DQUwiICIkTUVSR0VEIiAiJFJFTU9URSIK
IAlmaQogfQogCi0jIENoZWNrIHdoZXRoZXIgd2Ugc2hvdWxkIHVzZSAnbWVsZCAtLW91dHB1dCA8
ZmlsZT4nCi1jaGVja19tZWxkX2Zvcl9vdXRwdXRfdmVyc2lvbiAoKSB7Ci0JbWVsZF9wYXRoPSIk
KGdpdCBjb25maWcgbWVyZ2V0b29sLm1lbGQucGF0aCkiCi0JbWVsZF9wYXRoPSIke21lbGRfcGF0
aDotbWVsZH0iCisjIEdldCBtZWxkIGhlbHAgbWVzc2FnZQoraW5pdF9tZWxkX2hlbHBfbXNnICgp
IHsKKwlpZiB0ZXN0IC16ICIkbWVsZF9oZWxwX21zZyIKKwl0aGVuCisJCW1lbGRfcGF0aD0iJChn
aXQgY29uZmlnIG1lcmdldG9vbC5tZWxkLnBhdGggfHwgZWNobyBtZWxkKSIKKwkJbWVsZF9oZWxw
X21zZz0kKCIkbWVsZF9wYXRoIiAtLWhlbHAgMj4mMSkKKwlmaQorfQogCi0JaWYgbWVsZF9oYXNf
b3V0cHV0X29wdGlvbj0kKGdpdCBjb25maWcgLS1ib29sIG1lcmdldG9vbC5tZWxkLmhhc091dHB1
dCkKKyMgQ2hlY2sgdGhlIGZlYXR1cmVzIGFuZCBzZXQgZmxhZ3MKK2NoZWNrX21lbGRfZm9yX2Zl
YXR1cmVzICgpIHsKKwkjIENoZWNrIHdoZXRoZXIgd2Ugc2hvdWxkIHVzZSAnbWVsZCAtLW91dHB1
dCA8ZmlsZT4nCisJaWYgdGVzdCAteiAiJG1lbGRfaGFzX291dHB1dF9vcHRpb24iCiAJdGhlbgot
CQk6IHVzZSBjb25maWd1cmVkIHZhbHVlCi0JZWxpZiAiJG1lbGRfcGF0aCIgLS1oZWxwIDI+JjEg
fAotCQlncmVwIC1lICctLW91dHB1dD0nIC1lICdcW09QVElPTlwuXC5cLlxdJyA+L2Rldi9udWxs
CisJCW1lbGRfaGFzX291dHB1dF9vcHRpb249JChnaXQgY29uZmlnIC0tYm9vbCBtZXJnZXRvb2wu
bWVsZC5oYXNPdXRwdXQpCisJCWNhc2UgIiRtZWxkX2hhc19vdXRwdXRfb3B0aW9uIiBpbgorCQl0
cnVlIHwgZmFsc2UpCisJCQk6IHVzZSBjb25maWd1cmVkIHZhbHVlCisJCQk7OworCQkqKQorCQkJ
OiBlbXB0eSBvciBpbnZhbGlkIGNvbmZpZ3VyZWQgdmFsdWUsIGRldGVjdGluZyAiLS1vdXRwdXQi
IGF1dG9tYXRpY2FsbHkKKwkJCWluaXRfbWVsZF9oZWxwX21zZworCisJCQljYXNlICIkbWVsZF9o
ZWxwX21zZyIgaW4KKwkJCSoiLS1vdXRwdXQ9IiogfCAqJ1tPUFRJT04uLi5dJyopCisJCQkJIyBB
bGwgdmVyc2lvbiB0aGF0IGhhcyBbT1BUSU9OLi4uXSBzdXBwb3J0cyAtLW91dHB1dAorCQkJCW1l
bGRfaGFzX291dHB1dF9vcHRpb249dHJ1ZQorCQkJCTs7CisJCQkqKQorCQkJCW1lbGRfaGFzX291
dHB1dF9vcHRpb249ZmFsc2UKKwkJCQk7OworCQkJZXNhYworCQkJOzsKKwkJZXNhYworCWZpCisJ
IyBDaGVjayB3aGV0aGVyIHdlIHNob3VsZCB1c2UgJ21lbGQgLS1hdXRvLW1lcmdlIC4uLicKKwlp
ZiB0ZXN0IC16ICIkbWVsZF91c2VfYXV0b19tZXJnZV9vcHRpb24iCiAJdGhlbgotCQk6IG9sZCBv
bmVzIG1lbnRpb24gLS1vdXRwdXQgYW5kIG5ldyBvbmVzIGp1c3Qgc2F5IE9QVElPTi4uLgotCQlt
ZWxkX2hhc19vdXRwdXRfb3B0aW9uPXRydWUKLQllbHNlCi0JCW1lbGRfaGFzX291dHB1dF9vcHRp
b249ZmFsc2UKKwkJbWVsZF91c2VfYXV0b19tZXJnZV9vcHRpb249JCgKKwkJCWdpdCBjb25maWcg
LS1ib29sLW9yLXN0ciBtZXJnZXRvb2wubWVsZC51c2VBdXRvTWVyZ2UKKwkJKQorCQljYXNlICIk
bWVsZF91c2VfYXV0b19tZXJnZV9vcHRpb24iIGluCisJCXRydWUgfCBmYWxzZSkKKwkJCTogdXNl
IHdlbGwgZm9ybWF0dGVkIGJvb2xlYW4gdmFsdWUKKwkJCTs7CisJCWF1dG8pCisJCQkjIHRlc3Rp
bmcgdGhlICItLWF1dG8tbWVyZ2UiIG9wdGlvbiBvbmx5IGlmIGNvbmZpZyBpcyAiYXV0byIKKwkJ
CWluaXRfbWVsZF9oZWxwX21zZworCisJCQljYXNlICIkbWVsZF9oZWxwX21zZyIgaW4KKwkJCSoi
LS1hdXRvLW1lcmdlIiogfCAqJ1tPUFRJT04uLi5dJyopCisJCQkJbWVsZF91c2VfYXV0b19tZXJn
ZV9vcHRpb249dHJ1ZQorCQkJCTs7CisJCQkqKQorCQkJCW1lbGRfdXNlX2F1dG9fbWVyZ2Vfb3B0
aW9uPWZhbHNlCisJCQkJOzsKKwkJCWVzYWMKKwkJCTs7CisJCSIiKQorCQkJbWVsZF91c2VfYXV0
b19tZXJnZV9vcHRpb249ZmFsc2UKKwkJCTs7CisJCSopCisJCQlkaWUgInVua25vd24gbWVyZ2V0
b29sLm1lbGQudXNlQXV0b01lcmdlOiAkbWVsZF91c2VfYXV0b19tZXJnZV9vcHRpb24iCisJCQk7
OworCQllc2FjCiAJZmkKIH0KLS0gCjIuMi4wCgo=
--0000000000005987f505aed76a61--
