From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] configure: use AC_SEARCH_LIBS instead of AC_CHECK_LIB
Date: Tue, 21 Jul 2009 17:20:25 +0200
Message-ID: <4A65DCB9.3030207@gnu.org>
References: <m34ot9c67t.fsf_-_@localhost.localdomain> <a52be8ba36206abc5ff5c91a759036a931e2658c.1248007036.git.nicolas.s.dev@gmx.fr> <6WnEB0at_uuAu9kicWjrHLsBbTv58WtCNOANkKzk-SqTgqjuWyh8WA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	David Syzdek <david@syzdek.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jul 21 17:20:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTH90-0007FI-PW
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 17:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319AbZGUPUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 11:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755306AbZGUPUd
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 11:20:33 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:53336 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbZGUPUb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 11:20:31 -0400
Received: by ewy26 with SMTP id 26so3132629ewy.37
        for <git@vger.kernel.org>; Tue, 21 Jul 2009 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=7OIvfbvqeZn2GBwmToEbOUIPpBTBizww2hE8Rp17NUo=;
        b=VW2z35z24WjPju27/eV1uj9N1ELhCB0I/3Y9i6vEOi34X/qbtWfw+XFXjLTVw0I+mL
         LJzD/+OxIMhQ6e3MGae8z6RS9wEbNdnjMQLY0PrdB9A2SxzmwJDgT9Nm/lmrT/jz8tvh
         I07yV08nkxNOiMP1ma8plFhlwcGTLjf3bhxGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=KVDkAG09ieCpZSFhUWQL4VVgBXvME0ZVSGE/cHfVl00WlR+78L2B+P1pGuwtDl1h/x
         fXhmR/2WQZDloX6EiY9bbSosHYBlQsru3usUkyj37c+7QuC/KTWGlLd/fJe0O9Fh61HS
         f5K+kSs51Iv8p5vIL6Dcjnxric3SDYxA3qjzY=
Received: by 10.211.168.4 with SMTP id v4mr5280988ebo.82.1248189629162;
        Tue, 21 Jul 2009 08:20:29 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 7sm13605334eyb.45.2009.07.21.08.20.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Jul 2009 08:20:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <6WnEB0at_uuAu9kicWjrHLsBbTv58WtCNOANkKzk-SqTgqjuWyh8WA@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123663>


> With AC_SEARCH_LIBS, which of [action-if-found] or [action-if-not-found]
> is executed if the function is found in the standard c library i.e. "calling
> `AC_LINK_IFELSE([AC_LANG_CALL([], [function])])' first with no libraries"?
> Is the answer neither?  If the answer is [action-if-found], won't the
> NEEDS_LIBGEN=YesPlease be set when the function is found in the c library?

It evaluates the action-if-found and adds nothing to LIBS.  Instead, if 
it is found in a library, it evaluates the action-if-found after adding 
(actually prepending) -lBLAH to LIBS.

Paolo
