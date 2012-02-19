From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC v2] Document format of basic Git objects
Date: Sun, 19 Feb 2012 11:15:46 +0700
Message-ID: <1329624946-32173-1-git-send-email-pclouds@gmail.com>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 05:17:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyyD2-0007yZ-Bv
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 05:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab2BSEQj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Feb 2012 23:16:39 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46045 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab2BSEQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 23:16:38 -0500
Received: by pbcun15 with SMTP id un15so5146860pbc.19
        for <git@vger.kernel.org>; Sat, 18 Feb 2012 20:16:37 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.135.134 as permitted sender) client-ip=10.68.135.134;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.135.134 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.135.134])
        by 10.68.135.134 with SMTP id ps6mr48146765pbb.66.1329624997567 (num_hops = 1);
        Sat, 18 Feb 2012 20:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IEoP7Ex9/6uoO4ngJoVXzByVXLgCOvMXq5tPOlFCroY=;
        b=gO4YI7JtPSRJvjyPkyBFHQH/KLBs9H+1ntt+HWCKMSY4a8iRuFqrQW329qxZlS5D1H
         VUrWCsNjIOd+hL5+DukS5YEYO9enqZdAIb8albtb/K9uhDcziEn/0pUwQxK8h6v1mdDO
         ETB/WbWuIRpAVKHBE3CcVCx4etnOb8E6wdGcY=
Received: by 10.68.135.134 with SMTP id ps6mr39565074pbb.66.1329624997420;
        Sat, 18 Feb 2012 20:16:37 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.53.120])
        by mx.google.com with ESMTPS id t10sm21051964pbb.18.2012.02.18.20.16.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Feb 2012 20:16:35 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 19 Feb 2012 11:15:47 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191017>

Still draft for discussion. Of three people who participated on this
thread, two favor a man page (me and Jonathan), one techincal/
(Junio), so let's put it as a man page for now.

Some notes:

 - I'm tempted to include pack-format.txt because I also document
   loose object format here. If it's included and
   gitrepository-layout.txt links to this, we have a quite complete
   documentation of what's inside $GIT_DIR (assuming rebase-apply and
   such are of private use)

 - Not sure if we fix the order of gpgsig and mergetag, or they can be
   mixed together. Also not sure if we can have multiple gpgsig, I
   haven't checked the code.

 - I skipped the experimental loose object format (it's what it's
   called in sha1_file.c). I think we can call it deprecated and move
   on.

 - Do we assume tag/commit header in utf-8 or ascii?

 - We don't do any encoding on ident strings, right?

Mostly-written-by: Jonathan Nieder <jrnieder@gmail.com>
Mostly-written-by: Junio C Hamano <gitster@pobox.com>
Remaining-stolen-from: Documentation/user-manual.txt
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-object.txt |  273 ++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 273 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-object.txt

diff --git a/Documentation/git-object.txt b/Documentation/git-object.tx=
t
new file mode 100644
index 0000000..359af37
--- /dev/null
+++ b/Documentation/git-object.txt
@@ -0,0 +1,273 @@
+git-object(5)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-object - Git object format
+
+SYNOPSIS
+--------
+$GIT_DIR/objects/*
+
+OBJECT ON-DISK REPRESENTATIONS
+------------------------------
+Objects can be stored on disk as loose (unpacked) objects or
+in packs. Loose objects are in $GIT_DIR/objects/[0-9a-f][0-9a-f]
+directories. Packs are $GIT_DIR/objects/pack/pack-*.pack. Each pack
+has a corresponding index file to speed up pack access.
+
+Object SHA-1
+~~~~~~~~~~~~
+An object SHA-1 is calculated on its header and payload. The content
+to be consumed by SHA-1 calculation is:
+
+- Object type in ascii, either "commit", "tree", "tag" or "blob"
+  (without quotes)
+- One space (ASCII SP)
+- The payload length in ascii canonical decimal format
+- ASCII NUL
+- Object payload
+
+Loose objects
+~~~~~~~~~~~~~
+Loose objects are simply a compressed form using zlib(3) of the
+object's header and payload, as described in Object SHA-1 section
+above.
+
+Packed objects
+~~~~~~~~~~~~~~
+FIXME maybe include Documentation/pack-format.txt
+
+BLOB OBJECTS
+------------
+Blob object payload is file data.
+
+TREE OBJECTS
+------------
+Tree object payload contains a list of entries, each with a mode,
+object type, object name, and filename, sorted by filename. It
+represents the contents of a single directory tree.
+
+The object type may be a blob, representing the contents of a file,
+another tree, representing the contents of a subdirectory, or a commit
+(representing a subproject). Since trees and blobs, like all other
+objects, are named by a hash of their contents, two trees have the
+same object name if and only if their contents (including,
+recursively, the contents of all subdirectories) are identical. This
+allows git to quickly determine the differences between two related
+tree objects, since it can ignore any entries with identical object
+names.
+
+Note that the files all have mode 644 or 755: git actually only pays
+attention to the executable bit.
+
+Encoding
+~~~~~~~~
+Entries are of variable length and self-delimiting. Each entry
+consists of
+
+- a POSIX file mode in octal ascii representation, no 0 padding to the
+  left
+- exactly one space (ASCII SP)
+- filename for the entry, as a NUL-terminated string
+- 20-byte binary object name
+
+The mode should be 100755 (executable file), 100644 (regular file),
+120000 (symlink), 40000 (subdirectory), or 160000 (subproject), with
+no leading zeroes. Modes with one leading zero and the synonym 100664
+for 100644 are also accepted for historical reasons. Other modes are
+not accepted.
+
+The filename may be an arbitrary nonempty string of bytes, as long as
+it contains no '/' or NUL character.
+
+The associated object must be a valid blob if the mode indicates a
+file or symlink, tree if it indicates a subdirectory, or commit if it
+indicates a subproject. The blob associated to a symlink entry
+indicates the link target and its content not have any embedded NULs.
+
+Sorting
+~~~~~~~
+Entries are sorted by memcmp(3) on file name. No duplicate file names
+allowed.
+
+COMMIT OBJECT
+-------------
+The commit object links a physical state of a tree with a description
+of how we got there and why. Commit object payload contains the
+associated tree SHA-1, parent commits's SHA-1, author and comitter
+information.
+
+------------------------------------------------
+$ git cat-file commit 81d48f0aee54
+tree 093f37084c133795e4ce71befa57185328737171
+parent f5e4e20faa1eee3feaa0394897bbd1aca544e809
+parent 661db794eb8179c7bea02f159bb691a2fff4a8e0
+parent 14c173eb63432ba5d0783b6c4b23a8fe0c76fb0f
+author Linus Torvalds <torvalds@linux-foundation.org> 1326576355 -0800
+committer Linus Torvalds <torvalds@linux-foundation.org> 1326576355 -0=
800
+mergetag object 661db794eb8179c7bea02f159bb691a2fff4a8e0
+ type commit
+ tag devicetree-for-linus
+ tagger Grant Likely <grant.likely@secretlab.ca> 1326520038 -0700
+=20
+ 2nd set of device tree changes for v3.3
+ -----BEGIN PGP SIGNATURE-----
+ Version: GnuPG v1.4.11 (GNU/Linux)
+=20
+ iQIcBAABAgAGBQJPERbzAAoJEEFnBt12D9kBmDIP/R9Vspc6yhjSAEvdp/VET2gi
+ TgAQfdp4VuYjjIt4cUPO5UQU9kw478GjTuP2blZEC9DlG1jSf/L8U+A7FHJIVVzU
+ QfjwV1Lqaqk+sQQ1bsp2ixbesKECmqU9IweOIFmn0U2ZD+xlPFIpE2iTKEqymejf
+ PVZsFlkVmhQZgudPNieyZMjQpQ9hEb6UcSfXT//nmoRRxCL/PiMHGRx3UdS3eRe7
+ FApSW0Mty/PD07QXPsDjg1GvK59Gf6R1/4Bd31+rXEz9yaxf4I4I02fL553NDVIt
+ tAPfo/4YKW1rLMWQRkAUqCaMk9v/DWxeWYbbiJNZ2R3kys9o8k26XXxvcuYnecS2
+ G8DDJpmOikbN3Gvlskh40Tn3TJb5Wlgc7o/10L/fq6FovS4Uk7yUeFMqXUYfl8TU
+ ziIlrlt9IGabXBN4JKJl3OabgkeO+Oz9DKhTQFJLY4/121LAtFVk3xd316mY+wpX
+ mI83VmWMlp3sK+OLr+UdMTCXZvSIpu3KlGKMpAssHKUKxIV20NHLFNbm94/ywXBn
+ Zb8arjcv7+WzwhSqQJj851cq4/sEYx5HB4wU5Nm5SXBwcO3ixiij6lHCoHU+NudR
+ eyPIFLfrzwnUu3yTRgUfAnkgOce+2I+vUsU4pXUR6FyK73wSmm0+4WXQfB+OBlwD
+ 2O1RjZedZCb6zzf17H2k
+ =3Dmup8
+ -----END PGP SIGNATURE-----
+mergetag object 14c173eb63432ba5d0783b6c4b23a8fe0c76fb0f
+ type commit
+ tag spi-for-linus
+ tagger Grant Likely <grant.likely@secretlab.ca> 1326520366 -0700
+=20
+ SPI bug fixes for v3.3
+ -----BEGIN PGP SIGNATURE-----
+ Version: GnuPG v1.4.11 (GNU/Linux)
+=20
+ iQIcBAABAgAGBQJPERgyAAoJEEFnBt12D9kBRMsP/RBv6kWIb/qD7yJhrdbzJ4Tv
+ 1f7coSytuHupZVpxJstELKPugRmp2R6YeFbKw8P4P/12233Q0FcdKTF6ZE2h3cBp
+ bfCtyyzlFeY/nMfJKkwh37x2fHxNHynCCJEjHhecLday7NKQoTmmafivTfVmolWK
+ /MGjDarTAzC1FaP1xpBnuiI8eCr5WIgb4WmtvOmxIntVT077xggdJLL/Co7fBCqn
+ iibz3U/VyC68kQTGw6ELhnW1d7doHp7H3DJ2gPsh6lzpbv8JAnOMPpD+3Me1DVHE
+ Ay0kxPHV4bqnDyB+uEGppUiNoaTd5InrMAw+udDad60TMwOZzIvMkgxo0PIVM9Mm
+ k6mCcE2+TSnJetueX3cfrS5bRTPxUX7KRDC/WSp67/QPmelbYeRDLR7hrrQVqOPq
+ 5hIKMfz/kTBXcaXk643TEveaZlMuOZxHBYAvsbu5BX/3SQqYFS4POdxdeZVnUf54
+ ITHhftBtrXacCsjKujp0xmKCIpF+8v3yKRxGEQssByv8v+CaymNrEls2vTF8tn5P
+ sAIjPFJYG+IHtDMIsTHOvSPA7uwWYsOVHFEYsbC1758esiBD8+qtfvFS3jAH99z+
+ v2/aGsfMnjYEIsRtSm7PVTybJAo22Gr62yE/Q+rP//O0JaDahgdm009MjUo6BSgg
+ XNhZjQRYAYEExMTjJ2TK
+ =3Dq39P
+ -----END PGP SIGNATURE-----
+
+Merge tags 'devicetree-for-linus' and 'spi-for-linus' of git://git.sec=
retlab.ca/git/linux-2.6
+
+2nd set of device tree changes and SPI bug fixes for v3.3
+
+* tag 'devicetree-for-linus' of git://git.secretlab.ca/git/linux-2.6:
+  of/irq: Add interrupts-names property to name an irq resource
+  of/address: Add reg-names property to name an iomem resource
+
+* tag 'spi-for-linus' of git://git.secretlab.ca/git/linux-2.6:
+  spi/tegra: depend instead of select TEGRA_SYSTEM_DMA
+------------------------------------------------
+
+More precisely, a commit object begins with of one or more lines
+delimited by ASCII LF. The end of the header is signalled by an empty
+line. Any remaining text after the empty line forms the commit
+message. The header must not contain NUL.
+
+A "continuation line" in the header begins with an SP. The remainder
+of the line, after removing that SP, is concatenated to the previous
+line, while retaining the LF at the end of the previous line.
+
+When a line in the header begins with a letter other than SP, and has
+at least one SP in it, it is called a "field". A field consists of the
+"field name", which is the string before the first SP on the line, and
+its "value", which is everything after that SP. When the value
+consists of multiple lines, continuation lines are used.
+
+More than one field with the same name can appear in the header of an
+object, and the order in which they appear is significant. A commit
+object can contain these fields in the listed order:
+
+1. one "tree" field with the 40-character textual object name of the
+   associated tree object
+2. zero or more "parent" fields, each with 40-character textual object
+   name of the parent commit object
+3. one "author" field with an ident string
+4. one "committer" field with an ident string
+5. zero or one "encoding" field with an ascii string
+6. zero or more "mergetag" fields with associated tag object content
+7. zero or one "gpgsig" field with gpg signature content
+
+New kinds of fields may be added in later versions of git.
+
+Ident strings
+~~~~~~~~~~~~~
+Ident strings record who's responsible of doing something at what
+time. For a commit, the ident string in "author" line records who is
+the author of the associated changes and when the changes are
+made. The ident string in "committer" line records who commits the
+changes to the repository and at what time.
+
+An ident string consists of an email address and a timestamp. More
+precisely:
+
+1. Optionally, a name
+2. An email address wrapped around by `<` and `>`, followed by one
+   space (ASCII SP)
+3. The number of seconds since Epoch (00:00:00 UTC, January 1, 1970)
+   followed by a space (ASCII SP)
+4. Timezone: either plus or minus sign, followed by 4 decimal digits
+
+Name and email are encoded in UTF-8 and must must not contain ASCII
+NUL characters.
+
+Commit encoding
+~~~~~~~~~~~~~~~
+Encoding field describes that encoding that the commit message is
+encoded in. Encoding names must be recognized by iconv(3). By default,
+commit message is in UTF-8. It's discouraged to use encodings that can
+generate ASCII NUL characters.
+
+TAG OBJECTS
+-----------
+Tag object payload contains an object, object type, tag name, the name
+of the person ("tagger") who created the tag, and a message, which may
+contain a signature.
+
+------------------------------------------------
+$ git cat-file tag v1.5.0
+object 437b1b20df4b356c9342dac8d38849f24ef44f27
+type commit
+tag v1.5.0
+tagger Junio C Hamano <junkio@cox.net> 1171411200 +0000
+
+GIT 1.5.0
+-----BEGIN PGP SIGNATURE-----
+Version: GnuPG v1.4.6 (GNU/Linux)
+
+iD8DBQBF0lGqwMbZpPMRm5oRAuRiAJ9ohBLd7s2kqjkKlq1qqC57SbnmzQCdG4ui
+nLE/L9aUXdWeTFPron96DLA=3D
+=3D2E+0
+-----END PGP SIGNATURE-----
+------------------------------------------------
+
+Tag object format resembles commit format. A tag commit may have the
+following fields in listed order:
+
+1. one "object" field with 40-character textual object name of the
+   tagged object
+2. one "type" field with type of the tagged object ("commit", "tag",
+   "blob", or "tree")
+3. one "tag" field with the name of the tag
+4. one "tagger" with an ident string
+
+New kinds of fields may be added in later versions of git.
+
+Any remaining text after the header forms the tag message. Tag message
+has no specified encoding. Anything that does not contain ASCII NUL
+characters are accepted.
+
+The object field must point to a valid object of type indicated by the
+type field. The tag name can be an arbitrary string without NUL bytes
+or embedded newlines; in practice it usually follows the restrictions
+described in linkgit:git-check-ref-format[1].
+
+GIT
+---
+Part of the linkgit:git[1] suite
--=20
1.7.8.36.g69ee2
