From: Marc-Antoine Ruel <maruel@google.com>
Subject: git-svn fails to initialize with submodule setup, when '.git' is a
 file and not a directory
Date: Thu, 12 Sep 2013 14:45:26 -0400
Message-ID: <CANAQWOXT2pwF2tds3FK1bE6_cPYw_niB8O_nmxCs8_9GXuiF9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 12 20:45:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKBto-0007N9-G6
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 20:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204Ab3ILSps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 14:45:48 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:39639 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754Ab3ILSpr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 14:45:47 -0400
Received: by mail-oa0-f45.google.com with SMTP id m6so218644oag.4
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Iq94Js7LxH6V5ELffXN1T2GzmAaqqXlaiRvFVMaVQSE=;
        b=ayKVg1VR10mFWoMQRIeqHwaGSLLFSZGz5nnjpc38aFux9hH+YpBVI245tNmb0wHDJ6
         5OnzqA2WprJ1vEVdloi0n9ZzR1WgeZpZAthEzDB51SLbiKCoQod+r2IhrcrC8uzJrhud
         ISBh+Kc9CwkINEYivtMtC6XKLPQctCCMMo4tRxwTejp+xUckCe7KSJSFgSTqd16j4yyu
         mgVaRNGFGlN60c5vEvqW4GNZjmbZwSAZCJbLbOdpII/pRaqpk+JYo4WTyO49+1AYUD/w
         3YcpXmpnMtogpArUxuCjyzuRGRlrvVAMd1w5BDwTRjTJord6Hre8PsnEEnkuojQmF6ES
         tnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=Iq94Js7LxH6V5ELffXN1T2GzmAaqqXlaiRvFVMaVQSE=;
        b=AdDublZYaEt8EPfAf2eueWNqonhPfvEur4EKBgJSWfQuhinqEcp4KdwN+4pO0iyds1
         Fzw472RMeHU2utz7en9Ou+BbUxWDfFTCZiLx5J1zu/ZUtszdyeTBzAUE+KUD/bDkmGX+
         PsEERrDU+d2ZdjJYz65NgZgM85O3vcEAESnSJrqtBerChSXtLA7u7RmRxW0qhlVfofd8
         jhCPqmA4cRUVx0ffGRNub1qRcBQCBOSIMuGdRzAjhcfNGcsJSCVDZWweF1Q/ZmMfSSam
         ZhwWIn1Qu/nccQTnMrWP5km/GACrEBosEO0EY4LrKXHMdsHCDDS4/yj5/OC+acWeGbPY
         AiLQ==
X-Gm-Message-State: ALoCoQklWpXIG/vfYmLTi+ZUh548i7tOp3vRDdIOIIWRDT0P4UBPfm+6upQ9I0n1uEnx0L7V+Fs9JXTQuvBk2/XItBcgWnLv2uQKCtaRrwlrc4twYH6xshjmwywPXn9j4pTVBFCfewD34ZLyosadaI/Sd4P+v/bEq1KXmpcLTgk/EzHdCzsfbM3qSzNsNJnxu8/HHsTyBp3j
X-Received: by 10.182.71.82 with SMTP id s18mr8211985obu.9.1379011546426; Thu,
 12 Sep 2013 11:45:46 -0700 (PDT)
Received: by 10.182.104.8 with HTTP; Thu, 12 Sep 2013 11:45:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234671>

Repro:
1. git clone --recursive a repository with submodules.
2. cd checkout/submoduleA
3. git svn init svn://host/repo

Expected:
Works as usual

Actual:
/path/to/checkout/submoduleA/.git/refs: Not a directory
init: command returned error: 1

Why:
submoduleA/.git is a file, not a directory.
$ cat /path/to/checkout/submoduleA/.git
gitdir: ../.git/modules/submoduleA

$ git --version
git version 1.8.4

Thanks,

M-A
