From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitignore broken in git 1.7.0.1: slash checks leading dirs
Date: Fri, 5 Mar 2010 09:12:48 -0600
Message-ID: <20100305151248.GA24748@progeny.tock>
References: <4B90C701.3070308@gmail.com>
 <4B90C974.2050405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiri Slaby <jirislaby@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 05 16:12:45 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnZCm-0007eW-Oj
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 16:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570Ab0CEPMj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Mar 2010 10:12:39 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:40475 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895Ab0CEPMi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 10:12:38 -0500
Received: by pzk32 with SMTP id 32so1408600pzk.4
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 07:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BU98EE9TLzl0GUwcjRnUwavv/X2Lul/aHMRUFxhWjNY=;
        b=U90EBML5DEVU7jTXejeYwA4sytpg4eHTd936PD5mpIBj6PZ0eXhMzx415tSdMwn/8F
         qwGZUvbJsZtTfTyelLlmUjgyBlgMYhStpWxezVo6ari/i8fG/Ss5Ul9Zr43X702KhGG5
         lcrds0a20bqqVEZgZy9rKeU81ekXrssBBCKr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=V0qWJjFBmVlY0xGrQDloXT5qDjrbhC2McftZXp5C6j36nR4FZlHGmF8FzrdIYENUxw
         wcg7sJUE7dfTZZv47h+azaQGlleH2jEgs9RYjO7/tb5spRvEd3mOgIOUIE0X8JddQ67+
         9pp1VWmx4b0maSqEi9lKW+cYXrzLMLKbHSDuI=
Received: by 10.141.12.20 with SMTP id p20mr685214rvi.90.1267801958184;
        Fri, 05 Mar 2010 07:12:38 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1501484iwn.4.2010.03.05.07.12.37
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 07:12:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B90C974.2050405@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141581>

Johannes Sixt wrote:
> Jiri Slaby schrieb:

>> having 'linux' line in .gitignore makes 'include/linux/vga_switchero=
o.h'
>> to be ignored
>
> That's the behavior that I would expect.
>
>> though the documentation says:
>> ***
>> If the pattern does not contain a slash /, git treats it as a shell
>> glob pattern and checks for a match against the pathname without
>> leading directories.
>> ***
>
> and this citation confirms my expectation. Note that it says "pathnam=
e",
> not "filename". 'include/linux' is a "pathname".

It would be more precise to say this citation does not have much to do
with it.  'include/linux' contains a slash, so that paragraph does not
describe what it means.

The next paragraph is more on point:

 =B7 Otherwise, git treats the pattern as a shell glob suitable for
   consumption by fnmatch(3) with the FNM_PATHNAME flag: wildcards in t=
he
   pattern will not match a / in the pathname. For example,
   "Documentation/*.html" matches "Documentation/git.html" but not
   "Documentation/ppc/ppc.html". A leading slash matches the beginning =
of
   the pathname; for example, "/*.c" matches "cat-file.c" but not
   "mozilla-sha1/sha1.c".

The relevant sentence is the last one, and I can see how the length of =
the
paragraph might be daunting.  Maybe splitting it up would help?

 =B7 Otherwise, git treats the pattern as a shell glob suitable for
   consumption by fnmatch(3) with the FNM_PATHNAME flag: wildcards in t=
he
   pattern will not match a / in the pathname. For example,
   "Documentation/*.html" matches "Documentation/git.html" and
   "tools/perf/Documentation/perf-diff.html" but not
   "Documentation/ppc/ppc.html".

 =B7 A leading slash matches the beginning of the pathname; for example=
,
   "/*.c" matches "cat-file.c" but not "mozilla-sha1/sha1.c".

Not sure.

Jonathan

-- %< --
Subject: gitignore.5: Clarify that path matches are not anchored

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/gitignore.txt |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 98c459d..fa15422 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -89,10 +89,13 @@ Patterns have the following format:
    for consumption by fnmatch(3) with the FNM_PATHNAME flag:
    wildcards in the pattern will not match a / in the pathname.
    For example, "Documentation/\*.html" matches
-   "Documentation/git.html" but not
-   "Documentation/ppc/ppc.html".  A leading slash matches the
-   beginning of the pathname; for example, "/*.c" matches
-   "cat-file.c" but not "mozilla-sha1/sha1.c".
+   "Documentation/git.html" and
+   "tools/perf/Documentation/perf-diff.html" but not
+   "Documentation/ppc/ppc.html".
+
+ - A leading slash matches the beginning of the pathname;
+   for example, "/*.c" matches "cat-file.c" but not
+   "mozilla-sha1/sha1.c".
=20
 An example:
=20
--=20
1.7.0
