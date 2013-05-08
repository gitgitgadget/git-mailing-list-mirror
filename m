From: Michael Hunley <michael@codecobblers.com>
Subject: stdout versus stderr for cmd line git
Date: Tue, 7 May 2013 18:48:33 -0700
Message-ID: <CAKk5qjVoDUzeurgAL51jixXsm4rJCMCDf620vAv_Gsafk8N7iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 03:48:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZtUw-0004C9-FV
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 03:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715Ab3EHBse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 21:48:34 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:64068 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab3EHBsd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 21:48:33 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so2276431iee.13
        for <git@vger.kernel.org>; Tue, 07 May 2013 18:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type:x-gm-message-state;
        bh=h+n++ahms8x5RjDDM59E3/P0jFvl4SFaELz/wJnRfec=;
        b=oBA2NfsTz9l4kDWqHDuzBpUU2QWSUEKd3lVbZTJF3rH929SYWW5Wu8UUd/XDTO/FQL
         Wyp6UPYnqhZmB3kkIhkPe4DoiMbz1xHmOKCmGvAZJgmcvQEtU9HaSbSh6AZtJsmsv0Vz
         G0ijtSgKk+nkTyhEoEF1i0NVyVScCEPIk9PPwhajmn8xc5wFJTMksnfp08j5DSvvNIJu
         ikBi3dbH5Y0yuF8Iu+RlV04ZMA7BsRzU7Z5DRjIhbREpEqua25JnzcxX+8h24ZhL1YJg
         JiVGoetECXf9LUXzhCGgoGajKn5tbUMbk8ZbVkqetuFcgj0GBo4RCqF5qFB4QcuM4Cg2
         fABA==
X-Received: by 10.42.63.133 with SMTP id c5mr1392742ici.41.1367977713425; Tue,
 07 May 2013 18:48:33 -0700 (PDT)
Received: by 10.42.243.72 with HTTP; Tue, 7 May 2013 18:48:33 -0700 (PDT)
X-Gm-Message-State: ALoCoQlnWtX2PzRbSSSflA36BrPuGXSX7LKAEzBMayge4HoP2oOVXDAkN1vFQ2mYUpZz/mAFS5eH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223636>

I have been building some automated patching scripts to update
multiple servers at once from our dev host.  In doing so I ran into
some oddities with linux command line GIT version 1.8.0-rc0, so a
couple minor revisions behind.

First, a "git pull" puts the list of branches updated onto stderr.
These are not errors and should be on stdout.  E.g.
Filtered error: From <git host>:service-framework
Filtered error:    017f911..b1f72db  patching   -> origin/patching

Ok, we can filter that out.  But worse is that actual errors in a pull
request are sent to stdout instead of standard error.  For example,
merge conflicts or pull failures because you have unstaged changes.

For now I have to merge all stdout to stderr on my git requests in my
patching script, then filter the results to find the real errors.

Can we please make it so all actual errors appear on stderr, but not non-errors?

If this was fixed in 1.8.2 latest, please forgive as I am running fast
and furious to get this available tonight.

thanks
