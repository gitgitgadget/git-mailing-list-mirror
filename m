From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] make --max-pack-size argument to 'git pack-object'
 count in bytes
Date: Thu, 04 Feb 2010 09:11:10 -0800
Message-ID: <7vtytxexjl.fsf@alter.siamese.dyndns.org>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net>
 <1265255308-20514-3-git-send-email-nico@fluxnic.net>
 <20100204040046.GR14799@spearce.org>
 <7v7hqtty38.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 18:11:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd5Em-00048i-R0
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 18:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab0BDRLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 12:11:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205Ab0BDRLV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 12:11:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE18B9720B;
	Thu,  4 Feb 2010 12:11:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mlaSjEIOZzk06O06kKTD+3FRN0M=; b=xUrl0k
	FPue3cPQIbtId5TLXYMcNLxizVUN1ZThzF+YSvDnQJinCieKe0/ydJUFkrxSdrgw
	LlifhI4rTAc3K/DKCDKgvGzlRg2CWK8eKCtIEC2djirUk5h1+XA2LhOpOYMcA+Dj
	OdvzqwklWdiBdkHbZN66SEU/PMbx5KdPXAjJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HKtCM+KFlFrRKoq/Xts8q/HSAeQl4zN2
	nR3mGKkLVOxX21zstGLyL6cZEZsKXvPtIcVY+bvH3RGMV/Mu21+wetg4fhqYRuVv
	dwdNmF3TZX9+vB9CEmUm2T+KN7N8pOM9Jq7S9wYBvESvA4gdFneyi+2cgnWwhL4x
	ROj+4PW9ZdE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8101597208;
	Thu,  4 Feb 2010 12:11:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E6C797204; Thu,  4 Feb
 2010 12:11:12 -0500 (EST)
In-Reply-To: <7v7hqtty38.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 03 Feb 2010 20\:38\:03 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4DFECCF8-11B0-11DF-8492-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138981>

Junio C Hamano <gitster@pobox.com> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> ...
>> Shouldn't we also change fast-import.c ?
>
> Surely; could you do the honors?  I cannot really decide how big the deal
> would be to break backward compatibility for max-pack-size myself.

I'll queue the "fix mismerge" one I got "Yup, looks good to me." from you,
with this:

commit 76ea93ccb5df138eb57b2e8f2aee61dd1ca666ea
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Feb 3 18:27:08 2010 -0800

    fast-import.c: Fix big-file-threshold parsing bug
    
    Manual merge made at 844ad3d (Merge branch 'sp/maint-fast-import-large-blob'
    into sp/fast-import-large-blob, 2010-02-01) did not correctly reflect the change
    of unit in which this variable's value is counted from its previous version.
    
    Now it counts in bytes, not in megabytes.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    Acked-by: Shawn O. Pearce <spearce@spearce.org>

I am debating myself if we want to have another one (see below) on top; I
am not a heavy user of fast-import and I don't know if existing users will
be hurt by such a change and if so how much.

-- >8 --
Subject: [PATCH] fast-import: count --max-pack-size in bytes

Similar in spirit to 07cf0f2 (make --max-pack-size argument to 'git
pack-object' count in bytes, 2010-02-03) which made the option by the same
name to pack-objects, this counts the pack size limit in bytes.

In order not to cause havoc with people used to the previous megabyte
scale, and because this is a sane thing to do anyway, a minimum size of 1
MiB is enforced to avoid an explosion of pack files.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes-1.7.0.txt  |    8 ++++----
 Documentation/git-fast-import.txt |    4 ++--
 fast-import.c                     |   14 ++++++++------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/RelNotes-1.7.0.txt b/Documentation/RelNotes-1.7.0.txt
index e66945c..255666f 100644
--- a/Documentation/RelNotes-1.7.0.txt
+++ b/Documentation/RelNotes-1.7.0.txt
@@ -46,10 +46,10 @@ Notes on behaviour change
    environment, and diff.*.command and diff.*.textconv in the config
    file.
 
- * The --max-pack-size argument to 'git repack' and 'git pack-objects' was
-   assuming the provided size to be expressed in MiB, unlike the
-   corresponding config variable and other similar options accepting a size
-   value.  It is now expecting a size expressed in bytes, with a possible
+ * The --max-pack-size argument to 'git repack', 'git pack-objects', and
+   'git fast-import' was assuming the provided size to be expressed in MiB,
+   unlike the corresponding config variable and other similar options accepting
+   a size value.  It is now expecting a size expressed in bytes, with a possible
    unit suffix of 'k', 'm', or 'g'.
 
 Updates since v1.6.6
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 2691114..6764ff1 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -44,8 +44,8 @@ OPTIONS
 	not contain the old commit).
 
 --max-pack-size=<n>::
-	Maximum size of each output packfile, expressed in MiB.
-	The default is 4096 (4 GiB) as that is the maximum allowed
+	Maximum size of each output packfile.
+	The default is 4 GiB as that is the maximum allowed
 	packfile size (due to file format limitations). Some
 	importers may wish to lower this, such as to ensure the
 	resulting packfiles fit on CDs.
diff --git a/fast-import.c b/fast-import.c
index a6730d0..09c0817 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2764,11 +2764,6 @@ static void option_date_format(const char *fmt)
 		die("unknown --date-format argument %s", fmt);
 }
 
-static void option_max_pack_size(const char *packsize)
-{
-	max_packsize = strtoumax(packsize, NULL, 0) * 1024 * 1024;
-}
-
 static void option_depth(const char *depth)
 {
 	max_depth = strtoul(depth, NULL, 0);
@@ -2798,7 +2793,14 @@ static void option_export_pack_edges(const char *edges)
 static int parse_one_option(const char *option)
 {
 	if (!prefixcmp(option, "max-pack-size=")) {
-		option_max_pack_size(option + 14);
+		unsigned long v;
+		if (!git_parse_ulong(option + 14, &v))
+			return 0;
+		if (v < 1024 * 1024) {
+			warning("minimum max-pack-size is 1 MiB");
+			v = 1024 * 1024;
+		}
+		max_packsize = v;
 	} else if (!prefixcmp(option, "big-file-threshold=")) {
 		unsigned long v;
 		if (!git_parse_ulong(option + 19, &v))
-- 
1.7.0.rc1.199.g9253ab
