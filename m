Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F475C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 09:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjDLJky (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 05:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDLJkw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 05:40:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E7A65B9
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 02:40:38 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id q26so1692967lfe.9
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 02:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northern.tech; s=google; t=1681292436; x=1683884436;
        h=subject:from:content-language:to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mboHytoHUJY8hFVJYXqIPx6RU2ha5xQ0een13elDwc4=;
        b=H7w3H3tIzZgbfUTS/6G1I6f6JHiia32VDwNsChskr+DOh8FDB0e+QSLfXOhFf10koJ
         /aXdS1EYsrPzD8jnONpHRl8uBhMHtY1oCxsLb+JU1lliWwp9d05nJNj9TZtEOEpWst06
         HPC399v5yslCSdl+Npg1dKwxfc80vfQIRnDO0WLnF/wwSqvZfroSyhwATZTzE0xZXLPg
         V9jaoH9iwvX5imHK6yHvfODd7q+DlAGJu7moZJ2UTQrKrsefwNGFZuZL2eRnyXPzuqVN
         SWbmtA5BMTiTMGJ9ll+GxHQgCE3pj9taYR+7xWCZOri4pQn7T1HEkYmn9vJdjOSl4dzi
         zStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681292436; x=1683884436;
        h=subject:from:content-language:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mboHytoHUJY8hFVJYXqIPx6RU2ha5xQ0een13elDwc4=;
        b=UvKrSGrXxbqZhzgUrREl9U3T/d2Oo9EIEasrEGW6JVpaCyZy4cXV4/FW4DJ7/FpnrT
         yqaeviNP0hbq60pNQTJ8/PwWOmr2pxc+YW013Wd8UjJZOgJHSyapheTSqfeSc8xck/nd
         BY2NmfMKDuRALMb6g0oardW0LhP+emLjEUhj7591tmQ9j9EwF6/sT9KSXvnkQsbgitde
         CWWB4aNCkFFLx07nffeit76DBjv0kuEi1AmsOaXjPxlLeii//Ep0XDv2hOTnTmaDecIP
         XZXFyppS2o+TFkvnJ5EsT6tNoQ2wbb7FzoUy4zu8ly4LWpLHd3ea9qi3M8DK9hWXWNXQ
         7mBg==
X-Gm-Message-State: AAQBX9d+/JzBRtgb4sd2J7IGtYW7T936We0gOeJwhDur0obDgRwQS87m
        I2qsE2RvV1lr08IndME60FgQYXNTmSZR0Q34AM+g25qJZUPxs0n5GMLEtLaRsr5fh4mPNUy/eU9
        slWH0S2CeCXvZl23h
X-Google-Smtp-Source: AKy350b5aiVKOdI+xYI5ikd8mbogf4OjkPYsdSpM+79AbqOpeOhRoHbYdqgftGnC+OUtnkFRhi0mdw==
X-Received: by 2002:a19:5207:0:b0:4d5:a689:7580 with SMTP id m7-20020a195207000000b004d5a6897580mr1470579lfb.47.1681292436422;
        Wed, 12 Apr 2023 02:40:36 -0700 (PDT)
Received: from [10.180.37.228] ([91.232.32.37])
        by smtp.googlemail.com with ESMTPSA id f23-20020ac25097000000b004e7fa99f2b5sm2935841lfm.186.2023.04.12.02.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 02:40:36 -0700 (PDT)
Message-ID: <6813396c-6faa-f34d-992f-648a8d4462ea@northern.tech>
Date:   Wed, 12 Apr 2023 11:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To:     git@vger.kernel.org
Content-Language: en-US, nb-NO
From:   Kristian Amlie <kristian.amlie@northern.tech>
Subject: range-diff: Display new commits' diffs as well
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ipq7LbEsoaerE2qqOHTo5SU7"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ipq7LbEsoaerE2qqOHTo5SU7
Content-Type: multipart/mixed; boundary="------------QpqEQ7PttS0TGqMU78Odlus0";
 protected-headers="v1"
From: Kristian Amlie <kristian.amlie@northern.tech>
To: git@vger.kernel.org
Message-ID: <6813396c-6faa-f34d-992f-648a8d4462ea@northern.tech>
Subject: range-diff: Display new commits' diffs as well

--------------QpqEQ7PttS0TGqMU78Odlus0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QXQgdGhlIG1vbWVudCBicmFuZCBuZXcgY29tbWl0cyBpbiByYW5nZS1kaWZmIGFyZSBzaW1w
bHkgZGlzcGxheWVkIG9uIA0Kb25lIGxpbmUuIEhvd2V2ZXIsIEkgb2Z0ZW4gZmluZCBpdCB1
c2VmdWwgdG8gdmlldyBkaWZmcyBvZiBuZXcgY29tbWl0cyANCmluIGFkZGl0aW9uIHRvIHRo
ZSBhbHRlcmVkIGRpZmZzIG9mIHRoZSBleGlzdGluZyBjb21taXRzLCBzaW5jZSBJJ20gDQpp
bnRlcmVzdGVkIGluIGV2ZXJ5dGhpbmcgdGhhdCB3YXMgYWRkZWQuIEkgY291bGQgbm90IGZp
bmQgYSBmbGFnIHRvIA0KZW5hYmxlIHRoaXMsIHNvIGN1cnJlbnRseSBJIGhhdmUgdG8gY2hl
Y2sgdGhlc2Ugb3V0IHNlcGFyYXRlbHkuDQoNCldvdWxkIHRoZXJlIGJlIGludGVyZXN0IGlu
IGhhdmluZyBhIGZsYWcgbGlrZSwgc2F5IC0tc2hvdy1uZXctY29tbWl0cyANCihhbmQgcG9z
c2libHkgZXZlbiAtLXNob3ctb2xkLWNvbW1pdHMpIHRvIGVuYWJsZSB0aGlzIG91dHB1dD8N
Cg0KT2J2aW91c2x5IGR1YWwtY29sb3Igd291bGQgYmUgc29tZXdoYXQgcmVkdW5kYW50IGhl
cmUsIGJ1dCB0aGUgZXhhY3QgDQpvdXRwdXQgY2FuIGJlIGRpc2N1c3NlZC4NCg0KLS0gDQpL
cmlzdGlhbiBBbWxpZQ0KTWVuZGVyIDxodHRwczovL21lbmRlci5pbz4NCg==

--------------QpqEQ7PttS0TGqMU78Odlus0--

--------------ipq7LbEsoaerE2qqOHTo5SU7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENCehelwanxwH18S/9GRAfJlq8D8FAmQ2fJMACgkQ9GRAfJlq
8D+VVwf/ZOxo8oEqgXlPWVfKqKF4htUI8bi6xXtbDWcDilgZz85eGQ0q3YxIn9Ub
QN4Bvu1VeNGgi8utifZMxG2lUnpAESfSYAyJ5eJIsOM7uY+oeGB3qvWCXHGhHUUI
PvSwMLuzqKtyMK2+NTIDpTHb0iu40qLNeAO6CUgdrEHKuUFIojbiNQUT+Uro4EQD
eWbXyYjX8gHTkKWCL7U+7T0S9ZiQETIoet2Vej353LZgaVfZ0T4yjot1BIRNTdir
PtaOh+9Q6MTc3X/v07r5rZcQQnw5BvaeL1h8Y4CYWvdMCoJ0YZf6T3E6upxMRfSz
+pikw6KyAH3lGzgUreg9ZcRJ8p87LA==
=3z7j
-----END PGP SIGNATURE-----

--------------ipq7LbEsoaerE2qqOHTo5SU7--
