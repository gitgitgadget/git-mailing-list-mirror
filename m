From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Teach mailinfo %< as an alternative scissors mark
Date: Sat, 3 Apr 2010 14:52:17 -0500
Message-ID: <20100403195217.GA26698@progeny.tock>
References: <1270161834-9597-1-git-send-email-eblake@redhat.com>
 <7vaatmmju9.fsf@alter.siamese.dyndns.org>
 <4BB5F94F.3090403@redhat.com>
 <20100403074700.GA24176@progeny.tock>
 <7vr5mw8k66.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 21:52:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny9OO-00087H-AY
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 21:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab0DCTwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Apr 2010 15:52:13 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57268 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901Ab0DCTwL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 15:52:11 -0400
Received: by gwb19 with SMTP id 19so644449gwb.19
        for <git@vger.kernel.org>; Sat, 03 Apr 2010 12:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZBPLOlMQ9GzDGpR6asgVPJ4M0MlFCcAMQXu7bnmKOn8=;
        b=okN8hl7Zeeeuxb0ZiGOEjsUpkxw02mlRQJwkSMFOab+aFfpGdhl9ieO2QVOYB0nwz/
         Nmx0rRacuI8Y2y3i7JFnLr4JB5L3VgpF5Qlhmeb+h0QhxKmToeJyU17X+BHYCe6zZz3b
         /MgymzxMeh7QHq7f6fLuhtt1FxViQQK2nJtiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=eTXBDlEpgBq0NdIuJ7+zgIyqvSh5AhCG9wxaxIPxTizVM9VduB8jxaDVQ2rugXI81R
         A7IYylCTmtPVNEDz1VZ7n1B5NswvBuhTWf6Q8wzf2ilsKUmHw2G2AY2E9aBrD7Gh/KqY
         H+IpRBFiCd0P1X1j1wYNix+ww5nU74/ukr3xA=
Received: by 10.151.21.5 with SMTP id y5mr4650509ybi.145.1270324330968;
        Sat, 03 Apr 2010 12:52:10 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1334476iwn.12.2010.04.03.12.52.09
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 03 Apr 2010 12:52:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vr5mw8k66.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143897>

Handle perforations found =E2=80=9Cin the wild=E2=80=9D more robustly b=
y recognizing
=E2=80=9C%<=E2=80=9D as an alternative scissors mark.

This feature is only meant to support old habits.  Discourage new use
of the percent-based version by only documenting the 8< symbol so new
users=E2=80=99 perforations can still be recognized by old versions of =
Git.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> Thanks, will queue.  By the way, please spell scissors as 8< or >8 no=
t
> with a per-cent at least for now.

Thanks for pointing it out.  I will from now on.

Searching for =E2=80=9Ccut here=E2=80=9D on groups.google.com revealed =
several examples
like this one:

 ______________________%<__cut here ______________>%_____________

[ed: dashes converted to underscores to avoid confusing am]

So I guess I=E2=80=99m the only one using the small-fingered scissors. =
 Maybe
this patch could help support old habits.

 builtin/mailinfo.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index ce2ef6b..4a9729b 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -746,7 +746,8 @@ static int is_scissors_line(const struct strbuf *li=
ne)
 			continue;
 		}
 		if (i + 1 < len &&
-		    (!memcmp(buf + i, ">8", 2) || !memcmp(buf + i, "8<", 2))) {
+		    (!memcmp(buf + i, ">8", 2) || !memcmp(buf + i, "8<", 2) ||
+		     !memcmp(buf + i, ">%", 2) || !memcmp(buf + i, "%<", 2))) {
 			in_perforation =3D 1;
 			perforation +=3D 2;
 			scissors +=3D 2;
--=20
1.7.0.3
