From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [RFC PATCH] Makefile: point out "make" if "make configure" fails
Date: Mon, 11 Oct 2010 12:37:45 +0000
Message-ID: <1286800665-7437-1-git-send-email-avarab@gmail.com>
References: <4CB2FEB8.3050705@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 14:38:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Hdg-0003Mb-Rj
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 14:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab0JKMhz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 08:37:55 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50489 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab0JKMhy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 08:37:54 -0400
Received: by wye20 with SMTP id 20so406183wye.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mtcO+shyg0xU4pcKoeICXHGQoHG3mMqdrMckETtbkzw=;
        b=ihO3AqYe55dPdNY2J+xPzgjkPJmojZupo6OsLUKNEJZN+Dkb2nhRpRb4j49zzFBECI
         s/Eni3hHpWIMusIi6G+aFLIVjQkW5+a4JH5XYF6iJ82aCdV2yqFTgeVIJj/1D+D7RRPI
         WbTIT97q0J4IXbUc0SYQkuCnm703kzZ6Wg8dE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AFEkzoAboFLZ3AHv2XZby+vTO1w1f/MdmVpstDo2+zqqMoNSfNdVIcc9YxSwAFq9Hw
         n61DmBBDy02tzzvPvrj3TKSGfYhPv++eKfZvoe0fIunlDdL3OHrVZ1xsM+fRtNWQO427
         Dhrtta2gmm7jD+XcgTEHj/pAshTjfh5q/u7S8=
Received: by 10.227.68.199 with SMTP id w7mr5770044wbi.0.1286800672653;
        Mon, 11 Oct 2010 05:37:52 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id g9sm6004153wbh.7.2010.10.11.05.37.50
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 05:37:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.50.g1e633
In-Reply-To: <4CB2FEB8.3050705@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158758>

Someone trying to build Git may think the need autoconf when "make
configure && ./configure && make" fails. But actually they can
probably just run "make" directly.

Change the "make configure" output so that when it fails the user is
informed of this:

    make configure && ./configure && make
        GEN configure
    ERROR: We couldn't run autoconf for you. But you're in luck!
    ERROR: Git doesn't actually need autoconf to build. Just try
    ERROR: running "make" directly at the top-level. The Makefile
    ERROR: will guess your configuration based on your OS. If that
    ERROR: doesn't work try installing autoconf and running
    ERROR: "make configure && ./configure && make" again.
    make: *** [configure] Error 1

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Mon, Oct 11, 2010 at 12:10, Michael J Gruber <git@drmicha.warpmail.n=
et> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 11.10.2010=
 11:40:
>> On Mon, Oct 11, 2010 at 08:39, Jakub Narebski <jnareb@gmail.com> wro=
te:
>>
>>> But thanks to having ./configure optional step, we can build git al=
so
>>> on platforms that doesn't have autoconf installed (though the same =
could
>>> be achieved by bundling ./configure script with release tarballs).
>>
>> It already is built as part of the tarballs, at least for
>> http://kernel.org/pub/software/scm/git/git-1.7.3.1.tar.bz2
>
> Well, the point of my semi-serious RFC is that every so often, we hav=
e a
> variation on the following theme on the list:
>
> - "Newbee" uses make configure && ./configure && make and can't build=
=2E
> - Helpful "oldbees" respond like "Duh! Use the Makefile".
>
> configure is a second class citizen in git.git (we even explicitly
> .gitignore it - if you allow that lame joke), and given my complete l=
ack
> of auto-conf-foo, I can't change that. But there's no need to make
> someone feel stupid (I'm exaggerating a bit) for trying a standard bu=
ild
> tool that we do ship.
>
> But, really, the typical responses to build problems with configure
> indicate that most long timers don't use configure either, and probab=
ly
> don't feel too comfortable with it. So, I think we should either make
> the status quo clearer (Makefile as primary method) or change the sta=
tus
> quo. I can only do the former ;)

The main problem with your patch is that existing invocations of "make
configure" have to be altered. I haven't scoured the mailing list for
these newbie reports you mention but aren't they mostly failing
because users don't have autoconf installed, and not because the
configure script itself fails?

If that's case something like this patch would probably be better, and
maybe we also need to change something in the INSTALL file or other
documentation.

 Makefile |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 1f1ce04..6d2928d 100644
--- a/Makefile
+++ b/Makefile
@@ -1747,7 +1747,16 @@ configure: configure.ac
 	$(QUIET_GEN)$(RM) $@ $<+ && \
 	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $< > $<+ && \
-	autoconf -o $@ $<+ && \
+	if ! autoconf -o $@ $<+; \
+	then \
+		echo "ERROR: We couldn't run autoconf for you. But you're in luck!";=
 \
+		echo "ERROR: Git doesn't actually need autoconf to build. Just try";=
 \
+		echo "ERROR: running \"make\" directly at the top-level. The Makefil=
e"; \
+		echo "ERROR: will guess your configuration based on your OS. If that=
"; \
+		echo "ERROR: doesn't work try installing autoconf and running"; \
+		echo "ERROR: \"make configure && ./configure && make\" again."; \
+		false; \
+	fi && \
 	$(RM) $<+
=20
 # These can record GIT_VERSION
--=20
1.7.3.1.50.g1e633
