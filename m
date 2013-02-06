From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCH 0/4] Make git-send-email git-credential
Date: Wed,  6 Feb 2013 21:47:02 +0100
Message-ID: <cover.1360183427.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Ted Zlatanov <tzz@lifelogs.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:47:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3BuB-0005cR-Go
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 21:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758624Ab3BFUrU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2013 15:47:20 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42540 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758551Ab3BFUrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 15:47:19 -0500
Received: by mail-ee0-f46.google.com with SMTP id e49so1007629eek.33
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 12:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=P4kwczN/nKNU7kum/jtFRZV6ypnWQg/WmHz8Z5hGK3s=;
        b=KqGhohSZVLM+qBrRHH1SaUWM9/sqUuKKZBrgD7y3nWncQaTMVczkYJ8Jc/X3uaflwA
         BK6K3RfVzHxBpoj8961hFEa3YD71Ry8icmPzGhqoJlshYB77+oaEHcx057x7i4DKkYUr
         vdE1o6rbFQO3759nJisRk9+QKA5S/c3fRCv27cALeYw3LFWKMMPJ1z66QHJsIKYBcUX5
         NZ+3cLv2cVQfKedFTcAnfwLdrLygBHjGtgz0C6M+/dHbaLnFia75aMVG5a4rWkXAdBr/
         vz9Srn/aI1fxjXIy+yDq7U0xXZ5gbzyjXN9cuVvxfJ18Nrg+knQYwOWJM50X3BIv/BzE
         gKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=P4kwczN/nKNU7kum/jtFRZV6ypnWQg/WmHz8Z5hGK3s=;
        b=XEZADC2aC6v+ofkukacZ0nuhoLfvFDzy/7IlOJl4ah0AvZgWONF7okscjNRZdVDTcf
         sYtnzCMAf1zTjpbX0/GPFSJsAXaXBM3tTBLgbnVlsd6UNh5b4cKcvsZXSdXUNEmZYiS4
         RJHqRtyV0qOy6YMa/rscUPGMALYiWjT5ObKrhd4DEUFVIAcJPoDISe7w0jL7/dV5WlGs
         IOhbsXy/c9LeZeAcRzd+QINvy+rEZCKh0WMGFmwFoK/6+uOYX7g8eqGIHi+kHU3gw5A0
         p3KEPBATWvpmv/yK62Nv2lzRIyB1K6HJxzHLtkBkWb3rx7FNnzW471Bulwr/w9OleP/9
         T4zQ==
X-Received: by 10.14.194.4 with SMTP id l4mr4169195een.12.1360183638455;
        Wed, 06 Feb 2013 12:47:18 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:e809:df2d:46af:f661])
        by mx.google.com with ESMTPS id z5sm294639eep.16.2013.02.06.12.47.16
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Feb 2013 12:47:17 -0800 (PST)
X-Mailer: git-send-email 1.8.1.2.549.g1d13f9f
X-Gm-Message-State: ALoCoQnkM0Mp26LOZlpI2SXMVPHl7sC0XSUdJ4ziMyAsPOLv1J+KsxmZXAiEjkCmYN8kwKedicGtJglsICVNoVluflUWV+Vnd6pxLmSnUioRJ/tcQ5Nn1D77PB7FINfk+JTW2b/CiFfyZ88SSDM+u7UXjbcZ9idQMxIonJqL8Z7NwR5OLTwUZXrOxgCflbaan22XSReb66BZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215635>

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
 git-send-email.perl              |  59 +++++++++++---------
 perl/Git.pm                      | 116 +++++++++++++++++++++++++++++++=
+++++++-
 3 files changed, 149 insertions(+), 30 deletions(-)

--=20
1.8.1.2.549.g4fa355e
