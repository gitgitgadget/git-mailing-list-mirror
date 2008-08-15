From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH] bash-completion: Add non-command git help files to bash-completion
Date: Fri, 15 Aug 2008 17:17:25 -0400
Message-ID: <48A5F265.5080905@griep.us>
References: <1218816948-7864-1-git-send-email-marcus@griep.us> <7v8wuyb0m7.fsf@gitster.siamese.dyndns.org> <48A5CC07.2040500@griep.us> <7vvdy29kok.fsf@gitster.siamese.dyndns.org> <B03ECD53-5920-4750-816F-890980C4CBD6@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Aug 15 23:18:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU6gq-0007Yb-GF
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 23:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbYHOVR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 17:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbYHOVR3
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 17:17:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:47711 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbYHOVR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 17:17:28 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1214617wri.5
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 14:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=AQkIaQxkTef1uRcfnC4NT/mrxtX2oiJTMi4j5wmbZZY=;
        b=rmJClDyN41aysdwAv+6DWjIiYXctK9NsBeVWzWTBqvJdOA5xILFhUYLVLEXrdJPZp+
         0WB0eWnq0Cgy3FMZhqpVNgv4CrK6GUr5De5G+VZT7nisC3VXHcUvZXAF/I9OqC7xYdJu
         pBwQ4d68XQLxbOE4PLsdMX3xPOnKFTnreDBDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=whKXkj+D1ujdIcL+9OYNOl4aoVtDT3XmK/m4TQHm+kyq7Ay7C8q2sUVGmRe1uOjCnf
         N/wGfPWfSm48aLFkldipnvBqnoc0pZWLHlX0LDCb1zUdU0u7fArLzOyiWvWh7crYqnYg
         m2liSKR112LNLu3+YHgSsvK1UEqCqWFCnYSEI=
Received: by 10.90.55.9 with SMTP id d9mr4290474aga.40.1218835047947;
        Fri, 15 Aug 2008 14:17:27 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id q30sm1539900wrq.36.2008.08.15.14.17.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 14:17:26 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <B03ECD53-5920-4750-816F-890980C4CBD6@ai.rug.nl>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92518>

Pieter de Bie wrote:
> How about something simple like this?

Seems to do the job.

> diff --git a/builtin-help.c b/builtin-help.c

Are you working on next? Even though I know next is the new
master. (master is soooo nearly last week. :-P)

I had a slightly different take.  Your completion creates a 'k'
for gitk, which was suggested earlier in the thread suggested=20
is a bit harder to grok.  This promotes 'git?' commands to use
'git?' rather than '?' without affecting things otherwise.
---
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c0bf7aa..0bb0d79 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -885,7 +885,9 @@ _git_help ()
                return
                ;;
        esac
-       __gitcomp "$(__git_all_commands)"
+       __gitcomp "$(ls $(./git help man-path)/man?/* |
+               sed -n -e 's/^.*\/git-\?\(.\{2,\}\)\.[0-9]$/\1/p' \
+                       -e 's/^.*\/git\(.\)\.[0-9]$/git\1/p')"
 }

 _git_init ()
diff --git a/help.c b/help.c
index 3cb1962..d0416e1 100644
--- a/help.c
+++ b/help.c
@@ -717,6 +717,11 @@ int cmd_help(int argc, const char **argv, const ch=
ar *prefix)
                return 0;
        }

+       if (!strcmp("man-path", argv[0])) {
+               printf("%s\n", GIT_MAN_PATH);
+               return 0;
+       }
+
        switch (help_format) {
        case HELP_FORMAT_MAN:
                show_man_page(argv[0]);
---

What do you think, Junio?  If it works, I'll make this a
normal patch submission.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
