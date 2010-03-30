From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [BUG] remote curl fetches HTML documents
Date: Wed, 31 Mar 2010 01:36:21 +0530
Message-ID: <f3271551003301306i7e7659acu4724fc9e5a575468@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 22:06:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwhi6-00072u-U8
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 22:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab0C3UGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 16:06:43 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:48261 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab0C3UGm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 16:06:42 -0400
Received: by ywh2 with SMTP id 2so5882601ywh.33
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=4unD5xTbr4uejrMyNt7mE5KW/jJ8ADDpVCiAUpbHQkM=;
        b=iz41SaW399OfjPV5LXZHtdy24d/alYEU/+Iz337qEk8pJO25RqxdcnHfMRzI7l/lr5
         EmHnrPKElVf3RREPI1+izaWao8XxNsJ4Ah/PC0KIzsuyqmfXaoAyMqz8PU61RDf6xyS4
         SWmYtSKAedJHNTP5ojWjpYvQlnK48nOLcg7xk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=teFi9nXtfHX4wZVRyoklTjMt7Wr0fnqOMweFtuPN95Jef1UdBxSotuWcKxLKREmqAf
         hgRoNgXBO3T/kS9mqA9LeF4A9iClbEWmljo63253D4JKNG5tmu0lD1yrNbEJtD+WuoDQ
         kVhEpYKZmYNRlyj9w3EwG2fve4heRx6xCMV+s=
Received: by 10.90.69.14 with HTTP; Tue, 30 Mar 2010 13:06:21 -0700 (PDT)
Received: by 10.90.60.8 with SMTP id i8mr1329012aga.86.1269979601120; Tue, 30 
	Mar 2010 13:06:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143596>

Hi,

I found a bug in the curl family of remote helpers. I've posted a
bugfix by assuming as little about the URL that libcurl accepts as
possible.

$ git remote-http foo
list
0000000000000000000000000000000000000000 html>
0000000000000000000000000000000000000000 <head>
0000000000000000000000000000000000000000 <title>OpenDNS</title>
0000000000000000000000000000000000000000 </head>
0000000000000000000000000000000000000000 </head>
0000000000000000000000000000000000000000 <body id="mainbody"
onLoad="testforbanner();" style="margin: 0px;">
<SNIP>

$ git remote-http foo
fetch 0000000000000000000000000000000000000000 html>

error: inflate: data stream error (incorrect header check)
error: File 0000000000000000000000000000000000000000
(foo/objects/00/00000000000000000000000000000000000000) corrupt
error: Unable to find 0000000000000000000000000000000000000000 under foo
Cannot obtain needed object 0000000000000000000000000000000000000000
error: Fetch failed.

-- Ram
