From: Seren Thompson <serent@mindtouch.com>
Subject: Fsck message override issue
Date: Tue, 5 Apr 2016 12:58:38 -0700
Message-ID: <32B1B2EC-C1DD-4662-92F1-6A7A9099E110@mindtouch.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 21:59:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anX8B-00028q-VZ
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 21:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbcDET6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 15:58:42 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34102 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbcDET6m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2016 15:58:42 -0400
Received: by mail-qg0-f54.google.com with SMTP id c6so19587069qga.1
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 12:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mindtouch-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=OXN+Ht0h4e5owz6EeH11IfdATYOfOgYC5J/cfLcO+hU=;
        b=fpYzSKMkcDhhunHZV8zAhY7B4g621lw4D+LdBYcNT0J6p735BKvY0b3RRh3kibS4Jb
         2L2N/JsQe5Asok627sdF2cP6r3WpgB/9dCg47ATcJzd5vmV1LJV/5eIbrblLlK1Ifns4
         dUapjj+vbCST61dqjWD1bKO2CKfbFBU8eJO9J/h8UDSK9mcKH4HSJXwZ/lHc4s8Gi2AW
         1vN4XBYtvk6svyR4/9XLkM3kuyVgp+/CkGm7v0fUOcoI6XLVggFSZgPruvcEgg4Dw9ih
         1YBFK/JFl8G4gX1uopSYkWs3V+jKhLz/4y7+GwPTA8TYh7QxHPU7BrNf5WQsS+knIbIc
         /ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=OXN+Ht0h4e5owz6EeH11IfdATYOfOgYC5J/cfLcO+hU=;
        b=c/o7H34R6Q+sSPvjpzTSZCuwkZr5ZXn9IPJZ5hcQp2IBZ/jI7iCe9nq2I0BUFpgtgA
         nrGhVqsn4uPyIdIjw22fKqyu54wdBKjm8nAThSrvmE7tS6Egick6LxfwgoL8EExSpPfK
         SUuvuI/b6sFDNsuoixs2+ao5OUFtVPxAlbvWJqZXslWSch9Qh/T30FAMcJIRiX2fSayH
         Inu/abtOgFU/ffdofvil6yYQM9OlhyzsIRqAyg8o/5T8sg1F9BLx8GONSb6tJjPuW+UD
         iqKImCqEkuVzxDhD60hHEqG2zcZiHvGeRoz3+sc6pxr+mYLHvmdymBpG/+j2mTO7kuwt
         ZYMw==
X-Gm-Message-State: AD7BkJJ2pekbkXog8EnA3UzQKppmb6PwdzQr1vzaQxvgXbBdR+HoBkYqKLYWsvne+qiziEon
X-Received: by 10.140.83.212 with SMTP id j78mr49860884qgd.83.1459886320961;
        Tue, 05 Apr 2016 12:58:40 -0700 (PDT)
Received: from [192.168.168.183] (66.238.18.243.ptr.us.xo.net. [66.238.18.243])
        by smtp.gmail.com with ESMTPSA id z110sm15240298qgd.45.2016.04.05.12.58.39
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Apr 2016 12:58:39 -0700 (PDT)
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290806>

I'm not having luck with overriding the fsck message types (zeroPaddedFilemode specifically). I've tried adding
 [fsck]
    zeroPaddedFilemode = ignore
to both global and local configs, but it seems to have no effect:

  $ git --version
  git version 2.8.0
  $ git config --get fetch.fsckobjects
  true
  $ git config --get fsck.zeroPaddedFilemode
  ignore
  $ git pull
  remote: Counting objects: 14777, done.
  remote: Compressing objects: 100% (5495/5495), done.
  error: object 2b7227859263b6aabcc28355b0b994995b7148b6: zeroPaddedFilemode: contains zero-padded file modes
  fatal: Error in object
  fatal: index-pack failed

Is this expected behavior and I'm doing something wrong? Thanks.

-Seren
