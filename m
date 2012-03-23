From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Thu, 22 Mar 2012 17:46:09 -0700 (PDT)
Message-ID: <m3obrob0vk.fsf@localhost.localdomain>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
	<87aa3aw5z8.fsf@thomas.inf.ethz.ch>
	<CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
	<CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: elton sky <eltonsky9404@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 01:46:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAse1-0000bi-I4
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 01:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865Ab2CWAqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 20:46:13 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:40754 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207Ab2CWAqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 20:46:11 -0400
Received: by wibhq7 with SMTP id hq7so1451909wib.1
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 17:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=qt61KxYBOS9JJZ+OBQJZxc5rqGFfryJR0Jidv+akNKU=;
        b=wWGr1HacVDtNG0T2rvYokLCwR41B7gr2m4pxaQAD9MLLZ0eeVxWi8y9w89RWnXrrCX
         vBpLpHQ1jRPTeqy0fPbMEh9isXbohbCqOsaSZcPyR3ALWlUXnauNf6nXTxm15r1ZKNFl
         BMHFXiNf2vAuGw+hzVtX9VA7tMjlxIyV2R6yh6pvVnEP3vADQ17AaXzIhjQA33C9sLTq
         1HIhEzC9sUIEJiqc1Jz1x6IXkJPY+qXEO2IZInAg8sKUxwzb/emOzvFKpdKt4S+6yvJL
         zN5TE7/lnq99tMPpZhzO33IbsfERdE7ma/6eLlC6UFf77VPonHWQgYH/Socwcw+PGOJJ
         cZZw==
Received: by 10.216.145.209 with SMTP id p59mr5917179wej.50.1332463570529;
        Thu, 22 Mar 2012 17:46:10 -0700 (PDT)
Received: from localhost.localdomain (abwe160.neoplus.adsl.tpnet.pl. [83.8.228.160])
        by mx.google.com with ESMTPS id ff2sm15604230wib.9.2012.03.22.17.46.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 17:46:09 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2N0k8xJ007639;
	Fri, 23 Mar 2012 01:46:09 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2N0k7cN007636;
	Fri, 23 Mar 2012 01:46:07 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193740>

elton sky <eltonsky9404@gmail.com> writes:

> Got a few questions:
> 
> 1. index is used for building next commit, so it should only include
> files created/modified/deleted. But I see it has all entries for
> current working dir. why?

Because git is snapshot based, not changeset based.  Ecah commit
stores state of repository in the form of 'tree' object, which is
build out of index.
 
Also index stores extra information, like mtime, about all files
to make operations faster (skip unchanged files).  The index was
originally at the very beginning named dircache.

[...]
-- 
Jakub Narebski
