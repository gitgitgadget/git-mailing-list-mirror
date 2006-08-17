From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [RFC diff-tree -c with copy/rename]
Date: Thu, 17 Aug 2006 13:02:06 +0200
Message-ID: <e5bfff550608170402w25b9eaeaqe69665bdddaead3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 13:02:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDfdc-0007dA-G5
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 13:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWHQLCI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 07:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWHQLCH
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 07:02:07 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:12379 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964796AbWHQLCG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 07:02:06 -0400
Received: by py-out-1112.google.com with SMTP id z74so1393360pyg
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 04:02:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UY+MX6xQzxU5w9BruIWwvSUHOkGAiiI/hTXiEIrdO5cPimoynDUUf7aP9OfjZT/dPG/fU9hXHNX3otAIlycd6OaqIgWCV1OgmIZRzARZGKkggHSX6fh8UjlEh+H/HWpdJmcfmCpyk4hQh0aI24pYY0SEGmdyy/i4BuivRb7cyBY=
Received: by 10.35.26.14 with SMTP id d14mr3364439pyj;
        Thu, 17 Aug 2006 04:02:06 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Thu, 17 Aug 2006 04:02:05 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25582>

>From current git tree:

$ git-diff-tree -r -m -C bb266cb118 (I removed extra useless lines)

bb266cb11842f76712ebff1d8b1bd086dc65337f
:100644 100644 dfb1c44 8d0dbad R093	checkout-index.c	builtin-checkout-index.c
:100644 100644 357970d 7d39d9b R083	verify-pack.c	builtin-verify-pack.c
:100644 100644 6484cb9 6484cb9 R100	builtin-help.c	help.c

bb266cb11842f76712ebff1d8b1bd086dc65337f
:100644 100644 29ea6fd 8d0dbad M	builtin-checkout-index.c
:100644 100644 d700761 7d39d9b M	builtin-verify-pack.c
:100644 100644 7a7f775 6484cb9 M	help.c


$ git-diff-tree -r -c -C bb266cb118

bb266cb11842f76712ebff1d8b1bd086dc65337f
::100644 100644 100644 dfb1c44 29ea6f 8d0dbad RM	builtin-checkout-index.c
::100644 100644 100644 357970d d70076 7d39d9b RM	builtin-verify-pack.c
::100644 100644 100644 6484cb9 7a7f77 6484cb9 RM	help.c

Is it correct do not show in -c case:

- the similarity value
- the origin file:

As example

'R093MM	checkout-index.c builtin-checkout-index.c'

 instead of current

'RM	builtin-checkout-index.c'


Thanks
Marco

P.S: -c with --stat gives both origin and destination files
(checkout-index.c and builtin-checkout-index.c):

$ git-diff-tree -r -c -C --stat bb266cb118
bb266cb11842f76712ebff1d8b1bd086dc65337f
 Makefile                                     |   81 +++++++++++++++---------
 checkout-index.c => builtin-checkout-index.c |   26 ++++----
 builtin-count.c => builtin-count-objects.c   |    0
 name-rev.c => builtin-name-rev.c             |    4 +
 pack-objects.c => builtin-pack-objects.c     |    4 +
 symbolic-ref.c => builtin-symbolic-ref.c     |    4 +
 unpack-objects.c => builtin-unpack-objects.c |    7 +-
 verify-pack.c => builtin-verify-pack.c       |   15 ++---
 builtin.h                                    |   80 ++++++++++++------------
 git.c                                        |   86 ++++++++++++++------------
 builtin-help.c => help.c                     |    0
 11 files changed, 166 insertions(+), 141 deletions(-)
