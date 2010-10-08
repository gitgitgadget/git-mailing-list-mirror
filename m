From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] Unify argument and option notation in the docs
Date: Fri, 8 Oct 2010 02:43:20 -0500
Message-ID: <20101008074320.GB4671@burratino>
References: <20101008005256.GA21738@headley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 09:46:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P47f3-0006Z5-Bu
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 09:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293Ab0JHHqb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 03:46:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42881 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031Ab0JHHqb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 03:46:31 -0400
Received: by iwn6 with SMTP id 6so353458iwn.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 00:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KPMzSYIkM8zI3pDoDNzVBxz0hnTcajMnYPSAm6N9wAE=;
        b=vNmJGg49H2jZOs03Uz1DX5VWWJ3bxAkmurNd9PaJO47CuKgBhPbkH9/vdK9pKUtIIu
         ICCoxo9knSCRdra4lWtthDibnXLgG9EALp5U3L2eSyipMknarSEj8lubsclWHE16BRsu
         v9X65aPM5Km5LHhYQOiePO9R077l4znnXPXnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ovxlk9Ds71lAw6OPI9xRwGG9QvXTU2zAoK0WEzuYO5nAOe0puSJH870gl4QfKmPnxT
         kM9Hw0zZ61cJmOamOcRFV2eHQYD0Q6EZqVOaMDG5hFwD/y8W8clU27Hqv+OFj/F+b6C5
         BNOdtx6hlZ9XlQg7Si+f7qTxQ1IeOL0lzbznI=
Received: by 10.42.179.69 with SMTP id bp5mr369603icb.133.1286523990873;
        Fri, 08 Oct 2010 00:46:30 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 34sm611142ibi.20.2010.10.08.00.46.29
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 00:46:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101008005256.GA21738@headley>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158481>

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec wrote:

> Some examples of what this patch is based on (i.e., the current
> prevalent usage) follow (all coming from existing documentation):
>=20
> Placeholders are enclosed in angle brackets:
>   <file>
>   --sort=3D<key>
>   --abbrev[=3D<n>]
[etc]

All sane.

> [It is conceivable I could submit this as a series of smaller patches=
,
> but the problems this is solving didn't seem diverse enough to me to
> warrant that.

Since the documentation processor is known to be, um, picky, could you
do that?  That way after bisecting a formatting problem, one has a
diff addressing a single issue to look at.

On the other hand, I am happy enough to comment on a single, monolithic
patch on list if you publish the smaller patches making it up in a git
repository somewhere.

> 1. Is `[--refs [--unpacked | --all]]' in `git-pack-object' documentat=
ion
> correct? From my reading of builtin/pack-objects.c, `--unpacked' and
> `--all' do the same thing and both imply --refs, so perhaps [--refs |
> --unpacked | --all] would make more sense?

Doesn't the OPTIONS section explain what --revs, --unpacked, and --all
mean?

I suspect

	[--revs] [--unpacked] [--all]

would be clearer, but

	[--revs [(--unpacked|--all)...]]

seems fine, too.

By the way, shouldn't that code path use ALLOC_GROW? [1]

> (I also noticed that the
> --reflog option is shown in the usage string but undocumented.)

Looks like someone forgot to add it to the man page.

> 2. I left in one special case, namely the GIT_* variables in `git(1)'
> synopsis section as values for the `--exec-path' and other options.

Hmm, --exec-path=3DGIT_EXEC_PATH currently serves as a reminder of the
name of the corresponding environment variable, but I don't think
that's very important.  --exec-path[=3D<path>] should be fine.

[1]
-- 8< --
Subject: pack-objects: use ALLOC_GROW

Invoke ALLOC_GROW from cache.h instead of recaping its definition
verbatim.  When this code was first written, the ALLOC_GROW macro
didn't exist yet; now that the macro does exist, it can make the
source a little shorter and more readable.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/pack-objects.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3756cf3..6ab2878 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -896,13 +896,9 @@ static int check_pbase_path(unsigned hash)
 	if (0 <=3D pos)
 		return 1;
 	pos =3D -pos - 1;
-	if (done_pbase_paths_alloc <=3D done_pbase_paths_num) {
-		done_pbase_paths_alloc =3D alloc_nr(done_pbase_paths_alloc);
-		done_pbase_paths =3D xrealloc(done_pbase_paths,
-					    done_pbase_paths_alloc *
-					    sizeof(unsigned));
-	}
-	done_pbase_paths_num++;
+	ALLOC_GROW(done_pbase_paths,
+		   ++done_pbase_paths_num,
+		   done_pbase_paths_alloc);
 	if (pos < done_pbase_paths_num)
 		memmove(done_pbase_paths + pos + 1,
 			done_pbase_paths + pos,
@@ -2248,11 +2244,7 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 		    !strcmp("--reflog", arg) ||
 		    !strcmp("--all", arg)) {
 			use_internal_rev_list =3D 1;
-			if (rp_ac >=3D rp_ac_alloc - 1) {
-				rp_ac_alloc =3D alloc_nr(rp_ac_alloc);
-				rp_av =3D xrealloc(rp_av,
-						 rp_ac_alloc * sizeof(*rp_av));
-			}
+			ALLOC_GROW(rp_av, rp_ac + 2, rp_ac_alloc);
 			rp_av[rp_ac++] =3D arg;
 			continue;
 		}
--=20
1.7.2.3
