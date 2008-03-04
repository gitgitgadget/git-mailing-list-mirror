From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: add a setting to control the tabstop width
Date: Tue, 4 Mar 2008 01:08:57 +0100
Message-ID: <200803040108.58243.jnareb@gmail.com>
References: <20080303221159.GA6875@hashpling.org> <200803032333.29426.jnareb@gmail.com> <20080303225200.GA8145@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 01:09:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWKj7-0003lN-D2
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 01:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbYCDAIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 19:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756918AbYCDAIx
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 19:08:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:8763 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763089AbYCDAIu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 19:08:50 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2342831ugc.16
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 16:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=IvDyo5nFIImxhfZmzcpUOUvXLdJTvp4rg5UAlxCJcOM=;
        b=QbKhqDyEi9BQTWjWdg4Ee3dQNFgSzd1OGJ7q0RLPp7jbk8NP88gD2pM4lNFg+vv+4z3nvxj2UcCbD4asOU9VE+LO7GC1CMEYbyWqlJ0ii7KPRGdoYGNNK98vBGTBSbKQ5+6xUAzHfldMwMvx4zMYS7kWadEoKCKFZaGuqYAMFN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=P94nWSRbs0xjKeFUKS5OuwnSWFMv3ZC9hUuImIni4/6Yj5Ljjewr3vMU7dNQve+PCzr6AHccVByAc1PJGjIIL8Y3CvUEv6Od1UdwA4ph7WdsLmSEDPFP4x+2iXTf50U0novWCrWgDbbZqinqJbBXW7dOz3kUVZuSXnHH3YkjoeY=
Received: by 10.78.193.19 with SMTP id q19mr1674051huf.15.1204589326620;
        Mon, 03 Mar 2008 16:08:46 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.251.32])
        by mx.google.com with ESMTPS id 35sm1016705nfu.5.2008.03.03.16.08.43
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Mar 2008 16:08:44 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080303225200.GA8145@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76002>

Charles Bailey wrote:
> On Mon, Mar 03, 2008 at 11:33:28PM +0100, Jakub Narebski wrote:
>> Charles Bailey <charles@hashpling.org> writes:
>>> 
>>> The untabify function seems the sensible place to make the change. As
>>> untabify is called once per line from various different locations it
>>> also makes sense to cache the result of the config lookup in a package
>>> variable, though this makes the change slightly less neat.
>> 
>> Since b201927 (gitweb: Read repo config using 'git config -z -l')
>> repository config is cached in %config hash (per repository), so
>> I don't think global / package variable $tabstop_width is really
>> needed...
> 
> Fair point, although we still save the cost of some 'is the config
> variable overrideable and if so is it overriden' logic.  Untabify is a
> once per line call which is more frequesnt than most gitweb config
> checking calls.

Good enough.

One think I'd worry about is interaction with mod_perl (or FastCGI),
namely if $tabstop_width wouldn't get stale information.  Perhaps
writing

  our $tabstop_width = undef;

as initializer would be enough.
-- 
Jakub Narebski
Poland
