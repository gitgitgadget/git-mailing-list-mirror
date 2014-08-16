From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: t5534 broken when gpg not installed
Date: Sat, 16 Aug 2014 23:19:13 +0200
Message-ID: <53EFCAD1.8040808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 16 23:19:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIlNu-00079s-57
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 23:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbaHPVTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 17:19:30 -0400
Received: from mout.web.de ([212.227.17.12]:63059 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbaHPVTP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 17:19:15 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MKrU4-1XIlNZ3P72-00009G for <git@vger.kernel.org>; Sat,
 16 Aug 2014 23:19:14 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:jB5vBZSSEz1ZIo8USDxyiCP7YiFVyEB7yJWTOVn3VNYXI4B8rdT
 iYr4vvdN6WKxt/QW3XIikAXN5x8G03D/FU85NXLVPtv7fZkH/1XZeMOW0nxd4Ss7aycPNbF
 94cKIMQBjvfxsYUwAne28iGXtpc0xgwiqYBuTsWy7uXfbLlY0QoRAM5fHuhJUCognZ2SCAq
 /4VoGa9yVmHIjFgniJPEg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255342>

(I couldn't find a post for this patch)
The following is needed for systems without gpg to make t5534 pass:



diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 3acc864..ee5aaff 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -45,7 +45,7 @@ test_expect_success 'unsigned push does not send push certificate' '
        ! test -s dst/push-cert
 '
 
-test_expect_success 'signed push sends push certificate' '
+test_expect_success GPG 'signed push sends push certificate' '
        prepare_dst &&
        mkdir -p dst/.git/hooks &&
        write_script dst/.git/hooks/post-receive <<-\EOF &&
