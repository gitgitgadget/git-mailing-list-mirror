From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: [RFC] git-float
Date: Fri, 18 May 2007 00:18:05 +0300
Message-ID: <20070517211805.GA29259@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 23:18:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HonMQ-0004yA-Vn
	for gcvg-git@gmane.org; Thu, 17 May 2007 23:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719AbXEQVSH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 17:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754892AbXEQVSH
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 17:18:07 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:28271 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719AbXEQVSE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 17:18:04 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1112533nza
        for <git@vger.kernel.org>; Thu, 17 May 2007 14:18:04 -0700 (PDT)
Received: by 10.65.23.7 with SMTP id a7mr4902967qbj.1179436683795;
        Thu, 17 May 2007 14:18:03 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.34.225])
        by mx.google.com with ESMTP id f15sm3293488qba.2007.05.17.14.18.01;
        Thu, 17 May 2007 14:18:02 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47559>

Hi!
Here's a simple script I use to float a commit up the history -
similiar to what stg float does if I understand it correctly.

Is this a good way to implement it?
Would it make sense to have something like this in git tree?
Drop me a note.

############################################################

#!/bin/bash

check_revision() {
	case $# in
	2)
		true
		;;
	*)
		echo "Unable to float $1: it does not match a single non-merge commit" >&2
		exit 2
		;;
	esac
}
ref=`git-rev-list --no-merges $1~1..$1`
check_revision "$1" $ref

git-rebase --onto $ref~1 $ref && git-cherry-pick $ref

-- 
MST
