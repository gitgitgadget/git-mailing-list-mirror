From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Sat, 26 Feb 2011 17:03:10 +0700
Message-ID: <20110226100310.GA21724@do>
References: <AANLkTi=iFe=MmUiXzC_HMwueZxLJDCea+zp_-SNWvSup@mail.gmail.com>
 <1283769430-9263-1-git-send-email-pclouds@gmail.com>
 <AANLkTi=YJkk6KHChCrrazij_ziyG-Ru7kGLWc7JnUGoN@mail.gmail.com>
 <AANLkTi=hz0xRsTy5f8xhzBhu0md_iPCxvdTrEPrzYwzt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	kusmabite@gmail.com, raa.lkml@gmail.com, jjuran@gmail.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 11:04:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtH1E-0005hT-J1
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 11:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab1BZKEw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Feb 2011 05:04:52 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:56728 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab1BZKEv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 05:04:51 -0500
Received: by pxi15 with SMTP id 15so379965pxi.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 02:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=U561bGo18iN/seOGhVertdwGpdA9XMFgz17EHAkIpp0=;
        b=tkY8O3VYXpwDYcR4GG5bzn6ebx5poiUkIT8xxgls8ES//PYn0skbMxs/XPKy1HhK/E
         eV+zYgxu13uud/dThDVRxH7yC0UzifCvSminwfGVpsxgtnYq0wrMTGVEzYQSh7ShqZNb
         L4wjsCfw9wDstkwBdLCOrKymOUFXoT3mRJh3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Pyabzmhi+0xlaTjQ/T6dVmQyHxtncabRVqx1cv9nM0I/SyfXTPUVK0Q1FTXFGMQy+Y
         QL62sLMenkfACV9gwCZV9HCBK4Di/sjjxFxf+MtnTxq+nCGE2ADj5zb6FH6zafFkaFRs
         VPqNrjoK2o4/+W6W816MKrtowUiWVzYJsXpgE=
Received: by 10.142.187.2 with SMTP id k2mr2469573wff.97.1298714690503;
        Sat, 26 Feb 2011 02:04:50 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id w19sm2348160wfd.8.2011.02.26.02.04.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 02:04:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 26 Feb 2011 17:03:10 +0700
Content-Disposition: inline
In-Reply-To: <AANLkTi=hz0xRsTy5f8xhzBhu0md_iPCxvdTrEPrzYwzt@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167968>

On Sun, Feb 20, 2011 at 04:30:07PM +0700, Nguyen Thai Ngoc Duy wrote:
> 2011/2/20 Sverre Rabbelier <srabbelier@gmail.com>:
> > Heya,
> >
> > 2010/9/6 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>:
> >> This bases on the original work by Robin Rosenberg.
> >
> > Junio, in the "what's cooking" you mention that you might jump in t=
o
> > improve this? Duy, are you still interested in carrying this forwar=
d?
> > This patch [0] would be helpful to the hgit people as well :).
>=20
> I can try to study resolve undo extension next week and see if I can
> write it down in the document.

OK here come the missing bits on top of the previous patch. Looks good?

--8<--
diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index 5b1d70d..574eb3b 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -118,7 +118,7 @@ GIT index format
 =3D=3D=3D Tree cache
=20
   Tree cache extension contains pre-computes hashes for all trees that
-  can be derived from the index
+  can be derived from the index.
=20
   - Extension tag { 'T', 'R', 'E', 'E' }
=20
@@ -137,8 +137,20 @@ GIT index format
=20
 =3D=3D=3D Resolve undo
=20
-  TODO
+  Resolve undo extension records staged entries before they are
+  resolved and removed from index. It can be used to recreate conflict=
s
+  after the conflict is incorrectly resolved.
=20
   - Extension tag { 'R', 'E', 'U', 'C' }
=20
   - 32-bit size
+
+  - A number of entries
+
+    NUL-terminated entry name
+
+    Entry mode of the entry in three stages, in increasing order from
+    1 to 3, in NUL-terminated ASCII octal number.
+
+    160 bit SHA-1 of the entry in three stages, in increasing
+    order from 1 to 3. A stage with zero mode will be skipped.
-->8--
--=20
Duy
