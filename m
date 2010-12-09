From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC/WIP 0/3] Shared config
Date: Thu,  9 Dec 2010 22:09:45 +0700
Message-ID: <1291907388-9068-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 16:10:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQi91-0006DK-6z
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 16:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913Ab0LIPKu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 10:10:50 -0500
Received: from mail-px0-f179.google.com ([209.85.212.179]:58254 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab0LIPKt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 10:10:49 -0500
Received: by pxi20 with SMTP id 20so758873pxi.10
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 07:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=3U2Dt+Q3Ev4nswL4ylTvJeLduvRl29tmjYX+/Mv88Co=;
        b=VAa+44Y+Wac/O4pzd9XVYrdPoU9LeaNOA3jdGeI4jz71gL4ACjwzdN02z6GtZ0t6N7
         VVfdPdziw/BgpNmGUP27Zrh4VQ6LfkU4Lyh9ddzLgVHvqrB5zZxWzZbpWb7+/dLrjt+z
         nT1Vn0V0DK4v/hCXlF8hEJ+7qVhj2mmam6mVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=tvY4VKNBte+epYHBwxdaYKHxCQU8j7l99q9O5jrkttoJTJZtpjZUPghLkckOxgrb5U
         WtV9eyJ1D46guMThHTR8du+jLPtb+rglc2C/O/WOnziBdzI5Eyq9KgPQvr0/T/8eZDqf
         CTVY/LkGNlzeYSnBjLkCNJidJ9z8Fwdf9I7Tk=
Received: by 10.142.158.12 with SMTP id g12mr4143956wfe.170.1291907448502;
        Thu, 09 Dec 2010 07:10:48 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id f5sm2610759wfg.2.2010.12.09.07.10.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 07:10:47 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 09 Dec 2010 22:09:49 +0700
X-Mailer: git-send-email 1.7.3.3.476.g893a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163285>

Another approach is [1]. I think this one is somewhat simpler and
exposes less risk by putting the shared config under version control.

This is not complete (for example, git-prune should learn about this),
but is there any serious flaw that I missed?

One thing that I haven't thought of is the shared config between
subprojects. Maybe there's a better approach for subprojects.

(The resistance to nd/struct-pathspec seems great. This is the second
time I come to address it and end up with something else)

[1] http://thread.gmane.org/gmane.comp.version-control.git/162309

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  config: read full file content before parsing
  config: add git_config_from_sha1() to read from a blob
  config: add core.sharedconfig

 cache.h       |    1 +
 config.c      |  110 +++++++++++++++++++++++++++++++++++++++++++------=
--------
 environment.c |    1 +
 3 files changed, 85 insertions(+), 27 deletions(-)

--=20
1.7.3.3.476.g893a9
