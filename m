From: Ilya Basin <basinilya@gmail.com>
Subject: git cvsexportcommit: error patch does not apply
Date: Fri, 3 Aug 2012 13:05:55 +0400
Message-ID: <999213645.20120803130555@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 11:06:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxDpi-0004Vu-Mb
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 11:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab2HCJGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 05:06:06 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42883 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab2HCJGC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 05:06:02 -0400
Received: by eeil10 with SMTP id l10so112974eei.19
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 02:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:x-mailer:reply-to:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=+eP5Y8Q4z3oVebMWnJmyybfPcf4wfj0tQ1CkxpJ+cHQ=;
        b=wUFKNGmaw6nh6FkIBUnqKgF21o7Ks70QwrDC1189hKq40xNCuKe+oZFS9wOg0+IbIh
         Tcs4RXFQeYDL7AXGkuKV6b606YAydo81WTpBKUtTJkmdYPSFV8HTbGBSuYVMVTM+V3Z+
         gjoAQMplE0+jtRD2/J1sAV5IqHbffKvH3LOp8ZC/dxVE6p37nEe7ue73mSSZX5Yd9qqd
         HvzQ0vlCoKYn6onUG5BO6VUDv3ClK6JRwxjPPfqtoOneLUL+4zBI6PNZWaMVFWnLxtPM
         o0o1+dP3tk1QDumzZNn+nGwiNjmFC92D9iirErXfoQENYx73xQjfXw1eYLBHsCxkulrE
         eDqA==
Received: by 10.14.220.193 with SMTP id o41mr1227643eep.27.1343984760380;
        Fri, 03 Aug 2012 02:06:00 -0700 (PDT)
Received: from BASIN.reksoft.ru ([2a00:1120:0:1001:9918:1ddf:a32d:12a5])
        by mx.google.com with ESMTPS id 9sm23929162eei.12.2012.08.03.02.05.57
        (version=SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 02:05:58 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202823>

Hi. Here's what I'm trying to do:

In gitcvs:
    [il@basin documentation]$ git mv SIC_SAP1_0_ADM_dv1_1.doc SIC_SAP1_0_ADM_dv1_2.doc
    (edit the file)
    [il@basin documentation]$ git commit ... SIC_SAP1_0_ADM_dv1_2.doc
    ...
    $ git log --stat -n 1
    commit b04fa43c9f1374cf0ea5f9bf88024282414b0a0c
    Date:   Wed Aug 1 12:50:53 2012 +0400
    
        SIC_SAP1_0_ADM_dv1_2.doc: connection_timeout
    
     documentation/SIC_SAP1_0_ADM_dv1_1.doc |  Bin 7383040 -> 0 bytes
     documentation/SIC_SAP1_0_ADM_dv1_2.doc |  Bin 0 -> 7427584 bytes
     2 files changed, 0 insertions(+), 0 deletions(-)

OK So far

    $ git cvsexportcommit -w ../../cvs/SAP -u -p -k -c b04fa43c9f1374cf0ea5f9bf88024282414b0a0c
    Checking if patch will apply
    cvs update: nothing known about `documentation/SIC_SAP1_0_ADM_dv1_2.doc'
    cvs status: nothing known about `documentation/SIC_SAP1_0_ADM_dv1_2.doc'
    Huh? Status 'Unknown' reported for unexpected file 'no file SIC_SAP1_0_ADM_dv1_2.doc'
    Applying
    error: the patch applies to 'documentation/SIC_SAP1_0_ADM_dv1_1.doc' (e0c6cf56bd58ce3b1a8b8e00bfd20f75f89110f7), which does not match the current contents.
    error: documentation/SIC_SAP1_0_ADM_dv1_1.doc: patch does not apply
    cannot patch at /usr/lib/git-core/git-cvsexportcommit line 333.

    $ ls -l ../../cvs/SAP/documentation/SIC_SAP1_0_ADM_dv1_1.doc*
    -rw-r--r-- 1 basin Users 7382325 Aug  3 12:32 ../../cvs/SAP/documentation/SIC_SAP1_0_ADM_dv1_1.doc
    -rw-r--r-- 1 basin Users 7383040 Jun  9  2005 ../../cvs/SAP/documentation/SIC_SAP1_0_ADM_dv1_1.doc.orig

I compared SIC_SAP1_0_ADM_dv1_1.doc.orig and the file from HEAD~1 .
They are equal. Why error?
