From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: [GSoC] A late proposal: a modern send-email
Date: Sat, 26 Mar 2016 01:59:08 +0800
Message-ID: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:59:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajW0w-0000cC-HC
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 18:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbcCYR7K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 13:59:10 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33799 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbcCYR7J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 13:59:09 -0400
Received: by mail-ob0-f169.google.com with SMTP id kf9so57042434obc.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=T10IK5+oWWUJJ3EfrecAwU7saPvZvJw5yv+Wa5e1WmQ=;
        b=YFl8h1R21hLd9lM7gOpc0N2J4bntIkPZ+Y1pi9RlqxuqoseAZTd55K00/zzTdQN5pp
         GOQuYU9Hz3NxNpnk/Dq4bj5uGazltgMBDhGkMuUJxmZ9y1TKjFqzseOvmbYOb6mAYM+u
         Sk/v7xXHFSMPuN+HNpINKsJVPq7BwgNxuEBmqPWzGZ+g7hXxM7NNk01gF8ra1O1brSkX
         9rNhhxeX8KH8+UAyXbKDRHRJ5DWI4Jo1SpI4ssl1Dq6i3AhMm5Jdwn/9c9LQooFjxeta
         v5trutxhtOs/UEuxx04Fhh8ahVdApBKo2QldG4dQDcjt+/iaPJ3YvgxiaVuACuLQdi8Y
         pX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=T10IK5+oWWUJJ3EfrecAwU7saPvZvJw5yv+Wa5e1WmQ=;
        b=OcEN2/aNVC2TRtf5EYElrmELXMc3kmEbKeFMkIy6cb3PQEKvagobr50yvAoqeSZJvd
         4bswHX/ryfFnRpUmmbrK7D3V4Vq/6tGCdCatXyvCcuwpshvyYqtmInBu19N/62h17KEw
         XmdpPBXfb2ag4vHUPw/SPPZox2BOLczcCAEGzy5B+UxbrL3ljrMpZK1XbCFMQWljEhqt
         94a99QldTkzSF0U7BZ1nf4QYAJBtrzvJmj/8pY+7seMZGq7TfAmvIs2atU6pVhc0WASL
         GPk/3kJFlNcMPHdXjWo9IutiJXFQI2ZCbOYNxoac/hzxx2iLBWVKVDD1G/zmea8ozgQK
         rkbQ==
X-Gm-Message-State: AD7BkJK9gFwkNDbCLKq2LLtbNoPtx92XLtqVunqEKCfhZ8vAtMGNnZUVSDO3bpUGGRbE5+bqtTu+7m22N8dXFQ==
X-Received: by 10.182.138.7 with SMTP id qm7mr7676617obb.58.1458928748854;
 Fri, 25 Mar 2016 10:59:08 -0700 (PDT)
Received: by 10.157.27.250 with HTTP; Fri, 25 Mar 2016 10:59:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289918>

I know it's tooo late to post proposal here, but I'd like to let my
idea known by
others.

# Summary
Although many projects hosted on github or gitlab adopt the
fork-and-merge working flow, email is still  irreplaceable for its
compatibility. However, the send-email module is old and difficult for
new users. I=E2=80=99d like to improve it and implement a more modern
interface for git-send-email.

# Purpose
The current implementation of send-email is based on perl and has only
a tui, it has two problems:
- user must install a ton of dependencies before submit a single patch.
- tui and parameter are both not quite friendly to new users.

# Plan
So I propose to implement following:
- Allow user to send mail via a [`mailto`
link](https://en.wikipedia.org/wiki/Mailto). so that users could
complete the mail in their favorite email clients such as gmail, mutt,
alpine and even gmail for android through
[termux](https://termux.com/) (termux is a terminal emulator on
Android and has an API to call android system to open a link).
- Build a simple email client (maybe a web components based web app or
wxwidgets based GUI client, they are both cross-platform) which is
easy to use for sending patch without disrupting the mailbox format.

Here is my proposal:

https://docs.google.com/document/d/1PbaKJOUWjpAh0JEunqhKWiWW4SAr_-7DH_s=
s4WkgDGs/edit
