From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=5D=20Update=20documentation=20for=20stripspace?=
Date: Mon, 12 Dec 2011 14:28:29 -0800
Message-ID: <1323728909-7847-1-git-send-email-conrad.irwin@gmail.com>
References: <7vy5ui5h0k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Conrad Irwin <conrad.irwin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 23:28:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaEMY-0005TU-9g
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 23:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480Ab1LLW2k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 17:28:40 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33111 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233Ab1LLW2j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 17:28:39 -0500
Received: by iaeh11 with SMTP id h11so3787420iae.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 14:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Tr7AW13jlG0SaRvAJz3PQ57a7f1g+1FXurJ4Y/Wfmpg=;
        b=b6OLyhWFvWMlVtKq+shjdE/nr85x3HzPiqj6CShX06G9jhrvz2hB4ZimN0qZAGO+Md
         9Ku0aesdgWfobyWu9ey5/V2oOw2dIiEbr7tuC4AOlMe+J82nCReAeM9KdSTboC8Guf0e
         D5PAD12OEuKzeahRuR8r6aQMKwCwBR9op5SmE=
Received: by 10.50.242.1 with SMTP id wm1mr17271778igc.30.1323728918921;
        Mon, 12 Dec 2011 14:28:38 -0800 (PST)
Received: from monteverdi.rapportive.com (173-228-114-254.static.sonic.net. [173.228.114.254])
        by mx.google.com with ESMTPS id j3sm55960210ibj.1.2011.12.12.14.28.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 14:28:36 -0800 (PST)
X-Mailer: git-send-email 1.7.8.164.g00d7e
In-Reply-To: <7vy5ui5h0k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186964>

On Sun, Dec 11, 2011 at 10:41 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Conrad Irwin <conrad.irwin@gmail.com> writes:
>
> The original says "remove" and new one says "normalize*s*". I think w=
e
> tend to say things in imperative mood (i.e. without the trailing "s")=
=2E

Good point, fixed.

>
> I do not think 'user-provided metadata' is a good wording. This is ju=
st a
> simple text clean-up filter and you can use it to clean your text fil=
es
> that you mean to store in the repository as well.

Changed just to "text", as that seems simpler. I've left the example
uses as is, they were the prime reason for that sentence existing.

>
> The last one is a bit funny, though.
>
> By definition, you cannot end the last line with more than one '\n' (=
upon
> seeing the second '\n', you would realize immediately that the line y=
ou
> saw was _not_ the last line). I think you meant the file does not end=
 with
> an incomplete line, i.e. "ensures the output does not end with an
> incomplete line by adding '\n' at the end if needed".

Hmm, I'm not sure that's the best way of describing it =E2=80=94 I've g=
one with:
"add a missing '\n' to the last line if necessary.".

>
>> +In the case where the input consists entirely of whitespace charact=
ers, no
>> +output will be produced.
>> +
>> +*NOTE*: This is intended for cleaning metadata, prefer the `--white=
space=3Dfix`
>> +mode of linkgit:git-apply[1] for correcting whitespace of patches o=
r files in
>> +the repository.
>
> I can tell that these three lines were the _primary_ thing you wanted=
 to
> add with this patch, having never seen anybody got confused between t=
he
> whitespace breakage fix and text cleaning, I wonder if this is adding
> clarity or giving users an impression that git can do too many things=
 than
> they can wrap their mind around and forcing them to wonder if they ha=
ve to
> learn everything git can do for them.

The motivation for this patch was an old post to the Cairo mailing list
[1]. There they were using (previously undocumented) behaviour of
git stripspace, instead of git apply --whitespace=3Dfix (it may be that
--whitespace=3Dfix didn't exist at that point?).

I've moved the *NOTE* into a SEE ALSO section where I think it reads
less opinionatedly =E2=80=94 is that better?

>
>> =C2=A0OPTIONS
>> =C2=A0-------
>> =C2=A0-s::
>> =C2=A0--strip-comments::
>> - =C2=A0 =C2=A0 In addition to empty lines, also strip lines startin=
g with '#'.
>> + =C2=A0 =C2=A0 Also remove all lines starting with '#'.
[snip]
>
> If I were touching this description, I probably would say something l=
ike
> "Treat lines starting with a '#' as if they are empty lines".
>

If only it were that simple! If you have a commented line between two
non-commented lines, then no empty line results. I've added an example
to the re-rolled patch that show-cases the behaviour of comment
stripping in both cases. I went with "skip and remove" as the verb, to
imply that the lines are ignored by the previous transformations.

Thanks for the detailed feedback.

Conrad

[1] http://lists.freedesktop.org/archives/cairo/2006-June/007062.html

----8<----

Tell the user what this command is intended for, and expand the
description of what it does.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 Documentation/git-stripspace.txt |   69 ++++++++++++++++++++++++++++++=
++++---
 builtin/stripspace.c             |    2 +-
 2 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-stripspace.txt b/Documentation/git-strip=
space.txt
index b78f031..a0a6ea4 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -3,26 +3,83 @@ git-stripspace(1)
=20
 NAME
 ----
-git-stripspace - Filter out empty lines
+git-stripspace - Remove unnecessary whitespace
=20
=20
 SYNOPSIS
 --------
 [verse]
-'git stripspace' [-s | --strip-comments] < <stream>
+'git stripspace' [-s | --strip-comments] < input
=20
 DESCRIPTION
 -----------
-Remove multiple empty lines, and empty lines at beginning and end.
+
+Clean the input in the manner used by 'git' for text such as commit
+messages, notes, tags and branch descriptions.
+
+With no arguments, this will:
+
+- remove trailing whitespace from all lines
+- collapse multiple consecutive empty lines into one empty line
+- remove blank lines from the beginning and end of the input
+- add a missing '\n' to the last line if necessary.
+
+In the case where the input consists entirely of whitespace characters=
, no
+output will be produced.
=20
 OPTIONS
 -------
 -s::
 --strip-comments::
-	In addition to empty lines, also strip lines starting with '#'.
+	Skip and remove all lines starting with '#'.
+
+EXAMPLES
+--------
+
+Given the following noisy input with '$' indicating the end of a line:
+
+--------
+|A brief introduction   $
+|   $
+|$
+|A new paragraph$
+|# with a commented-out line    $
+|explaining lots of stuff.$
+|$
+|# An old paragraph, also commented-out. $
+|      $
+|The end.$
+|  $
+---------
+
+Use 'git stripspace' with no arguments to obtain:
+
+--------
+|A brief introduction$
+|$
+|A new paragraph$
+|# with a commented-out line$
+|explaining lots of stuff.$
+|$
+|# An old paragraph, also commented-out.$
+|$
+|The end.$
+---------
=20
-<stream>::
-	Byte stream to act on.
+Use 'git stripspace --strip-comments' to obtain:
+
+--------
+|A brief introduction$
+|$
+|A new paragraph$
+|explaining lots of stuff.$
+|$
+|The end.$
+---------
+
+SEE ALSO
+--------
+The `--whitespace=3Dfix` mode of linkgit:git-apply[1].
=20
 GIT
 ---
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 1288ffc..f16986c 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -75,7 +75,7 @@ int cmd_stripspace(int argc, const char **argv, const=
 char *prefix)
 				!strcmp(argv[1], "--strip-comments")))
 		strip_comments =3D 1;
 	else if (argc > 1)
-		usage("git stripspace [-s | --strip-comments] < <stream>");
+		usage("git stripspace [-s | --strip-comments] < input");
=20
 	if (strbuf_read(&buf, 0, 1024) < 0)
 		die_errno("could not read the input");
--=20
1.7.8.164.g00d7e
