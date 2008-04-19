From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: branch description
Date: Sat, 19 Apr 2008 23:05:35 +0200
Message-ID: <200804192305.36780.jnareb@gmail.com>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com> <200804182358.31041.jnareb@gmail.com> <200804191118.50105.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matt Graham <mdg149@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Russ Dill <russ.dill@gmail.com>,
	Stephen Sinclair <radarsat1@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Apr 19 23:06:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnKGe-00079x-9r
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 23:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762382AbYDSVFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 17:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762355AbYDSVFm
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 17:05:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:12978 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515AbYDSVFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 17:05:41 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1107481fgb.17
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=U+B1F/GErEbO2EugfvF5n/Ip+/+ZsHUkoNMCcSnXf+g=;
        b=a9OSbP2CWGxzED7AFd2RjETtwvtBpqGVFodQZoE9WwXnND76qLDQ3gSTGTlEn0EyFYVAfZm58Z5+CfDtmOb53G35R/cgXxcs1+COIujQ6wWNcFz6qeYCdcY/ZSGOAKrvJW84VsTfG9jtfvI1Es38TXhKY6/HTfDKBykqeKGFfDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dCSafY7Gn5yU2VaWbTTk+unFv187kfXhJmhE0SiKAj02NEmSn7FVUaCifD6o+JLC1TJBXZ0WtIqMTxM3uCpOTSwym2sdt6R47+vLBv7XW7VY8mSvCuIKMX7w4slALLPO2wePcl7Xh15wsRvfJXBtASrZkLI3WZDxrDKddr33+gg=
Received: by 10.86.84.5 with SMTP id h5mr8765599fgb.55.1208639139734;
        Sat, 19 Apr 2008 14:05:39 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.225.130])
        by mx.google.com with ESMTPS id p10sm3246841gvf.8.2008.04.19.14.05.36
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Apr 2008 14:05:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200804191118.50105.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79920>

On Sat, 19 April 2008, Johan Herland wrote:
> On Friday 18 April 2008, Jakub Narebski wrote:

>> Let me sum up here proposals where to put branch description:
[...]
>> 3. Put them in GIT_DIR/info/refs_description, in some format.  It makes
>>    it very easy to add support for propagation for dumb transports.
>>    Native transport probably would need some extension.  Should not
>>    interfere with the rest of git code.
>> 4. Store description after sha1 in the ref file itself.  Automatic
>>    propagation for dumb transport (whether we want it or not).  Native
>>    transport as above.  Very high probabily of interfering with the rest
>>    of code, especially shell part of Git.  Need to find a place for
>>    descriptions in pack-refs.
[...]
>> 
>> I think that the best proposal is (3), not (4) as you say.
> 
> The problem with (3) vs. (4) is that in (3) we must make sure that whenever
> a branch is moved/renamed (e.g. "git clone", "git branch -m", probably more
> as well), the corresponding description is moved/renamed as well. This is
> elegantly solved in (4). But as you say, (4) may have implementation
> difficulties of its own. I guess the first acceptable implementation will
> win.

First, git already has move corresponding reflog and per-branch
configuration when renaming a branch, so it is nothing new for (3).

Second, implementation difficulties of (4) might be made stronger by
the fact that repository with branches with descriptions should be
fetchable and clonable using both native and dumb protocols by older
versions of git, and shouldn't cause troubles after fetching.  (Assume
that git is new enough to understand packed refs).  Backward
compatibility might kill this solution; but it might not.

BTW. I have added line with description to loose ref, and a few
commands I tried didn't return (cause) any errors... so...
-- 
Jakub Narebski
Poland
