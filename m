From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3] gitweb: clarify search results page when no matching
 commit found
Date: Sat, 7 Aug 2010 16:56:47 -0500
Message-ID: <20100807215647.GB2969@burratino>
References: <AANLkTikiVQCMKjftWfrKbK-K+Gv45CTunxjULGc1==Zb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 23:58:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhrPe-0000sa-Je
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 23:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382Ab0HGV60 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 17:58:26 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49929 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab0HGV60 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 17:58:26 -0400
Received: by ywh1 with SMTP id 1so3138840ywh.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ubRNt8eMw1NUTlZVOhM1xJWQcY8Gwcn/jy8U2JKNCO8=;
        b=jv5tO8sHrsXIe/e7eYbcIvgx6dec90x5uD+hAc7uS0DU1OLn2vTAWHohlBTMtcRvgQ
         TVOFik7/4Bo+NdUFxdHPHfqCPxQG/lLYihVvLAgg0xnTKBfBZO1mqsl8SJlvXcq+fTLh
         V6KeaQeJZm+9O5ikYSvkw1SRBrlxWc217ieBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Z619xekhLM6tFwytj0furwtkcAigh1SHXgMk+renBUF6W0BxX3x0jO8VGbzOoNOK9H
         6lmF2aZ3XEW6rdyGnfvL8mTBXQPWsubd9RC2j3PNK2LSDsjZ3o7oNBR0iwLU2iF1xMb2
         HFUf3r5zFVLpWOCrD6USMShx8123MOhEb7n9g=
Received: by 10.100.225.8 with SMTP id x8mr15789257ang.203.1281218303951;
        Sat, 07 Aug 2010 14:58:23 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id a12sm4968026and.16.2010.08.07.14.58.20
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 14:58:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikiVQCMKjftWfrKbK-K+Gv45CTunxjULGc1==Zb@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152868>

When searching commits for a string that never occurs, the results
page looks something like this:

	projects / foo.git / search                                 \o/
	summary | ... | tree          [commit] search: [ kfjdkas ] [ ]re
	first =E2=8B=85 prev =E2=8B=85 next

	Merge branch 'maint'

	Foo: a demonstration project

Without a list of hits to compare it to, the header describing the
commit named by the hash parameter (usually HEAD) may itself look
like a hit.  Add some text (=E2=80=9CNo match.=E2=80=9D) to replace the=
 empty
list of hits and avoid this confusion.

While at it, remove some nearby dead code, left behind from a
simplification a few years ago (v1.5.4-rc0~276^2~4, 2007-11-01).

Noticed-by: Erick Mattos <erick.mattos@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Jakub Narebski <jnareb@gmail.com>
---
changes relative to v2[1]:
 - better newline placement in the produced HTML.

Erick Mattos wrote:

> What's up to:
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/151402/focus=3D=
151414

Hopefully third time=E2=80=99s the charm.  Test reports welcome as alwa=
ys.

 gitweb/gitweb.perl |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8b02767..4efeebc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6521,12 +6521,13 @@ sub git_search {
 			$paging_nav .=3D " &sdot; next";
 		}
=20
-		if ($#commitlist >=3D 100) {
-		}
-
 		git_print_page_nav('','', $hash,$co{'tree'},$hash, $paging_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash);
-		git_search_grep_body(\@commitlist, 0, 99, $next_link);
+		if ($page =3D=3D 0 && !@commitlist) {
+			print "<p>No match.</p>\n";
+		} else {
+			git_search_grep_body(\@commitlist, 0, 99, $next_link);
+		}
 	}
=20
 	if ($searchtype eq 'pickaxe') {
--=20
1.7.2.1.544.ga752d.dirty
