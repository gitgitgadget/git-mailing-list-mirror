From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: remove duplicate code and not needed break statement
Date: Mon, 19 Jul 2010 18:26:12 +0200
Message-ID: <AANLkTilB1eNHZWHLoBsVmEOObdSdCZQ0fxzqWc-SkC_a@mail.gmail.com>
References: <1279475399-6081-1-git-send-email-ralf.thielow@googlemail.com>
	<AANLkTimHHJnvgFh3Kd7jMqTJJFensZjkD7YCU1gdt-FT@mail.gmail.com>
	<20100719160632.GA17526@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	Valeo de Vries <valeo@valeo.co.cc>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 18:26:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OatAa-0006rj-KS
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 18:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936414Ab0GSQ0O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 12:26:14 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63300 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936396Ab0GSQ0N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jul 2010 12:26:13 -0400
Received: by wwb39 with SMTP id 39so370141wwb.1
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hq5JY6NJgus8+Cvs6izNEWfv82j8GadzBwtvEJSdZuQ=;
        b=tNIQqxxJeK/dW2Xvxh8BTsHVyzWjh4m+cRk4KlCk9W5e38kaNCrmd12dGBrKddN1LJ
         W5A4S6lK4ZZRll06fIjkDN2s3FWLYnDizjeio/XXMoAH9c/CzmlJ6D/zA0LcsfVzFvdL
         3mQbPmMCfYxbzHoY7DdV2v9WfgYcRQyp5Wo7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cEdv0xx5/D4rgEhC938T2mN0rU94moMLNHDnPXcW/7eRYtUNDrjSr2F4llzHh0tzHu
         c22O+PEihGwkpgEfOVmWaw1O4o+vZ7qC1l/B8RubM2zFWtqPxED0Zaiq531GGlTJ8Cf2
         e6FGQRuJohoE9wL9x95rq0F1JO/dFvwy4Mly0=
Received: by 10.216.179.140 with SMTP id h12mr3664406wem.39.1279556772253; 
	Mon, 19 Jul 2010 09:26:12 -0700 (PDT)
Received: by 10.216.163.132 with HTTP; Mon, 19 Jul 2010 09:26:12 -0700 (PDT)
In-Reply-To: <20100719160632.GA17526@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151257>

=46rom 5b3e7c8f8b81a295b5c58534be250f5a818ccc64 Mon Sep 17 00:00:00 200=
1
=46rom: Ralf Thielow <ralf.thielow@googlemail.com>
Date: Sun, 18 Jul 2010 18:48:58 +0200
Subject: [PATCH] update-server-info: Shorten read_pack_info_file()

The correct responses to a D and a T line in .git/objects/info/packs
are the same, so combine their case arms.  In both cases we already
=E2=80=98goto=E2=80=99 out of the switch so while at it, remove a redun=
dant =E2=80=98break=E2=80=99
to avoid yet another line of code.


Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
Reviewed-by: Jonathan Nieder <jrnieder <at> gmail.com>
---
 server-info.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/server-info.c b/server-info.c
index 4098ca2..9ec744e 100644
--- a/server-info.c
+++ b/server-info.c
@@ -113,11 +113,8 @@ static int read_pack_info_file(const char *infofil=
e)
 				goto out_stale;
 			break;
 		case 'D': /* we used to emit D but that was misguided. */
-			goto out_stale;
-			break;
 		case 'T': /* we used to emit T but nobody uses it. */
 			goto out_stale;
-			break;
 		default:
 			error("unrecognized: %s", line);
 			break;
--=20
1.7.0.4
