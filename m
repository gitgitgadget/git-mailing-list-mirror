From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 8 Aug 2007 09:50:14 -0400
Message-ID: <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com>
References: <f99cem$4a4$1@sea.gmane.org>
	 <Pine.LNX.4.64.0708071257350.14781@racer.site>
	 <f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org>
	 <20070807143616.GO9527@spearce.org> <20070807145825.GO21692@lavos.net>
	 <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de>
	 <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>
	 <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Sebastian Schuberth" <sschuberth@gmail.com>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 15:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIlva-00069O-OZ
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 15:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917AbXHHNuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 09:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755300AbXHHNuT
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 09:50:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:51622 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760AbXHHNuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 09:50:17 -0400
Received: by nf-out-0910.google.com with SMTP id g13so46727nfb
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 06:50:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EnF4QVVi+UaYKRMLyORL4lamVLZ/bHjwN0TsGoG4boEvNvMMPJBu9jsCknDfJWiHOFtmvl7M5eICuzZehp+HdD5wLKeLsNarJXCOLlrGxG7znxfbW4Cunn3Y0HdsxJQ5SeEBzLoIiknxSAWBn6anMZPcsPx6Ex0tOFlMm7dPgnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YOPQBjH308Nh7Y+5+h6J8l2R3H/sssT/qFt2Tec5U/sFwpEfuEc+uVM8omCQysfFKVjpELPrSaB5GydN4CbClFetcoumUjEie0/DC4COeIvKXpqA6EfMlL99GKySpUnIy2YQn0k0gmlDaWn68Eno85P5ljYT5w1f0D/wZvibeSw=
Received: by 10.78.131.8 with SMTP id e8mr155101hud.1186581014185;
        Wed, 08 Aug 2007 06:50:14 -0700 (PDT)
Received: by 10.78.190.5 with HTTP; Wed, 8 Aug 2007 06:50:14 -0700 (PDT)
In-Reply-To: <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55320>

On 8/7/07, Steffen Prohaska <prohaska@zib.de> wrote:
>
> I read your message and I just checked the most recent installer
> of cygwin (screenshot attached).
>
> I see three choices I'm offered:
> 1) the path to install;
> 2) install for all or just me;
> 3) choose the default text file type.
>
> I wouldn't call that deprecated, not even obsolenscent.

Call it passively deprecated. there has been a lot of discussion about
removing it, or at least hiding it behind the mount command and not
offering it at all during installation. The objective of text mounts
was noble, but it really is hard to automatically convert any
occurrence of crlf->lf and lf->crlf everywhere it should be done but
not where it should not be done. However, a lot of people use text
mounts without trouble (or at least without complaining to the lists),
so removing the option outright was thought too likely to cause an
uproar. So, consider that Cygwin is taking the "let it rot, remove it
later" approach. Anyone who has troubles is generally and not so
gently encouraged to just use binary mounts. There are some known crlf
problems, largely with bash/sh, pipes, forks, and redirection (of
which git is a heavy user so git is a prime candidate to get into
trouble) that are not being worked.

For instance, when working on git-bundle.sh, I got bit by crlf
conversions corrupting packfiles sent through a pipe on a system with
pure binary mounts and CYGWIN=binmode. The cure to that bug is
*removing* auto-crlf conversion from Cygwin.

Mark
