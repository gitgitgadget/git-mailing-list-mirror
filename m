From: =?UTF-8?Q?Antonio_Garc=C3=ADa_Dom=C3=ADnguez?= 
	<nyoescape@gmail.com>
Subject: Re: git-http-backend and Authenticated Pushes
Date: Tue, 9 Mar 2010 20:23:48 +0100
Message-ID: <2b8265361003091123g780a9b36g5ec641d465c7df02@mail.gmail.com>
References: <46a47f951003090908s62512bd7xcbb707205958e004@mail.gmail.com>
	 <2b8265361003091101x1e3a3410hc3be2446dc7ddce@mail.gmail.com>
	 <64E1366D-31FC-4E0D-9F7D-35E6387E2EC1@bjhargrave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ryan Phillips <ryan@trolocsis.com>, git@vger.kernel.org
To: BJ Hargrave <bj@bjhargrave.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 20:23:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np524-0007Rp-Nt
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 20:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597Ab0CITXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 14:23:51 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:51820 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab0CITXu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 14:23:50 -0500
Received: by fxm5 with SMTP id 5so1715003fxm.29
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 11:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=wEs+DI+u4tRDp6zJqoiEJXuSNvOCGmEPklRDB1KpIZo=;
        b=R2+0iyWFo4tpn4GYaX0U0BuXq2mQMC3R38HBeuiEFkgS6Z39hS339hW+TdHvjHB+tn
         eg0F1CADE9MF0rfVgQLaz4cppj6YA24hGwMrL1WFEKwZU87EezIwBVjFN6Z+ckvPwdOG
         lIjr8yROqGGYx+gDxY/yUfbFy9vSZ75gzbSRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Dj4DkjXlUPw85oysUxRq6xkeys3+H2eJXWpua499nCi2SMtw53sWFgtRYYav2PUjOM
         GsKDrutDVuTo6anHqOUu52gx8257X8QUkT4o5J5bfaz2wNz1MuhNO2FVnKyc0sqklW+C
         PXeJ9m0wuutZgjifmvaMLLTwPe6ABclX0XxFk=
Received: by 10.87.63.33 with SMTP id q33mr942657fgk.24.1268162628278; Tue, 09 
	Mar 2010 11:23:48 -0800 (PST)
In-Reply-To: <64E1366D-31FC-4E0D-9F7D-35E6387E2EC1@bjhargrave.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141842>

Hi BJ,

> LocationMatch will not match against the query string which is where the service name is. To match against the query string, you would need to do something like:

Oops, you're right. I'm actually matching the unparsed URL using a
regexp in a Perl authentication module, so I missed that Apache
detail. Your snippet looks good to me.

> But, I would think using <LimitExcept GET PROPFIND OPTIONS REPORT> to protect against "writing" to the repo without auth should be sufficient.

But that doesn't work for the smart HTTP method. Limiting by method is
OK for dumb HTTP (as we're basically just modifying files using
WebDAV), but the git-http-backend CGI only uses GET and POST, and
requires authentication depending not on the HTTP method, but what
service is being used.

Or so I think :-).

Cheers,
Antonio
