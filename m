From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv11 0/7] Expose submodule parallelism to the user
Date: Fri, 12 Feb 2016 15:34:33 -0800
Message-ID: <1455320080-14648-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Sat Feb 13 00:34:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNEg-0005Qz-4a
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbcBLXep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 18:34:45 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35771 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbcBLXeo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:34:44 -0500
Received: by mail-pf0-f180.google.com with SMTP id c10so55558403pfc.2
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 15:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KOd6RWnIpl/PBN9tcUh/hQhDXzofYYBcqKpWXAGqAms=;
        b=ez7Nkrn1upkhFeW7kgLt+zRbC/Mpm1/IP3PVU+uZUtE0eeeX/hhecCea5F7uKl16wt
         hCKEFWFSH7h5oHY358UsM0NMZtroTFjOSMx30LSj5GzIpr10Fm0xEIT3QnXV+AUqlV2D
         jjDN3k2LVQvLzWUqvn7tIrP027d0RJgaVZUU028ubuBmAKTa19fY7wmhAGNawTRUkPO1
         oUDSaYnF4nNHJ4C762LSfU9XtjngWEkpy7yl/+9wcpscE/UweqIA/eO5jqBPcjRcvUS7
         J5p+Qh0vditU2vcNhIBgDaSXejr5X7ifVv+44c7O7LW4tjqAufaTaflYyP/sPt3FCiJy
         nlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KOd6RWnIpl/PBN9tcUh/hQhDXzofYYBcqKpWXAGqAms=;
        b=OHWvbpVI+KL+rE9gfKEFUv2zt2rSoQM4+rtmSqfxqhuD1SoHgwZY5kPwGo55MsMb/f
         JbaXksy9UoHyUl/PsYNkQn0Zn1k+vGNZnzJrzjj5x9g6cd+3QJqOminuARfBYjmFXABV
         f/CfsWOgpgINTJn+rMxWf52793/FSBaFTjH/1yZd+OubQAnktfgyomZnRRaEPJe8CQP9
         MwQ1H10Qru9DYspSZ83sG8mYo2Ee5uV+3aFIopCZ7tpQsQ3x42VCwSPjFpIVUya1t3eE
         5yCk5+joS285IXt95yrIuCyVKmxKMw3V+gP9bb7dmSCnDqvR/wxRuKpVsr8FI8krq87g
         ghOw==
X-Gm-Message-State: AG10YOTQ/YPIETNrjg87nopxrXGsWuuIAXGGv9l7/vrdLKdjmkT6NJeQU/SJJ1pWF9o2H1g/
X-Received: by 10.98.73.205 with SMTP id r74mr6035115pfi.118.1455320083892;
        Fri, 12 Feb 2016 15:34:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f1e7:203f:9d1e:8193])
        by smtp.gmail.com with ESMTPSA id e79sm21825528pfb.76.2016.02.12.15.34.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2016 15:34:42 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286085>

> This replaces origin/sb/submodule-parallel-update
> and is based on origin/master
>
> * broke out the patch for redirecting errors to stderr in "submodule update"
>   (Thanks Jonathan, Jacob)
> * use git_config_int and manually check for less than 0.
>   (Thanks Junio)
> * use an enum consistently now for submodule update strategy
>   (Thanks Junio)
> * fixed the funny indentation

* removed the indirect call to submodule_config, but made it directly
  (Thanks Jonathan)

> 
> I haven't looked at how this integrates with Davids refs backend, I'll take a
> look at the merge tomorrow
>
> Sorry for the long turn around time,
> Thanks,
> Stefan


Stefan Beller (7):
  submodule-config: keep update strategy around
  submodule-config: drop check against NULL
  fetching submodules: respect `submodule.fetchJobs` config option
  submodule update: direct error message to stderr
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/config.txt        |   6 +
 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 +++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 239 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  54 ++++-----
 submodule-config.c              |  18 ++-
 submodule-config.h              |   2 +
 submodule.c                     |  35 +++++-
 submodule.h                     |  18 +++
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 14 files changed, 402 insertions(+), 49 deletions(-)

-- 
2.7.1.292.g18a4ced.dirty
