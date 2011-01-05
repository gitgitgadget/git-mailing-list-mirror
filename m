From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Document escaping of special characters in gitignore files
Date: Wed, 5 Jan 2011 20:38:28 +0100
Message-ID: <201101052038.28515.trast@student.ethz.ch>
References: <1294234732-20094-1-git-send-email-jnareb@gmail.com> <7vwrmjchuu.fsf@alter.siamese.dyndns.org> <201101052027.24640.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Bruce Korb <bruce.korb@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 20:38:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaZBs-0003wM-20
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 20:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168Ab1AETia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 14:38:30 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:53886 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624Ab1AETia (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 14:38:30 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 5 Jan
 2011 20:37:45 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 5 Jan
 2011 20:38:28 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc8-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <201101052027.24640.jnareb@gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164586>

Jakub Narebski wrote:
> Second, http://www.methods.co.nz/asciidoc/userguide.html#_text_formatting
> ("7. Text Formatting", "7.1. Quoted Text") says (emphasizis mine):
> 
>   Word phrases `enclosed in backtick characters` (grave accents) are also
>   rendered in a monospaced font but in this case the enclosed text is
>   __rendered literally__ and is not subject to further expansion (see
>   inline literal).
> 
> So yes, it is safe, and no, `{backslash}#` would not work.

This is correct, but the behaviour you quote was introduced in a minor
release of asciidoc (!!!).  From 71c020c5:

    Disable asciidoc 8.4.1+ semantics for `{plus}` and friends
    
    asciidoc 8.4.1 changed the semantics of inline backtick quoting so
    that they disable parsing of inline constructs, i.e.,
    
      Input:    `{plus}`
      Pre 8.4.1:        +
      Post 8.4.1:       {plus}
    
    Fix this by defining the asciidoc attribute 'no-inline-literal'
    (which, per the 8.4.1 changelog, is the toggle to return to the old
    behaviour) when under ASCIIDOC8.

So in fact with current settings in Documentation/Makefile, the brace
escapes *are* expanded even within backticks.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
