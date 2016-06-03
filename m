From: Stefan Beller <sbeller@google.com>
Subject: RFC: have a config option for running submodule update after checkout <revision>
Date: Fri, 3 Jun 2016 15:53:21 -0700
Message-ID: <CAGZ79kb9xHNYysb6gS9nPWvFW3cgcW-ey+5qyfTHTPGkT0fNfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 00:53:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8xy3-0007Ty-TM
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 00:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbcFCWxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 18:53:23 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35910 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbcFCWxX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 18:53:23 -0400
Received: by mail-qg0-f52.google.com with SMTP id q32so18909872qgq.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 15:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=nK4uL5hq+hZx4ucqB61clLBjl/jydaiIjmp8W80oVIM=;
        b=COGVzpauyW7l8nfC+trRvZFxpV3HIBmWj+sL8qmQI5ZKGnDrq2ciLpmcj2bW6x7FKJ
         9QTzOrIpP3it+U8zwB1N3FPtPSSYFxkksFe0XD74ELgxP5PhafXnjCuUTccNvuYGGB8+
         6EGLAfNJsk7UuxSRYMvP/EFZcpcTmp9oVm1yNxfwblmUwpakOcK53XWAcRRWeczjjzhj
         hm5r6TMNtlnU1+Ym7SlYph2clNtfi3D3yEsKhfOrpjKCkqFf6H5+fJzqAOEqHJco7gzl
         Rm7YnctBNHHMfvnFX5qFSjFRyXSDX8XQc9e7PIyvE0qO1x6TABMKlghkNUMPBpFLYqS4
         bNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nK4uL5hq+hZx4ucqB61clLBjl/jydaiIjmp8W80oVIM=;
        b=kbF2yvmwChe6G2bXvOM4x1smWiJ61c5DPGh8kNN6Kj6lPMkfGoWCjOwEKyiyVnyZlF
         C4k4oUuZWyAOvMuSUejJzU6Rb4356JFApLuqKlsAQswEhz0MxQqAg6SrYZoArnZA1//y
         wRnZ5+8JDn8pQ1V1xdXv/ngz533emR/XVBDfOnIs8j0n4uEx8RyLncdryk3sX6/3v1gH
         utF2TF0+ETMlZtfVdVylQix22bu6+Xw7wfZZ629tnpSYVHesQFfTF5WIYor66jXFCueB
         7mb58l95KbqGend7v5vcKagJNQIElc0s9yB0fNTWxA1xpFXTJTFPuizPABljrIu/FQlp
         uEPw==
X-Gm-Message-State: ALyK8tIDWJy2Ue7g+5ldeAXWT59fy0GUAqREu6INjhnVSYHFhYdE2ilOCNa2aXUzrijkPMlzrSDtzEuxtPbt/j2B
X-Received: by 10.140.221.135 with SMTP id r129mr5728256qhb.59.1464994402059;
 Fri, 03 Jun 2016 15:53:22 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Fri, 3 Jun 2016 15:53:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296423>

When checking out a new revision in a repo with submodules,
one of the first commands after checkout is `git submodule update`
to make sure the submodules are updated.

I propose to have a switch which when turned on automatically runs
`git submodule update` for you instead of implementing proper
submodule support in checkout for example.

advantages:
* users are already used to the quirks of `submodule update`
* a lot of config options exist for the behavior of `submodule update`

disadvantages:
* it's not `done right`, i.e. dealing with gitlinks in read-tree/unpack-tree
   but just another command chained after checkout, so we would do that
   for pull too eventually?

What do you think?

Thanks,
Stefan
