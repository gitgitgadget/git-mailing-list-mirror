From: Jakub Narebski <jnareb@gmail.com>
Subject: [1.8.0] split largest remaining scripts, gitk and gitweb
Date: Tue, 01 Feb 2011 10:26:08 -0800 (PST)
Message-ID: <m38vxzaa03.fsf_-_@localhost.localdomain>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<7vwrll57ha.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.1101311459000.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 19:26:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkKvi-0002L9-2o
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 19:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693Ab1BAS0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 13:26:12 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39592 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab1BAS0L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 13:26:11 -0500
Received: by ewy5 with SMTP id 5so3313111ewy.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 10:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=iVsCzGNCyhXc309iV8VwwgOYjP80Y7JSTomQDy1B3M4=;
        b=N5+VAODco9Gy+9CG5FVlleYYKDAmXw8n6RnWJq2h25UwRgqX3G5fSd9VAjpSMPw6sk
         UTrvCslBV4NUXW+ElqR2SwKkINl+UNf4kQ0OK+ZfVPUiIqC8GkwGb9OtJpXAD5DBKm8E
         0eMhNYf98NFSiBHZEb47TLekgquQgRb4KgA5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Fu7yQUIswIepVu2vLJDNNc0isYTXLwy+82CmY4ybkBvH7z6EzDqmtC9AJchsjsN1/D
         mlIfVZ0ZfvklDzMdcVuHK+ZDjfh/3zHyu8NnUGGP6R1aDNOy7kjGwx2h1Simtj7THN+d
         4jqou/GNZ2kQHpbWXETYGrLxQaLdNMcWfJY8o=
Received: by 10.216.150.129 with SMTP id z1mr7375320wej.113.1296584769909;
        Tue, 01 Feb 2011 10:26:09 -0800 (PST)
Received: from localhost.localdomain (abuz232.neoplus.adsl.tpnet.pl [83.8.197.232])
        by mx.google.com with ESMTPS id o19sm11606051wee.26.2011.02.01.10.25.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 10:26:08 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p11IP6GV014021;
	Tue, 1 Feb 2011 19:25:17 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p11IOT1b014016;
	Tue, 1 Feb 2011 19:24:29 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165839>

Two largest files in git repository are gitk and gitweb, see the
output of the following command

  $ git ls-tree --abbrev -r -t -l v1.7.4 | sort -k4,4 -n | tail

I can't say much about splitting gitk, besides the fact that git-gui
which was of comparable size IIRC got split into smaller files; I
guess similar thing could be done for gitk.


There was an attempt (ultimately failed) on splitting gitweb during
Google Summer of Code 2010.  At least providing infrastructure for
multiple gitweb modules is very much required for adding
code-intensive new features, like gitweb output caching.

On the other hand this might make gitweb harder to install...


Next in size is compat/nedmalloc/malloc.c.h (I don't know if it can be
reduced in size), and git-svn.  I think we could separate core
functionality into Git::Svn module or something, and make git-svn
smaller (perhaps reusing some code in/from svn remote helper).


What do you think?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
