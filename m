From: Lars Schneider <larsxschneider@gmail.com>
Subject: [RFC] Clone repositories recursive with depth 1
Date: Wed, 11 Nov 2015 15:09:18 +0100
Message-ID: <DE5B8B46-B185-4258-A1C8-07E46072CD5D@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 11 15:10:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwW5V-0005jy-Uf
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 15:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbbKKOJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 09:09:21 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35588 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbbKKOJU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2015 09:09:20 -0500
Received: by wmdw130 with SMTP id w130so114316547wmd.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 06:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=G793v/SABT2JX+1+q6Cq9SXHAWo7QAhwvnsJND0+/F4=;
        b=PHVKdbL+thd23Mjp8n12SXMJ/5iywVfULx1ciT0qCEfet2sUbkYCCLFb2J4TuoXL1g
         pP1p8T8yiqZ6xZTtREAr9oyoycvQ/I4brv1MC2yqLfp8KczCKt7lVCeMAJZG805VN8LY
         kEwDI2pwibBjju3xoGRgHVjvqdEVBf/scjyv0UE8in4qDHT55MvKSpStNF7TcsImMk7v
         nUgvW11sBVxyDlA4rpKoJGBKjD6HY1DOFuYqnKbcdC+QFtHV1/l1db+4Ugz/CMZvabjC
         q+nxfKFsCD0jD29w+X8eJ0VSV0wAt/58jsbDnfSxj59fXhN57KPil5yaaWC0z2e4YgQt
         Y4GQ==
X-Received: by 10.195.11.101 with SMTP id eh5mr10427825wjd.104.1447250959689;
        Wed, 11 Nov 2015 06:09:19 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w67sm9773155wmw.17.2015.11.11.06.09.18
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2015 06:09:19 -0800 (PST)
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281163>

Hi,

I have a clean build machine and I want to clone my source code to this machine while transferring only the minimal necessary amount of data. Therefore I use this command:

git clone --recursive --depth 1 --single-branch <url>

Apparently this does not clone the submodules with "--depth 1" (using Git 2.4.9). As a workaround I tried:

git clone --depth 1 --single-branch <url>
cd <repo-name>
git submodule update --init --recursive --depth 1

However, this does not work either as I get:
fatal: reference is not a tree: <correct sha1 of the submodule referenced by the main project>
Unable to checkout <correct sha1 of the submodule referenced by the main project> in submodule path <submodule path>

How would you clone the repo? Is the behavior above expected? If not, should the "--depth 1" flag be applied recursively to all submodules on a clone --recursive? Has a patch implementing this a chance to get in?

Thanks,
Lars