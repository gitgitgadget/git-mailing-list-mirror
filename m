From: Leonid Podolny <leonidp.lists@gmail.com>
Subject: Rebasing multiple branches
Date: Tue, 21 Dec 2010 15:40:43 +0200
Message-ID: <4D10AE5B.2080700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 21 14:40:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV2ST-0007Rt-RP
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 14:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846Ab0LUNks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 08:40:48 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:38904 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab0LUNkr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 08:40:47 -0500
Received: by bwz16 with SMTP id 16so4520738bwz.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 05:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=c2bg3LvmfK8ikwTj8b8Km5OZXZNTXPypCNhEUElTmUo=;
        b=B9l53jWX0V9FytWomxzvXwKZqpj6MwvxVVz1pTnkt1b214CAFBT24DtaENuCfyqw5s
         xRkouLvEooONs6lWKkbnyLq8JsdbLa8LJ/BuifZfuTCkPGopzwq8BSZMQqatNt5w846C
         Stzgig3DIKADqzHKCsZfA/lkYtOe7nPBOxn4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=neJuwjYVibY9uI17USw6bm0qtPs/HaqQ5kA+UHrD/hZNCW3cHjXGi/au30hYiCWqJc
         hs37C5FK23MPLcHYJypAuH2h0X34ML1TGBbH0aMUfVKzZ9kduD/6Tio67mupdVc4Gvc0
         XPEfR6a2aEhxLtJZjE/JnrD5/v+8zDnNN0s7U=
Received: by 10.204.54.69 with SMTP id p5mr4744744bkg.82.1292938846346;
        Tue, 21 Dec 2010 05:40:46 -0800 (PST)
Received: from [10.20.20.19] (80.179.223.9.cable.012.net.il [80.179.223.9])
        by mx.google.com with ESMTPS id q18sm4373290bka.15.2010.12.21.05.40.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 21 Dec 2010 05:40:45 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164032>

Hi,
I need to rebase a rather complicated formation of branches.

My situation is like this (I hope ASCII graphics survive the sending):

         B--o--o--o--o--o--o  <--branch A
        /                   \
o--o--A--o--E  <--master    C--o--o--o--D  <--branch C
        \                   /
         C--o--o--o--o--o--o  <--branch B

I would like to rebase all three branches A, B and C onto commit E, and 
it's very important to keep the information about merges. For instance, 
if I take commit C and rebase it onto D, it serializes all the 
intermediate commits.
The only solution I managed to come up with is as follows:
- Take branch A and rebase it onto D (branch A').
- Same with branch B.
- Open a new branch C' from commit E.
- Merge A' and B' into C'.
- Manually cherry-pick all commits from commit C to commit D into branch C'.


The last step is way too ugly to be the only possible solution :)
