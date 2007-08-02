From: "David Symonds" <dsymonds@gmail.com>
Subject: core.gitproxy and non-git protocols
Date: Thu, 2 Aug 2007 15:21:53 +1000
Message-ID: <ee77f5c20708012221j4d75ff0dl8fbf16cdaf1401bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 07:22:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGT8U-0006o1-Ho
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 07:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbXHBFVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 01:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbXHBFVy
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 01:21:54 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:53814 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbXHBFVy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 01:21:54 -0400
Received: by rv-out-0910.google.com with SMTP id k20so328038rvb
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 22:21:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TBsnvjt1hMNKI5ug7VYR6GCvWAzmGlMUdURGxr4UFHipHf6HgYc7idH+oGqZYRUdJCjJRRf4vJLC77+gFpV/hlc0yg24WXuMz/CavaLTRTPq6QeFI/Qo5QMz5oZQLQJA7QroFa3nV1pf4mhVZ++O8okqSRMbHyE2ssL4VOu0ALc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QOYAih0gkQUi7nDdcLH14bb7W0PHn6UeNQKxgBdc8J0nvlOM0NmTuMAhfR4N0t0eQ1uA/h8+sgg8LgppbngFUEhj8nx/rfZ3GxAFw+L1uNcx656YMZGAYskrfQu6Nm/p1jsnCnY7UXF5so+4T/KnN8PycMlQAv2ZJR5jVbpfHqw=
Received: by 10.141.172.6 with SMTP id z6mr529589rvo.1186032113574;
        Wed, 01 Aug 2007 22:21:53 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Wed, 1 Aug 2007 22:21:53 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54513>

Hi,

The part of the git-config documentation that covers core. gitproxy is
incorrect: you can't use the core.gitproxy setting to use a proxy
command for ssh://, nor to create your own faux-protocols. In the
git_connect function (connect.c), it only references git_proxy_connect
(and thus the core.gitproxy setting) if (protocol == PROTO_GIT).

I have a situation where I'd like to push to a remote git repository
on a machine that is a little weird to access, so I need two different
types of ssh'ing to reach it depending on my location. That is easily
scriptable, which is how I did it with SVN (ended up with a
svn+voltron:// protocol), but is not currently possible with git.

It'd be great if (a) the documentation could be fixed, or (b) the
proxy-picking code could be at least extended to ssh:// protocols, and
preferrably extended to defining custom protocols.

Thanks,

Dave.
