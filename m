From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Sat, 20 Jan 2007 01:59:14 +0100
Message-ID: <200701200159.15355.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <200701192344.11972.jnareb@gmail.com> <Pine.LNX.4.63.0701200100530.12889@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 01:58:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H84Z6-0004Uu-LR
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 01:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbXATA6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 19:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbXATA6i
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 19:58:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:37483 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965011AbXATA6h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 19:58:37 -0500
Received: by ug-out-1314.google.com with SMTP id 44so596080uga
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 16:58:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XGFmQyPk5Ud1YfybfJENY+rSSFnGoycGELd17FH8/2YKkO2SjhbvgXpKGuASAoWVLt7igZZdYmSrd5+ee3v38ckZNQzA2liAgpRx+be99cUm+btmG4TBEKUQga4v8FVef0UX9GickPiEVogfP7feoHnWI0jh/Fh/6XHXbrN0Kfg=
Received: by 10.67.96.14 with SMTP id y14mr4018761ugl.1169254715717;
        Fri, 19 Jan 2007 16:58:35 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id 54sm3401955ugp.2007.01.19.16.58.35;
        Fri, 19 Jan 2007 16:58:35 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0701200100530.12889@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37236>

Johannes Schindelin wrote:
> 
> On Fri, 19 Jan 2007, Jakub Narebski wrote: 

>> +in the section header, like in example below
>> +
>> +	[section "subsection"]
> 
> I wonder if we should also mention the (case insensitive) alternative 
> "[section.subsection]", to give a better idea to people why we actually 
> check for "section.subsection" in the code.

I'm not sure. "section.subsection" can be treated as section with that
name, strange because it has '.' in it, and not subsection "subsection"
of section "section". git-repo-config writes section with subsection
in above format.
 
>> +All the other lines are recognized as setting variables, in the form
>> +'name = value'. If there is no equal sign on the line, the entire line
>> +is taken as 'name' and the variable is recognized as boolean "true".
>> +Variable names are case insensitive.
> 
> They cannot contain anything else than alphanumeric characters, in 
> particular no whitespace.

Contrary to for example also ini-like smb.conf:
  Leading, trailing and _internal_ whitespace in section and parameter
  names is  irrelevant.

>>					 There can be more than one value
>> +for a given variable; we say then that variable is multivalued.
> 
> Maybe give the example of "remote.<name>.fetch" to explain why? Or maybe 
> not.

I put it because in this git config differs from standard ini-format.

>> +The following escape sequences (beside `\"` and `\\`) are recognized:
>> +`\n` for newline character (NL), `\t` for horizontal tabulation (HT, TAB)
>> +and `\b` for backspace (BS).  No other character escape codes, nor octal
>> +char sequences are valid.
> 
> I did not even know about BS! Does it make sense to allow it, really?

That is the question I'm also asking...

>> +Some variables may require special value format.
> 
> I think you can safely skip that; it should be evident that the format of 
> the variables depends on the purpose.

This was in the original, and I think it is better left (at least for now).

I wonder if to write about --bool and --int formats...
-- 
Jakub Narebski
Poland
