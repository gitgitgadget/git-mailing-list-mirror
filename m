From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] autocrlf: Make it work also for un-normalized repositories
Date: Mon, 10 May 2010 13:30:22 -0700 (PDT)
Message-ID: <m37hnbec16.fsf@localhost.localdomain>
References: <20100510171119.GA17875@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon May 10 22:30:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBZcW-0005mE-F3
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 22:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259Ab0EJUa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 16:30:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:65054 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab0EJUaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 16:30:25 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1782777fga.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 13:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=oI6ec6FnBz+XJ70rWH0Dg/VAOcWjYGIPB6V7V3+DUpk=;
        b=TN7adYqzcAXIq1T/axFA5784ho9pHeT22hJJ7zIXpA/4EreOOqTTwfpC1ubT5V+EU/
         9w7qrlMpkBLjuxq4eLiPGdAnafktH15HizMUYNpO/27D1GRuHxnL0BPFRrOv85iRARe2
         QpgCZJyeNe+2hj2moLBZNRao9NWaMl3gjtswg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=wWTWxBGhX5d3YFyVU5IIb4KghtgX3Ttg5r/Dgc28cIzx5BP+5BvXPMawndevsB+vEG
         M92cDWi7hxCZvSwASqVqN8A0TkzBXKGFnWGHiXUERq7Brop9gTRTvG62pWbNehN5vTUp
         6zMnX7PyhYNCkJPkhtqOvScSPOV8+sPMTGBBY=
Received: by 10.87.73.20 with SMTP id a20mr10344825fgl.67.1273523423517;
        Mon, 10 May 2010 13:30:23 -0700 (PDT)
Received: from localhost.localdomain (abwb94.neoplus.adsl.tpnet.pl [83.8.225.94])
        by mx.google.com with ESMTPS id d8sm10832137fga.21.2010.05.10.13.30.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 13:30:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o4AKTcFq007656;
	Mon, 10 May 2010 22:29:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o4AKTAYT007581;
	Mon, 10 May 2010 22:29:10 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100510171119.GA17875@pvv.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146850>

Finn Arne Gangstad <finnag@pvv.org> writes:

> Previously, autocrlf would only work well for normalized
> repositories. Any text files that contained CRLF in the repository
> would cause problems, and would be modified when handled with
> core.autocrlf set.
> 
> Change autocrlf to not do any conversions to files that in the
> repository already contain a CR. git with autocrlf set will never
> create such a file, or change a LF only file to contain CRs, so the
> (new) assumption is that if a file contains a CR, it is intentional,
> and autocrlf should not change that.
> 
> The following sequence should now always be a NOP even with autocrlf
> set (assuming a clean working directory):
> 
> git checkout <something>
> touch *
> git add -A .    (will add nothing)
> git comit       (nothing to commit)
> 
> Previously this would break for any text file containing a CR

How this feature relates to `core.safecrfl'?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
