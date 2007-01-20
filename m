From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Documentation/config.txt: Document config file syntax better
Date: Sat, 20 Jan 2007 15:03:09 +0100
Message-ID: <11693017892595-git-send-email-jnareb@gmail.com>
References: <7v8xfyczxi.fsf@assigned-by-dhcp.cox.net>
Cc: Nikolai Weibull <now@bitwi.se>, Eric Wong <normalperson@yhbt.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 20 15:03:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Go8-0004Lw-RN
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 15:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbXATOC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 09:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbXATOC4
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 09:02:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:4386 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965231AbXATOCz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 09:02:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so676527uga
        for <git@vger.kernel.org>; Sat, 20 Jan 2007 06:02:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i545WdXyWiJbotqQQIyujj2jCWOEMZrpup/NpCDUevAwuL64Dje224Gbuj5CrTzX+ixu3eC28Nww9re9RivKQZj5WIy1kucA+J3pCLTpaVivG+5biHE3NE8tU0bwEtTMpPhO41rsMcd/pY9sv4rdq6px8XHXE/l2EenNMw9OOEs=
Received: by 10.67.20.3 with SMTP id x3mr4639198ugi.1169301773825;
        Sat, 20 Jan 2007 06:02:53 -0800 (PST)
Received: from roke.D-201 ( [81.190.20.200])
        by mx.google.com with ESMTP id b35sm4019156ugd.2007.01.20.06.02.52;
        Sat, 20 Jan 2007 06:02:53 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l0KE3KA9022239;
	Sat, 20 Jan 2007 15:03:22 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l0KE3Aal022237;
	Sat, 20 Jan 2007 15:03:10 +0100
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <7v8xfyczxi.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37272>

Separate part of Documentation/config.txt which deals with git config file
syntax into "Syntax" subsection, and expand it.  Add information about
subsections, boolean values, escaping and escape sequences in string
values, and continuing variable value on the next line.

Add also proxy settings to config file example to show example of
partially enclosed in double quotes string value.

Parts based on comments by Junio C Hamano, Johannes Schindelin,
and the smb.conf(5) man page.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Sat, 20 Jan 2007, Johannes Schindelin wrote:
> On Fri, 19 Jan 2007, Jakub Narebski wrote:

>> +in the section header, like in example below
>> +
>> +	[section "subsection"]
> 
> I wonder if we should also mention the (case insensitive) alternative 
> "[section.subsection]", to give a better idea to people why we actually 
> check for "section.subsection" in the code.

Added one line note about this.

>> +All the other lines are recognized as setting variables, in the form
>> +'name = value'. If there is no equal sign on the line, the entire line
>> +is taken as 'name' and the variable is recognized as boolean "true".
>> +Variable names are case insensitive.
> 
> They cannot contain anything else than alphanumeric characters, in 
> particular no whitespace.

It is mentioned above "Syntax" section, but perhaps it should be repeated.
I haven't took a look at code to check what values for section names and
for key/variable names are allowed.

>> +Some variables may require special value format.
> 
> I think you can safely skip that; it should be evident that the format of 
> the variables depends on the purpose.

This was in the original, and I think it is better left (at least for now).


Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> I'm not sure how to tell that you can have [section] if you have
>> [section "subsection"], but you don't need to.
> 
> s/I'm not .*that//; would be enough, I think.

Thanks for suggestion. I have used it (although perhaps the preceding
sentence is now not needed).

> One thing that left me puzzled after reading the description was
> what a user can do with "subsection".  It is unclear from the
> description if [section "sub.section"], [section "sub.sec=ti.on"]
> or worse yet, [section "sub\nsection with an embbedded LF"] are
> allowed.  The rest seemed sane.

I'm not sure what is allowed in section name, and in subsection name,
so for now I have left it as is. I can amend this commit, or add new
commit explaining this.


BTW. currently one of examples from git-repo-config(1) doesn't work:

  To add a new proxy, without altering any of the existing ones, use
  
  ------------
  % git repo-config core.gitproxy '"proxy" for example.com'
  ------------

I think it would be better instead of adding quotes if needed, just
do _not_ escape quotes. But that leaves the problem what to do if one
puts value with trailing or leading whitespace, or comment character
outside quotes using git-repo-config...


 Documentation/config.txt |   69 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index da7fde5..03133e2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -14,14 +14,65 @@ dot-separated segment and the section name is everything before the last
 dot. The variable names are case-insensitive and only alphanumeric
 characters are allowed. Some variables may appear multiple times.
 
+Syntax
+~~~~~~
+
 The syntax is fairly flexible and permissive; whitespaces are mostly
-ignored. The '#' and ';' characters begin comments to the end of line,
-blank lines are ignored, lines containing strings enclosed in square
-brackets start sections and all the other lines are recognized
-as setting variables, in the form 'name = value'. If there is no equal
-sign on the line, the entire line is taken as 'name' and the variable
-is recognized as boolean "true". String values may be entirely or partially
-enclosed in double quotes; some variables may require special value format.
+ignored.  The '#' and ';' characters begin comments to the end of line,
+blank lines are ignored.
+
+The file consists of sections and variables.  A section begins with
+the name of the section in square brackets and continues until the next
+section begins.  Section names are not case sensitive.  Each variable
+must belong to some section, which means that there must be section
+header before first setting of a variable.
+
+Sections can be further divided into subsections.  To begin a subsection
+put its name in double quotes, separated by space from the section name,
+in the section header, like in example below:
+
+--------
+	[section "subsection"]
+
+--------
+
+Subsection names can contain whitespace and are case sensitive.  Variables
+may belong directly to a section, or to a given subsection.  You can have
+`[section]` if you have `[section "subsection"]`, but you don't need to.
+
+There is also (case insensitive) alternative `[section.subsection]` syntax.
+
+All the other lines are recognized as setting variables, in the form
+'name = value'. If there is no equal sign on the line, the entire line
+is taken as 'name' and the variable is recognized as boolean "true".
+Variable names are case insensitive.  There can be more than one value
+for a given variable; we say then that variable is multivalued.
+
+Leading and trailing whitespace in a variable value is discarded.
+Internal whitespace within a variable value is retained verbatim.
+
+The values following the equals sign in variable assign are all either
+a string, an integer, or a boolean.  Boolean values may be given as yes/no,
+0/1 or true/false.  Case is not significant in boolean values, when
+converting value to the canonical form using '--bool' type specifier;
+git-repo-config will ensure that the output is "true" or "false".
+
+String values may be entirely or partially enclosed in double quotes.
+You need to enclose variable value in double quotes if you want to
+preserve leading or trailing whitespace, or if variable value contains
+beginning of comment characters (if it contains '#' or ';').
+Double quote '`"`' and backslash '`\`' characters in variable value must
+be escaped: use '`\"`' for '`"`' and '`\\`' for '`\`'.
+
+The following escape sequences (beside '`\"`' and '`\\`') are recognized:
+'`\n`' for newline character (NL), '`\t`' for horizontal tabulation (HT, TAB)
+and '`\b`' for backspace (BS).  No other char escape sequence, nor octal
+char sequences are valid.
+
+Variable value ending in a '`\`' is continued on the next line in the
+customary UNIX fashion.
+
+Some variables may require special value format.
 
 Example
 ~~~~~~~
@@ -40,6 +91,10 @@ Example
 		remote = origin
 		merge = refs/heads/devel
 
+	# Proxy settings
+	[core]
+		gitProxy="ssh" for "ssh://kernel.org/"
+		gitProxy=default-proxy ; for the rest
 
 Variables
 ~~~~~~~~~
-- 
1.4.4.3
