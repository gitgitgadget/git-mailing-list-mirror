From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/14] merge_file(): add comment explaining behavior wrt
 conflict style
Date: Sat, 20 Mar 2010 19:40:53 -0500
Message-ID: <20100321004053.GC23888@progeny.tock>
References: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
 <20100321002535.GA23681@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 01:40:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt9Cx-0001F5-GX
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 01:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125Ab0CUAjz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 20:39:55 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48364 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab0CUAjy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 20:39:54 -0400
Received: by gyg8 with SMTP id 8so2112304gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 17:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=EX1SY7HQ1mJFI8VneCTYWQURze+kKwO+Y7evYkHSHWs=;
        b=sgTM7nurp9Je1ggkAOWu5L0y1BPuF96zn2IFZvWVUYD/1kofl/G6C15ORgUbB+17JE
         3MybCK1BkqoXuKua5/8qLtfxNPI5MqTQV4mX866XHGD1N3APcCrm14d4qKdLmhzUtr82
         xxJ26zDe67LzCUmAJBX3e57yNXfrALCcQq2xc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WR3UuwAXm0g+xVxjAxrSL1zIIf/VrMoi3hgkH+GRz5AC8LB+gHALb24CsQTHPyDh/Y
         kOhVQ9mn3w0yZnxO/HtHfdpYnU0yG+r7wcCAZeKHMqU4zUsS4wQlsGAskPS2GJEvaMlD
         CTQPSA46lPKQ9HsJscR19CSe0unpgCaVuneDw=
Received: by 10.150.48.33 with SMTP id v33mr3615631ybv.16.1269131993380;
        Sat, 20 Mar 2010 17:39:53 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2756832iwn.14.2010.03.20.17.39.52
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 17:39:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100321002535.GA23681@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142776>

The merge_file() function is a helper for =E2=80=98git read-tree=E2=80=99=
, which does
not respect the merge.conflictstyle option, so there is no need to
worry about what ancestor_name it should pass to ll_merge().  Add a
comment to this effect.

Signed-off-by: Jonathan Nieder <jrnieder@mgila.com>
---
=46rom <http://thread.gmane.org/gmane.comp.version-control.git/142374/f=
ocus=3D142381>.

 merge-file.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/merge-file.c b/merge-file.c
index 07cc0c9..c336c93 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -30,6 +30,12 @@ static void *three_way_filemerge(const char *path, m=
mfile_t *base, mmfile_t *our
 	int merge_status;
 	mmbuffer_t res;
=20
+	/*
+	 * This function is only used by cmd_merge_tree, which
+	 * does not respect the merge.conflictstyle option.
+	 * There is no need to worry about a label for the
+	 * common ancestor.
+	 */
 	merge_status =3D ll_merge(&res, path, base, NULL,
 				our, ".our", their, ".their", 0);
 	if (merge_status < 0)
--=20
1.7.0.2
