From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: noob user, want checkins to all be forced to LF terminated
 lines
Date: Wed, 04 Aug 2010 06:29:35 +0100
Message-ID: <1280899775.2820.4.camel@dreddbeard>
References: <i308gl$v6p$1@dough.gmane.org> <20100731044957.GA8920@burratino>
	 <i30bg7$50k$1@dough.gmane.org> <20100731054437.GD14425@burratino>
	 <i30g2s$dpt$1@dough.gmane.org>
	 <AANLkTim=avirVOZ99_Pgp1iLJQ_5J_1xpAad84boi_M3@mail.gmail.com>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Walter Bright <boost@digitalmars.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 07:29:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgWXy-00008Q-EN
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 07:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341Ab0HDF3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 01:29:40 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34736 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756120Ab0HDF3j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 01:29:39 -0400
Received: by wwj40 with SMTP id 40so6048212wwj.1
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 22:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=UL8yO2HgdZawtsi4VWZpBu7QeO4Spf/RrN7zoYU8mjA=;
        b=UrsLyeAxMjwcXSDOdTxHtPNIqHZRnEGuGYN7lOtDJ7yu/igMFL/fiizr8z4a//GGlA
         JeLwRWVPEfSdtU856ZAqh3F/ar1kYAvYV9tCrDSbijYFR6bbeGFvdSVQg79iNxw5sGVa
         A7p5SUFSX0Uqxwav5zHzKWuj197yNBHmtc+/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=kXYLi3vu3kpDDyMn/+bWS3wEHbSligG9C3xsn0xLJ22NY8M74A5eB6DlFD+wi2Ihan
         iwDle40/CXc/OmPhp4lGehBE718MH3v54dwrUOixwN2lAPPE3NSO7zH5mmqIkdthORN+
         rHwAoSuLOvyQXkChOHS9TR0ZqgtgWrBe1S2ks=
Received: by 10.227.141.204 with SMTP id n12mr7279893wbu.7.1280899778151;
        Tue, 03 Aug 2010 22:29:38 -0700 (PDT)
Received: from [192.168.0.129] (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id b18sm6868257wbb.1.2010.08.03.22.29.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 22:29:37 -0700 (PDT)
In-Reply-To: <AANLkTim=avirVOZ99_Pgp1iLJQ_5J_1xpAad84boi_M3@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152562>

On Tue, 2010-08-03 at 19:56 -0400, Jay Soffian wrote:
> On Sat, Jul 31, 2010 at 2:32 AM, Walter Bright <boost@digitalmars.com> wrote:
> > So I'm lost again. If the version in the repository is always converted to
> > LF, then why do I need to set autocrlf=input ?
> 
> Let's start over. :-)
> 
> Before git-1.7.2, EOL conversion was rather insane. It's fixed in
> 1.7.2, so I'm going to start by explaining what happens with that
> version and later.
> 
> Option 1 (text/eol attributes):
> 
> - Normally git will perform no EOL conversion. Files are committed
> into the repo exactly as you see them in your checkout.
> 
> - To have git perform EOL conversion, you need to either explicitly
> tell it which files are text, or let it autodetect. You normally do
> this via the .gitattributes file using:
> 
>   <pattern> text
> 
> or
> 
>   * text=auto
> 
> In the former case, you're telling git explicitly which files are
> text. In the latter case, you're telling git to do its best to detect
> which files are text.
> 
> Files which are explicitly tagged as text, or auto-detected as text,
> will have their EOLs converted to LF on check-in, and converted to
> core.eol on check-out. core.eol defaults to "native" which means LF on
> Unix and CRLF on Cygwin, but you can explicitly set it to "lf" or
> "crlf" if you desire.
> 
> Certain files you may wish to specify their EOL in the working copy
> explicitly. You do this with the eol attribute. e.g.:
> 
>   <pattern> eol=crlf
>   <pattern> eol=lf
> 
> Files which are tagged with eol={crlf,lf} are implicitly text, and
> will have their EOLs converted to LF on check-in, and converted to the
> specified EOL on check-out.
> 
> Okay, so that's how you ensure that certain files have LFs in the
> repo, and the desired EOL in the working-copy.
> 
> Option 2 (core.autocrlf):
> 
> With core.autocrlf=true, any files in the repo that git detects as
> text and which already have LF EOLs will have their EOLs converted to
> CRLF on check-out. Also, any additions to these files, or any new
> files that git detects as text, will have their EOLs converted to LF
> on check-in.
> 
> In this way, core.autocrlf=true is similar to "* text=auto", however
> it does not affect any files in the repo which already have CRLF EOLs.
> 
> AFAIK, there's no reason to set core.autocrlf=true on Unix. You'd
> typically only set it under Windows.
> 
> I'm going to stop here as I think these are the only options that make
> sense with 1.7.2 and above. If you want me to explain your options
> using earlier versions of git, I can try, but it's even more
> confusing.
> 
> j.

If it is accurate (and I have no way of knowing, since I've never
understood the ins-and-outs before), then that was the best, most
straightforward, most complete, least confusing description of
core.autocrlf, eol={crlf,lf}, and text=auto that I have ever read. I
want this post re-formatted and included in the docs :)

For completeness, would you mind explaining the "old way" too, and
include a note on oddities such as "git says my entire working copy has
changed, but reset --hard does nothing"? I just feel like I'm closer
than I've ever been to understanding the whole mess.


> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- Will
