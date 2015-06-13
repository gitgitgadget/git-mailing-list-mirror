From: Sami Boukortt <samiboukortt@gmail.com>
Subject: Failed assertion in pathspec.c
Date: Sat, 13 Jun 2015 19:18:39 +0200
Message-ID: <20150613191839.3585effd@SaMobile>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 19:18:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3p53-0000ye-TK
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 19:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbbFMRSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 13:18:48 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34079 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926AbbFMRSr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 13:18:47 -0400
Received: by wgv5 with SMTP id 5so41952425wgv.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:subject:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=6SCC53nc9LtVO2ycqCbrtqfS1Pl75dlkLpIpJ2QVL90=;
        b=VORejaY9EYsgTInyEDmAc2Nx2UO6yEwREyLt2X8gvNcUrG4W2ctqgVcYTUJNIg+oeI
         FDBfzbVxv1cdvKDVudNbPxqwWY0/Tx3saIdCH5R7PooRI3qyDxxDjbHHVlxtNi2UD+7m
         8qvOkz1auJYU3OpccMtzTsbp/WJl1+nOP+cQJ7Wtbr/x8IdbqrXun3ywItJPvtLJ9gCB
         bC6Jn6qGNfyIpkpdw/rmYwzTejdTEpT8ScEQscZIOFlGk+tEwltKiqGMDptqgVtEtIxM
         oole/m8uI4EKa1xiZzXseGP0fryd0qZdQ35EbINmQhC6tEJQ7LeM7F6IDDjK0MBKIgbe
         i9Pw==
X-Received: by 10.194.61.236 with SMTP id t12mr37173549wjr.59.1434215925482;
        Sat, 13 Jun 2015 10:18:45 -0700 (PDT)
Received: from SaMobile (mtg95-10-78-219-27-149.fbx.proxad.net. [78.219.27.149])
        by mx.google.com with ESMTPSA id ju2sm8047501wid.12.2015.06.13.10.18.44
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jun 2015 10:18:45 -0700 (PDT)
X-Google-Original-From: Sami Boukortt <sami.boukortt@gmail.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.28; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271562>

Hi,

I can reliably trigger a failed assertion in Git 2.4.3 by performing
the following steps:

mkdir a; cd a
git init
touch a.txt
git add a.txt
git commit -m 'a'
cd ..

mkdir b; cd b
git init
git submodule add ../a
cd a
rm -fr .git
git add .

This results in:
git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len
<= item->len && item->prefix <= item->len' failed.
