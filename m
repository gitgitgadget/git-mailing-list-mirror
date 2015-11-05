From: David Turner <dturner@twopensource.com>
Subject: File owner/group and git
Date: Wed, 04 Nov 2015 21:03:57 -0500
Organization: Twitter
Message-ID: <1446689037.4131.47.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 05 03:04:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu9uJ-0001A9-4V
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 03:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031597AbbKECEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 21:04:01 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36647 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030919AbbKECD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 21:03:59 -0500
Received: by qgad10 with SMTP id d10so55853923qga.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 18:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:organization:content-type
         :mime-version:content-transfer-encoding;
        bh=PkCaFh1lEY8CRJkWkDsx77YJkCSoBN4IIqngemsSOe8=;
        b=Z6vljHjFRGKLKbT8Nq8SHWK7YhLu+5sXyoOt4ByMB28chLMmpqeAgOObYMw08mW2/x
         9JZ91qLBCsIpudpr3Lyo5wvnWfSe5FXsHvw9Vb1DA5vDVpaxYXzct1eFIe9p+KXTVQjV
         u6MW0X07aCg7S4v9tmHhQug/AudT1n85EeTt0PvCqb8autaMosHMtrMsd5YDltpbZg8e
         Q2r18g3S9Rvn3nq/qnK60yQ4DpjSkT3pLQizMNjqN26yFlDL/eUHjDIb4Z0hs2sorpUr
         5mVr/BT2Q7LYoz+R26XpgJOk/xEzzPwKMIxn9tZFHqIdc0KeD4s6xT9/pe83Mi9eQVCN
         LpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=PkCaFh1lEY8CRJkWkDsx77YJkCSoBN4IIqngemsSOe8=;
        b=mHFsdS8Rk90DHJlaVdnAaDJMGfHdkQsJgKd0wPaD1aRr8TheelYDegyVohZ0DyIFGU
         2mLcomUlbdoqfu0nzcHNfy2x7EpatW8Cd4tWrDXnKCbAUJE2SyRrwVxhy3HeN6/EHo3w
         w8UV78WtoHFG01FewBFx+sRJzw93vaueIAlt+3HFbYy+xoz+vfKMRj4xnS/1bXT3SaMA
         zhBe6IzBMvHtGHcEGrsj8Kttux0QAzbf4UI6skcOLLHBfrDPQoks+otXtB2/HRS2cveE
         gZoWherTYdTI4BirjYlP6fFiAj+CV8Pv7trQIDK/CpQN8gXtnrT0qxf4qfm1haLAvNug
         Cw6A==
X-Gm-Message-State: ALoCoQn7lYjKTBwjzSSzAm1D2N7MHN4SgW2Yhg4xFIrFPXBZuRCFNShdkt8fNBLXttv/4LI32ira
X-Received: by 10.140.250.11 with SMTP id v11mr5086753qhc.60.1446689038613;
        Wed, 04 Nov 2015 18:03:58 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 16sm1085681qhe.9.2015.11.04.18.03.57
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 18:03:58 -0800 (PST)
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280893>

In unpack-trees.c, in verify_uptodate_1, we check ie_match_stat.  This
returns OWNER_CHANGED if a file has changed ownership since the index
was updated.  Do we actually care about that particular case?  Or really
anything other than DATA_CHANGED?

(We noticed this due to a bug in our watchman code, which fakes up the
owners, but it's a general question).
