From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 3/3] git-submodule: New subcommand 'summary' (3) - limit summary size
Date: Sat, 1 Mar 2008 18:29:26 +0800
Message-ID: <46dff0320803010229h17b810a7k26d0ac36cf1eaef6@mail.gmail.com>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
	 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
	 <d6e82710452985611fb75c9d32a1b772bf0cb529.1204306070.git.pkufranky@gmail.com>
	 <18af168b52a735c33612c9c9e4778d8b8bef1cbc.1204306070.git.pkufranky@gmail.com>
	 <7v1w6u7vhf.fsf@gitster.siamese.dyndns.org>
	 <46dff0320803010216m1bd20674if82d2d2072858290@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 11:30:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVOyj-0004cX-AO
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 11:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866AbYCAK33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 05:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755568AbYCAK32
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 05:29:28 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:61803 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890AbYCAK31 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 05:29:27 -0500
Received: by an-out-0708.google.com with SMTP id d31so1002049and.103
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 02:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=szrRku6MVe9mPYb+9IdqsTQOW+5xoCmmrXGSeBzy58E=;
        b=UFRD9QreZMigjvZk4dLUPHJ2VvNMCcCdbvnvD2H0D1GnQkagmHltNOMPq3RoQBMOP4BtTKgPdthwXyKwJHkTLf0RFnu/bgQwgcYanhWq+OIhC1cuCdCxwP24bR6KQ3oKwi8+nW6BYobP5k+cKNRYxwm7SIGNqKDggK+AfTtH2HE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tOszPjT3GITypLL4hgGjWThDyDbgq7q2JkjKQl3FRhOKhNs8XEbkqwpa72LpABSsmvs4q6QOV6b8WOjd7EW6QWnQB5rSLuJ+1jwC41c8m+OvbRfIHMmw71MlN03LMiHATzMTsWssTmaFNMa37WBRvNklpbSRR707WZ321AoQc9s=
Received: by 10.100.154.9 with SMTP id b9mr22296695ane.86.1204367366845;
        Sat, 01 Mar 2008 02:29:26 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sat, 1 Mar 2008 02:29:26 -0800 (PST)
In-Reply-To: <46dff0320803010216m1bd20674if82d2d2072858290@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75652>

On Sat, Mar 1, 2008 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
 > Ping Yin <pkufranky@gmail.com> writes:
 >
 >  > This patches teaches git-submodule an option '--summary-limit|-n <number>'
 >  > to limit number of commits for the summary. Number 0 will disable summary
 >  > and minus number will not limit the summary size.
 >
 >  "Negative means unlimited" feels unnecessary.  Didn't you make "unlimited"
 >  the default anyway?
 'unlimited' is the default, i should clarify this in the message.

 I think 'Negative means unlimited' is neccessary. Someone may override
 --summary-limit in the shell alias, but sometime he may want to  bring
 back the unlimited behavior in the command line.


 > >
 >  > For beauty and clarification, the last commit for each section (backward
 >  > and forward) will always be shown disregarding the given limit. So actual
 >  > summary size may be greater than the given limit.
 >  >
 >  > In the same super project of these patch series, 'git submodule -n 2
 >  > summary sm1' and 'git submodule -n 3 summary sm1' will show the same.
 >
 >  This description is unclear.  Does "-n 2" tell "show 2 commits from both
 >  side", or "show 2 in total"?
 >
 I should make it clear that -n means 'in total'.

>
 >  > ---------------------------------------
 >  >  $ git submodule -n 2 summary sm1
 >  >  # Submodules modifiled: sm1
 >  >  #
 >  >  # * sm1 354cd45...3f751e5:
 >  >  #   <one line message for C
 >  >  #   <one line message for B
 >  >  #   >... (1 more)
 >  >  #   >one line message for E
 >  >  #
 >
 >  When you have room only for N lines, you might have to say (X more), but
 >  you never need to say (1 more).  You can fit that omitted one item on that
 >  line instead of wasting that line to say (1 more).
 >
 make sense.


 >
 >  > +             -n|--summary-limit)

>  > +                     if test -z "$2" || echo "$2" | grep --quiet -v '^-\?[0-9]\+$'
 >
 >  \?\+?????
 >
 >         summary_limit=$(expr "$2" : '[0-9][0-9]*$')
 >
 >  or even
 >
 >         if summary_limit=$(( $2 + 0 )) 2>/dev/null ||
 >            test "$2" != "$summary_limit"
 >         then
 >                 usage
 >         fi
 >
 >  perhaps.
 >
 >  > +                     if (( $summary_limit < 0 ))
 >
 >  Don't.  The first line of this script says "#!/bin/sh", not bash.
 >
 ok, i'll fix it.



 --
 Ping Yin
