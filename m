From: James <purpleidea@gmail.com>
Subject: Re: [Patch] Use a default for a bad env config file variable
Date: Tue, 10 Aug 2010 11:54:43 -0400
Message-ID: <AANLkTi=UCJa9uT5i9TRB9hGsH1D8b9DgB49TPM5k1htQ@mail.gmail.com>
References: <AANLkTi=42V8=26oEwcNOHubuK+VAf-QaYnvCLAKQ0xtg@mail.gmail.com>
	<vpq4of2scen.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 10 17:54:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OirA9-0004i1-F6
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 17:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297Ab0HJPyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 11:54:45 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:39924 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157Ab0HJPyo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 11:54:44 -0400
Received: by pxi10 with SMTP id 10so123527pxi.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=K9Oi/haAZwCbwuxX6xWQImSxvfDXbryX6AfjcIYMsj8=;
        b=pDjwx91qmyU4wMoCRi2zgm0zX8/fOAwP/vy9JV9L+KnGDlDd3I43ZBfjfKQ8y/UeO2
         FfdsLoHDthaeVZyRxoK8uQ2X98NwJkAM25xY5KLWUuYE8iwyc16kjx3Zno4YL/bV/StQ
         kmVTrET43uKqxXD853C1zSVmu3ixXqDcgwS6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wYbx4/f95Y4P04FPolBRt0lHgVJR1XdT3pNsxER0A0lMdQQiYjljJfCVa/Iwz9Z6gc
         JHXFsvi8qwwlVYEsVCMztYbs87/jH00HXszdx+fHSiTK4QuGA6aoV6qRUziHsjx68cOX
         BGbJdPMRy7ZTLhAzd8Ybt/Ko7B3FU6hyuOShc=
Received: by 10.115.58.4 with SMTP id l4mr20535252wak.16.1281455684121; Tue, 
	10 Aug 2010 08:54:44 -0700 (PDT)
Received: by 10.220.46.69 with HTTP; Tue, 10 Aug 2010 08:54:43 -0700 (PDT)
In-Reply-To: <vpq4of2scen.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153124>

Sorry about that,
I guess I had only read the README.
Hope this is better:

>From d29adf8c788b8a747bfd38dd7e10f684de9aa8e9 Mon Sep 17 00:00:00 2001
From: James Shubin <purpleidea@gmail.com>
Date: Tue, 10 Aug 2010 10:30:22 -0400
Subject: [PATCH] Use a default for a bad env config file variable.


Signed-off-by: James Shubin <purpleidea@gmail.com>
---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4efeebc..43294e1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -605,6 +605,10 @@ sub evaluate_gitweb_config {
 	} elsif (-e $GITWEB_CONFIG_SYSTEM) {
 		do $GITWEB_CONFIG_SYSTEM;
 		die $@ if $@;
+	# if config file from env is missing, then try the default anyways
+	} elsif (-e "++GITWEB_CONFIG_SYSTEM++") {
+		do "++GITWEB_CONFIG_SYSTEM++";
+		die $@ if $@;
 	}
 }

-- 
1.7.0.4



On 8/10/10, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Hi,
>
>
>  James <purpleidea@gmail.com> writes:
>
>  > Hi git list, my name is James, and this is my first patch.
>
>
> Then, I'll have to be the first person directing you to
>  Documentation/SubmittingPatches ;-).
>
>  The custom here is to send patches inline (git send-email can help),
>  not attached. Read about Signed-off-by too.
>
>  (Don't know perl and gitweb enough to judge on the content
>  unfortunately, sorry)
>
>
>  --
>  Matthieu Moy
>  http://www-verimag.imag.fr/~moy/
>
