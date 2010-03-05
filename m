From: Jiri Slaby <jirislaby@gmail.com>
Subject: gitignore broken in git 1.7.0.1: slash checks leading dirs
Date: Fri, 05 Mar 2010 09:55:29 +0100
Message-ID: <4B90C701.3070308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 05 09:55:50 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnTJz-0001ig-Tq
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 09:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab0CEIzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 03:55:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:27670 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab0CEIzc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 03:55:32 -0500
Received: by fg-out-1718.google.com with SMTP id l26so147780fgb.1
        for <multiple recipients>; Fri, 05 Mar 2010 00:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:x-enigmail-version
         :content-type:content-transfer-encoding;
        bh=bkwPcRClV0JGXxdSmVwBXZUlbhOBDuduTdimcD4ZlsU=;
        b=uglHY49UzZ6nShXuAN7nJEKWu1hcc2ejoQQxD3jumfCFb+filFUO9MorRFUwviAiJj
         c9H/bz/Y/iKekxMrbUm5wnJgTVcZqEp/58hNlLWRk9t5OcyMfu7ti7waTXQ1f3IwVEpO
         zcwcN2dGkH1+DOFaffPXZcoR/h9QDJtlO/DAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=FFVCzk5fLPqMxAHX+sHxmYO27g0PXroA9EJBOxzcuPBz4oEYLCPWR75HZ7Gr5YXTBU
         n/mbskBHiVMhiATuf7xSjA2TUPxzRaUUhCBNT7rAB2eBupRuB4r65Y8kKaRTXJJSO9FF
         dS6xXWOzxqdYY/+uWm73jBFMY0VDg2NjOenrY=
Received: by 10.87.66.29 with SMTP id t29mr644645fgk.49.1267779330596;
        Fri, 05 Mar 2010 00:55:30 -0800 (PST)
Received: from [192.168.2.129] ([217.66.174.142])
        by mx.google.com with ESMTPS id d4sm447856fga.8.2010.03.05.00.55.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 00:55:30 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; cs-CZ; rv:1.9.1.7) Gecko/20100111 SUSE/3.0.1-11.2 Thunderbird/3.0.1
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141564>

Hi,

having 'linux' line in .gitignore makes 'include/linux/vga_switcheroo.h'
to be ignored though the documentation says:
***
If the pattern does not contain a slash /, git treats it as a shell
glob pattern and checks for a match against the pathname without
leading directories.
***

$ touch test
$ touch include/linux/vga_asdads.h
$ git ls-files -o --exclude-from=test
include/linux/vga_asdads.h
test
$ echo linux >test
$ git ls-files -o --exclude-from=test
test

This does not happen with git 1.6.

thanks,
-- 
js
