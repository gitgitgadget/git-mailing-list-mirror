From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 00/16] Protocol version 2
Date: Mon,  1 Jun 2015 17:02:02 -0700
Message-ID: <1433203338-27493-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:05:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfA-0000hv-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbbFBACd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 20:02:33 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36524 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbbFBACb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:31 -0400
Received: by ieclw1 with SMTP id lw1so26285401iec.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=YY7khVWwmQ4OW6eT3cr+AmR+RJ41HK7FcRN0xRxI3qU=;
        b=NPaT1J21JNvjwWc3ksVqF6InAHhRxl0eIs6MFheBuBPGMNbSfQtRi4t+FTUqHc6cRE
         Rx5FJHqY64eZ7gZwGr7maG5rqQFEChQY7iHRplZjza5M9+b2kyikjFPhNKZ2oZ8ariLX
         278Yx6wRhsvJhes1pAdhtnzyqSp0SN7ZeTFPrkReyjKZAjBon2iJ2Meyeu8Yp0z2yqo1
         JypK38kYaY9GMA2wzU6zywxx8SL2miz9nG6zwJIH7nnlTaQ4z9jb4BUo9l+g277nkGXW
         Hw/5WRurAXIuBx2I08rFHD7B1W4hcHBcuPYdXM+nIow5TItrL9t49SSiCmy+bnxeavpK
         FKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=YY7khVWwmQ4OW6eT3cr+AmR+RJ41HK7FcRN0xRxI3qU=;
        b=dmPFfEubsDAV+KC+fDVBst8Dy3pe//grq3sd5aLLAlrYnSPB7MDYsauFIERaVrf7jF
         tOu9vU+JmVtU4iwMiQTYi1vYncD2/Y9tY8aEnJ6XH8jDjKWAOlQAtKZBsjhmB/l8aW11
         A1iyUyGgZRCUOprRqVuZ/rAQB2GdwU0F89xmoBVZ2T4VLVsuj17jEe6mYy/1fOi/5T0L
         x5Z7UwgVL8PR/Ctu6WwhQXyyUXMOQUfDnKF9zbOEwmVMMLCB+lPhT7DKEqa4rare392l
         8diuELT+1PQYOqsa/3oPUqYkfw0CCw9Sb+e2AFjp/mGKLnOGITQm+UZQnZI9EH7BWX6f
         IHXw==
X-Gm-Message-State: ALoCoQk8wNW4dg7AkxhpYFcO30GFglwqthd4ZzyGAUXwBLsxXrl4EBeHaRMJzaza4brYtMEZaw5Q
X-Received: by 10.107.9.223 with SMTP id 92mr30546462ioj.71.1433203350684;
        Mon, 01 Jun 2015 17:02:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id g3sm8910010igi.10.2015.06.01.17.02.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270499>

patches 1-4 are for the uploading side (upload-pack)
and 5-13 for the fetching side.

patches 14-16 are documentation and the tiny test.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  upload-pack: make client capability parsing code a separate function

Stefan Beller (15):
  stringlist: add from_space_separated_string
  connect: rewrite feature parsing to work on string_list
  upload-pack-2: Implement the version 2 of upload-pack
  remote.h: Change get_remote_heads return to void
  remote.h: add new struct for options
  transport: add infrastructure to support a protocol version number
  transport: select transport version via command line or config
  remote.h: add get_remote_capabilities, request_capabilities
  transport: connect_setup appends protocol version number
  remote: have preselect_capabilities
  transport: get_refs_via_connect exchanges capabilities before refs.
  fetch-pack: use the configured transport protocol
  t5544: add a test case for the new protocol
  Documentation/technical/pack-protocol: Mention http as possible
    protocol
  Document protocol version 2

 .gitignore                                        |   1 +
 Documentation/technical/pack-protocol.txt         |  85 ++++++++++--
 Documentation/technical/protocol-capabilities.txt |  15 ---
 Makefile                                          |   2 +
 builtin/fetch-pack.c                              |  22 +++-
 builtin/fetch.c                                   |   6 +
 builtin/receive-pack.c                            |  13 +-
 connect.c                                         | 154 ++++++++++++++=
+-------
 connect.h                                         |   2 +-
 fetch-pack.c                                      | 109 ++++++++------=
-
 fetch-pack.h                                      |   1 +
 remote.c                                          |   2 +
 remote.h                                          |  28 +++-
 string-list.c                                     |  12 ++
 string-list.h                                     |   1 +
 t/t5544-fetch-2.sh                                |  40 ++++++
 transport-helper.c                                |   1 +
 transport.c                                       |  60 ++++++++-
 transport.h                                       |  11 ++
 upload-pack-2.c                                   |   1 +
 upload-pack.c                                     | 151 ++++++++++++++=
+------
 21 files changed, 535 insertions(+), 182 deletions(-)
 create mode 100755 t/t5544-fetch-2.sh
 create mode 120000 upload-pack-2.c

--=20
2.4.1.345.gab207b6.dirty
