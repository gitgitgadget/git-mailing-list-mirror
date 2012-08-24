From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: bug: when applying binary diffs, -p0 is ignored
Date: Fri, 24 Aug 2012 15:09:09 -0700
Message-ID: <CA+qbEUOw9zR1_kdXU=mB8_KADq2NRT_qxSvGT+SfS55dUM8j6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 25 00:09:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5247-0006hI-4g
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 00:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402Ab2HXWJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 18:09:12 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:65439 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758962Ab2HXWJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 18:09:09 -0400
Received: by obbuo13 with SMTP id uo13so5321154obb.19
        for <git@vger.kernel.org>; Fri, 24 Aug 2012 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=PQ8yAeUvEZj0/3dfgcjleF/9CThpFu+3/qO6ZXS4vP0=;
        b=DwPV9da4mGFClLcDi0qTiUYk71pvk25M5CRK/enb+UjwA7bKVFc9wm6nnZ0LqqgoCP
         CXu46AvCFvG2Z3de58ySBMA3DRt3f8u8bMnpG4WP3v8mgZL0DGznDhEJdgWPwm4AQUxx
         WaG2Z64TjWamn27ortSrXLfohMWWA6Hsx0jo2sXUaQ7YYlnXW4lXc/1IO+WU46lvBigY
         iS8k6mXVB5mmVU833AFNnRNDaEBkgDjj0l3b3ZP3/K5eNTPtzyQiGpgXdqb4S5SHD9Px
         YIkJfDC4I+lDF7FNy/sTtUxYt+2NwemtdvLbvKvrTRZOeXpiI7A8sG0dc4eanvSmNQBo
         sSZg==
Received: by 10.60.169.75 with SMTP id ac11mr5165877oec.12.1345846149197; Fri,
 24 Aug 2012 15:09:09 -0700 (PDT)
Received: by 10.76.7.137 with HTTP; Fri, 24 Aug 2012 15:09:09 -0700 (PDT)
X-Google-Sender-Auth: pOi4ccX1kLio4Oj6NXxGglJk_58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204237>

I found a bug in git's handling of binary diff segments.

When applying binary diffs using -p0, the prefix (or --strip) argument
is ignored.

For example, try this:
git apply -p0 --binary <<'EOF'
diff --git a/init.tar.gz a/init.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..
         386b94f511a17a8a3d62eb6cec14694cb9b9b51d
GIT binary patch
literal 118
zcmb2|=3qGT-8_JS`RzGFp(Y0bmIKvX{ySXzs`-OhSfm*K#a}SG%CY!eN_LjnjGuP-
zFH<V7m)|X1{OzyyaqIde8O2kg^q0P?b&0-p<;muDS-IC{I=+*S-L~Mn{_^zwEo=Tu
UurR>Dep|-nAGgFaXfQAU0L+LoA^-pY

literal 0
HcmV?d00001

EOF

It will create init.tar.gz, but in the root of the repository, not in a/

(Sorry if my mailer wraps the long index line)

cheers,
Colin McCabe
