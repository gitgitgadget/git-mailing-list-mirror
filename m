From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Tue, 16 Jan 2007 15:14:47 +0100
Message-ID: <200701161514.47908.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <7vwt3nxnak.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701161206050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Nikolai Weibull <now@bitwi.se>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 15:14:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6p55-0001rB-T0
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 15:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbXAPOOa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 09:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbXAPOO3
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 09:14:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:31909 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbXAPOO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 09:14:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1682435uga
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 06:14:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qqEDhP65yeHa8RADOUl+B9V7kxIJSfQMxfKFnYBeDownwpoLafgQyulYZQgtoNNHNCIMjIMHiZjZV0hSz17Yd+daqgY7Hco55ssQ06LJkoRY1/2Ms6zukCd62lu/Xy1lgdgJ3LGgPBUKIFG+31b8b1RWmvclr3Khu6VvgsvxgAw=
Received: by 10.67.26.7 with SMTP id d7mr7547840ugj.1168956867018;
        Tue, 16 Jan 2007 06:14:27 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id 54sm8692975ugp.2007.01.16.06.14.26;
        Tue, 16 Jan 2007 06:14:26 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0701161206050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36938>

Johannes Schindelin wrote:

> On Tue, 16 Jan 2007, Junio C Hamano wrote:
> 
>> "Nikolai Weibull" <now@bitwi.se> writes:
>> 
>>> If we're going down this slippery slope, why not just give up and add
>>> a --xml switch instead?  Readable by all...
>> 
>> Perhaps all except humans.
>> 
>> At least YAML, please...
> 
> I am _strongly_ opposed to all that rubbish. _If_ we want to use 
> repo-config to preformat the config variables, we should either
> 
> 1) just use "git repo-config -l" and STFU, or

> P.S.: The more I think about it, we should just use the output of 
> "repo-config -l".

It wouldn't work. Subsection and value are (almost) free form, and
they can contain '=' in them.

But I agree that XML is serious overkill...

> 2) introduce something like "--dump" which Eric implemented.

It would be probably best to introduce --dump which would output
config file _as if_ it was written by git-repo-config (probably
without comments).

All values would be in separate lines, there would be only one
section header per each section, values would be quoted if needed
(if they contain comment delimiter, '=' or whitespace).

E.g.

  [section "subsection"] key=a " b; " c; " d; "

would get rewritten as

  [section "subsection"]
  	key = "a  b;  c"

-- 
Jakub Narebski
Poland
