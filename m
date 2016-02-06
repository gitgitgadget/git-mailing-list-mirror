From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v9] ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Sat,  6 Feb 2016 08:23:34 +0200
Message-ID: <1454739816-24007-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 07:24:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRwIZ-0004eX-UN
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 07:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbcBFGYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 01:24:03 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34222 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbcBFGYC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 01:24:02 -0500
Received: by mail-wm0-f51.google.com with SMTP id 128so95797830wmz.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 22:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=IXSbLHqXA1L+aXUiV7deOpJZcUWAta+HS28S9bxRTm4=;
        b=ZchL7nz4nSzWBbk2FEQahZzVUO81dvyk4S3xA3SjaU0M/YWeMkJqp4A6ZosXMAvW/j
         8z/WZL2rfyBoabDXuOUi8lcccsBnNX4+1Zxevh1zMCldydN9HCmykHbkGibmM1gRaMQU
         JblqlHKejXbUcPzjz6M9YHN4Ztof0JZvj99Ffhkxvpz1q/4TZInKN0I2aZPJymQOqTbY
         FSUs6u58ZSBu/zu/0e8SnPk+8xCCLXhqzu77wkgTtE8a1zm23Zm/TTjwazFfub7R+hCA
         1ZVkAQLgpXwsSEFX7NcXmB/uHjFXTlMWxDQ5Dlaq0JwiIyaSYrpzwokF/QAFeGGDFt2F
         Hn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IXSbLHqXA1L+aXUiV7deOpJZcUWAta+HS28S9bxRTm4=;
        b=JjR9c7DtvhlUePy6m6CI3N3rk1PqgnJOnyrXPor0dUOZfqQ7aipincagzf3ThkT4Tx
         vhr52wwCAYNRuvXwwr3jJAk/Hts8DXtfz5TARFg3+OGdGFNG+Mg6bYMYjAdvXqojH4oG
         wHHw5vhOxj+Lpd7Na55JBhBLdJWQzfR4wHBq5iXjmXrzmR9UJuELncJgxDAwED35chQs
         rPj3pxcEndrsYidxQZsETFqRK6VqvSau9sUC3nuTE26sYl3zM2h9RHAz9TkazWo8jZLS
         uqmV+mvmNyFk/MJk2GspLDHXYf5JUMg9eblc2bf/olLFLgVZiPbT0/bHhjvy2oFoixlV
         Mf8w==
X-Gm-Message-State: AG10YOSqDJvX+66GSPFELkreH6AxwK7D5mspKUd2GYYfm2cTZ5KM+OVuX5Eje70RJ0L3lg==
X-Received: by 10.28.7.72 with SMTP id 69mr42184161wmh.50.1454739840560;
        Fri, 05 Feb 2016 22:24:00 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id k130sm1807554wmg.6.2016.02.05.22.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 22:23:58 -0800 (PST)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285681>


Changes between v8 -> v9:

* Rebased and tested on v2.7.1.
* Made a small correction suggested by Junio in the documentation for
  the new option: s/upon/before

v8: http://article.gmane.org/gmane.comp.version-control.git/285646
