From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 1/9] "git read-tree -m" and the like require worktree
Date: Wed, 27 Feb 2008 23:38:10 +0700
Message-ID: <20080227163810.GA28016@laptop>
References: <cover.1204130175.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 17:39:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUPJ9-0001Gm-JI
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 17:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbYB0QiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 11:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755136AbYB0QiU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 11:38:20 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:56726 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099AbYB0QiT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 11:38:19 -0500
Received: by an-out-0708.google.com with SMTP id d31so645074and.103
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 08:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=2MBcnZhvnW34NPsfEm5G07ZhYVmuuXtw3VypPs976DE=;
        b=vaxPa9K+1KIq/LGEsdVcyCAbqgpnNXUW8qKKg+MoCcwhkL9hma5bd0PzdAPXp0vM4+dP9nOvxM1wSQD6KHHyu3k3536LOO58x2sgZBJM61V7YKsnKjPBjQpxJNaz8Pz5X88DA5HdhaLEy3w/S4r1eG+TOL9QgnzQqJLoGr/ez1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=rZ/557g9Lu+Z8xmdbRA+gL9Bk7UcrhktWiUhpAe+3oHohD+8Y2cZs8VBvydeFqDYWwQiNUuNkZHTuDZLAr4uOsmnyM0jRaSVB1JO9NojBPCOWkq/HNXYBNOlX16lCveD/c+cXP4x65LfvAW3nbOyyO0V+7Kv67pdv334E2gNCAY=
Received: by 10.100.231.16 with SMTP id d16mr12613088anh.55.1204130298927;
        Wed, 27 Feb 2008 08:38:18 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.231])
        by mx.google.com with ESMTPS id b14sm13120714ana.26.2008.02.27.08.38.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Feb 2008 08:38:17 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Feb 2008 23:38:10 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204130175.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75232>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-read-tree.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index e78cf69..95318e3 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -219,6 +219,9 @@ int cmd_read_tree(int argc, const char **argv, cons=
t char *unused_prefix)
 	if ((opts.dir && !opts.update))
 		die("--exclude-per-directory is meaningless unless -u");
=20
+	if (opts.merge)
+		setup_work_tree();
+
 	if (opts.prefix) {
 		int pfxlen =3D strlen(opts.prefix);
 		int pos;
--=20
1.5.4.2.281.g28d0e
