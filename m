From: Josh Rabinowitz <joshr@joshr.com>
Subject: [PATCH] push: don't show Done with --quiet --porcelain
Date: Mon, 31 Aug 2015 12:40:45 -0400
Message-ID: <CA+WR+g7frN4uV12dxahxZbr-5az7sj3zx2oN-Z3rKH0_Y8jqqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 18:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWS8u-0008Pb-2G
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 18:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbbHaQlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 12:41:07 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36305 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbbHaQlF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 12:41:05 -0400
Received: by igboj15 with SMTP id oj15so31881294igb.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 09:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=kqX0y7J/3DqmDKeX9TKXLf8ZqWP0QvxirOxLV1FVy6o=;
        b=C2lHIlluwMjuJA63Mc1cfyQ2AaLz0koXUMD9GEIYzMSzpnclWVkTPlaCj+x2/+v3Fi
         Kyb7maZIBjgU0SqHv5/QZfsrfaOpf5zQd8YFPOdtBu07Pz7j7EXe1GILvQ8q3Z99dxY8
         nU4JSo9GcNwfIESIN2bYWYvaTh2Wm0H+fyloQXeXxtFemHuIyL5Y/2Wap5Ih6cyCsiLg
         xmWkaziq2cOsc8kueo/ZrZfIbRV5yEQDPM7gWL1cFuK8kEtUYvkhyvxP8Pp/AVPe1rLJ
         OVyW5HehYV74lE40vlFqwv1rKLyNd4wgLMibsNzDo8CYFpo3LWqNFZ3BTwAMpCxOuvC9
         lBfw==
X-Received: by 10.50.66.164 with SMTP id g4mr1665076igt.32.1441039265301; Mon,
 31 Aug 2015 09:41:05 -0700 (PDT)
Received: by 10.64.122.2 with HTTP; Mon, 31 Aug 2015 09:40:45 -0700 (PDT)
X-Google-Sender-Auth: bn9lpL1tx5l0n6wFEbYNuigW_4E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276890>

Change so 'git push --porcelain --quiet' emits no text when there
is no error.  This makes the --quiet option here more consistent with
other git commands.

Signed-off-by: josh rabinowitz <joshr@joshr.com>
---
 transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index 40692f8..0021b3f 100644
--- a/transport.c
+++ b/transport.c
@@ -1209,7 +1209,7 @@ int transport_push(struct transport *transport,
                transport_update_tracking_ref(transport->remote, ref, verbose);
        }

-       if (porcelain && !push_ret)
+       if (!quiet && porcelain && !push_ret)
            puts("Done");
        else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
            fprintf(stderr, "Everything up-to-date\n");
--
2.3.2 (Apple Git-55)
