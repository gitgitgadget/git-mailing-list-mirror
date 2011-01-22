From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git bisect problems/ideas
Date: Sat, 22 Jan 2011 06:52:34 -0800 (PST)
Message-ID: <m3d3npat5c.fsf@localhost.localdomain>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com>
	<0253BAE3-90F7-492C-ADF5-8B16DFFA1E44@gmail.com>
	<AANLkTikG6Ft3Y922Aaakf28cnYs26PcRHoq9GSNj04mu@mail.gmail.com>
	<201101212304.36741.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	"Aaron S. Meurer" <asmeurer@gmail.com>, git@vger.kernel.org,
	=?iso-8859-15?q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 22 15:52:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgepZ-0002Je-1a
	for gcvg-git-2@lo.gmane.org; Sat, 22 Jan 2011 15:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400Ab1AVOwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jan 2011 09:52:39 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54047 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331Ab1AVOwi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jan 2011 09:52:38 -0500
Received: by wyb28 with SMTP id 28so2771587wyb.19
        for <git@vger.kernel.org>; Sat, 22 Jan 2011 06:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=ZL3caAxyyeDMrn64OB/qvSg5N/KF5+nDBBlBraAHjM4=;
        b=S1djyhEA8tI4oeg1iJpYz2cSjQvDbfaYzpF2gLlApywUqSCsftrmnCf89r8k/nDL5Q
         VWaX6foZDcrkEJqoEEY8t1ZWJSMm38IFqfwRKCXhFLsPTgCajzgQ5H+PrbUB/gI+AK5S
         FMW2UU3EQfii3jdUFaGzhJ7CdzOYaw61Se4Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=tRnvvNjXPiSNs+GWAI30Tz1oRtenKaaNqQxRyE/wKCSbYtfW8hShRZp+g73SugUSsQ
         k9ZeHCpGukNxDSCEHnMVt3T9peF2XLcmsEgDqhlIqX4Nw83EqOyD4z2T27lj0axHgLHH
         MgR0JhrOEnLp+yqEj/SIb3daQhKMKE/lSteGg=
Received: by 10.227.166.13 with SMTP id k13mr2180994wby.178.1295707956480;
        Sat, 22 Jan 2011 06:52:36 -0800 (PST)
Received: from localhost.localdomain (abvp238.neoplus.adsl.tpnet.pl [83.8.213.238])
        by mx.google.com with ESMTPS id f35sm7761464wbf.14.2011.01.22.06.52.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 Jan 2011 06:52:34 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p0MEpnWo016767;
	Sat, 22 Jan 2011 15:51:54 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p0MEpRl2016762;
	Sat, 22 Jan 2011 15:51:27 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <201101212304.36741.j6t@kdbg.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165413>

Johannes Sixt <j6t@kdbg.org> writes:

> On Freitag, 21. Januar 2011, Christian Couder wrote:
> > On Wed, Jan 19, 2011 at 8:44 PM, Aaron S. Meurer <asmeurer@gmail.com> wrote:

> > > If no, I think --reverse is actually a suitable fix.
> >
> > Yeah, but I think that what Dscho started was probably better. The
> > problem is just that it is not so simple to implement and no one yet
> > has been interested enough or took enough time to finish it.
> 
> Let me throw in an idea:
> 
> Add two new sub-commands:
> 
> * 'git bisect regression': this is a synonym for 'git bisect start'.
> 
> * 'git bisect improvement': this also starts a bisection, but subsequently the 
>    operation of 'git bisect good' and 'git bisect bad' is reversed.

I like this!

-- 
Jakub Narebski
Poland
ShadeHawk on #git
