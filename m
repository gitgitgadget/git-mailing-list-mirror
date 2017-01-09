Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MIME_HEADER_CTYPE_ONLY,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_TVD_MIME_NO_HEADERS
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742371FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 23:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031512AbdAIXa2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 18:30:28 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36218 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031182AbdAIXaR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 18:30:17 -0500
Received: by mail-qt0-f180.google.com with SMTP id k15so380626802qtg.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 15:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sEbGgZcZTkHqZM5KPePNYbqHvwObYBZl+0Ws5EtMCRc=;
        b=rR6NWYP3K+NchhUjEHSwoaPv3T/vOWTYESsGuP44myh6dzMyl89V5Ysl6tlJnwALvL
         SkvMiOdQ1Xtliz7M2uCQrlbIPr7VUTobXu/L5oSrKYqHsiaKTg+BT/K7unQUBWdVgBAw
         be0okKbYC+DCa7bNZcW/KRH617qMobE1AZcoSL8YJEwaf8pfm5Tk7bZbNnWbghBN2Ccw
         QsB7yY9IvRfEv7QFHxX4Da71rip1MEuQ7zTU8zmGwYKwbLK9i8+E0J10dr/YxVQduo1j
         DyYnRSDVeRDIQeBX+XxVfzw2vz22AW5ejLNoPkGWwbeIzP8rNlrpqbn542MVKJzZVUXM
         3pOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sEbGgZcZTkHqZM5KPePNYbqHvwObYBZl+0Ws5EtMCRc=;
        b=VfGTbDFMUcz4of4JIGbuFWTnT442IS6xO0zSqYjP/4ROB3kyb8vjK0zO7TAloyKJ2b
         3Ad+ZEp5vVwhHPYFpcXpVeLvHGfPScBYJJ+0P76bq8q+B4OWvH16SfEMoPt5+qIZRwb2
         8O0TpA0l9dPpkmAMY1MAlxiU5KcYZRF6rseMCeh3cZxYGf1N6xstnAYMUz96GeFOru29
         EFAYYx5CMyiHcEVOr44TWz4DvVdaN+wvs5PBzWKax66U6cBT0JyTV7X3PshGcEZQStg5
         MTUT203tJ9wh0y5P1sGYxxp+Ww8AL3LT7VDvCq/1XbBKFNLbw3/uQDv+CSwCPv7VDC+J
         ojAQ==
X-Gm-Message-State: AIkVDXIT3qXe/ABpBsKzfxdBcwfRrFRg9O+mtazr1V2cb+TAwGhTomixr2MQXk2HJY1xJPgy
X-Received: by 10.200.52.170 with SMTP id w39mr177057qtb.123.1484004616431;
        Mon, 09 Jan 2017 15:30:16 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id c41sm42910qtd.3.2017.01.09.15.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 15:30:15 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v4 14/14] mergetool: fix running in subdir when rerere enabled
Date:   Mon,  9 Jan 2017 18:29:41 -0500
Message-Id: <20170109232941.43637-15-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170109232941.43637-1-hansenr@google.com>
References: <20170109054238.42599-1-hansenr@google.com>
 <20170109232941.43637-1-hansenr@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="001a1147904a06bc550545b1c052"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a1147904a06bc550545b1c052

The pathnames output by the 'git rerere remaining' command are
relative to the top-level directory but the 'git diff --name-only'
command expects its pathname arguments to be relative to the current
working directory.  Run cd_to_toplevel before running 'git diff
--name-only' and adjust any relative pathnames so that 'git mergetool'
does not fail when run from a subdirectory with rerere enabled.

This fixes a regression introduced in
57937f70a09c12ef484c290865dac4066d207c9c (v2.11.0).

Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Richard Hansen <hansenr@google.com>
---
 git-mergetool.sh     | 16 ++++++++++++++--
 t/t7610-mergetool.sh |  7 ++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index b506896dc..cba6bbd05 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -454,6 +454,15 @@ main () {
 	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
 	merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
 
+	prefix=$(git rev-parse --show-prefix) || exit 1
+	cd_to_toplevel
+
+	if test -n "$orderfile"
+	then
+		orderfile=$(git rev-parse --prefix "$prefix" -- "$orderfile") || exit 1
+		orderfile=$(printf %s\\n "$orderfile" | sed -e 1d)
+	fi
+
 	if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
 	then
 		set -- $(git rerere remaining)
@@ -461,14 +470,17 @@ main () {
 		then
 			print_noop_and_exit
 		fi
+	elif test $# -ge 0
+	then
+		files_quoted=$(git rev-parse --sq --prefix "$prefix" -- "$@") || exit 1
+		eval "set -- $files_quoted"
+		shift
 	fi
 
 	files=$(git -c core.quotePath=false \
 		diff --name-only --diff-filter=U \
 		${orderfile:+"-O$orderfile"} -- "$@")
 
-	cd_to_toplevel
-
 	if test -z "$files"
 	then
 		print_noop_and_exit
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index b36fde1c0..820fc8597 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -234,7 +234,7 @@ test_expect_success 'mergetool merges all from subdir (rerere disabled)' '
 	)
 '
 
-test_expect_failure 'mergetool merges all from subdir (rerere enabled)' '
+test_expect_success 'mergetool merges all from subdir (rerere enabled)' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_config rerere.enabled true &&
@@ -677,6 +677,11 @@ test_expect_success 'diff.orderFile configuration is honored' '
 		b
 		a
 	EOF
+
+	# make sure "order-file" that is ambiguous between
+	# rev and path is understood correctly.
+	git branch order-file HEAD &&
+
 	git mergetool --no-prompt --tool myecho >output &&
 	git grep --no-index -h -A2 Merging: output >actual &&
 	test_cmp expect actual
-- 
2.11.0.390.gc69c2f50cf-goog


--001a1147904a06bc550545b1c052
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS6QYJKoZIhvcNAQcCoIIS2jCCEtYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBPMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
BgEFBQcwAoY0aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NodnNtaW1lY2Ex
LmNydDAdBgNVHQ4EFgQUbPFPDSp3rGDbNu3Pb8jJO+QTw0AwHwYDVR0jBBgwFoAUyzgSsMeZwHiS
jLMhleb0JmLA4D8wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wOwYDVR0fBDQwMjAwoC6gLIYqaHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2h2c21pbWVjYTEuY3JsMA4GA1UdDwEB/wQEAwIFoDAdBgNV
HSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAG7GEcPrcRoMakd1
k8cdl7NUgGsEGoTzcS1ASh1ZaKlEzGR0uHyB7QwpX1hSHCvUKMRAqe5vXqZWhVhiPNPc0792yPHo
K+K5sV1W+pF66TlYY/9qlz0IDyKlMRKyCkc77PdrXubuJjauu2WGnbDpHvVwLTqwwlR5O0OLig48
m4YUSo869xADdrGrWJ7KzroFbucLZYh3niIjVICp7fh9wtLgbX7X/akdubehYhy/l+AIMml6Zlyu
GNGCGIleyQ0bAdjjG+dKrDErUlui8wd/YplvelaTAzSvNpxcrr+2YB8UBWcYkgULkp5GDCC2guKl
rMF1mTS6N6GMxUi30sZicbMxggJeMIICWgIBATBcMEwxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSIwIAYDVQQDExlHbG9iYWxTaWduIEhWIFMvTUlNRSBDQSAxAgwvfEOc
7N3JjQI9nAwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN4I3FH5KSCmXy0Xt6yK
G42CTna0jMi8JkubBzQM2YR0MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTE3MDEwOTIzMzAxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB6dgI4LHaGglaJG43Grf/IrB08TTzc0U2JURYy
4O2QgKPEH1vMyHxfGDGepNNko+MEb+PmCZyvrWyQqua3vgklDe43J0UpUpuRDTl+9arfAEbh+a3d
43UdztUYqF8mHvqVO6ctRhMJzrmg41YPvVHtligLYGPzeb3J71Tu0o+nz26t99dAGOyE+x8pno2w
o0ZiBDIj7ocCgAfUWG6VSiWUpF3lQaNi3HeSD4xwyVKWrWLTDsr/GYbL/AaNfiDiUTQTSBF15soB
InoDhNu2IezlSaHEZlCNPOn6lyU547LUMy/n9+U8e1r2zC8bI73plAIaVOccUumtMiNQd4EsLQ0I
--001a1147904a06bc550545b1c052--
