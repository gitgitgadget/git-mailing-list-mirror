From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v2 0/5] Tests and fixes for merge-recursive rename options
Date: Sun, 21 Feb 2016 19:59:00 -0300
Message-ID: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 00:00:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXczb-0001lA-UZ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbcBUXAj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 18:00:39 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33808 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbcBUXAi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:00:38 -0500
Received: by mail-qg0-f48.google.com with SMTP id b67so100031655qgb.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 15:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=74Gc1x4loEIul6htdRaOZn1t+MTnflAugM0nePFD9d8=;
        b=OIv8TMu7lE66AoU0xi5fIrP5+dQB0qXQyUtvwgNdCCLxOBBWSpN6sxu/Ses+JnO9Os
         REimvcfZlqNU1d6PKqfi5XusEtlX8UZw2eGYbFQJtbaC7hn9SG1yW4iAiOc1ro8+NtBq
         VfPd92pD5YHeAAm7Bev9QxzSBRiaTS1zGBFatnOf9Cw+Q725sDWljk2gaFmUk2zgEeWh
         HkYWH0xkf4Df24VLpqIk9P77bw4Qm+ACmAFAbQv1XzizdjJk2thPypy/ZjxWYxXl8jsx
         WKjDoWqyygHkRw5B5wAtt7dBolukS05dCORDRzGjszwrHffqq+czXPQEBqRMcalqBgbO
         Rd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=74Gc1x4loEIul6htdRaOZn1t+MTnflAugM0nePFD9d8=;
        b=GXEAoJeU8YcZpKfFtsjQwNV/9xGOtKk+Y7HdIXC59xQHsjfQ+oS3UJKuPssqSphCrB
         NftkXm8yKVI698BB6rgtbSqZiiTmDg1aIbVyxyMdMO4Sn6X7JngcN6VHJb1BN+3zhyKS
         hajHmoB+9p2I35dnEzhUm+NhaggCUTCj5fKwsbxXmGW+APRtGbNRM0jB6gYKemw0LDtY
         hPYzZl2WztROrB491hdKmVXgNJ+2WTRsDm2R5uAps4GhGjbSABFF3ztRsY2b/aDwSgFi
         Yyamgmr0PxBcmawxmfIdKefb2M9g5QLL4bnvan0NWrdJwGwmNpWMD1wS04k3fm6FiFve
         IwVA==
X-Gm-Message-State: AG10YOQVORerucLjlnMCoHX5phTfoOeJA/uapeEwctye9fOSRboZ9+qHD+fcXZo6WBTd6Q==
X-Received: by 10.140.166.198 with SMTP id m189mr31130446qhm.35.1456095637802;
        Sun, 21 Feb 2016 15:00:37 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id f83sm9177201qkb.25.2016.02.21.15.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2016 15:00:36 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286833>

This is a reorganisation of the previous series, bundling the test for =
the fix
along with the commit itself, as suggested by Eric. It also includes ma=
ny fixes
and improvements pointed out by the same reviewer, whom I thank.

The typo fix is the same as before.

In "add rename threshold tests", I include tests involving --find-renam=
es,
except for one that depends on the fix.

"test option to disable renames" adds tests involving --rename-threshol=
d.

"test deprecated interface" tests the aliasing --rename-threshold.

In "find-renames resets threshold", the specific test for the feature w=
as
bundled along.

To Junio: Please pay special attention to the test of threshold truncat=
ion.
Given that it seems to be an undocumented feature, I am not sure whethe=
r it
should be included or not.

=46elipe Gon=C3=A7alves Assis (5):
  merge-strategies.txt: fix typo
  t3034: add rename threshold tests
  t3034: test option to disable renames
  t3034: test deprecated interface
  merge-recursive: find-renames resets threshold

 Documentation/merge-strategies.txt                 |   4 +-
 merge-recursive.c                                  |   4 +-
 ...s.sh =3D> t3032-merge-recursive-space-options.sh} |   2 +-
 t/t3034-merge-recursive-rename-options.sh          | 235 +++++++++++++=
++++++++
 4 files changed, 241 insertions(+), 4 deletions(-)
 rename t/{t3032-merge-recursive-options.sh =3D> t3032-merge-recursive-=
space-options.sh} (99%)
 create mode 100755 t/t3034-merge-recursive-rename-options.sh

--=20
2.7.1.492.gd821b20
