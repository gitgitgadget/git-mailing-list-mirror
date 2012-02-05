From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Specifying revisions in the future
Date: Sun, 5 Feb 2012 23:24:59 +0100
Message-ID: <201202052324.59941.jnareb@gmail.com>
References: <jgjkk0$qrg$1@dough.gmane.org> <m3ehu9kknw.fsf@localhost.localdomain> <m2wr81vsdv.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, jpaugh@gmx.us,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Feb 05 23:25:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuAW7-0007Gr-2m
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 23:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab2BEWY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 17:24:58 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38188 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab2BEWY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 17:24:57 -0500
Received: by eekc14 with SMTP id c14so1967782eek.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 14:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=K0mV2h33438RQEAKLHDf59iae9CmJTr3dt0SuGXQcTE=;
        b=CwD+4GvoMcqJSQx1yFTDky4ZBQI2WCuO8Ap/SJlSZY8EYl73IMwAcALGwLpTm/S6lE
         PtdipCqW/iQIJ7cQAgoeMpFaZcVedFF2KqWSp+7VnL/QcGh1MAfgcJunKSB39pOXcHkw
         r9EEqtblAOLU3n5aKbufd0xhZPRxUQMt3L6WI=
Received: by 10.14.188.15 with SMTP id z15mr398833eem.71.1328480696408;
        Sun, 05 Feb 2012 14:24:56 -0800 (PST)
Received: from [192.168.1.13] (abvp235.neoplus.adsl.tpnet.pl. [83.8.213.235])
        by mx.google.com with ESMTPS id n56sm53508323eeh.6.2012.02.05.14.24.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 14:24:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <m2wr81vsdv.fsf@igel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189977>

On Sun, 5 Feb 2012, Andreas Schwab wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>> 
>>>> "the successor of <commit>", OTOH, is not well defined, since there can
>>>> be several successors, and one can't order them reliably (you can't
>>>> really know the set of successors, because they can exist in different
>>>> repositories).
>>> 
>>> Yet it would be nice to have a concise notation for "the nth successor
>>> of <commit> towards <commit>" (using --first-parent ordering when
>>> ambiguous).
>>
>> First, "the nth successor"... from which refs?
> 
> From the first given commit towards the other given commit (the latter
> defaulting to HEAD).

That helps some, but not all situations, see below.
 
> > Second, `--first-parent' won't help here.  Take for example the
> > following situation:
> >
> >    ---X<---*<---.<---A
> >             \
> >              \--.<---B
> >
> > X+3 is A or B?
> 
> If "towards A" then it is A, if "towards B", it is B.  In other words,
> to get the "nth successor of C1 towards C2" take the leftmost possible
> parent when walking from C2 to C1, then walk back n commits along this
> path.  This way you should have an unambigous definition.

Nope, still ambiguous:



  ---X<---*<---.<---A<---.<---M<---
           \                 /
            \--.<---B<------/

Is X+3 A or B?  Though '--first-parent + towards N' is I think unambiguous.
-- 
Jakub Narebski
Poland
