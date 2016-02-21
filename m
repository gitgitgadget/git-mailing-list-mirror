From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH 0/5] Tests and fixes for merge-recursive rename options
Date: Sun, 21 Feb 2016 12:09:13 -0300
Message-ID: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 18:53:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXYCY-0000CN-9M
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbcBURxm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 12:53:42 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35047 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbcBURxl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 12:53:41 -0500
Received: by mail-qg0-f52.google.com with SMTP id y89so96934006qge.2
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 09:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=WQsuIBggWO2Gc/tQMXh8LYF+eg6WJpzUGlcMXtt6R3o=;
        b=zadV60VV/4cqiTQnQa5B/8el3c/pKcR2xeyJFZzbjZa0bnWuJ/AiOnshR/p31VWqGo
         nqfI9xL65lzuVhlkF2GaYTk4cO+sRrRHieUZo7POn7OTkzaKP1Gl3UJ2yMoFxsWVx8Km
         8APzg5kM7VI47bjQy+QiwXcKvM+Ff8YMgLRJESRrZ97dzds7w1YT6yLbkRIxEMRkAPKQ
         FdXIcLpG1P19HLOTrBl7LiKIvvnpquLhFmNh35ewASq1rRO0FWN2ZtJ9uLsGB8fYrqUh
         0jrEiyUZszx4QBtVWZVeBhR9mpI6mcLx2dr0dHkm2ilW9vh1kV48mZ0k03FNJP4JTEex
         qLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=WQsuIBggWO2Gc/tQMXh8LYF+eg6WJpzUGlcMXtt6R3o=;
        b=nM/jSAltfECNIvbYIvUw63SRGvlkPDGByRI5SQym6bUpYFsWefnPlej0NRXa7LqxHr
         Qx6/Gorej7l/LHiAbjdRtg3tSbtZVRukNWY+tkfNdKRFiSmn73fNeVmUVgXKWHkpwq+O
         gkpXNaMYk71SjaRhWKcj+eg0NivowAUwrpyHDfl7L0GNuEofYglV2SQABZ4dCd1e689E
         zI8PD1eMdOsJBrtBkFvjkViqyfUEQXK+O/BmpePwS+ID3c30WlRqW+BwLecx7UZ41ier
         nsUDqbP3dEEtkr/FGqo2bXmjyoObWkuqSmYUZOBEWFVusTLrNdhO+Nhp/ZqWNnN+tprK
         QbnQ==
X-Gm-Message-State: AG10YOT7BWKpxioN/cbwOKOb+LJR6oZlZ2S8e0RXKUxPswyAefv/kwmsso4LAeQahbtL5w==
X-Received: by 10.140.20.82 with SMTP id 76mr29178325qgi.5.1456067464737;
        Sun, 21 Feb 2016 07:11:04 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id o203sm8467389qho.15.2016.02.21.07.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2016 07:11:04 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gc9722f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286813>

This builds on the work in 1b47ad160b55f50a7a98c180e18d80f0f8f17a67
(merge-recursive: more consistent interface, 2016-02-17).

Add tests for the merge-recursive rename options, as suggested by Eric =
Sunshine.
Also fixes an inconsistency in the behaviour of find-renames and a typo=
=2E

The first two commits contain fixes.

The tests were divided in the latter three, reproducing the chronologic=
al
history of the features:
  3. --rename-threshold only
  4. --rename-threshold and --no-renames
  5. --find-renames, --no-renames and deprecated --rename-threshold

=46elipe Gon=C3=A7alves Assis (5):
  merge-recursive: find-renames resets threshold
  merge-strategies.txt: fix typo
  merge-recursive: test rename threshold option
  merge-recursive: test option to disable renames
  merge-recursive: test more consistent interface

 Documentation/merge-strategies.txt                 |   4 +-
 merge-recursive.c                                  |   4 +-
 ...s.sh =3D> t3032-merge-recursive-space-options.sh} |   2 +-
 t/t3034-merge-recursive-rename-options.sh          | 200 +++++++++++++=
++++++++
 4 files changed, 206 insertions(+), 4 deletions(-)
 rename t/{t3032-merge-recursive-options.sh =3D> t3032-merge-recursive-=
space-options.sh} (99%)
 create mode 100755 t/t3034-merge-recursive-rename-options.sh

--=20
2.7.1.492.gc9722f8
