From: Stuart Rackham <srackham@methods.co.nz>
Subject: Re: asciidoc 7--8 compatibility (was Re: pull-fetch-param.txt)
Date: Thu, 05 Oct 2006 10:06:53 +1300
Message-ID: <4524226D.5000305@methods.co.nz>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>	<7vhcymt07a.fsf@assigned-by-dhcp.cox.net>	<452211C2.8020402@s5r6.in-berlin.de>	<7vven1rfpj.fsf@assigned-by-dhcp.cox.net>	<45222B18.1090305@s5r6.in-berlin.de> <7v64f1np8i.fsf@assigned-by-dhcp.cox.net> <4522E66B.4080103@methods.co.nz> <4523E401.5080709@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000801060307050600080101"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 04 23:07:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVDxV-0004km-9s
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 23:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWJDVHO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 17:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWJDVHN
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 17:07:13 -0400
Received: from fep01.xtra.co.nz ([210.54.141.245]:36959 "EHLO fep01.xtra.co.nz")
	by vger.kernel.org with ESMTP id S1751128AbWJDVHL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Oct 2006 17:07:11 -0400
Received: from falcon.methods.co.nz ([219.89.35.210]) by fep01.xtra.co.nz
          with ESMTP
          id <20061004210702.WJHE14162.fep01.xtra.co.nz@falcon.methods.co.nz>;
          Thu, 5 Oct 2006 10:07:02 +1300
Received: from [192.168.1.6] (quark.methods.co.nz [192.168.1.6])
	by falcon.methods.co.nz (Postfix) with ESMTP id 6C663278715;
	Thu,  5 Oct 2006 10:06:58 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <4523E401.5080709@s5r6.in-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28331>

This is a multi-part message in MIME format.
--------------000801060307050600080101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stefan

Stefan Richter wrote:
> Stuart Rackham wrote:
>> From the AsciiDoc User Guide
>> (http://www.methods.co.nz/asciidoc/userguide.html#X53):
>>
>> If you want to disable unconstrained quotes, the new alternative
>> constrained quotes syntax and the new index entry syntax then you can
>> define the attribute asciidoc7compatible (for example by using the -a
>> asciidoc7compatible command-line option).
> 
> Stuart,
> 
> the actual issues were:
> 
> 1.) Input which works with asciidoc 7 fails to build with asciidoc 8
> (after the intermediary XML step). This pair of tildes broke (but other
> occurences of tilde did not):
> 
> | * A suffix '~<n>' to a revision parameter means the commit
> |   object that is the <n>th generation grand-parent of the named
> |   commit object, following only the first parent.  I.e. rev~3 is

I've conditionally redefined subscript (tilde) and superscripting so 
they use the old replacements mechanism when asciidoc7compatible is 
defined rather than the asciidoc 8 default unconstrained quoting (patch 
for affected files attached).


> 
> 2.) Asciidoc 8 silently swallows characters from input which works with
> asciidoc 7. The two pluses in the following line vanished (but instances
> of single pluses per input line did not vanish):
> 
> | 	`+?<src>:<dst>`; that is, an optional plus `+`, followed

Fixed by asciidoc7compatible.


> 
> I wonder:
> 
>  - Are tilde and plus new special characters in asciidoc 8, or were they
> already special characters in asciidoc 7?
>        [ A pair of single pluses encloses monospaced text in asciidoc 8.
>          A pair of single tildes encloses subscripts. ]
> 
>  - If they were already special characters in asciidoc 7, what is the
> canonical way to escape them in asciidoc 7, 8, and hopefully 9?
>        [ If they weren't special characters in asciidoc 7, then we need
>          to use the asciidoc7compatible attribute. ]
> 
>  - Does asciidoc 7 accept the asciidoc7compatible attribute?

No.


> 
> Thanks.
> 
> 
> PS:
> 
> Junio, Stuart, here is another inconsistency between asciidoc 7 and 8.
> Please have a look at
> http://www.kernel.org/pub/software/scm/git/docs/git-rev-parse.html .
> See the ASCII art above "SPECIFYING RANGES". The input
>        \  |  / \
>         \ | /   |
> produced
>    \  |  /         \ | /   |
> I.e. backslash-newline was interpreted by asciidoc 7 (or whatever you
> use to generate what is put online) as an escaped thus swallowed
> newline. But the output that I got here from asciidoc 8 (manpage as well
> as the html file) still has backslash and newline printed out.


Cheers, Stuart

--------------000801060307050600080101
Content-Type: text/plain;
 name="asciidoc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asciidoc.patch"

Index: asciidoc.conf
===================================================================
--- asciidoc.conf	(revision 53)
+++ asciidoc.conf	(working copy)
@@ -62,9 +62,9 @@
 __=#emphasis
 ++=#monospaced
 \##=#unquoted
-endif::asciidoc7compatible[]
 ^=#superscript
 ~=#subscript
+endif::asciidoc7compatible[]
 
 [specialwords]
 emphasizedwords=
Index: xhtml11.conf
===================================================================
--- xhtml11.conf	(revision 53)
+++ xhtml11.conf	(working copy)
@@ -22,6 +22,12 @@
 \$=\$
 `=\`
 endif::asciimath[]
+ifdef::asciidoc7compatible[]
+# Superscripts.
+\^(.+?)\^=<sup>\1</sup>
+# Subscripts.
+~(.+?)~=<sub>\1</sub>
+endif::asciidoc7compatible[]
 
 [ruler-blockmacro]
 <hr />
Index: docbook.conf
===================================================================
--- docbook.conf	(revision 53)
+++ docbook.conf	(working copy)
@@ -18,6 +18,12 @@
 [replacements]
 # Line break markup is dropped (there is no DocBook line break tag).
 (?m)^(.*)\s\+$=\1
+ifdef::asciidoc7compatible[]
+# Superscripts.
+\^(.+?)\^=<superscript>\1</superscript>
+# Subscripts.
+~(.+?)~=<subscript>\1</subscript>
+endif::asciidoc7compatible[]
 
 [ruler-blockmacro]
 # Only applies to HTML so don't output anything.
Index: html4.conf
===================================================================
--- html4.conf	(revision 53)
+++ html4.conf	(working copy)
@@ -18,6 +18,12 @@
 [replacements]
 # Line break.
 (?m)^(.*)\s\+$=\1<br />
+ifdef::asciidoc7compatible[]
+# Superscripts.
+\^(.+?)\^=<sup>\1</sup>
+# Subscripts.
+~(.+?)~=<sub>\1</sub>
+endif::asciidoc7compatible[]
 
 [ruler-blockmacro]
 <hr />

--------------000801060307050600080101--
