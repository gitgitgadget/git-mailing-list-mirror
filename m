From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [WIP/PATCH 0/5] git checkout --recurse-submodules
Date: Thu, 26 Dec 2013 07:58:57 -0800
Message-ID: <20131226155857.GL20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 26 16:59:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwDL5-0001w2-8k
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 16:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401Ab3LZP7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 10:59:03 -0500
Received: from mail-yh0-f45.google.com ([209.85.213.45]:35142 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399Ab3LZP7B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 10:59:01 -0500
Received: by mail-yh0-f45.google.com with SMTP id v1so1779588yhn.4
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 07:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=u3X0K21/amebSX4r2GpJoMS4mJSVLPjpAwx0eI5XLGo=;
        b=nO6sU+txA0eyt3zItA8WoiMpFaamz5ifS5ZFn+ej87f16L7FomPHRplUnwgupAQ5T7
         NzhCaI722vtMoa4gzfvrZr1uXldwCZb7Ik3Rq3Ct1IGBJtGRHlxZ7KefxAbnApeXtkW7
         91otaEheynQYPOJft8mcY8fOUCCpo3Egx7dycLi0RtFLaROxKveLDZIC8Ob4r5YNIpE1
         kVvBMuYpUk0Zyo6sZHCy7/KnAvm0NmYqp4ChlVQqSQBJnioIZUYh+bV89EW/ga4NH5QF
         7ex9j+VzqNImFfVYxHwFRwQEWsmHFa7k8m37/4zDUqf6N4U8zSZtPd3TvcNWefqMbsJw
         L6Hg==
X-Received: by 10.236.87.239 with SMTP id y75mr30383932yhe.50.1388073541032;
        Thu, 26 Dec 2013 07:59:01 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id o27sm42205292yhb.19.2013.12.26.07.58.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 07:59:00 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239695>

Hi,

This patch series comes from
https://github.com/jlehmann/git-submod-enhancements branch
recursive_submodule_checkout.  It needed some tiny tweaks to apply to
current "master" and build without warnings, but nothing major, and I
haven't sanity checked it much beyond that and letting the kind folks
that use Debian experimental play with it.

I'm sending it out now to get review and ideas for what needs to
happen next to get this series in shape to be included in git.git.

Thoughts of all kinds welcome.

Thanks,
Jonathan

Jens Lehmann (5):
  submodule: prepare for recursive checkout of submodules
  submodule: teach unpack_trees() to remove submodule contents
  submodule: teach unpack_trees() to repopulate submodules
  submodule: teach unpack_trees() to update submodules
  Teach checkout to recursively checkout submodules

 Documentation/git-checkout.txt |   8 ++
 builtin/checkout.c             |  14 +++
 entry.c                        |  19 +++-
 submodule.c                    | 217 ++++++++++++++++++++++++++++++++++++++++-
 submodule.h                    |  11 +++
 t/t2013-checkout-submodule.sh  | 215 +++++++++++++++++++++++++++++++++++++++-
 unpack-trees.c                 |  94 ++++++++++++++----
 unpack-trees.h                 |   1 +
 wrapper.c                      |   3 +
 9 files changed, 556 insertions(+), 26 deletions(-)
