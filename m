From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 5/7] Makefile: Add coverage-report-cover-db-html
 target
Date: Sun, 25 Jul 2010 12:17:33 -0500
Message-ID: <20100725171733.GB8604@burratino>
References: <1280068861-17701-1-git-send-email-avarab@gmail.com>
 <1280068861-17701-6-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 19:18:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od4qY-00063J-MM
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 19:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435Ab0GYRSi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 13:18:38 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58845 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab0GYRSh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 13:18:37 -0400
Received: by gwb20 with SMTP id 20so1176074gwb.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+KYdy/QGHZJknLBm9HpVOSSkOzDKXo6Q1Kb+EsR3Pqg=;
        b=gio6cXKmNT/VopyGUsdJYW3DLruGpaIh6+/VwFHOw0E2lVqn+ujuzY5v5eyLE0xsok
         WRMsd7tXJaRAyKpwcBgy5S3PmBY5BxtM0aE4v7OIrbKj+AGjFGgBaeXh/4y7C4NYYJ/O
         2wCC/l/gReWgmSQGqss7vpnkU/GDHkt4fPZrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OCWw3/QkHOh3Njv14PWAzj5MsVWJnAdr0yjj4dL/V7CpJEemB/OGM9/mcvciH6CAdf
         /LSQVgv+w67LNe502E6YOfLkiwr47soHlv3KWD1wsyG8+h3hnagQKQcxlpNBh7l2z/iA
         LAYDasGP20OtrlPTf73dKqhYV6tSIrjsD657g=
Received: by 10.150.160.2 with SMTP id i2mr7933606ybe.314.1280078317192;
        Sun, 25 Jul 2010 10:18:37 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id q3sm4844266ybe.14.2010.07.25.10.18.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 10:18:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280068861-17701-6-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151762>

=C6var Arnfj=F6r=F0 Bjarmason wrote:

> Add a target to generate a detailed HTML report for the entire Git
> codebase using Devel::Cover's cover(1) tool. Output it in
> cover_db_html instead of the default cover_db, so that it isn't mixed
> up with our raw report files.

Oh!  Apparently these are directories. ;-)

diff --git i/.gitignore w/.gitignore
index baed247..54280af 100644
--- i/.gitignore
+++ w/.gitignore
@@ -209,4 +209,4 @@
 *.gcov
 /coverage-untested-functions
 /cover_db
-/cover_db_html
+/cover_db_html/
diff --git i/Makefile w/Makefile
index b6975aa..0fdb434 100644
--- i/Makefile
+++ w/Makefile
@@ -2282,6 +2282,7 @@ coverage:
=20
 object_dirs :=3D $(sort $(dir $(OBJECTS)))
 coverage-clean:
+	$(RM) -r cover_db_html
 	$(RM) $(addsuffix *.gcov,$(object_dirs))
 	$(RM) $(addsuffix *.gcda,$(object_dirs))
 	$(RM) $(addsuffix *.gcno,$(object_dirs))
@@ -2307,5 +2308,5 @@ coverage-untested-functions: coverage-report
 coverage-report-cover-db: coverage-report
 	gcov2perl -db cover_db *.gcov
=20
-coverage-report-cover-db-html: coverage-report-cover-db
+cover_db_html: coverage-report-cover-db
 	cover -report html -outputdir cover_db_html cover_db
--=20
