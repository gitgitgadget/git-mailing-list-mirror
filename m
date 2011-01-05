From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Document escaping of special characters in gitignore files
Date: Wed, 5 Jan 2011 20:27:18 +0100
Message-ID: <201101052027.24640.jnareb@gmail.com>
References: <1294234732-20094-1-git-send-email-jnareb@gmail.com> <7vwrmjchuu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Bruce Korb <bruce.korb@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 20:27:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaZ1Y-0005dQ-4M
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 20:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858Ab1AET1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 14:27:50 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:48741 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab1AET1t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 14:27:49 -0500
Received: by wwi17 with SMTP id 17so16255637wwi.1
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 11:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4XaGGNCM/AneiaFysOay80RCmiR+qLoigckPcMIJJ94=;
        b=awCnBKXVwwcqWBpGmGCBWOgrVGOzJokqby8hOsNTC0XOqKLCKkE0zSstieYUeJhuKo
         sMGRdMvcrSdcBKwmGr2ifTbXf+R4jh3L2HMu+2EckXNiFFmOJH72LrWy2CSrEmUiw8Pq
         SFZkZnBAlfxgv0JQJOrwugesNl3T1KAxpeGL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UUiDLckvY4YrJ7G/lKFeByCSz10zOX1PucmApSGAiGVin689ywJZh0scGhh7DgKHZ0
         HZ1Ga05aJOIobclVssfuxnRBCn6IjNdZ50MrBQIFDU18FzlBMEGePFyiWpXz2Pzo0mkE
         UIivqZ2IU7Il0/UHM0riiC5cQBqU83xxedbQg=
Received: by 10.216.158.205 with SMTP id q55mr294914wek.76.1294255668277;
        Wed, 05 Jan 2011 11:27:48 -0800 (PST)
Received: from [192.168.1.13] (abwm104.neoplus.adsl.tpnet.pl [83.8.236.104])
        by mx.google.com with ESMTPS id b30sm11359086wen.25.2011.01.05.11.27.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Jan 2011 11:27:46 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwrmjchuu.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164585>

On Wed, 5 Jan 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > This patch was originally send 10 Sep 2010, but I guess it was lost
> > because it appeared only deep in thread inside response, and not as
> > well separated patch.  I have found about it when I got conflict
> > merging current code.
> >
> > It applies on top of current 'master'.
> 
> Thanks.  A few questions before applying.
> 
> > diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> > index 7dc2e8b..20abc20 100644
> > --- a/Documentation/gitignore.txt
> > +++ b/Documentation/gitignore.txt
> > @@ -68,6 +68,7 @@ Patterns have the following format:
> >     for readability.
> >  
> >   - A line starting with # serves as a comment.
> > +   Use `\#` for a literal # character starting filename.
> 
> Is a literal bs safe here?  You later use "{backslash}#" in this same
> file, and it might make sense to do so here for the sake of source
> readability, even if a literal bs is safe here---provided that
> "{backslash}#" does not break here, of course.

First, I have checked how it is done in current codebase, and as one
can check, inside backtics escape sequences are written literally, e.g.
`\"`, `\\` in Documentation/config.txt -- notice that those are about
escaping of special characters too.

Second, http://www.methods.co.nz/asciidoc/userguide.html#_text_formatting
("7. Text Formatting", "7.1. Quoted Text") says (emphasizis mine):

  Word phrases `enclosed in backtick characters` (grave accents) are also
  rendered in a monospaced font but in this case the enclosed text is
  __rendered literally__ and is not subject to further expansion (see
  inline literal).

So yes, it is safe, and no, `{backslash}#` would not work.


I later use "{backslash}#" because it is inside double quotes, and not
backticks.  It is similar to how {caret} is treated inside double or
single quotes.

> > @@ -98,6 +99,12 @@ Patterns have the following format:
> > ...
> > + - You can escape special characters using backslash.
> > +   For example, "{backslash}#*" matches files beginning in `#`
> > ...
> 
> > diff --git a/templates/info--exclude b/templates/info--exclude
> > index a5196d1..2ebaf0d 100644
> > --- a/templates/info--exclude
> > +++ b/templates/info--exclude
> > @@ -4,3 +4,4 @@
> >  # exclude patterns (uncomment them if you want to use them):
> >  # *.[oa]
> >  # *~
> > +# \#*#
> 
> Do we need this?  Without explanation it is somewhat hard to realize that
> this last line is also an example of a pattern that excludes any filename
> that begins and ends with a pound.

Well, perhaps not.  Note though that this exclude pattern is actually
useful for me, as GNU Emacs uses this convention ("#<filename>#") for
auto-save files.   From "(emacs.gz)Auto Save Files":

     Auto-saving does not normally save in the files that you visited,
  because it can be very undesirable to save a program that is in an
  inconsistent state when you have made half of a planned change.
  Instead, auto-saving is done in a different file called the "auto-save
  file", and the visited file is changed only when you request saving
  explicitly (such as with `C-x C-s').

     Normally, the auto-save file name is made by appending `#' to the
  front and rear of the visited file name.  Thus, a buffer visiting file
  `foo.c' is auto-saved in a file `#foo.c#'.

-- 
Jakub Narebski
Poland
