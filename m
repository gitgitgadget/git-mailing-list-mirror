From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 24/73] gettextize: git-checkout "Switched to a ..
 branch" message
Date: Fri, 25 Feb 2011 02:10:48 -0600
Message-ID: <20110225081048.GH23037@elie>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-25-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 09:11:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsslV-0006pc-K0
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 09:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927Ab1BYIK5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 03:10:57 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41967 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab1BYIK4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 03:10:56 -0500
Received: by vxi39 with SMTP id 39so1173847vxi.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 00:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nv6YINyLHVsM0qEUvt/Vu4q/dl5tzRSYzkPTtEPs4/U=;
        b=pP6JEoF9n8ttGfQra2kdiZdbxHvN3aKWssdSuuFa8rbq3ni6ua9zn645Wdl8qfC/91
         4XXjcZt0kADpwHTONanIra1nF2NEhE6YajK7qPbSTKnKPq/uFSCcF7AFL5Izx/4eYGg9
         ZlJu2KmT9rzMqMRnDNR9QIsGmL9QhN86zNJ40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KQ+0HyidvaDZE8H80L+sCncr2uilD0grEjLy1eS8s3D4GJfDG3A4WYs+kPlExxlhPH
         SNbW3xcx10wWW9ZTAOgRr/iUXTi3ydZ2FagwfPiagcPO4tj/uvSpEV37EbAmvvkgJVOb
         UJvMkKQWk+5fwhtkKzwJzAZ/tN37O8DQdJsVo=
Received: by 10.52.160.8 with SMTP id xg8mr3203017vdb.264.1298621455790;
        Fri, 25 Feb 2011 00:10:55 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id s6sm237570vch.23.2011.02.25.00.10.53
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 00:10:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298418152-27789-25-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167883>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -550,9 +550,10 @@ static void update_refs_for_switch(struct checko=
ut_opts *opts,
>  				fprintf(stderr, _("Already on '%s'\n"),
>  					new->name);
>  			else if (opts->new_branch)
> -				fprintf(stderr, "Switched to%s branch '%s'\n",
> -					opts->branch_exists ? " and reset" : " a new",
> -					new->name);
> +				if (opts->branch_exists)
> +					fprintf(stderr, _("Switched to and reset branch '%s'\n"), new->=
name);
> +				else
> +					fprintf(stderr, _("Switched to a new branch '%s'\n"), new->name=
);
>  			else

C grammar is on your side, but the following seems worthwhile for
the sanity of readers and those who might modify the code in the
future.
---
 builtin/checkout.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 92049cb..fc727ce 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -553,17 +553,18 @@ static void update_refs_for_switch(struct checkou=
t_opts *opts,
 	if (new->path) {
 		create_symref("HEAD", new->path, msg.buf);
 		if (!opts->quiet) {
-			if (old->path && !strcmp(new->path, old->path))
+			if (old->path && !strcmp(new->path, old->path)) {
 				fprintf(stderr, _("Already on '%s'\n"),
 					new->name);
-			else if (opts->new_branch)
+			} else if (opts->new_branch) {
 				if (opts->branch_exists)
 					fprintf(stderr, _("Switched to and reset branch '%s'\n"), new->na=
me);
 				else
 					fprintf(stderr, _("Switched to a new branch '%s'\n"), new->name);
-			else
+			} else {
 				fprintf(stderr, _("Switched to branch '%s'\n"),
 					new->name);
+			}
 		}
 		if (old->path && old->name) {
 			char log_file[PATH_MAX], ref_file[PATH_MAX];
--=20
1.7.4.1
