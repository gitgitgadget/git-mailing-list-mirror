From: =?utf-8?Q?Mislav_Marohni=C4=87?= <mislav.marohnic@gmail.com>
Subject: Commit with an empty message broken since v1.8.2.1
Date: Sat, 25 May 2013 21:12:06 +0200
Message-ID: <195A1F16-B587-4217-97BF-6A92DA8C0786@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 21:12:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgJt3-0004C8-CQ
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 21:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757733Ab3EYTMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 15:12:12 -0400
Received: from mail-bk0-f48.google.com ([209.85.214.48]:62849 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757707Ab3EYTMM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 15:12:12 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf20so1598129bkc.35
        for <git@vger.kernel.org>; Sat, 25 May 2013 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version:x-mailer;
        bh=ijBWU3pVx9K0YUEyHuZewYnYUz1ZBU/1rsIpZgWsjZo=;
        b=nsBuzYuPkCnBUq300ZrpXCD+hK2FWF/7eIQ8doDbWcY6uTe9V3j9LNzbHDX62v5c5n
         q4Its3w31GWJnk0TdvAVH3vyP+L0NgUoaIHo0LvU0B0aYmL99asLazKxnMB9xPVSDClA
         rYb0BUiOwSkwX7cxz0jt/wFmH24R5skmIMllUlLGtk+475CSVrGX1seNGjkGwVSbcQms
         6wJEmZH2JP3UWjcx9CIGpyJI4A5lQOvpbA8NWAJGZWoBN+g4tMCANalnJzmhk701ZJtz
         xLZEUGbd9hjglCUL2pSqj7wEP07fhnmvFrwGZzzoWymbD2jiSXeQvhACAtXymJVgaAVf
         5cTw==
X-Received: by 10.205.38.195 with SMTP id tj3mr10626547bkb.67.1369509130684;
        Sat, 25 May 2013 12:12:10 -0700 (PDT)
Received: from mislav.lan (93-138-115-167.adsl.net.t-com.hr. [93.138.115.167])
        by mx.google.com with ESMTPSA id fh8sm6094521bkc.10.2013.05.25.12.12.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 25 May 2013 12:12:09 -0700 (PDT)
X-Mailer: Apple Mail (2.1503)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225529>

Commit a24a41ea9a928ccde2db074ab0835c4817223c9d introduces a bug which is still present in latest master.

This command 

    git commit -m "" --allow-empty --allow-empty-message

should create an empty commit with an empty message and never open a text editor for the commit message. Since the change, the editor is always opened.

My current workaround to skip the editor is setting the environment variable:

    GIT_EDITOR=true