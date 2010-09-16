From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv2 3/3] t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
Date: Thu, 16 Sep 2010 21:58:17 +0200
Message-ID: <201009162158.20730.jnareb@gmail.com>
References: <1284284466-14506-1-git-send-email-jnareb@gmail.com> <7vtylueuc4.fsf@alter.siamese.dyndns.org> <201009122133.26427.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"=?iso-8859-1?q?=C6var_Arnfj=F6r=F0?= Bjarmason" <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 21:58:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwKbQ-0001KD-Mj
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 21:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab0IPT6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 15:58:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49248 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525Ab0IPT6d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 15:58:33 -0400
Received: by bwz11 with SMTP id 11so1936788bwz.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=IChpOcGN3knNE/m6QDIAdFghktq3yDLNjjpxN30O4y0=;
        b=BgOUXzX3KPKLQLYUVxI8AJ50fKbbDL0xb1tJQuyC0IWGxoJj5MLLDBuCE8DjT590kB
         RD52GrIR6832wypq0LcQ7F/9NJ8HVXgyDfYk+DU/2icOyXHxeKgjwUtUJRPvv7Rd2I5n
         qpnSl7qn2pJ+49JQCQxcyMjYWSkjb4RvmBmlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=T0q2ta3zMc/u23zjWmezjHd5FNqWUFWko3i/QLA0mBpOOFkv0eRAYzOapfNgG8zZkO
         n7GF70bV1rJMgjYLSJviOzQ6IYdwAfMJnkBSs68wro0+FxPPk4nQJI2T7q4GaSBcvlSY
         jspgKn265HH7476SPZvb8n+tJJU8o/NEKFbRQ=
Received: by 10.204.117.209 with SMTP id s17mr3030163bkq.15.1284667112271;
        Thu, 16 Sep 2010 12:58:32 -0700 (PDT)
Received: from [192.168.1.13] (abvm37.neoplus.adsl.tpnet.pl [83.8.210.37])
        by mx.google.com with ESMTPS id f18sm2829175bkf.15.2010.09.16.12.58.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 12:58:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201009122133.26427.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156350>

You can set the GITWEB_TEST_INSTALLED environment variable to the
gitwebdir (the directory where gitweb is installed / deployed to) of
an existing gitweb instalation to test that installation.

This change is intended to make it possible to test that process of
installing gitweb and the modules it depends on works correctly (after
splitting gitweb).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Jakub Narebski wrote:
> On Sun, 12 Sep 2010, Junio C Hamano wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:

> > > +	# You can set the GITWEB_TEST_INSTALLED environment variable to
> > > +	# the gitwebdir (the directory where gitweb is installed / deployed to)
> > > +	# of an existing gitweb instalation to test that installation.
> > > +	if test -n "$GITWEB_TEST_INSTALLED" ; then
> > > +		SCRIPT_NAME="$GITWEB_TEST_INSTALLED/gitweb.cgi"
> > > +		test -f "$SCRIPT_NAME" ||
> > > +		error "Cannot find gitweb.cgi at $GITWEB_TEST_INSTALLED."
> > 
> > I don't know if GIT_WEB_TEST_INSTALLED=/path/to/some/directory (naming the
> > directory that houses the script which must be named gitweb.cgi) is easier
> > to use than GIT_WEB_TEST_INSTALLED=/path/to/some/gitweb.perl (naming the
> > script that is allowed to be renamed).
> 
> First, I was following what GIT_TEST_INSTALLED does (it points to bindir,
> not to git binary).  Second, I had half of idea to also change paths to
> static files... but they are not used anyway, at least not currently
> (no check for links).
> 
> Anyway we can support both situations, slightly similarly to how
> GIT_TRACE can have different kinds of values.

And this implements it.

It is an RFC because it is not well tested... and I have forgot
to update comment about GITWEB_TEST_INSTALLED and the commit message.

 t/gitweb-lib.sh |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 8c490c8..b76ec4d 100755
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -32,17 +32,32 @@ EOF
 	cat >.git/description <<EOF
 $0 test repository
 EOF
+
+	# You can set the GITWEB_TEST_INSTALLED environment variable to
+	# the gitwebdir (the directory where gitweb is installed / deployed to)
+	# of an existing gitweb instalation to test that installation.
+	if test -n "$GITWEB_TEST_INSTALLED" ; then
+		if test -d $GITWEB_TEST_INSTALLED; then
+			SCRIPT_NAME="$GITWEB_TEST_INSTALLED/gitweb.cgi"
+		else
+			SCRIPT_NAME="$GITWEB_TEST_INSTALLED"
+		fi
+		test -f "$SCRIPT_NAME" ||
+		error "Cannot find gitweb at $GITWEB_TEST_INSTALLED."
+	else # normal case, use source version of gitweb
+		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.perl"
+	fi
+	export SCRIPT_NAME
 }
 
 gitweb_run () {
 	GATEWAY_INTERFACE='CGI/1.1'
 	HTTP_ACCEPT='*/*'
 	REQUEST_METHOD='GET'
-	SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.perl"
 	QUERY_STRING=""$1""
 	PATH_INFO=""$2""
 	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD \
-		SCRIPT_NAME QUERY_STRING PATH_INFO
+		QUERY_STRING PATH_INFO
 
 	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
 	export GITWEB_CONFIG
-- 
1.7.2.1
