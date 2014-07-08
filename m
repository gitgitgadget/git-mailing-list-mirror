From: Jeremy Apthorp <nornagon@nornagon.net>
Subject: Branch list by date
Date: Mon, 7 Jul 2014 21:54:55 -0700
Message-ID: <CAMxk9GhQs_kF5573MS1SJ6a7UZuPu+oquXidOOvibznLQ7_FWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 06:55:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4NRD-0003x8-54
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 06:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbaGHEz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 00:55:26 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:63550 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbaGHEzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 00:55:25 -0400
Received: by mail-ob0-f170.google.com with SMTP id uz6so5751914obc.15
        for <git@vger.kernel.org>; Mon, 07 Jul 2014 21:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=SwpLgy7Dcvro0YHhuw4PwonciAhtgxejxLcZDk6b5A4=;
        b=MUy+npniGxn8qIaV3xSzCXardMCUgfaftMP2oIr/E+abKF0uMpMr7wljjwyEHKZXsg
         NH4c2RPfoZ0McPaoG9/zfX6pL+DpjV98Vo+hyNy52iaaxhcbTuEtbWiYIZm+1YRPtBMi
         6f15zYWpt5F5r08U0QvIsSXiotALwuS/PTTP+nXsJ2oeRFRNwnwtRj5I6KXG8bmq7jfv
         zjXxHKdMnx+BuD6LYi0xQ583u7yKhqmoy2YIqsT5gFZcEvv1qY+LHtd4uvcQ9zc2j45k
         TyIrd7veSWO/LsV1EMcQy9FeLKRvgT/6IKsZcuS7j31EksYnz4iMG3Uv7HuunB4JsQfS
         QFMA==
X-Received: by 10.60.42.162 with SMTP id p2mr36724575oel.27.1404795325343;
 Mon, 07 Jul 2014 21:55:25 -0700 (PDT)
Received: by 10.60.132.49 with HTTP; Mon, 7 Jul 2014 21:54:55 -0700 (PDT)
X-Google-Sender-Auth: UJfjoTXeKgF0lRTHhqGjMkABY1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253001>

I built this terribly-written alias because I wanted to see a list of
branches by date of commit. The output looks like this:

$ git bbd
  11 months ago  pipette_editor
    7 weeks ago  ensure-ie-rendering-edge
    6 weeks ago  strings-yml
    5 weeks ago  message-when-validation-fails
    4 weeks ago  new-parsers
    11 days ago  tax
    8 hours ago  search
    7 hours ago  browse
 16 minutes ago  master
  8 seconds ago  org-read

And the alias, in all its glory:

[alias]
  bbd = "!export head=$(git symbolic-ref HEAD); git for-each-ref
--sort=committerdate --format 'color=$(if [[ %(refname) = $head ]];
then printf \"\\e[32m\"; fi); printf \"\\e[01;30m%%15s\\e(B\\e[m
%%s%%s\\n\" %(committerdate:relative) $color %(refname:short)'
refs/heads/ --shell | sh"

I write this missive with dual purpose: firstly to share a potentially
useful tool, and secondly to suggest that this feature (with a less
mind-wrenchingly disgusting implementation) might be included in
mainline git, as for example `git branch [-t] | [--by-time]`.

Until the ocean swallows us all,
j
