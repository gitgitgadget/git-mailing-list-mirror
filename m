From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] compat/regex: define out variables only used under RE_ENABLE_I18N
Date: Thu, 19 Aug 2010 18:30:01 +0000
Message-ID: <1282242601-2630-1-git-send-email-avarab@gmail.com>
References: <201008191805.o7JI5Aw0002340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Aharon Robbins <arnold@skeeve.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 19 20:30:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om9sa-0008FS-74
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 20:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398Ab0HSSaK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 14:30:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52400 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab0HSSaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 14:30:08 -0400
Received: by fxm13 with SMTP id 13so1298754fxm.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Q8i2P9XZAgAaYjdqh6tsVYID7wt/0aJmV+FOPeaDXSk=;
        b=ukbi3/dMdKE4ANTKCRA6nJ3KYlfJ2Lj14qLTejFuuPuPvWLzL39HdYbxCQHaHptQkx
         GqlGn5/HKtoXXo6rP4kuoKAnzmA3mwg1NUmoB/8Rj0oDjVeAog1dlAT20+0gVO42g68L
         ZcaDkUocSzh60Wd3rqYdSWFo15df3AMoSiorQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UCe+LNyTGxTholVSR7CZ27/oPbK3VAW9op50f+AxTyzAj0FPErvy9WxhD7tLrE74rQ
         JDLeHdM+ZEbPiKjUQfWn08MD18S0fhT+rmai34ez6h5FVXAWulqfjTJSQ19T5GVkD8c7
         9pUTSqJ6XkcB+pKP0diptH/nEOe1+Bq6oJhfs=
Received: by 10.216.59.148 with SMTP id s20mr1016135wec.41.1282242606978;
        Thu, 19 Aug 2010 11:30:06 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w1sm1230350weq.25.2010.08.19.11.30.05
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 11:30:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.446.g168052
In-Reply-To: <201008191805.o7JI5Aw0002340@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153947>

Wrap variables that were only used RE_ENABLE_I18N in `#ifdef
RE_ENABLE_I18N`. This eliminates compiler warnings when compiling with
NO_REGEX=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Thu, Aug 19, 2010 at 18:05, Aharon Robbins <arnold@skeeve.com> wrote=
:
> Hi! Re this:
>
>> Date: Thu, 19 Aug 2010 13:16:56 +0000
>> Subject: Fwd: What's cooking in git.git (Aug 2010, #04; Wed, 18)
>> From: ??var Arnfj??r?? Bjarmason <avarab@gmail.com>
>> To: "Arnold D. Robbins" <arnold@skeeve.com>
>>
>> Hi there. The Git project grabbed the gawk regex engine to use as a
>> compat engine in case the platform we're working on doesn't support
>> REG_STARTEND. But because we don't compile it with RE_ENABLE_I18N
>> it'll spew some warnings about unused variables (see below). Here's =
a
>> patch to solve this:
>
> Wow! It's really cool to be upstream for someone else. :-)

Cool that someone else is teasing useful code out of glibc so I don't
have to :)

> Thanks for the patch. I'll get it into my code base.

Junio, here's a version of this patch for our tree.

>> I was going to report this upstream once I got around to finding out
>> what upstream *is*, I don't *think* gawk itself is the canonical
>> upstream, they just copy it from somewhere else (again, I *think*).
>
> About every year or so, I sync from whatever is in GLIBC. =C2=A0But m=
y version
> has a number of additional fixes that have not been accepted back int=
o
> the GLIBC version.
>
> The only other possible candidate for an "upstream" source would be t=
he
> version in gnulib.

That's good to know. B.t.w. we have to compile with -DNO_MBSUPPORT
because regex_internal.h will pull in mbsupport.h if it's defined,
which is a GPLv3 header, the rest being LGPL 2.1.

I don't even know if we want mbsupport.h, but if it's possible to
relicense mbsupport.h to LGPL 2.1 it'd be easier for projects like Git
to pull in the gawk regex engine.

 compat/regex/regex_internal.c |    2 +-
 compat/regex/regexec.c        |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_interna=
l.c
index dad17a8..193854c 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -692,10 +692,10 @@ re_string_reconstruct (re_string_t *pstr, int idx=
, int eflags)
 	}
       else
 	{
+#ifdef RE_ENABLE_I18N
 	  /* No, skip all characters until IDX.  */
 	  int prev_valid_len =3D pstr->valid_len;
=20
-#ifdef RE_ENABLE_I18N
 	  if (BE (pstr->offsets_needed, 0))
 	    {
 	      pstr->len =3D pstr->raw_len - idx + offset;
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index aee502d..0c2b054 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -3059,7 +3059,9 @@ check_arrival_add_next_nodes (re_match_context_t =
*mctx, int str_idx,
   const re_dfa_t *const dfa =3D mctx->dfa;
   int result;
   int cur_idx;
+#ifdef RE_ENABLE_I18N
   reg_errcode_t err =3D REG_NOERROR;
+#endif
   re_node_set union_set;
   re_node_set_init_empty (&union_set);
   for (cur_idx =3D 0; cur_idx < cur_nodes->nelem; ++cur_idx)
--=20
1.7.2.1.446.g168052
