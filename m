From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: support the rel=vcs microformat
Date: Fri, 09 Jan 2009 15:56:07 -0800 (PST)
Message-ID: <m3ocyg11bb.fsf@localhost.localdomain>
References: <20090107042518.GB24735@gnu.kitenet.net>
	<gk2794$djn$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 00:57:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLRET-0006yl-31
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 00:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbZAIX4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 18:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754253AbZAIX4N
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 18:56:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:11760 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbZAIX4M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 18:56:12 -0500
Received: by ug-out-1314.google.com with SMTP id 39so70099ugf.37
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 15:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=egQjP2sVsCRXMoMrBcL0SnpgMdwdzHVkivF0HpLcC48=;
        b=EMwRCnEPs85zoCpXl3IEXKQNCKYIV9fRfO5K7/jh+kgaA/379JQTRcNpj9iZBROpLJ
         49zTonQ6TFoGpDQTMC7HRkbfIk1rQe/JAKie27I2qTon9goGUSpvPDIdnNESTzzg1dSR
         TyNJuCE/PIk8yEOi6SeHLheW7pGme/lJfRm5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=PDve3mYfT7KQFYMuh2OEgbetfoemzQanPSjMdFUjRo29yzM5Bc/MaD2rJ2HrLNNr2S
         V2U6FEzDy+pr9tAsxzWAsI3In8HyxQu0A7+5K8Qpg0iqsXzBEJ65D2TCsZUL57aO5JuP
         simnbJkFqUf5ru3hwOJ6FEthZ/ZlIzJFK7mG0=
Received: by 10.67.103.11 with SMTP id f11mr12757173ugm.12.1231545369976;
        Fri, 09 Jan 2009 15:56:09 -0800 (PST)
Received: from localhost.localdomain (abwp34.neoplus.adsl.tpnet.pl [83.8.239.34])
        by mx.google.com with ESMTPS id 30sm64731384ugf.13.2009.01.09.15.56.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 15:56:07 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n09Nu8d6028218;
	Sat, 10 Jan 2009 00:56:09 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n09Nu8pu028215;
	Sat, 10 Jan 2009 00:56:08 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <gk2794$djn$1@ger.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105047>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> On Wednesday 07 January 2009 05:25, Joey Hess wrote:
> 
> > The rel=vcs microformat allows a web page to indicate the locations of
> > repositories related to it in a machine-parseable manner.
> > (See http://kitenet.net/~joey/rfc/rel-vcs/)
> 
> Interesting idea, I like it. However, I see a problem in the proposed
> implementation versus the spec. According to the spec:
> 
> """
> The "title" is optional, but recommended if there are multiple, different
> repositories linked to on one page. It is a human-readable description of the
> repository.
> [...]
> If there are multiple repositories listed, without titles, tools
> should assume they are different repositories.
> """

Good catch.

> 
> In this patch you do NOT add titles to the rel=vcs links, which means that
> everything works fine only if there is a single URL for each project. If a
> project has different URLs, it's going to appear multiple times as _different_
> projects to a spec-compliant reader.
> 
> A possible solution would be to make @git_url_list into a map keyed by the
> project name and having the description and repo URL(s) as values.
> 
> Since there is the possibility of different projects having the same
> description (e.g. the default one), the link title could be composed of
> "$project - $description" rather than simply $description.
> 
> Note that both in summary and in project list view you already retrieve the
> description, so there are no additional disk hits.

Wouldn't "$project git repository" (i.e. do not use description at
all) be a simpler, faster and also _better_ solution?
 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
