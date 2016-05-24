From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
Subject: [PATCH] git-prompt.sh: Don't error on null ${ZSH,BASH}_VERSION
Date: Tue, 24 May 2016 11:31:53 +0300
Message-ID: <1464078713-3220-1-git-send-email-ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:32:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57ky-00078e-Ou
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbcEXIb7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 May 2016 04:31:59 -0400
Received: from mail-lb0-f193.google.com ([209.85.217.193]:36274 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbcEXIb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:31:58 -0400
Received: by mail-lb0-f193.google.com with SMTP id r5so547089lbj.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtso8ZWse6pkH3NZDIu3EYEMBDGEZB2+5UyiE4cdaLo=;
        b=yT0gfeFfSKr06brGodiPqNxFk6EPqH8qPO78Rjea9U31lam7gfRdHJMfttHkCIhPMn
         7YegWc2SQoA6HzytBfwaakYKfpm5ANaRMYcZ5/qK7vDdoaYzz5M69t7NVzVqGuVn7AeZ
         8G78rPJuiI5tpdPm1DvjPZLdNOCrDzbwGpTTLV+p10nKE9ACoaVr9l4MdVF5YfabaZMf
         1lLhtWcoTHToKMq3juVayxDviS7ymmfMZ8vm4YO/bbn5xkkYW707u361xvx5/U30M3dO
         dSD0dhK+MpiEdcUM8zIY4kXdHodgCEVbyV74rYghBpPsgVLPBb4K4ryD7j7U2dtYprBW
         yE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=gtso8ZWse6pkH3NZDIu3EYEMBDGEZB2+5UyiE4cdaLo=;
        b=E6/bib/bqhdIM3wcs3VF0cp/6zS/oG60IcYWrvW0bGZKr1n2kImalfgJ/74rm9XV8b
         xtYK9OWO6dOjPNk9O2iuUC9S7CTeIEe4VQDxPrC1r4hiUJH3BWn3pyX7qB3iUrDAdvjb
         jpgH3ngTLvfhXhuipEUV/H/5R9fJFa105tvbWZ1q+lyhuxJnJIYSc0R6FPXXJpa2bqSS
         Z7F7glQQMhVbw9ik2bgOmfDxjkQhVCuCOtB0+s9Jx7HCvYwBGm5lKPQWIHj8IXR/03ar
         pfjO9aMFuWWM1pwrkZ/4CBdDALTc0WBUqRTB86Xp680KTXGfpkyiyyeLqk/iz4hCJiNF
         Su9w==
X-Gm-Message-State: AOPr4FWJVBT9JTsYwwWcAzmRrZ9gknxLDenXDaGqi5WBpDvQxprKKgqtgxA2lf0R4eP32A==
X-Received: by 10.112.171.74 with SMTP id as10mr6317667lbc.139.1464078716408;
        Tue, 24 May 2016 01:31:56 -0700 (PDT)
Received: from viper.dy.fi (dtpyyyyyyyyyyyyybw5mt-3.rev.dnainternet.fi. [2001:14ba:8300::1:9655])
        by smtp.gmail.com with ESMTPSA id s133sm327966lfe.22.2016.05.24.01.31.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 May 2016 01:31:54 -0700 (PDT)
X-Mailer: git-send-email 2.5.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295479>

When the shell is in "nounset" or "set -u" mode, referencing unset or
null variables results in an error. Protect $ZSH_VERSION and
$BASH_VERSION against that.

Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
---
 contrib/completion/git-prompt.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 64219e6..341cf6b 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -355,8 +355,8 @@ __git_ps1 ()
 	# incorrect.)
 	#
 	local ps1_expanded=3Dyes
-	[ -z "$ZSH_VERSION" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=3Dno
-	[ -z "$BASH_VERSION" ] || shopt -q promptvars || ps1_expanded=3Dno
+	[ -z "${ZSH_VERSION-}" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=3Dn=
o
+	[ -z "${BASH_VERSION-}" ] || shopt -q promptvars || ps1_expanded=3Dno
=20
 	local repo_info rev_parse_exit_code
 	repo_info=3D"$(git rev-parse --git-dir --is-inside-git-dir \
--=20
2.5.5
