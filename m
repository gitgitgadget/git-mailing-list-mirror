From: Kevin Ballard <kevin@sb.org>
Subject: git rev-parse -q --verify $SHA doesn't always quiet errors
Date: Thu, 4 Nov 2010 15:54:10 -0700
Message-ID: <4A1CAE91-E31C-46B5-A614-9634D8FC1FB1@sb.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 23:54:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE8hM-0004SK-8g
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 23:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497Ab0KDWyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 18:54:14 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60560 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab0KDWyN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 18:54:13 -0400
Received: by pvb32 with SMTP id 32so742108pvb.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 15:54:12 -0700 (PDT)
Received: by 10.142.140.7 with SMTP id n7mr1111144wfd.302.1288911252648;
        Thu, 04 Nov 2010 15:54:12 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id e14sm613363wfg.20.2010.11.04.15.54.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 15:54:12 -0700 (PDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160792>

The -q flag to git rev-parse --verify is supposed to quiet all errors.
However it doesn't appear to quiet the "short SHA1 is ambiguous" error.

% cd Dev/git
% git rev-parse -q --verify e51d
error: short SHA1 e51d is ambiguous.

I took a quick look, and the error is being emitted deep within
sha1_name.c, far outside of any access to the -q flag. I'm not sure how
to go about fixing this. Does anyone have any ideas?

Alternatively, is there a better way to tell if a given string can
resolve into a full sha1 besides

  git rev-parse -q --verify "$word" 2>/dev/null

-Kevin Ballard
