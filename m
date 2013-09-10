From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 05/14] drop rules, etc. common to the pack protocol
Date: Wed, 11 Sep 2013 01:07:49 +0800
Message-ID: <1378832878-12811-6-git-send-email-rctay89@gmail.com>
References: <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <1378832878-12811-1-git-send-email-rctay89@gmail.com>
 <1378832878-12811-2-git-send-email-rctay89@gmail.com>
 <1378832878-12811-3-git-send-email-rctay89@gmail.com>
 <1378832878-12811-4-git-send-email-rctay89@gmail.com>
 <1378832878-12811-5-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:09:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRR9-000483-27
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086Ab3IJRI6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Sep 2013 13:08:58 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:45195 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab3IJRI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:08:28 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so7934386pdi.19
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CLs68LpnGHOdTlaCcoiajbzRFGNBLoPHI4JiJpKhmiA=;
        b=mLVXIbje62Pg5fvqnTmgBBeFFbrD76fcNfaC5X5wWeySV5oAEWdWQQpH6e8qqVtuJ5
         BjvSdayUnE2NFJUe4ILRSf0rQZ3EQ84ilvFXhlLaAbQT3EMWVFf1oGJ4h5ui7GiSsc6V
         a/AYtxYUAIva3KUaqNq+Yskq2tAWWM3lL3Ms6UMl3rBHwd0gT/oL4r4VUwJf4UL5WofX
         px38VSaGS+0CpCNqhKeU+/PhVsVLegPVIAk4d7mgJLxBQU3q/ciwVoz87ShEVrURlT4u
         obbsxkcKF4ND79VxtPKsFU4NYXwZGtWDgrCjbQpxXQ9p0aVg94bsN5q6JWxMkHBHL6a4
         nz4A==
X-Received: by 10.68.236.168 with SMTP id uv8mr15583042pbc.124.1378832908273;
        Tue, 10 Sep 2013 10:08:28 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (bb42-60-75-197.singnet.com.sg. [42.60.75.197])
        by mx.google.com with ESMTPSA id tg7sm24173138pbc.36.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 10:08:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1378832878-12811-5-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234460>

Use obj-id in lieu of id (defined as 40*HEX).

Use zero-id in lieu of 40*"0".

Use refname in lieu of name (not defined).

Drop section on capabilities, since they are already available in
protocol-capabilities.txt.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
--

pkt-line format section was dropped in response to Junio's comments:

  From:   Junio C Hamano <gitster@pobox.com>
  Message-ID: <7vskdss3ei.fsf@alter.siamese.dyndns.org>

  > +pkt-line Format
  > +---------------
  > ...
  > +Examples (as C-style strings):
  > +
  > +  pkt-line          actual value
  > +  ---------------------------------
  > +  "0006a\n"         "a\n"
  > +  "0005a"           "a"
  > +  "000bfoobar\n"    "foobar\n"
  > +  "0004"            ""
  > +
  > +A pkt-line with a length of 0 ("0000") is a special case and MUST
  > +be treated as a message break or terminator in the payload.

  Isn't this "MUST be" wrong?

  It is not an advice to the implementors, but the protocol specificati=
on
  itself defines what the flush packet means.  IOW, "The author of this
  specification, Shawn, MUST treat a flush packet as a message break or
  terminator in the payload, when designing this protocol."

Capabilities and 'command' ABNF rules under git-upload-pack were
dropped by Nguy=E1=BB=85n:

  Message-ID: <1377092713-25434-1-git-send-email-pclouds@gmail.com>
---
 Documentation/technical/http-protocol.txt | 85 ++++-------------------=
--------
 1 file changed, 10 insertions(+), 75 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/=
technical/http-protocol.txt
index ff91bb0..a8d28ba 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -84,34 +84,6 @@ as described by RFC 2616 (HTTP/1.1).  Servers SHOULD=
 ignore any
 cookies sent by a client.
=20
=20
-pkt-line Format
----------------
-
-Much (but not all) of the payload is described around pkt-lines.
-
-A pkt-line is a variable length binary string.  The first four bytes
-of the line indicates the total length of the line, in hexadecimal.
-The total length includes the 4 bytes used to denote the length.
-A line SHOULD BE terminated by an LF, which if present MUST be
-included in the total length.
-
-A pkt-line MAY contain binary data, so implementors MUST ensure all
-pkt-line parsing/formatting routines are 8-bit clean.  The maximum
-length of a pkt-line's data is 65532 bytes (65536 - 4).
-
-Examples (as C-style strings):
-
-  pkt-line          actual value
-  ---------------------------------
-  "0006a\n"         "a\n"
-  "0005a"           "a"
-  "000bfoobar\n"    "foobar\n"
-  "0004"            ""
-
-A pkt-line with a length of 0 ("0000") is a special case and MUST
-be treated as a message break or terminator in the payload.
-
-
 General Request Processing
 --------------------------
=20
@@ -194,11 +166,9 @@ the default ref named 'HEAD'.
   info_refs        =3D  *( ref_record )
   ref_record       =3D  any_ref / peeled_ref
=20
-  any_ref          =3D  id HTAB name LF
-  peeled_ref       =3D  id HTAB name LF
-		      id HTAB name "^{}" LF
-  id               =3D  40*HEX
-
+  any_ref          =3D  obj-id HTAB refname LF
+  peeled_ref       =3D  obj-id HTAB refname LF
+		      obj-id HTAB refname "^{}" LF
=20
 Smart Clients
 ~~~~~~~~~~~~~
@@ -283,23 +253,7 @@ named 'HEAD' as the first ref.  The stream MUST in=
clude capability
 declarations behind a NUL on the first ref.
=20
   smart_reply      =3D  PKT-LINE("# service=3D$servicename" LF)
-		      ref_list
-		      "0000"
-  ref_list         =3D  empty_list / non_empty_list
-
-  empty_list       =3D  PKT-LINE(id SP "capabilities^{}" NUL cap_list =
LF)
-
-  non_empty_list   =3D  PKT-LINE(id SP name NUL cap_list LF)
-		      *ref_record
-
-  cap_list         =3D  *(SP capability) SP
-  ref_record       =3D  any_ref / peeled_ref
-
-  any_ref          =3D  PKT-LINE(id SP name LF)
-  peeled_ref       =3D  PKT-LINE(id SP name LF)
-		      PKT-LINE(id SP name "^{}" LF
-  id               =3D  40*HEX
-
+		      advertised-refs
=20
 Smart Service git-upload-pack
 ------------------------------
@@ -345,31 +299,9 @@ appear in the response obtained through ref discov=
ery.
=20
   have_list        =3D  *PKT-LINE("have" SP id LF)
=20
-  command          =3D  create / delete / update
-  create           =3D  40*"0" SP new_id SP name
-  delete           =3D  old_id SP 40*"0" SP name
-  update           =3D  old_id SP new_id SP name
-
 TODO: Document this further.
 TODO: Don't use uppercase for variable names below.
=20
-Capability include-tag
-~~~~~~~~~~~~~~~~~~~~~~
-
-When packing an object that an annotated tag points at, include the
-tag object too.  Clients can request this if they want to fetch
-tags, but don't know which tags they will need until after they
-receive the branch data.  By enabling include-tag an entire call
-to upload-pack can be avoided.
-
-Capability thin-pack
-~~~~~~~~~~~~~~~~~~~~
-
-When packing a deltified object the base is not included if the base
-is reachable from an object listed in the COMMON set by the client.
-This reduces the bandwidth required to transfer, but it does slightly
-increase processing time for the client to save the pack to disk.
-
 The Negotiation Algorithm
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 The computation to select the minimal pack proceeds as follows
@@ -523,9 +455,9 @@ the id obtained through ref discovery as old_id.
   cap_list         =3D  *(SP capability) SP
=20
   command          =3D  create / delete / update
-  create           =3D  40*"0" SP new_id SP name
-  delete           =3D  old_id SP 40*"0" SP name
-  update           =3D  old_id SP new_id SP name
+  create           =3D  zero-id SP new_id SP refname
+  delete           =3D  old_id SP zero-id SP refname
+  update           =3D  old_id SP new_id SP refname
=20
 TODO: Document this further.
=20
@@ -536,4 +468,7 @@ References
 link:http://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Lo=
cators (URL)]
 link:http://www.ietf.org/rfc/rfc2119.txt[RFC 2119: Key words for use i=
n RFCs to Indicate Requirement Levels]
 link:http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer =
Protocol -- HTTP/1.1]
+link:technical/pack-protocol.txt
+link:technical/protocol-common.txt
+link:technical/protocol-capabilities.txt
=20
--=20
1.8.4.rc4.527.g303b16c
