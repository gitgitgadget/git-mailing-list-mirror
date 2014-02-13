From: Ephrim Khong <dr.khong@gmail.com>
Subject: git blame: "Not Committed Yet" with clean WD
Date: Thu, 13 Feb 2014 10:08:55 +0100
Message-ID: <52FC8BA7.30102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 13 10:09:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDsI9-0002vp-PN
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 10:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbaBMJJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 04:09:01 -0500
Received: from mail-bk0-f54.google.com ([209.85.214.54]:40981 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbaBMJI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 04:08:58 -0500
Received: by mail-bk0-f54.google.com with SMTP id u14so2953217bkz.41
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 01:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=jh7Z7a/Oo1diAR6jAz3GR5PtBd9voyjGwe1ac8p6mk4=;
        b=jxZrW7lta4X2LraXh/wElvnt/bLHFob+ny/HCpwdgRXzYY1J4oxUsiey7szfvWb/2F
         kkRVbWtEwyHYnDNvDf9AIMryGBvXUT8n425cObWjp8UowqQ7X9OcWpf9/vY6DPPnSngi
         D+3lngTkODqjFvKRRp/oqSGfAYFibeE/zSGwvlDatZiAankITCXJZlsyn/TSrtjr02QZ
         CEjKYvwRoRMs4cPxlcQI7+nFJRpptbCtCEH6LDo/p4eUs8E/9cy531UKRFDTPxCNLXqQ
         0AczC53dUtZOImWvDBVGN84KV+PYOcGmNbYYJaqMnUQ4F+ag85Mm2AWvfFgC/EK7wh4L
         8Xgw==
X-Received: by 10.205.107.129 with SMTP id dy1mr28500bkc.48.1392282536955;
        Thu, 13 Feb 2014 01:08:56 -0800 (PST)
Received: from [192.168.32.40] (merlin.mvtec.com. [62.245.183.130])
        by mx.google.com with ESMTPSA id zf3sm1396114bkb.4.2014.02.13.01.08.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Feb 2014 01:08:56 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242052>

Hi,

for files that contain windows line endings in a repository with 
core.autocrlf=input, git blame will show lines as "Not Committed Yet", 
even though they were not modified.

Example:

--
git init
git config core.autocrlf false
echo "foo" > a
unix2dos a
git add a
git commit -m "initial commit"
git config core.autocrlf input
git status
git blame a
--

Output:

--
Reinitialized existing Git repository in /.../testblame2/.git/
unix2dos: converting file a to DOS format ...
On branch master
nothing to commit, working directory clean
On branch master
nothing to commit, working directory clean
00000000 (Not Committed Yet 2014-02-13 10:02:43 +0100 1) foo
--

Is there an easy way to work around this; is this desired behaviour or 
mor a bug?

Thanks - Eph
