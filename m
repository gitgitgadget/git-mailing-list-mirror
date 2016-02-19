From: larsxschneider@gmail.com
Subject: [PATCH v6 0/4] config: add '--sources' option to print the source of a config value
Date: Fri, 19 Feb 2016 10:15:58 +0100
Message-ID: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 10:16:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWhAn-0004aF-TF
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 10:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948526AbcBSJQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 04:16:14 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:32795 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947875AbcBSJQG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 04:16:06 -0500
Received: by mail-wm0-f45.google.com with SMTP id g62so60016789wme.0
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 01:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ptm+u4QsCzd1KQ4zgjHb67DN1eC1SwLZH/gZJAjcKBI=;
        b=iP1JgrUfvG3JfRbObCsLQAELZx/ixFASEjsLZD6NKpUF6ezWbinQhVoIl34R5NQinR
         GUcKopL52Pcpo0lnORJEQ8je3geFyK6xOyjEfcLr2JL0XJQGEeUAtu1MCILnnOEPVNvJ
         vyYzKCi94ga/RjWHgqUWaJzOljmugeG3O/2hT6JXhQnh+6IMPyyeABQYk9Nf4Q83e9vu
         aXHrMbtQkxBOYKDvmhNOURJBTsOO3wZJmlRVZql+iL+ggqETAhnhLOdTnzc/VCUHGPWV
         qJJmm2QEB3ScGJz9XK+1KvVSvL9Hm8yVAFDSZyU5Hw/p2ZXD8T8MuJs0Kt5Pa5vmTbxi
         jaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ptm+u4QsCzd1KQ4zgjHb67DN1eC1SwLZH/gZJAjcKBI=;
        b=CpXKso25BostbLI0Xh+vIXo5RMhHW6HLOP/yKuhlmsRAdJ+NkF4AxsPquYM8Zv961U
         OVKGCCA2LL8C4ZI1jsoFcOPFnMbVSfHmfrG8Cj9KbkY2bJKo9nF1BdgR37HWQITbWXjG
         86SnDVaqVVpgUXY0DBLowQyyjPtM90wiEsy2DSoKv3ckBLLXRRs/5GYLh1hEBsNyM4Gx
         FvZKU53kV6SEJ3ri6IjeoO8qqnHTRzO3KWp8lR3ZSNSUg41dyCEP0098v2hV7hUo2Fz2
         y/Esb4WTBGFwiv5N6vCdsrXc8IrVc9uOQRL70hUbImE1hv6bgppgy1Rv9Un1eCvaJMi7
         lUIw==
X-Gm-Message-State: AG10YORMuYBTuVhmxmBcDFJe/lBzP8Qu2pvWoqQs3D7Fm5svRBq4doPW18yeybdj/vKQag==
X-Received: by 10.28.49.69 with SMTP id x66mr7479374wmx.11.1455873365336;
        Fri, 19 Feb 2016 01:16:05 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB455F.dip0.t-ipconnect.de. [93.219.69.95])
        by smtp.gmail.com with ESMTPSA id ks5sm10301204wjb.13.2016.02.19.01.16.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2016 01:16:04 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286672>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v5:
* rename 'type' to 'origin_type' as 'type' is too broad a word in the context
  of configuration file (Thanks to the reviewers Junio and Dscho)
* add dedicated patch to rename git_config_from_buf to git_config_from_mem
  (this change was part of the series since v4 as suggested by Junio but
  hidden in the "config: add 'origin_type'" patch)

Thanks,
Lars

Lars Schneider (4):
  t: do not hide Git's exit code in tests using 'nul_to_q'
  rename git_config_from_buf to git_config_from_mem
  config: add 'origin_type' to config_source struct
  config: add '--show-origin' option to print the origin of a config
    value

 Documentation/git-config.txt |  15 ++--
 builtin/config.c             |  33 +++++++++
 cache.h                      |   6 +-
 config.c                     |  36 +++++++---
 submodule-config.c           |   4 +-
 t/t1300-repo-config.sh       | 161 ++++++++++++++++++++++++++++++++++++++++++-
 t/t1308-config-set.sh        |   4 +-
 t/t7008-grep-binary.sh       |   3 +-
 8 files changed, 236 insertions(+), 26 deletions(-)

--
2.5.1
