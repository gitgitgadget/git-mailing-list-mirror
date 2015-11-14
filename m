From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 0/3] Add cleanup for garbage .bitmap files
Date: Fri, 13 Nov 2015 16:10:50 -0800
Message-ID: <1447459853-28838-1-git-send-email-dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 01:12:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxOS0-0008CB-TR
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 01:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbbKNAMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 19:12:12 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36687 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbbKNAML (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 19:12:11 -0500
Received: by pacdm15 with SMTP id dm15so114429397pac.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 16:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=u9Ij0zQoeBAdfXoiquRgXBB3hE2RiYAPgXTaOyMQj0Y=;
        b=rqPhNACiXpwS3FJFtL1WOndint6VaX6D6JAlP0Zw/gCIwJ/lH8mK907sfvE499kzj9
         iJUtrPS/KaEe2MacShvMF8PpOg8FdzXNFs/UXOvXrwa++S+S20hfDGYld7QUVW7W8Gxv
         MNGz5MOfBoazqbcHe9xj7lV7vPiSGNjXbVRm+81vOaNlF5BOzDm0mJIvrEj+5yquzjfa
         JyzErM64nk35CpcWJaz3DlcYkwtBwsyxh7y8TLZybFkZncITXE676teV/o7yjBnvS1uh
         0UbqSv531Ib2B8AzsgrwlwwTr20mhWLtnKwUabr06qdO9CmkYc44m3PH94HjPIkL7XgG
         TwCg==
X-Received: by 10.68.219.3 with SMTP id pk3mr36489143pbc.85.1447459930760;
        Fri, 13 Nov 2015 16:12:10 -0800 (PST)
Received: from k-na.local.com ([104.135.13.127])
        by smtp.gmail.com with ESMTPSA id qd2sm22507609pbb.68.2015.11.13.16.12.10
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Nov 2015 16:12:10 -0800 (PST)
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281279>

Following Peff and Junio's comments when adding support for cleaning garbage
.idx files left in the pack directory, this patch introduces the ability to
detect garbage .bitmap files.  Additionally, .keep files are still reported,
but no action is taken to clean them.

This includes some refactor around count-objects' report_pack_garbage handler,
to make it more extensible when adding understanding for different file types.
Testing shows this working, but it may be a section to provide extra scrutiny
to.
