From: Liu Yubao <yubao.liu@gmail.com>
Subject: duplicate memory allocation in buildin-add.c
Date: Fri, 15 Sep 2006 19:26:55 +0800
Message-ID: <450A8DFF.9040605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 15 13:28:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOBru-0002DH-5v
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 13:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWIOL1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 07:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWIOL1e
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 07:27:34 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:16095 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751276AbWIOL1c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 07:27:32 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1343290nzf
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 04:27:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=iD1XcgdXvdQ+XLb+X+mOzv3fpxdZFNAUzIcUZJ12IzeoUmpprOrabBhvCDByFCxcCxIhoCbuQ3zPYZlXiA7x1bipMxbA6co/0T9HaBAD9Ue87Dg4Vwb/QMM8Dy9S44YePV6Qc4nU3f2wchKhZFr8Zic6Z14tf1HPHblc7H1LiUU=
Received: by 10.65.73.16 with SMTP id a16mr12021176qbl;
        Fri, 15 Sep 2006 04:27:31 -0700 (PDT)
Received: from ?192.168.88.85? ( [221.122.47.70])
        by mx.gmail.com with ESMTP id 20sm1021362nzp.2006.09.15.04.27.29;
        Fri, 15 Sep 2006 04:27:31 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27077>

http://www.kernel.org/git/?p=git/git.git;a=commitdiff;h=0d78153952e70c21e94dc6b7eefcb2ac5337a902

buildin-add.c:

+static void fill_directory(struct dir_struct *dir, const char **pathspec)
+{
+ 	const char *path, *base;
+ 	int baselen;
...
+ 	if (baselen) {
+ 		char *common = xmalloc(baselen + 1);
+ 		common = xmalloc(baselen + 1);
+ 		memcpy(common, *pathspec, baselen);
+ 		common[baselen] = 0;
+ 		path = base = common;
+ 	}
...

Allocate memory twice for "common" variable, is it indended? I'm very confused @_@
