Received: from smtp-out1-03.simnet.is (smtp-out1-03.simnet.is [194.105.232.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A91F0E4B
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.232.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892883; cv=none; b=Q08PIGar7IUTI0SR0jj9GuFJhUvlbtZsy6BeI8cGGcPuaPiMQuhWHCP/MxphmFEPm4aq6m0N8W3r/ilZhe6Ab8RiwYzVGFObV2pCxoGXyqqM+unFrKvDSlPqG5hwZcpRcUUKuF2pul64n/YaqIZcpk6mZAQqDwoyVGKoSPpMyfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892883; c=relaxed/simple;
	bh=89hAFlIzDZJ/lHz6JNF7PwaP+QS5tJDpnEpu5Iqn/GM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YnA807oouTnjSpa4kCLChW1LQ8Hn8fczUhA9Kjd7fFx3keCeUz1hC1S+hwXtDCd9GszQ4zKbDIJZYOVivoYTh6QOPFAahx+lv4xdKZ5gkwT3UalXCQ1zLvPbcSCsEFD1CwsC3KQepu+7FgE3BtgdZ30d3yPZugISpuGIX9TQPhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=iLa8GC/O; arc=none smtp.client-ip=194.105.232.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="iLa8GC/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1741892880; x=1773428880;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zAHSqOPofetiS3SxzRVCJZhS1XQ4QMJwADZi47RlPEI=;
  b=iLa8GC/Oz56qYQh3ogFN5I6LL1CNlhmiy9aDS+GNKbAUHvQRjsuGLIiN
   +rghDSa7hrFodoCY12Fz87/0f1EMpEDzGNL2Wjxb1r/V4jXjwT02paTra
   DKzxoMkqwYlQmiHmZXOf3JiKGPj4ads04ueivuWGE4JlSmMwtwEnFtUDL
   gEdL12nVG6kqUpMUvqnUhIOG2JmfH2reRvqDNTbXdzmOokw3M2obAgDLs
   zUchintcWwKKg4qc9Vux88OyDPtzV1ld+PTnZANt1+k4to37TY0g8Kwp6
   icLICcGrSOcUhsB04117L2qXgIFlmOTeldGwWk/2sj/j4IPxHCS1vSlf7
   w==;
X-CSE-ConnectionGUID: CFQtpYfKR22KnQv+UbQ+FA==
X-CSE-MsgGUID: hnjn6qolSdqagAsjwxW2zw==
Authentication-Results: smtp-out-03.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2EPAADGK9NnhVfoacJaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFCAgEBAQELAYJDfYFkiBYPjiKeK4FyBwEBAQ85CwQBAQMBA?=
 =?us-ascii?q?4IMgnSLHSg3Bg4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEGAQEBAQEBBgcCE?=
 =?us-ascii?q?AEBAQFADjuFNUYNgxZxgSQBAQEBAQEBAQEBAQEBAR0BAQILgX0tfDCCeQGCZ?=
 =?us-ascii?q?BSwHIE0gQGDHFBB2geBXhCBSAGFbIJjAYVshHc8BoINEoEDMgOBc1FvglYLA?=
 =?us-ascii?q?YEsARECAQYCRIYYBIIYF4E7ggKBaoU/gV6IXYZHIIdwiw1IgSEDWSwBVRMNC?=
 =?us-ascii?q?gsHBYFsAzUMCy4VMoEUQzc1gg5pSToCDQI1ght8giuCVYF4hDyEQYVOghGLN?=
 =?us-ascii?q?oRhLVROHTYKAwsYDUgRLDcUG0RuB6FXO4NICQEtAUICATAoNQEpAVlAAzAGD?=
 =?us-ascii?q?x0BKQsYFJM0j1uBRKAkgT6EJYZcgzGCC5VKMyKDYYFXkWwMOpJLmH6NG2qJC?=
 =?us-ascii?q?4xIIxk3hGiBfYEQcCwHGggwO4JnCUkZD44HIwMWFogaBTbECng8AgcLAQEDC?=
 =?us-ascii?q?ZFnAQE?=
IronPort-PHdr: A9a23:6EeMlRcCO2qOy7acLuRTnRMNlGM/noqcDmcuAvsPkLdSauGk4oinZ
 BeZ/vRoilLVG4TAuLpIiOvT5qbnX2FIoZOMq2sLf5EEURgZwd4XkAotDI/NCUDyIPPwKS1vG
 sNEWTdY
IronPort-Data: A9a23:ocMiH6wrORg6J2jvyTF6t+dawCrEfRIJ4+MujC+fZmQN5Y4CYwd3n
 TpENjTXZOHfICDrLIAyddTrpAob+sOLmshieLZf3SxmRntBoJfJCIuVdRz7YX3OcpaaQUw64
 p5FM4bOIs46EyOMq0f3POS8o3cg2/uBGeDxAreeZCp4HAQ0RCtxgkgLd4LV+mJNqYHR71Sl5
 4Kq+6UzQWON2yJoKjBTrK6Eoxlou/e0oz1euFEiIph3UCTlew8o4Og3fufpR0bQQpVIBrz9A
 Pnc0/e1+WjT+BAuTNS/nfHnfkJXBbPUegiSj34RUrW+gh9YzhDeqZ3XQsfwE28PzW3hou1M9
 DkkWeRcIy8mP7GJmeEUS1xDHidye/QA9L7JLxBT2uTKxEeeeiDgnq5jARhqZtRApL9+DzoTp
 PIScjlVZ0/bir7mnLjhF7MwjZQtdMPmYIoU4X8/lW6FBvt4Gc2bSPmUjTM0ME/co+gXdRqJT
 5NAM2EHgG38XiBz1j77cH5UtOilgHTlejkeok+avsLbiECIkFN72ei2O9eFd9CHTJsLlxuW+
 GjMrzyoUhxLOYCRk2WPrSKniLCWxHyhAt1PSuW0q69kjQLCmGFPUEFHW1DjyRXVZjZSfvoGQ
 6BD0nN/9/JaGDWXc+TAsz2ETF+stxdBBdQBS+Qzt1mEwaSOv1jHCzINHmBMNIYs6sJmHmcD2
 w7SlbsFJxQ26+TNFij1GpR4DN+WEXJIRYPXTXZcFWPp2/G6/sdryEqJFos/eEKMpoWdMSnqx
 DyXpzQJibwWjMoav4225lmvbwiE//AldSZroFyLNo6ZxlkhPtP9PNXzsQOzActode51cHHQ7
 RDopODGhAw+JcnlvDCARuwLAIao656tWBXAgURiFoUW7D+k/XiuZ+h4uFmS828wb67o0RewC
 KPikVs5CK17ZRNGXocrC26FMPnG+IC7fTjTul84WfIVCnR5XFfvECiD/id81Ui1+KQnuflX1
 Zt27a9ApJvVYEhq5GPeegsT7VMk7gsQ/H/LdJ7Y9U798rynej2oQ45GHnLbO4jV7IvcyOnU2
 8heLNfP2RRaSPf5cjiSqddVM1ERMT46HvgaqeQOJ7LFe1I7Xjt6UbmBntvNeKQ890hRvu3H1
 mq8X0lV1Bz+nhUrLC3WMi86Oe6xBP6Tq1o7Oy4qY0+v30MveI+gxbwdaIsIJ6s4obkLIflcF
 KVVKprRXpyjUA/v4CkXaJjhhIZ/ew/tiQ+EPiOjJj8lcPZISA3V0sHrcxGp9yQUCCez88wkr
 NWdOhjzX5sYW0FwDcPOcvW/3hbp5D4DmfluGUrTSjVORKny2KNEEjDpv/EUGZtWChP62Hin3
 T/VLz5N8IEhvLQJ2NXOgKmFqaKgHO1/AldWEgHnAVCeaXiyEo2LnNYobQqYQQ0xQl8Y742DX
 o1oIxzULvwcgBNYso9kCbF73Odmvp3xpqRGiAV/dJkqU7hJIu05SpVl9ZAe3kGo+lO/kVDsM
 q5o0oIAUYhlwOu/TDYsyPMNN4xvL808lDjI9ugSK07n/iJx97fveRwNY0Dc0HAGdOAlbd5NL
 QIdVCg+t13XZv0Cb4zus8yo3z7TfxTsro1+6spEWdGDZvQDmg0cP/Qw9RMaELnUN4UdbRh2S
 tNlrK/Dg70UxkSqTpbAPSWl4AapvrxX4Eoi5AZbezyhxIGf7tdph0I5zNjCZl8Opvmx+7koY
 jAzX6C0TI3SlwpVaD9rBD39R1obWUHDpSQcCTIhzQXkcqVhbUSVREVVBApH1BtxH750FtSDw
 Iyl9Q==
IronPort-HdrOrdr: A9a23:o/Q7R68i6h1goA+Rjw9uk+DTI+orL9Y04lQ7vn2ZhyYlEPBws/
 re5cjztCWE7gr5N0tApTntAsm9qBDnhPlICOsqTNOftWDd0QPCRuwPguXfKlbbakjDH4BmpM
 RdmtBFeaXNMWQ=
X-Talos-CUID: 9a23:C/rnnWBmv8Qkb4z6EwJJzVIMK84GSCeH73HpPQyFA18qZpTAHA==
X-Talos-MUID: 9a23:7kleOwrzP/TxgY8WuBEezzFkNsE2+qOqM0wUmJovoMubJRMqKSjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,245,1736812800"; 
   d="1'?diff'?bugs'?scan'208";a="40719561"
Received: from vist-zimproxy-01.vist.is ([194.105.232.87])
  by smtp-out-03.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 19:06:48 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id 4974841C4686;
	Thu, 13 Mar 2025 19:06:48 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Im_wjdykZpz0; Thu, 13 Mar 2025 19:06:47 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id 42F7A41C469C;
	Thu, 13 Mar 2025 19:06:47 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id w7xcTQbKCXWq; Thu, 13 Mar 2025 19:06:47 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTPS id 04C2641C4686;
	Thu, 13 Mar 2025 19:06:46 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1tsntG-0000000067o-31IY;
	Thu, 13 Mar 2025 19:06:46 +0000
Date: Thu, 13 Mar 2025 19:06:46 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: git@vger.kernel.org
Cc: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: git-imap-send.1: Some remarks and a patch with editorial changes for
 this man page
Message-ID: <174189190917.23318.16618875466087190958.reportbug@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Tjc0VzT0B8I7ITM1"
Content-Disposition: inline
X-Mailer: reportbug 13.1.0


--Tjc0VzT0B8I7ITM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Package: git-man
Version: 1:2.47.2-0.1
Severity: minor
Tags: patch

   * What led up to the situation?

     Checking for defects with a new version

test-[g|n]roff -mandoc -t -K utf8 -rF0 -rHY=0 -rCHECKSTYLE=10 -ww -z < "man page"

  [Use "groff -e ' $' -e '\\~$' <file>" to find obvious trailing spaces.]

  ["test-groff" is a script in the repository for "groff"; is not shipped]
(local copy and "troff" slightly changed by me).

  [The fate of "test-nroff" was decided in groff bug #55941.]

   * What was the outcome of this action?


troff:<stdin>:260: warning [page 3, line 23]: cannot break line


   * What outcome did you expect instead?

     No output (no warnings).

-.-

  General remarks and further material, if a diff-file exist, are in the
attachments.


-- System Information:
Debian Release: trixie/sid
  APT prefers testing
  APT policy: (500, 'testing')
Architecture: amd64 (x86_64)

Kernel: Linux 6.12.17-amd64 (SMP w/2 CPU threads; PREEMPT)
Locale: LANG=is_IS.iso88591, LC_CTYPE=is_IS.iso88591 (charmap=ISO-8859-1), LANGUAGE not set
Shell: /bin/sh linked to /usr/bin/dash
Init: sysvinit (via /sbin/init)

-- no debconf information

--Tjc0VzT0B8I7ITM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chk_man.err.git-imap-send.1"

Input file is git-imap-send.1

Output from "mandoc -T lint  git-imap-send.1": (shortened list)

      2 input text line longer than 80 bytes: A boolean to enable/...
      1 input text line longer than 80 bytes: An integer port numb...
      1 input text line longer than 80 bytes: Command used to set ...
      1 input text line longer than 80 bytes: Everything above thi...
      1 input text line longer than 80 bytes: If your Gmail accoun...
      1 input text line longer than 80 bytes: It is still your res...
      1 input text line longer than 80 bytes: Just make sure to di...
      1 input text line longer than 80 bytes: Specify the authenti...
      1 input text line longer than 80 bytes: Talk to the IMAP ser...
      1 input text line longer than 80 bytes: The folder to drop t...
      1 input text line longer than 80 bytes: This command uploads...
      1 input text line longer than 80 bytes: Thunderbird in parti...
      1 input text line longer than 80 bytes: To use the tool, \fB...
      1 input text line longer than 80 bytes: Use libcurl to commu...
      1 input text line longer than 80 bytes: You may want to use ...
      1 input text line longer than 80 bytes: You might need to in...
      1 input text line longer than 80 bytes: prefix for secure co...
      1 skipping paragraph macro: PP after SH
      3 skipping paragraph macro: br after br
      3 skipping paragraph macro: br before sp
      7 skipping paragraph macro: sp after SH

-.-.

Output from "test-nroff -mandoc -t -ww -z git-imap-send.1": (shortened list)

      1 cannot break line

-.-.

Show if docman-to-man created this.

Who is actually creating this man page?  Debian or upstream?

Is the generating software out of date?

3:.\"    Author: [FIXME: author] [see http://www.docbook.org/tdg5/en/html/author]
4:.\" Generator: DocBook XSL Stylesheets vsnapshot <http://docbook.sf.net/>

-.-.

Strings longer than 3/4 of a standard line length (80).

Use "\:" to split the string at the end of an output line, for example a
long URL (web address)

260 Thunderbird in particular is known to be problematic\&. Thunderbird users may wish to visit this web page for more information: \m[blue]\fBhttps://kb\&.mozillazine\&.org/Plain_text_e\-mail_\-_Thunderbird#Completely_plain_email\fR\m[]

-.-.

Wrong distance (not two spaces) between sentences in the input file.

  Separate the sentences and subordinate clauses; each begins on a new
line.  See man-pages(7) ("Conventions for source file layout") and
"info groff" ("Input Conventions").

  The best procedure is to always start a new sentence on a new line,
at least, if you are typing on a computer.

Remember coding: Only one command ("sentence") on each (logical) line.

E-mail: Easier to quote exactly the relevant lines.

Generally: Easier to edit the sentence.

Patches: Less unaffected text.

Search for two adjacent words is easier, when they belong to the same line,
and the same phrase.

  The amount of space between sentences in the output can then be
controlled with the ".ss" request.

Mark a final abbreviation point as such by suffixing it with "\&".

Some sentences (etc.) do not begin on a new line.

Split (sometimes) lines after a punctuation mark; before a conjunction.

  Lines with only one (or two) space(s) between sentences could be split,
so latter sentences begin on a new line.

Use

#!/usr/bin/sh

sed -e '/^\./n' \
-e 's/\([[:alpha:]]\)\.  */\1.\n/g' $1

to split lines after a sentence period.
Check result with the difference between the formatted outputs.
See also the attachment "general.bugs"

[List of affected lines removed.]

-.-.

Split lines longer than 80 characters into two or more lines.
Appropriate break points are the end of a sentence and a subordinate
clause; after punctuation marks.
Add "\:" to split the string for the output, "\<newline>" in the source.  

[List of affected lines removed.]

-.-.

The name of a man page is typeset in bold and the section in roman
(see man-pages(7)).

263:\fBgit-format-patch\fR(1), \fBgit-send-email\fR(1), mbox(5)

-.-.

Add a zero (0) in front of a decimal fraction that begins with a period
(.)

191:.sp .5v
224:.sp .5v
240:.sp .5v

-.-.

Put a parenthetical sentence, phrase on a separate line,
if not part of a code.
See man-pages(7), item "semantic newline".

git-imap-send.1:190:You may want to use \fBsslVerify=false\fR while troubleshooting, if you suspect that the reason you are having trouble connecting is because the certificate you use at the private server \fBexample\&.com\fR you are trying to set up (or have set up) may not be verified correctly\&.
git-imap-send.1:255:Just make sure to disable line wrapping in the email client (Gmail\(cqs web interface will wrap lines no matter what, so you need to use a real IMAP client)\&.
git-imap-send.1:258:It is still your responsibility to make sure that the email message sent by your email program meets the standards of your project\&. Many projects do not like patches to be attached\&. Some mail agents will transform patches (e\&.g\&. wrap lines, send them as format=flowed) in ways that make them fail\&. You will get angry flames ridiculing you if you don\(cqt check this\&.

-.-.

No need for '\&' to be in front of a period (.),
if there is a character in front of it.

Remove with "sed -e 's/\\&\././g'".

[List of affected lines removed.]

-,-

One space only after a possible end of sentence
(after a punctuation, that
can end a sentence).

[List of affected lines removed.]

-.-

Put a subordinate sentence (after a comma) on a new line.

[List of affected lines removed.]

-.-.

Remove quotes when there is a printable
but no space character between them
and the quotes are not for emphasis (markup),
for example as an argument to a macro.

git-imap-send.1:10:.TH "GIT\-IMAP\-SEND" "1" "01/19/2025" "Git 2\&.47\&.2" "Git Manual"
git-imap-send.1:30:.SH "NAME"
git-imap-send.1:32:.SH "SYNOPSIS"
git-imap-send.1:38:.SH "DESCRIPTION"
git-imap-send.1:45:.SH "OPTIONS"
git-imap-send.1:66:.SH "CONFIGURATION"
git-imap-send.1:127:.SH "EXAMPLES"
git-imap-send.1:256:.SH "CAUTION"
git-imap-send.1:264:.SH "GIT"

-.-.

Use ".na" (no adjustment) instead of ".ad l" (and ".ad" to begin the
same adjustment again as before).

26:.ad l

-.-.

Put a (long) web address on a new line to reduce the posibility of
splitting the address between two output lines.
Or inhibit hyphenation with "\%" in front of the name.


260:Thunderbird in particular is known to be problematic\&. Thunderbird users may wish to visit this web page for more information: \m[blue]\fBhttps://kb\&.mozillazine\&.org/Plain_text_e\-mail_\-_Thunderbird#Completely_plain_email\fR\m[]

-.-.

Output from "test-nroff  -mandoc -t -K utf8 -rF0 -rHY=0 -rCHECKSTYLE=10 -ww -z ":

troff:<stdin>:260: warning [page 3, line 23]: cannot break line

-.-.

Generally:

Split (sometimes) lines after a punctuation mark; before a conjunction.

--Tjc0VzT0B8I7ITM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git-imap-send.1.diff"

--- git-imap-send.1	2025-03-13 18:30:08.296097490 +0000
+++ git-imap-send.1.new	2025-03-13 18:49:12.211871441 +0000
@@ -257,7 +257,10 @@ Just make sure to disable line wrapping
 .sp
 It is still your responsibility to make sure that the email message sent by your email program meets the standards of your project\&. Many projects do not like patches to be attached\&. Some mail agents will transform patches (e\&.g\&. wrap lines, send them as format=flowed) in ways that make them fail\&. You will get angry flames ridiculing you if you don\(cqt check this\&.
 .sp
-Thunderbird in particular is known to be problematic\&. Thunderbird users may wish to visit this web page for more information: \m[blue]\fBhttps://kb\&.mozillazine\&.org/Plain_text_e\-mail_\-_Thunderbird#Completely_plain_email\fR\m[]
+Thunderbird in particular is known to be problematic.
+Thunderbird users may wish to visit this web page for more information:
+.br
+\m[blue]\fBhttps://kb.mozillazine.org/\:Plain_text_e\-mail_\-_Thunderbird#\:Completely_plain_email\fR\m[]
 .SH "SEE ALSO"
 .sp
 \fBgit-format-patch\fR(1), \fBgit-send-email\fR(1), mbox(5)

--Tjc0VzT0B8I7ITM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="general.bugs"

  Any program (person), that produces man pages, should check the output
for defects by using (both groff and nroff)

[gn]roff -mandoc -t -ww -b -z -K utf8 <man page>

  The same goes for man pages that are used as an input.

  For a style guide use

  mandoc -T lint

-.-

  Any "autogenerator" should check its products with the above mentioned
'groff', 'mandoc', and additionally with 'nroff ...'.

  It should also check its input files for too long (> 80) lines.

  This is just a simple quality control measure.

  The "autogenerator" may have to be corrected to get a better man page,
the source file may, and any additional file may.

  Common defects:

  Not removing trailing spaces (in in- and output).
  The reason for these trailing spaces should be found and eliminated.

  "git" has a "tool" to point out whitespace,
see for example "git-apply(1)" and git-config(1)")

  Not beginning each input sentence on a new line.
Line length and patch size should thus be reduced.

  The script "reportbug" uses 'quoted-printable' encoding when a line is
longer than 1024 characters in an 'ascii' file.

  See man-pages(7), item "semantic newline".

-.-

The difference between the formatted output of the original and patched file
can be seen with:

  nroff -mandoc <file1> > <out1>
  nroff -mandoc <file2> > <out2>
  diff -d -u <out1> <out2>

and for groff, using

\"printf '%s\n%s\n' '.kern 0' '.ss 12 0' | groff -mandoc -Z - \"

instead of 'nroff -mandoc'

  Add the option '-t', if the file contains a table.

  Read the output from 'diff -d -u ...' with 'less -R' or similar.

-.-.

  If 'man' (man-db) is used to check the manual for warnings,
the following must be set:

  The option \"-warnings=w\"

  The environmental variable:

export MAN_KEEP_STDERR=yes (or any non-empty value)

  or

  (produce only warnings):

export MANROFFOPT=\"-ww -b -z\"

export MAN_KEEP_STDERR=yes (or any non-empty value)

-.-

--Tjc0VzT0B8I7ITM1--
