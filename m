From: Marc Pegon <pegon.marc@gmail.com>
Subject: Sha1 lookup and GIT_USE_LOOKUP
Date: Wed, 8 Jun 2011 20:31:15 +0200
Message-ID: <BANLkTintTECbO5X3VMvzHdGgyKmLKe65YE=0mX6Ahj5wutCJ0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 20:31:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNXL-0007cP-2I
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab1FHSbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:31:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33460 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab1FHSbS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:31:18 -0400
Received: by iwn34 with SMTP id 34so646410iwn.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=4lOs5z+QrrMCQZv5o3kdkITBpvcFQmM2pd5mkvzkb2E=;
        b=N4FyW/iBVKgtDiTKlQ3rf9h1QcZ/FXYDLezmDYlO0+TmpBypoQKkuWCNU/bsNjVnTs
         saONW0MZgVl4OCha72Nd2FqS+N7HPGLeU6UsnTErKiN3Ea4+vKk+LmIe83JDp8aI9vct
         OONC6EZfip8J5wzrXn7jdak6eqipdlnMbA6Bo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=scot5D+57XLOXx5f8K1SmeSQFcgNMDTIUyKJy0JhAmDc5rLAAgVtEmZeb4AxMEIFbp
         Xyaen2VW078LiR3Sl19j2sJ3RIa0y7X88o+VZ+xDvN1UOPw/AAFdq2OsJvBo9MKjDjAp
         mEuQWL8ba2u3ITVFfthZb1kwzumWhNJkaI1Ec=
Received: by 10.42.28.66 with SMTP id m2mr13942408icc.492.1307557875145; Wed,
 08 Jun 2011 11:31:15 -0700 (PDT)
Received: by 10.42.165.6 with HTTP; Wed, 8 Jun 2011 11:31:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175419>

Hi,
I noticed in find_pack_entry_one the use of the environment variable
GIT_USE_LOOKUP, which does not seem to be used anywhere else in git or
even in the tests.

Obviously, it determines whether or not a simple binary search or the
sha1_entry_pos method (which is apparently some kind of improved
binary search) should be used to retrieve the offset of an object
(given its sha1) in a pack.
Since this environment variable is not set by default, git will always
use a simple binary search, won't it ?

Also, when searching for a sha1 given a sha1 prefix, among packed
objects, find_short_packed_object also does a simple binary search.
Wouldn't it be simpler to just use the sha1_entry_pos method ?

Thanks

--
Marc Pegon
