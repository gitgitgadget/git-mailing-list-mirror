From: Quy Tonthat <qtonthat@gmail.com>
Subject: Re: [PATCH] Fix break in git-rev-list.txt
Date: Thu, 23 Aug 2007 00:37:55 +1000
Message-ID: <46CC4A43.9050305@gmail.com>
References: <11877706831306-git-send-email-qtonthat@gmail.com> <7vbqczkhvb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 16:38:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INrLf-0002J7-8T
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 16:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760250AbXHVOiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 10:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759922AbXHVOiD
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 10:38:03 -0400
Received: from pecan.exetel.com.au ([220.233.0.17]:48608 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758579AbXHVOiB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 10:38:01 -0400
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95] helo=kingbee.home)
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1INrLI-00032b-EO; Thu, 23 Aug 2007 00:37:57 +1000
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <7vbqczkhvb.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56384>

Junio C Hamano wrote:
> 
> Hmph.  Interesting.  The text around this is:
> 
> 	-g, --wark-reflogs::
> 
>         	Indented first paragraph...
> 	+
>         With '\--pretty' fromat ... second paragraph ...
> 	prefixed with this information on the same line.
> 	+
>         Cannot be combined with --reverse.
> 
> And its formatted form looks like either (without your patch):
> 
> 	<listitem>
>         <simpara>
>         	Indented first paragraph...
> 	With <emphasis>--pretty</emphasis> format ...
> 	</simpara>
>         <simpara>Cannot be combined with --reverse.</simpara>
> 
>         </listitem>	
> 
> or (with):
> 
> 	<listitem>
>         <simpara>
>         	Indented first paragraph...
> 	With <emphasis>--pretty</emphasis> format ...
> 	Cannot be combined with --reverse.
> 	</simpara>
> 
>         </listitem>	
> 

Well, it goes differently on my system here (asciidoc 8.1.0), as shown
in the diff bellow:

	--- git-rev-list.xml.bad	2007-08-23 00:08:58.000000000 +1000
	+++ git-rev-list.xml.good	2007-08-23 00:10:20.000000000 +1000
	@@ -509,16 +509,15 @@
	         When this option is used you cannot specify commits to
	         exclude (that is, <emphasis>&#94;commit</emphasis>, <emphasis>commit1..commit2</emphasis>,
	         nor <emphasis>commit1&#8230;commit2</emphasis> notations cannot be used).
	-<literal>
	 With <emphasis>--pretty</emphasis> format other than oneline (for obvious reasons),
	 this causes the output to have two extra lines of information

	 taken from the reflog.  By default, <emphasis>commit@{Nth}</emphasis> notation is
	 used in the output.  When the starting commit is specified as

	 instead.  Under <emphasis>--pretty=oneline</emphasis>, the commit message is

	 prefixed with this information on the same line.

	-</literal>

	-Cannot be combined with --reverse.

	 </simpara>

	+<simpara>Cannot be combined with --reverse.</simpara>

	+

	 </listitem>

	 </varlistentry>

	 <varlistentry>


Note the extra <literal></literal> which what xmlto has problems with as
in its error messages

/work/devel/git/git.git/Documentation/git-rev-list.xml:512: element literal: validity error : Element emphasis is not declared in literal list of possible children

I'll have a look at asciidoc as soon as I have some time.

Quy
