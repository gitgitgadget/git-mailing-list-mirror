From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCH 0/4] Make git-send-email git-credential
Date: Wed,  6 Feb 2013 21:34:37 +0100
Message-ID: <cover.1360172967.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Ted Zlatanov <tzz@lifelogs.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:35:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3BiD-0003Z3-Mg
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 21:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758188Ab3BFUe6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2013 15:34:58 -0500
Received: from mail-ea0-f180.google.com ([209.85.215.180]:52347 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758087Ab3BFUe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 15:34:57 -0500
Received: by mail-ea0-f180.google.com with SMTP id c1so746642eaa.11
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 12:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=5n3xOk7t5CqbfP9+qtQerHSSWhJPHUG8mfu5tQ1ocIo=;
        b=Q7EsH3ISpuB9oRicrAlcFlBsV1vVgeeH/sqauH6KA9BMI+GPJtcPjkwaDGbK70lAFB
         3hR6AHX+QaGFLpfZGF4XoBNSNTqeXazceXnp6/8i4NvNQVi+PQP5LNwYf0XZKld3el4T
         m0FcvfXOBIo1Izom4IE6ruLwfWmth/1/5Obz38nfUXLJQTF0YkJ1ZHvM5mdCzB8F+CVz
         huKYdwomTAtH4f9q/HzWfJUw/P8W9rxvfJl8nf1bXobwDFW1Jg5WQYyGBSP+Vixca2yp
         3Hb1Lq3nzTVqkBlgQ0AaDAmvKXICxZqO9Xi98Y7YQVk41bQOMvsxLnE03DqVbH4Qt4r2
         utNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=5n3xOk7t5CqbfP9+qtQerHSSWhJPHUG8mfu5tQ1ocIo=;
        b=f4WR4zm9aYctOe4f5CQq7o2QpTsLNGRzaqmLAWl3SetYfbCy8S2Wjjy9OfjMgFBG7x
         jLgF97fkApebeF9iwbYPwn7czeUWrlnSwBRDI+o2y54h02gmZdy2LS5CDtTvFdVK/6mL
         ofpnrX60O0hwIzYoCddY3oN9o/XkSasb2b8KXjRliy4JJ54cD5Q0Lo1znkqflBnspfvx
         EZk8cZYQzI/pNJyWaZHJvaQlmshVrg7WdhifcFj9IuO3okgraopJKeShZaRQE8eVHkdT
         5ljURPCDUl9nwESk39L6N3V3up3w3i8YfxSOBHYcUnSnhg4OOUX1pBNbGuBYVDvLhMbV
         Bihg==
X-Received: by 10.14.173.69 with SMTP id u45mr100642377eel.21.1360182895989;
        Wed, 06 Feb 2013 12:34:55 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:e809:df2d:46af:f661])
        by mx.google.com with ESMTPS id h5sm38686311eem.1.2013.02.06.12.34.54
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Feb 2013 12:34:54 -0800 (PST)
X-Mailer: git-send-email 1.8.1.2.550.g0d3a9c0.dirty
X-Gm-Message-State: ALoCoQnpK59rYdr8CR4XKky9u4n/0ReBokGAri4xezr8n/9UHks4bTBj7bQxd4nmHUEWMrrL1icu0/mWxsGyKM9CKg4viFnmOLwOt00RvfwakVMGb5nsCO+GqSzDWGI+SGjGlzdREnmxZGPaiAaRV6OdILj8uFBZKADRceBtO/rqW4SXz32vIAXwAp+uqAXWFdLMs7utZj1j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215632>

=46rom: Michal Nazarewicz <mina86@mina86.com>

As discussed on the list, adding git-credential interface to Git.pm
(sort of copied from git-remote-mediawiki) and making git-send-email
use it.

I see git-remote-mediawiki does not have =E2=80=9Cuse Git=E2=80=9D so I=
 did not touch
it.  On top of that I'd have no way to tests the changes anyway.

Michal Nazarewicz (4):
  Git.pm: Allow command_close_bidi_pipe() to be called as method
  Git.pm: Allow pipes to be closed prior to calling
    command_close_bidi_pipe
  Git.pm: Add interface for git credential command.
  git-send-email: Use git credential to obtain password.

 Documentation/git-send-email.txt |   4 +-
 git-send-email.perl              |  60 +++++++++++---------
 perl/Git.pm                      | 116 +++++++++++++++++++++++++++++++=
+++++++-
 3 files changed, 149 insertions(+), 31 deletions(-)

--=20
1.8.1.2.550.g0d3a9c0.dirty
